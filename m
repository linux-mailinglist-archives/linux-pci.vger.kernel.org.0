Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D6421545
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhJDRnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhJDRnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 13:43:04 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B56C061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 10:41:15 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso5622856ooq.8
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D/lMeoiuV+B5vzH2sTnlyy03bha/AFNv6BYAxtArpmc=;
        b=WSdD5Yhua0kLFYxTM3uXF03qqwgDsgzFpc7672PC16XJWMPvDWlKUGvXhotGJCKPf7
         71TGJcohCl5LAY00/ufklpY2WXXL2lStemKnIurL9scuZkvx0BOUh5P89pjqtKP90ieh
         BWbT08QZYeSMzf4JwzSdOm/W+FKEgtko67k7dRbftmbRdZjjAU4WYYvAJogFCex/aoKz
         Z8Fi8Q5i3dw6hZjZhx5hMWkwwY1WRB+U3+DjBH15+OnP8TU1ctYKdWbG1K2B0baK6WFE
         rPJsPkbNuCG/k8DyWCY1kQv5J8tIttWU4UhZhMyWkX4otfmr5GAN4qoPf3ebQ1ir2+US
         jWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/lMeoiuV+B5vzH2sTnlyy03bha/AFNv6BYAxtArpmc=;
        b=KqoHk+W1utWYPoXnZCmXU8H9haMixaPYYKCq59iaGl6RzHdR5kQ1zVKNBBHBVfjPIt
         jhdS/WSYdZQj2nJfrLlZrRffJ6Q28NU35Ks5j5RW5E7dRAjMOLK9Wf2qpmou+S7yACXR
         3kvBgOyMRswDkt6h/Jc7xCDXSBGslNCDvhzGvE8oooLE5mWcb9TpiqeUdYnzAkdW1Uyb
         XG7Y4edvybjwkNphCtnFSepShjc7HqIZ1xPPZs7w9ikjh39DUWxe2uJeUGEE1u6aKQ1L
         dFca1DQJhuaZLwJwgDwFflLhdyPNFl6Nr7pn9CiLNBq07eZB1LqAHqjIhxbJ+MIDKq4A
         BGJw==
X-Gm-Message-State: AOAM533tXP397+GaVmjvxF4PTVIq1T0K5ShH1ydi22re0j7z1IdCDs6+
        gWeYC8Y/Kqu1qFfHiMh87g86pU3ioTE=
X-Google-Smtp-Source: ABdhPJzwI6rF34qhq6GXVIbn6+GyC3iyAr2jDd5vxhDUefrtz7gPcIydBOsEjXMcRbtjcWAsWDhTCw==
X-Received: by 2002:a4a:d0cd:: with SMTP id u13mr10026262oor.3.1633369274539;
        Mon, 04 Oct 2021 10:41:14 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:c5d3:8f2f:d5f0:22e6? (2603-8081-2802-9dfb-c5d3-8f2f-d5f0-22e6.res6.spectrum.com. [2603:8081:2802:9dfb:c5d3:8f2f:d5f0:22e6])
        by smtp.gmail.com with ESMTPSA id 65sm3021017otd.81.2021.10.04.10.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 10:41:13 -0700 (PDT)
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com, pavel@ucw.cz
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <20210814062328.GA25723@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <aa253bad-5de0-7a25-7cc0-56ebfc0b6828@gmail.com>
Date:   Mon, 4 Oct 2021 12:41:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210814062328.GA25723@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/14/2021 1:23 AM, Lukas Wunner wrote:
> On Fri, Aug 13, 2021 at 05:36:53PM -0400, Stuart Hayes wrote:
>> +struct mutex drive_status_dev_list_lock;
>> +struct list_head drive_status_dev_list;
> 
> Should be declared static.
> 
>> +const guid_t pcie_ssd_leds_dsm_guid =
>> +	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
>> +		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
> 
> Same.
> 
>> +struct drive_status_led_ops dsm_drive_status_led_ops = {
>> +	.get_supported_states = get_supported_states_dsm,
>> +	.get_current_states = get_current_states_dsm,
>> +	.set_current_states = set_current_states_dsm,
>> +};
> 
> Same.
> 

Thank you!

>> +static void probe_pdev(struct pci_dev *pdev)
>> +{
>> +	/*
>> +	 * This is only supported on PCIe storage devices and PCIe ports
>> +	 */
>> +	if (pdev->class != PCI_CLASS_STORAGE_EXPRESS &&
>> +	    pdev->class != PCI_CLASS_BRIDGE_PCI)
>> +		return;
>> +	if (pdev_has_dsm(pdev))
>> +		add_drive_status_dev(pdev, &dsm_drive_status_led_ops);
>> +}
> 
> Why is &dsm_drive_status_led_ops passed to add_drive_status_dev()?
> It's always the same argument.
>

Because I hope this will also support NPEM as well, since it is so 
similar except for using a PCIe extended capability instead of a _DSM 
method. This will make it very easy to add the support... I just don't 
have any NPEM hardware yet.

>> +static int __init ssd_leds_init(void)
>> +{
>> +	mutex_init(&drive_status_dev_list_lock);
>> +	INIT_LIST_HEAD(&drive_status_dev_list);
>> +
>> +	bus_register_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
>> +	initial_scan_for_leds();
>> +	return 0;
>> +}
> 
> There's a concurrency issue here:  initial_scan_for_leds() uses
> bus_for_each_dev(), which walks the bus's klist_devices.  When a
> device is added (e.g. hotplugged), that device gets added to the
> tail of klist_devices.  (See call to klist_add_tail() in
> bus_add_device().)
> 
> It is thus possible that probe_pdev() is run concurrently for the
> same device, once by the notifier and once by initial_scan_for_leds().
> 
> The problem is that add_drive_status_dev() only checks at the top
> of the function whether the device has already been added to
> drive_status_dev_list.  It goes on to instantiate the LED
> and only then adds the device to drive_status_dev_list.
> 
> It's thus possible that the same LED is instantiated twice
> which might confuse users.
>

I missed that, thanks!

