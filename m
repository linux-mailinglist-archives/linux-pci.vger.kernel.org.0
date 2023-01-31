Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC56820CE
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 01:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAaAgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 19:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjAaAgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 19:36:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F03274BE
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675125371; x=1706661371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qevYVBO9PX+yDZ2mDMWbsi/UTtfi4hEIwc6K7CxoL9k=;
  b=HEC7AFY7o1E31L/ECgAMqmTefe9hDLVJXIdzk7ga3zWl95gsBaLGeZ2k
   M6VYz4rt8Os5+yHlCz1ajlvXOsF2hk1bZ9oKJvbxXHrctbbCq9//Br1Xc
   Ay0EzTm7nsq9X6jiM4/xPKYiRK5UeiYdiSywhnfjrTY9IJp2F7rcldzN1
   k7aKsIbrY+ogtQT6NPV9I2x2rz7r0a6Lz9c8fhqJoCMIJVZHWljc+xKJ2
   7Xu4ZkJ6mbClhRIg1O+r8JpeqgCCnG+pjr6Ug1DRZNBiU1+ekYXI7oJdN
   w2qaZOTnBcn0S3bcXtnU67yM8VAQVDvBYwmiZCJXsYEeRyPKeyZnwSfcb
   w==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="222178415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 08:36:07 +0800
IronPort-SDR: N5ocWIjUe/q1bndIW0wdcbLiM4kQqtSqLZE0KZ+BXYKRvEDVMZxkkmk/fVPpHd2y4ok1zCudtw
 w7BCuVSAHo8asdaGIu3Pmju9udBY6sxfR5m72VM/1F0BT7w4qECX7Y+rtr9YqJHs/USD0RHIb6
 boKnm5VYVUrZ04bfUI3+nKIXd0fNmZfA2u0RsT38bGrOWs6i0+NQxYAvwejlZPrr4Vw+CWRCie
 UU+tne5UWH4YBVEzAneNicr52bH/4m8vShKo4oJ/MS5OV9qMi28KoIvQO1noNEZLBG7+IhCzoi
 scU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 15:53:32 -0800
IronPort-SDR: IreOjlovKVQwNs9zcy2fF/+hPpcYDbfyKFeBAqywDBXgKLSdUfi7k9H5dfmKz2rSkRV5YPFhOX
 nPO/5VfNsYbVenx77azVCT8SWlKgA4o6uLHW4Cu7dws0IIjNEy/da9dH6QSw4zQ7Xwjqtm68jB
 Dw+Yd6i07Mt1P2IMxLGAmBpsVbrIRtbupPuEjNa89ENR3g47dzIpLR/zqNVyeM5TgH/MBAORfw
 G7dMrFGdqPc0p0i1k4jXrPa0dM6fQDUxrpC15QjHQC4SOrIDRKeMeG1uED3wKRQMwZ68ky0MKk
 j4Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 16:36:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5R1M38Fpz1Rwtl
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 16:36:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675125365; x=1677717366; bh=qevYVBO9PX+yDZ2mDMWbsi/UTtfi4hEIwc6
        K7CxoL9k=; b=KXIVFY6bVpJpRIxnnPCTcup4paagPuf/8NjjJFJpeMnppkug931
        iVzEl7PTfk4FQ568h2se2feVPCbfkqKPb+uEW0QpDbWJjGMyHfVUdHdZcmHH6mgn
        NhLVlhWNXj3Bp5DH2lszQBxjCnGFVZzRvoly0yXX655+b8DDrFXBQeXxnYbtBKj7
        SfF7vr/tGai4wBLmbxFL4fQuZv2VPTwed14U7HjRXjvnJntHUrPsrA9OcVB6gkNF
        qH1IOGTYxhxl8ZVoGgC8Wk+RebFIAf8PJL3Wt4hBZQA+s2UINEPnhNpwIR/NuR+h
        LNuXNf2a7tiZn5oENYoAxtl2DpCKKrwwh0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ftS9wMFWvocj for <linux-pci@vger.kernel.org>;
        Mon, 30 Jan 2023 16:36:05 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5R1J0ZJmz1RvLy;
        Mon, 30 Jan 2023 16:36:03 -0800 (PST)
Message-ID: <22d87b2d-8ecb-5f7f-2440-7535a493b5c1@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 09:36:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20230130160436.GA1678344@bhelgaas>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230130160436.GA1678344@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/31/23 01:04, Bjorn Helgaas wrote:
> On Mon, Jan 30, 2023 at 03:46:06PM +0000, Niklas Cassel wrote:
>> On Mon, Jan 30, 2023 at 09:21:11AM -0600, Bjorn Helgaas wrote:
>>> On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
>>>> PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
>>>> guest OS fails to correctly probe devices attached to the controller due
>>>> to FIS communication failures. 
>>>
>>> What does a FIS communication failure look like?  Can we include a
>>> line or two of dmesg output here to help users find this fix?
>>
>> It looks like this:
>>
>> [   22.402368] ata4: softreset failed (1st FIS failed)
>> [   32.417855] ata4: softreset failed (1st FIS failed)
>> [   67.441641] ata4: softreset failed (1st FIS failed)
>> [   67.453227] ata4: limiting SATA link speed to 3.0 Gbps
>> [   72.661738] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
>> [   78.121263] ata4.00: qc timeout after 5000 msecs (cmd 0xec)
>> [   78.134413] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>
>> Basically, we can read and write MMIO registers in the AHCI HBA,
>> but the communication between the AHCI HBA and the ATA device does
>> not work properly.
>>
>> (Because the AHCI HBA did not get reset when binding/unbinding the
>> device.)
>>
>> The exact same kernel, using the same generic AHCI driver within the VM,
>> can communicate perfectly fine when using e.g. an Intel AHCI HBA.
>>
>> (With both the AMD and Intel AHCI HBAs being bound to the vfio-pci driver
>> in the host.)
>>
>> We can send a v2 with the above dmesg output.
> 
> Don't bother, I added the above and applied this to pci/virtualization
> for v6.2, thanks!

Thanks !


-- 
Damien Le Moal
Western Digital Research

