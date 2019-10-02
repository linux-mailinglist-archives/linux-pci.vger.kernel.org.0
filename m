Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE15C934C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfJBVLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 17:11:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfJBVLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 17:11:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so525592wrm.12
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2019 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DfBXBUyiw97To+io1cJq9TUMttHsei1MNjbJG6hjvjo=;
        b=M8sG7cmzF5l2TY1i6g309lgRuYeiBUTLDJtNryx2j6ERfOOiQWBnUBbcAoZ3CMHk2U
         obQ9MVC7kCJKr/l7wtvkIncVMjCm3tmcmnNN98+sNIf9uTgcQ616GSQzdtNQGY575b5S
         VdceNnEQ+DQ8BVQqlsSxG1GsLmu5W/aJCYWmremhrmQk7vm7sNelKPdh8GCw6DwbAqtK
         u4lmdqmY7wNavJereHo6de4hfIa/GeNGEb4/TLYId18u+8w1cmd0vRRYC/qFaBD3xGWs
         QSYrRBy98U94rEAYusCIjVKL83FtGygEThc8+6v9ZLtnrkE6awMrocf8XqLKphhscTs+
         zSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DfBXBUyiw97To+io1cJq9TUMttHsei1MNjbJG6hjvjo=;
        b=aeiDvq9J2qSsCjDa42oT8fPLaEkq7J4JguiSeW6Pd4KX0JBUydy69NscPdO4vFwBlC
         hGCP17FMDwswDvIOfh8UsNxjERqtZjuXlN7iG3Le2HpQ4s44IayJ9m+WqJgwJ6/QWVJB
         owCSuopKInQ3GSXjmvmwwvQqRDC1NwgYKBR/s4TvkFTsjjfM5L3UFfT5ECrVIH/pm9sh
         M0oRAPgnAI0dBpQm877cu7uHMjo1khOKsrGR/VsDWJSnxyTUp4ED75OxHCOQUZ3tsytR
         7INTP+L0zRB744pWV0tLH18s3X6NSun4Sb3OpcomTzqoo8EIAmmiWIcyhsacwwuSu8tx
         xRIw==
X-Gm-Message-State: APjAAAVmbFWyagCNDK5iujcjEaHXXgWZszUNolkM6SbpGqbav9JhrEQM
        6K+R5N3EciFMIiO6bAo+5OikbYb5
X-Google-Smtp-Source: APXvYqxU392cbT38mrQ6aY+/6doTqm73HnHFmDo0l6OuOb0kQgcPDYHBjizy0ZaicyoHMvGwcghh+g==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr4562246wrw.385.1570050667392;
        Wed, 02 Oct 2019 14:11:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:9cd0:52ca:b438:97d1? (p200300EA8F2664009CD052CAB43897D1.dip0.t-ipconnect.de. [2003:ea:8f26:6400:9cd0:52ca:b438:97d1])
        by smtp.googlemail.com with ESMTPSA id z189sm502431wmc.25.2019.10.02.14.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:11:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20191002195541.GA49632@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a4d86993-46fc-ef15-8c7a-6e5e049a3065@gmail.com>
Date:   Wed, 2 Oct 2019 23:10:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002195541.GA49632@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02.10.2019 21:55, Bjorn Helgaas wrote:
> On Sun, Sep 29, 2019 at 07:15:05PM +0200, Heiner Kallweit wrote:
>> On 07.09.2019 22:32, Bjorn Helgaas wrote:
>>> On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:
>>>> Background of this extension is a problem with the r8169 network driver.
>>>> Several combinations of board chipsets and network chip versions have
>>>> problems if ASPM is enabled, therefore we have to disable ASPM per default.
>>>> However especially on notebooks ASPM can provide significant power-saving,
>>>> therefore we want to give users the option to enable ASPM. With the new
>>>> sysfs attributes users can control which ASPM link-states are
>>>> enabled/disabled.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>> v2:
>>>> - use a dedicated sysfs attribute per link state
>>>> - allow separate control of ASPM and PCI PM L1 sub-states
>>>> v3:
>>>> - statically allocate the attribute group
>>>> - replace snprintf with printf
>>>> - base on top of "PCI: Make pcie_downstream_port() available outside of access.c"
>>>> v4:
>>>> - add call to sysfs_update_group because is_visible callback returns false
>>>>   always at file creation time
>>>> - simplify code a little
>>>> v5:
>>>> - rebased to latest pci/next
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>>>>  drivers/pci/pci-sysfs.c                 |   7 +
>>>>  drivers/pci/pci.h                       |   4 +
>>>>  drivers/pci/pcie/aspm.c                 | 184 ++++++++++++++++++++++++
>>>>  4 files changed, 208 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>>>> index 8bfee557e..49249a165 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>>>> @@ -347,3 +347,16 @@ Description:
>>>>  		If the device has any Peer-to-Peer memory registered, this
>>>>  	        file contains a '1' if the memory has been published for
>>>>  		use outside the driver that owns the device.
>>>> +
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l0s
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
>>>> +What		/sys/bus/pci/devices/.../aspm/aspm_clkpm
>>>> +date:		August 2019
> 
> I didn't notice this before, but I wonder if one "aspm" in these paths
> would be enough?  E.g., /sys/bus/pci/devices/.../aspm/l0s?
> 
Yes, that should be fine.

>>>> @@ -1315,6 +1315,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>>>>  
>>>>  	pcie_vpd_create_sysfs_dev_files(dev);
>>>>  	pcie_aspm_create_sysfs_dev_files(dev);
>>>> +#ifdef CONFIG_PCIEASPM
>>>> +	/* update visibility of attributes in this group */
>>>> +	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
>>>> +#endif
>>>
>>> Isn't there a way to do this in drivers/pci/pcie/aspm.c somehow,
>>> without using sysfs_update_group()?  There are only three callers of
>>> it in the tree, and I'd be surprised if ASPM is unique enough to have
>>> to be the fourth.
>>>
>> At least I didn't find any. Reason seems to be the following:
>> Static sysfs files are created in pci_scan_single_device ->
>> pci_device_add. And pci_scan_slot calls pci_scan_single_device
>> before calling pcie_aspm_init_link_state(bus->self).
>> Means the pcie_link_state doesn't exist yet and we have to update
>> visibility of the ASPM sysfs files later.
> 
> Ah, I see.  I think it's this call graph:
> 
>   pci_scan_slot
>     pci_scan_single_device
>       pci_scan_device
>       pci_device_add
> 	pci_init_capabilities
> 	device_add
> 	  device_add_attrs
> 	    device_add_groups(dev->type->groups)
> 	      sysfs_create_groups         # <-- sysfs files created
>     pcie_aspm_init_link_state(bridge)     # <-- link_states allocated
> 
> I think this part of the ASPM code is a little bit broken -- we wait
> to initialize ASPM until we've enumerated all the devices on the link.
> I think it would be better to initialize it somewhere in
> pci_device_add(), maybe pci_init_capabilities(), which would solve
> this ordering problem.  That's a pretty big project that can be done
> later.
> 
> But I *think* we should be able to at least move the
> sysfs_update_group() to the end of pcie_aspm_init_link_state().  We'd
> have to iterate over the subordinate->devices, but it would at least
> be in the ASPM code where we'll see it if/when we rework the
> initialization.
> 

OK

>>>> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
>>>
>>> I know the ASPM code is pretty confused, but I don't think "parent
>>> link" really makes sense.  "Parent" implies a parent/child
>>> relationship, but a link doesn't have a parent or a child; it only has
>>> an upstream end and a downstream end.
>>>
>> I basically copied this "parent" stuff from __pci_disable_link_state.
>> Fine with me to change the naming.
>> What confuses me a little is that we have different versions of getting
>> the pcie_link_state for a pci_dev in:
>>
>> - this new function of mine
>> - __pci_disable_link_state
>> - pcie_aspm_enabled
>>
>> The latter uses pci_upstream_bridge instead of accessing pdev->bus->self
>> directly and doesn't include the call to pcie_downstream_port.
>> I wonder whether the functionality could be factored out to a generic
>> helper that works in all these places.
> 
> Definitely.  I think your pcie_aspm_get_link() (from the v6 patch)
> could be used directly in those places.  You could add a new patch
> that just adds pcie_aspm_get_link() and uses it.
> 

OK

>>>> +{
>>>> +	struct pci_dev *parent = pdev->bus->self;
>>>> +
>>>> +	if (pcie_downstream_port(pdev))
>>>> +		parent = pdev;
>>>> +
>>>> +	return parent ? parent->link_state : NULL;
>>>> +}
>>>> +
>>>> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pcie_link_state *link;
>>>> +
>>>> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>>>
>>> Do you intend to exclude other Upstream Ports like Legacy Endpoints,
>>> Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
>>> a link leading to them, so we might want them to have knobs as well.
>>> Or if we don't want the knobs, a comment about why not would be
>>> useful.
>>>
>> My use case is about endpoints only and I'm not really a PCI expert.
>> Based on your list in addition to PCI_EXP_TYPE_ENDPOINT we'd enable
>> the ASPM sysfs fils for:
>> - PCI_EXP_TYPE_LEG_END
>> - PCI_EXP_TYPE_UPSTREAM
>> - PCI_EXP_TYPE_PCI_BRIDGE
>> - PCI_EXP_TYPE_PCIE_BRIDGE
>> If you can confirm the list I'd extend my patch accordingly.
> 
> Yes, I think the list would be right, but looking at this again, I
> don't think you need this function at all -- you can just use
> pcie_aspm_get_link().  Then aspm_ctrl_attrs_are_visible() uses exactly
> the same test as the show/store functions.  Actually, I think then you
> could omit the "if (!link)" tests from the show/store functions
> because those functions can never be called unless
> aspm_ctrl_attrs_are_visible() found a link.
> 
Right, the !link checks can be removed from the show/store functions.
In pcie_is_aspm_dev() I think we need to check at least whether
device is PCIe and whether link is ASPM-capable. Making the sysfs
attributes visible for a non-PCIe device doesn't make sense,
the same applies to PCIe devices with a link that is not ASPM-capable.

> Bjorn
> 
Heiner
