Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC936E992
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhD2La4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 07:30:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3971 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Laz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 07:30:55 -0400
Received: from dggeml711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FWCsb6TQ3zRflp;
        Thu, 29 Apr 2021 19:27:47 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml711-chm.china.huawei.com (10.3.17.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 29 Apr 2021 19:30:05 +0800
Received: from [127.0.0.1] (10.69.38.196) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Apr 2021 19:29:59 +0800
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, <linux-pci@vger.kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
 <20210428144041.GA27967@wunner.de>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
Date:   Thu, 29 Apr 2021 19:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210428144041.GA27967@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/28 22:40, Lukas Wunner wrote:
> On Wed, Apr 28, 2021 at 06:08:02PM +0800, Yicong Yang wrote:
>> I've tested the patch on our board, but the hotplug will still be
>> triggered sometimes.
>> seems the hotplug doesn't find the link down event is caused by dpc.
>> Any further test I can do?
>>
>> mestuary:/$ [12508.408576] pcieport 0000:00:10.0: DPC: containment event, status:0x1f21 source:0x0000
>> [12508.423016] pcieport 0000:00:10.0: DPC: unmasked uncorrectable error detected
>> [12508.434277] pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
>> [12508.447651] pcieport 0000:00:10.0:   device [19e5:a130] error status/mask=00008000/04400000
>> [12508.458279] pcieport 0000:00:10.0:    [15] CmpltAbrt              (First)
>> [12508.467094] pcieport 0000:00:10.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
>> [12511.152329] pcieport 0000:00:10.0: pciehp: Slot(0): Link Down
> 
> Note that about 3 seconds pass between DPC trigger and hotplug link down
> (12508 -> 12511).  That's most likely the 3 second timeout in my patch:
> 
> +	/*
> +	 * Need a timeout in case DPC never completes due to failure of
> +	 * dpc_wait_rp_inactive().
> +	 */
> +	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> +			   msecs_to_jiffies(3000));
> 
> If DPC doesn't recover within 3 seconds, pciehp will consider the
> error unrecoverable and bring down the slot, no matter what.
> 
> I can't tell you why DPC is unable to recover.  Does it help if you
> raise the timeout to, say, 5000 msec?
> 

I raise the timeout to 4s and it works well. I dump the remained jiffies in
the log and find sometimes the recovery will take a bit more than 3s:

[  826.564141] pcieport 0000:00:10.0: DPC: containment event, status:0x1f01 source:0x0000
[  826.579790] pcieport 0000:00:10.0: DPC: unmasked uncorrectable error detected
[  826.591881] pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
[  826.608137] pcieport 0000:00:10.0:   device [19e5:a130] error status/mask=00008000/04400000
[  826.620888] pcieport 0000:00:10.0:    [15] CmpltAbrt              (First)
[  826.638742] pcieport 0000:00:10.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
[  828.955313] pcieport 0000:00:10.0: DPC: dpc_reset_link: begin reset
[  829.719875] pcieport 0000:00:10.0: DPC: DPC reset has been finished.
[  829.731449] pcieport 0000:00:10.0: DPC: remaining time for waiting dpc compelete: 0xd0 <-------- 208 jiffies remained
[  829.732459] ixgbe 0000:01:00.0: enabling device (0000 -> 0002)
[  829.744535] pcieport 0000:00:10.0: pciehp: Slot(0): Link Down/Up ignored (recovered by DPC)
[  829.993188] ixgbe 0000:01:00.1: enabling device (0000 -> 0002)
[  830.760190] pcieport 0000:00:10.0: AER: device recovery successful
[  831.013197] ixgbe 0000:01:00.0 eth0: detected SFP+: 5
[  831.164242] ixgbe 0000:01:00.0 eth0: NIC Link is Up 10 Gbps, Flow Control: RX/TX
[  831.827845] ixgbe 0000:01:00.0 eth0: NIC Link is Down
[  833.381018] ixgbe 0000:01:00.0 eth0: NIC Link is Up 10 Gbps, Flow Control: RX/TX


CONFIG_HZ=250 so remaining jiffies should larger than 250 if the recovery finished in 3s.
Is there a reference to the 3s timeout? and does it make sense to raise it a little bit?

Thanks,
Yicong


> Thanks,
> 
> Lukas
> 
> .
> 

