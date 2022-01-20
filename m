Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5149484B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 08:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiATHbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 02:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358996AbiATHbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 02:31:39 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738AC061574
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 23:31:38 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JfZ2J1LXfzQjkl;
        Thu, 20 Jan 2022 08:31:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <487c2f8f-a02d-1ddb-ff17-339cbac7e1a7@denx.de>
Date:   Thu, 20 Jan 2022 08:31:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices supporting
 it
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220119092200.35823-1-sr@denx.de>
 <20220119092200.35823-3-sr@denx.de> <20220119103711.hadtvpxklfnxmqth@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220119103711.hadtvpxklfnxmqth@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/19/22 11:37, Pali Rohár wrote:
> On Wednesday 19 January 2022 10:22:00 Stefan Roese wrote:
>> With this change, AER is now enabled on all PCIe devices, also when the
>> PCIe device is hot-plugged.
>>
>> Please note that this change is quite invasive, as with this patch
>> applied, AER now will be enabled in the Device Control registers of all
>> available PCIe Endpoints, which currently is not the case.
>>
>> When "pci=noaer" is selected, AER stays disabled of course.
> 
> Hello Stefan! I was thinking more about this change and I'm not sure
> what happens if AER-capable PCIe device is hotplugged into some PCIe
> switch connected in the PCIe hierarchy where Root Port is not
> AER-capable (e.g. current linux implementation of pci-aardvark.c and
> pci-mvebu.c). My feeling is that in this case AER should not be enabled
> as there is nobody who can deliver AER interrupt to the OS. But I really
> do not know what is supposed from kernel AER driver, so lets wait for
> Bjorn reply.

But what happens right now, when a device driver like the NVMe driver
calls pci_enable_pcie_error_reporting() ? There is also no checking,
if the connected Root Port or some switch / bridge in-between supports
AER or not. IIUTC, this is identical to what this patch here does.
Enable AER in the device and if the upstream infrastructure does not
support AER, then the AER event will just not be received by the
Kernel. Which is most likely not worse than not enabling AER at all
on this device. Or am I missing something?

> And when you opened this issue with hotplugging, another thing for
> followup changes in future is calling pcie_set_ecrc_checking() function
> to align ECRC state of newly hotplugged device with "pci=ecrc=..."
> cmdline option. As currently it is done only at that function
> set_device_error_reporting().

Agreed, this is another area to look into. Not sure if it's okay to
address this, once this patch-set has been accepted (if it will be).

Thanks,
Stefan
