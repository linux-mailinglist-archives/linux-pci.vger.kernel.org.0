Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69088C1672
	for <lists+linux-pci@lfdr.de>; Sun, 29 Sep 2019 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfI2RPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Sep 2019 13:15:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2RPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2019 13:15:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so8368689wru.11
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2019 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7fn0nn+QegTqpxNw9j4LUHAb0YjF89tuixnElNtvu8=;
        b=tIUEx4S2J91jKzUF3fSpctcvHgLLNT7cQCLQppvdmHqAflJMi29Q7KxmW9jkYglZt2
         KuBm3Ffn8Ix/FVOT7VVsFMNS1hPExqSzRBVFeK0osn/bSBIoauJ0u0LWFNjVBAgkv3UQ
         cLLkMJqzhOoMdSxpk39lcFAp9eMEg9wbekgieXD3heIH2DvRjzYfCljb14eLSQX+wnFL
         DQ57mUtBvIdwtoNYEGxV5TkpFwC58b5jZs1pwAtWhXq4qZDeCw6LBLfv0TjAYyAdTWFP
         wEDRTWJLWXarFzvegg8AtheoHgtxKTOY4ex2qXqGUmLE2o4Wbf2l03CL3IAJ1RyZtfU2
         ZA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7fn0nn+QegTqpxNw9j4LUHAb0YjF89tuixnElNtvu8=;
        b=iiZM1dOiJyO77aCqQnddMjwtuLgov600DyEUhjY+goVfOy8uS2HcL31q/yiGKTGs1U
         NhtaLtByCSxZTdw0DLkYwEFn8rnKQYlWouTMdROnsonb9ZhhlW08Pr0AjssiNQuf8rIL
         KgWDY1N3qVqocpXbbvnM+hBkHaJze8MNAN+LT3yrMowDOkMJdqyfHCh2ukcUYDEpB9oN
         r1O9spazbWozVTXoqW2+JHuOSZKSa+CMenvLjKxX958+c1CFKdO96B7R0DhV8snGhYGa
         oJSkxlV9sVIhePXiMoN5HZNMeLy5tpvqvpzAVXDP3wqv5QFOOlOqOuqe8/UO3t6+61da
         HXTA==
X-Gm-Message-State: APjAAAUfVj0/O3QkE3HnCK/dZ+hAZXc3HvMDweQ9ww8pcDnH2oxHsE3N
        tvad1O2LnrTbhELGLqjx8vcFTSYY
X-Google-Smtp-Source: APXvYqxXajZGfSzTCTxc/y6OHqjEeuEfEBqwbKJ1rW/6WbVg+mW12xmhqZO0CvUhJnb1somvEPk00A==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr8012586wrw.237.1569777312819;
        Sun, 29 Sep 2019 10:15:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ccd:6ebf:612a:80e8? (p200300EA8F2664000CCD6EBF612A80E8.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ccd:6ebf:612a:80e8])
        by smtp.googlemail.com with ESMTPSA id q66sm18046559wme.39.2019.09.29.10.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 10:15:11 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
 <8783b887-2e30-43f0-d462-96f8fbb18ae2@gmail.com>
 <20190907203220.GR103977@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a12e0e2c-dcb8-9ec5-cf10-1029732a00fb@gmail.com>
Date:   Sun, 29 Sep 2019 19:15:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190907203220.GR103977@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07.09.2019 22:32, Bjorn Helgaas wrote:
> On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:
>> Background of this extension is a problem with the r8169 network driver.
>> Several combinations of board chipsets and network chip versions have
>> problems if ASPM is enabled, therefore we have to disable ASPM per default.
>> However especially on notebooks ASPM can provide significant power-saving,
>> therefore we want to give users the option to enable ASPM. With the new
>> sysfs attributes users can control which ASPM link-states are
>> enabled/disabled.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> v2:
>> - use a dedicated sysfs attribute per link state
>> - allow separate control of ASPM and PCI PM L1 sub-states
>> v3:
>> - statically allocate the attribute group
>> - replace snprintf with printf
>> - base on top of "PCI: Make pcie_downstream_port() available outside of access.c"
>> v4:
>> - add call to sysfs_update_group because is_visible callback returns false
>>   always at file creation time
>> - simplify code a little
>> v5:
>> - rebased to latest pci/next
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>>  drivers/pci/pci-sysfs.c                 |   7 +
>>  drivers/pci/pci.h                       |   4 +
>>  drivers/pci/pcie/aspm.c                 | 184 ++++++++++++++++++++++++
>>  4 files changed, 208 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 8bfee557e..49249a165 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -347,3 +347,16 @@ Description:
>>  		If the device has any Peer-to-Peer memory registered, this
>>  	        file contains a '1' if the memory has been published for
>>  		use outside the driver that owns the device.
>> +
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l0s
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
>> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
>> +What		/sys/bus/pci/devices/.../aspm/aspm_clkpm
>> +date:		August 2019
> 
> Other entries use "What:" and "Date:" (add colon and capitalize).
> 
> There are no examples in *this* file, but in
> Documentation/ABI/testing/sysfs-bus-pci-drivers-ehci_hcd,
> the "What:" is not repeated for each file in the group.
> 
>> +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
>> +Description:	If ASPM is supported for an endpoint, then these files
>> +		can be used to disable or enable the individual
>> +		power management states.
> 
> Please mention the specific details here, e.g., "write 1 to enable, 0
> to disable".
> 
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 868e35109..687240f55 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1315,6 +1315,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>>  
>>  	pcie_vpd_create_sysfs_dev_files(dev);
>>  	pcie_aspm_create_sysfs_dev_files(dev);
>> +#ifdef CONFIG_PCIEASPM
>> +	/* update visibility of attributes in this group */
>> +	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
>> +#endif
> 
> Isn't there a way to do this in drivers/pci/pcie/aspm.c somehow,
> without using sysfs_update_group()?  There are only three callers of
> it in the tree, and I'd be surprised if ASPM is unique enough to have
> to be the fourth.
> 
At least I didn't find any. Reason seems to be the following:
Static sysfs files are created in pci_scan_single_device ->
pci_device_add. And pci_scan_slot calls pci_scan_single_device
before calling pcie_aspm_init_link_state(bus->self).
Means the pcie_link_state doesn't exist yet and we have to update
visibility of the ASPM sysfs files later.
I'd be happy if I could avoid this visibility update exercise.

>>  	if (dev->reset_fn) {
>>  		retval = device_create_file(&dev->dev, &dev_attr_reset);
>> @@ -1571,6 +1575,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>>  	&pcie_dev_attr_group,
>>  #ifdef CONFIG_PCIEAER
>>  	&aer_stats_attr_group,
>> +#endif
>> +#ifdef CONFIG_PCIEASPM
>> +	&aspm_ctrl_attr_group,
>>  #endif
>>  	NULL,
>>  };
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 44b80186d..9dc3e3673 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -659,4 +659,8 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_PCIEASPM
>> +extern const struct attribute_group aspm_ctrl_attr_group;
>> +#endif
>> +
>>  #endif /* DRIVERS_PCI_H */
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index f044ae4d1..ce3425125 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1287,6 +1287,190 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>>  }
>>  #endif
>>  
>> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
> 
> I know the ASPM code is pretty confused, but I don't think "parent
> link" really makes sense.  "Parent" implies a parent/child
> relationship, but a link doesn't have a parent or a child; it only has
> an upstream end and a downstream end.
> 
I basically copied this "parent" stuff from __pci_disable_link_state.
Fine with me to change the naming.
What confuses me a little is that we have different versions of getting
the pcie_link_state for a pci_dev in:

- this new function of mine
- __pci_disable_link_state
- pcie_aspm_enabled

The latter uses pci_upstream_bridge instead of accessing pdev->bus->self
directly and doesn't include the call to pcie_downstream_port.
I wonder whether the functionality could be factored out to a generic
helper that works in all these places.

> Anyway, any given PCIe device has either zero or one link associated
> with it, so something like "aspm_get_link()" would be unambiguous all
> by itself.
> 
>> +{
>> +	struct pci_dev *parent = pdev->bus->self;
>> +
>> +	if (pcie_downstream_port(pdev))
>> +		parent = pdev;
>> +
>> +	return parent ? parent->link_state : NULL;
>> +}
>> +
>> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
> 
> Maybe "pcie_is_aspm_dev()" or similar?  I think we may want to include
> more than just endpoints (see below).  "Check" in function names is a
> pet peeve of mine because it doesn't tell us whether it's a pure
> function (as this is) or it has side effects, and it doesn't give a
> hint about what the sense of the return value is.
> 
>> +{
>> +	struct pcie_link_state *link;
>> +
>> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> 
> Do you intend to exclude other Upstream Ports like Legacy Endpoints,
> Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
> a link leading to them, so we might want them to have knobs as well.
> Or if we don't want the knobs, a comment about why not would be
> useful.
> 
My use case is about endpoints only and I'm not really a PCI expert.
Based on your list in addition to PCI_EXP_TYPE_ENDPOINT we'd enable
the ASPM sysfs fils for:
- PCI_EXP_TYPE_LEG_END
- PCI_EXP_TYPE_UPSTREAM
- PCI_EXP_TYPE_PCI_BRIDGE
- PCI_EXP_TYPE_PCIE_BRIDGE
If you can confirm the list I'd extend my patch accordingly.

[...]
