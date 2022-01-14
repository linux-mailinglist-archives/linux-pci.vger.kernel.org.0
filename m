Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9488A48E43C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 07:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiANGZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 01:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiANGZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 01:25:36 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629DC061574
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 22:25:36 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JZrrs1KCwzQjkC;
        Fri, 14 Jan 2022 07:25:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <dd3d7cd9-6232-e793-a26c-a10e5cc13fae@denx.de>
Date:   Fri, 14 Jan 2022 07:25:29 +0100
MIME-Version: 1.0
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20220113213230.GA433650@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220113213230.GA433650@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/13/22 22:32, Bjorn Helgaas wrote:
> On Thu, Jan 13, 2022 at 08:13:55AM +0100, Stefan Roese wrote:
>> On 1/12/22 18:49, Bjorn Helgaas wrote:
> 
>>> Ah.  I assume you have:
>>>
>>>     00:00.0 Root Port to [bus 01-??]
>>>     01:00.0 Switch Upstream Port to [bus 02-??]
>>>     02:0?.0 Switch Downstream Port to [bus 04-??]
>>
>> This is correct, yes.
>>
>>> pcie_portdrv_probe() claims 00:00.0 and clears CERE NFERE FERE URRE.
>>>
>>> aer_probe() claims 00:00.0 and enables CERE NFERE FERE URRE for all
>>> downstream devices, including 01:00.0.
>>>
>>> pcie_portdrv_probe() claims 01:00.0 and clears CERE NFERE FERE URRE
>>> again.
>>>
>>> aer_probe() declines to claim 01:00.0 because it's not a Root Port, so
>>> CERE NFERE FERE URRE remain cleared.
> 
>> I'm baffled a bit, that this problem of AER reporting being disabled in
>> the DevCtl regs of PCIe ports (all non root ports) was not noticed for
>> this long time. As AER is practically disabled in such setups.
> 
> The more common configuration is a Root Port leading directly to an
> Endpoint.  In that case, there would be no pcie_portdrv_probe() in the
> middle to disable reporting after aer_probe() has enabled it.
> 
> The issue you're seeing happens because of the switch in the middle,
> which is becoming more common recently with Thunderbolt.
> 
> I poked around on my laptop (Dell 5520 running v5.4):
> 
>    00:01.0 Root Port       to [bus 01]          CorrErr-
>    01:00.0 NVIDIA GPU                           CorrErr-
> 
>    00:1c.0 Root Port       to [bus 02]     AER  CorrErr+
>    02:00.0 Intel NIC                       AER  CorrErr-  <-- iwlwifi
> 
>    00:1c.1 Root Port       to [bus 03]     AER  CorrErr+
>    03:00.0 Realtek card reader             AER  CorrErr-  <-- rtsx_pci
> 
>    00:1d.0 Root Port       to [bus 04]     AER  CorrErr+
>    04:00.0 NVMe                            AER  CorrErr+
> 
>    00:1d.6 Root Port       to [bus 06-3e]  AER  CorrErr+
>    06:00.0 Thunderbolt USP to [bus 07-3e]  AER  CorrErr-
>    07:00.0 Thunderbolt DSP to [bus 08]     AER  CorrErr-
>    ...                                          CorrErr-
> 
> Everything in the Thunderbolt hierarchy has reporting disabled,
> probably because of the issue you are pointing out.
> 
> I can't explain the iwlwifi and rtsx_pci cases.  Both devices have AER
> and are directly below a Root Port that also has AER, so I would think
> reporting should be enabled.

This is because AER is enabled for the complete bus via
set_downstream_devices_error_reporting(), which calls
set_device_error_reporting():

static int set_device_error_reporting(struct pci_dev *dev, void *data)
...
	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
	    (type == PCI_EXP_TYPE_RC_EC) ||
	    (type == PCI_EXP_TYPE_UPSTREAM) ||
	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
		if (enable)
			pci_enable_pcie_error_reporting(dev);
		else
			pci_disable_pcie_error_reporting(dev);
	}

	if (enable)
		pcie_set_ecrc_checking(dev);

Not sure, why error reporting is not enabled for "normal" PCIe devices
but only pcie_set_ecrc_checking(). This behavior was integrated with the
intial AER support in commit 6c2b374d7485 ("PCI-Express AER
implemetation: AER core and aerdriver") in 2006.

This explains, why you have AER disabled in the DevCtl registers of your
iwlwifi and rtsx_pci devices.

Now you might be asking, why you have AER enabled in the NVMe drive.
This is because the NVMe driver specifically enables AER:

drivers/nvme/host/pci.c:
static int nvme_pci_enable(struct nvme_dev *dev)
{
...
	pci_enable_pcie_error_reporting(pdev);

There are other device drivers, especially ethernet, SCSI etc, which
also specifically call pci_enable_pcie_error_reporting() for their
PCIe devices.

So how to continue with this? Are we "brave enough" to enable AER
for normal PCIe devices as well in set_device_error_reporting()?
This would be a quite big change, as currently all PCIe devices have
AER disabled per default.

And we still have the problem that AER is disabled in all PCIe devices
except for the Root Port. This can be fixed by removing the AER
disabling from get_port_device_capability() as done in the patch I've
sent yesterday to the list.

Another idea that comes to my mind is, to change
pci_enable_pcie_error_reporting() to walk the PCI bus upstream
while enabling the device and enable AER in the DevCtl register in all
upstream PCIe devices (e.g. PCIe switch etc) found on this way up to
the PCIe Root Port. This way, AER will work on PCIe device, where it
is specifically enabled in the device driver. But only there - at
least in cases, where PCIe switches etc are involved.

Did I miss anything?

Thanks,
Stefan
