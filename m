Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F120422F3B3
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgG0PTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgG0PTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:19:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB08C0619D2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:19:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so1350588pjb.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHt3OW1PiSHH3TWA+f0N3SNu3bHzJ0l57BQilBA3+pI=;
        b=LAU0Mjbfq939NMhR/eiOISTSzZ9oAfhJTSxKjcTso60ALATkC5zXQCp5KQUPL/wCgm
         ja60LFpDGWc1sSr3aQq6ZI8QaeLAxCnpPBydGhrg0x8zaWXLfdLDojDDaEmc+CaDGm6I
         GwlwDmf79WJcCprY+TwEZf/+gK4kaMLzdwcoUc6N+1fD9zGbEc8Mb0AN+WuQNEKZ8pzH
         5RqDhNJYq63sLWYrmnbB1xjMCrh9pDx5ZujZB1fwWi1a7i38pnbRNRk8LVvwWuwggpLu
         TkSXyYOHtOqwjHstCtR7RKNkjup6VSaIuwvXfSZqJN54lxeu5fOprak8fJBeJ/ixzz6T
         e9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHt3OW1PiSHH3TWA+f0N3SNu3bHzJ0l57BQilBA3+pI=;
        b=CZbA4PkDJGtCs5Fgdc4fdISKKvvPqLTyeWegvn9LHF3wQI3CKdfZwveig0/LRZPF7Z
         j0j3OIuMZ3PiqI+cVcb9Fyf+531rSB+OASdZm52wSq+rZlWd82q95mq6OrNqV7lw735Z
         TL5PwECoVAx+fG0YMwbimdCwGvyIR+iUaacf96xCfxfPjDrHf5w7+I2UyInQBo/uKW7m
         IyHsUi8HjAEQgmcHFC6KUDfscnTavjCmPYsUmww8sp0jRZdad+MDRb/ujkw5DQHEHgU8
         XyTmgXkWtIOh8dtvGTHscJv6JrTuEsb4MGlK6kV8HilHjibOcdtX19b7jsj1bTgh9O/9
         Gofg==
X-Gm-Message-State: AOAM532HD5Rt/MlaBEKANrEtGuhyN8YHJwIaVK6QhLe5pXU06d76xS0M
        f3q88dfsHHyHGVXYnvSUeXiAKQ==
X-Google-Smtp-Source: ABdhPJwy0oTu2o2WnKkue2AcW6YKBHustiMeVNrhbryx+OeQ6y1H8Rr3bvh4JQxasU+B4vomTScXCg==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr19674722plr.152.1595863179706;
        Mon, 27 Jul 2020 08:19:39 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id 66sm16045562pfg.63.2020.07.27.08.19.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:19:39 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, tony.luck@intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 7/9] PCI/AER: Add RCEC AER handling
Date:   Mon, 27 Jul 2020 08:19:39 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <6C5C96C5-0365-48A0-B623-1A4C0CE0D13E@intel.com>
In-Reply-To: <20200727132252.0000644c@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-8-sean.v.kelley@intel.com>
 <20200727132252.0000644c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 5:22, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:21 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
>> and also have the AER capability. So add RCEC support to the current 
>> AER
>> service driver and attach the AER service driver to the RCEC device.
>>
>> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> A few questions and comments for this patch.
>
> See inline.
>
> Jonathan
>
>
>> ---
>>  drivers/pci/pcie/aer.c | 34 +++++++++++++++++++++++++++-------
>>  1 file changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index f1bf06be449e..7cc430c74c46 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -303,7 +303,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
>>  		return -EIO;
>>
>>  	port_type = pci_pcie_type(dev);
>> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT || port_type == 
>> PCI_EXP_TYPE_RC_EC) {
>>  		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
>>  		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
>>  	}
>> @@ -389,6 +389,12 @@ void pci_aer_init(struct pci_dev *dev)
>>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * 
>> n);
>>
>>  	pci_aer_clear_status(dev);
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) {
>> +		if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC))
>> +			return;
>> +		pci_info(dev, "AER: RCEC CAP FOUND and cap_has_rtctl = %d\n", n);
>
> It feels like failing to find an RC_EC extended cap in a RCEC deserved
> a nice strong error message.  Perhaps this isn't the right place to do 
> it
> though.  For that matter, why are we checking for it here?

Sorry, I’ve left an in-development output in the code.  Will replace 
with a check with more meaningful output elsewhere.

>
>> +	}
>>  }
>>
>>  void pci_aer_exit(struct pci_dev *dev)
>> @@ -577,7 +583,8 @@ static umode_t aer_stats_attrs_are_visible(struct 
>> kobject *kobj,
>>  	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
>>  	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
>>  	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
>
> It is a bit ugly to have these called rootport_total_err etc for the 
> rcec.
> Perhaps we should just add additional attributes to reflect we are 
> looking at
> an RCEC?

I was trying to avoid any renaming to reduce churn as I did with my 
first patch for ACPI / CLX_OSC support.
Will take a look.

>
>> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
>> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
>>  		return 0;
>>
>>  	return a->mode;
>> @@ -894,7 +901,10 @@ static bool find_source_device(struct pci_dev 
>> *parent,
>>  	if (result)
>>  		return true;
>>
>> -	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>> +	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(parent, find_device_iter, e_info);
>> +	else
>> +		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>>
>>  	if (!e_info->error_dev_num) {
>>  		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
>> @@ -1030,6 +1040,7 @@ int aer_get_device_error_info(struct pci_dev 
>> *dev, struct aer_err_info *info)
>>  		if (!(info->status & ~info->mask))
>>  			return 0;
>>  	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
>>  	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>>  		   info->severity == AER_NONFATAL) {
>>
>> @@ -1182,6 +1193,8 @@ static int set_device_error_reporting(struct 
>> pci_dev *dev, void *data)
>>  	int type = pci_pcie_type(dev);
>>
>>  	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (type == PCI_EXP_TYPE_RC_EC) ||
>> +	    (type == PCI_EXP_TYPE_RC_END) ||
>
> Why add RC_END here?

I’m not clear on your question.  Errors can come from RCEC or RCiEPs.  
We still need to enable reporting by the RCiEPs.

>
>>  	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>>  	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>>  		if (enable)
>> @@ -1206,9 +1219,11 @@ static void 
>> set_downstream_devices_error_reporting(struct pci_dev *dev,
>>  {
>>  	set_device_error_reporting(dev, &enable);
>>
>> -	if (!dev->subordinate)
>> -		return;
>> -	pci_walk_bus(dev->subordinate, set_device_error_reporting, 
>> &enable);
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
>> +	else if (dev->subordinate)
>> +		pci_walk_bus(dev->subordinate, set_device_error_reporting, 
>> &enable);
>> +
>>  }
>>
>>  /**
>> @@ -1306,6 +1321,11 @@ static int aer_probe(struct pcie_device *dev)
>>  	struct device *device = &dev->device;
>>  	struct pci_dev *port = dev->port;
>>
>> +	/* Limit to Root Ports or Root Complex Event Collectors */
>> +	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
>> +	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
>> +		return -ENODEV;
>> +
>>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>>  	if (!rpc)
>>  		return -ENOMEM;
>> @@ -1362,7 +1382,7 @@ static pci_ers_result_t aer_root_reset(struct 
>> pci_dev *dev)
>>
>>  static struct pcie_port_service_driver aerdriver = {
>>  	.name		= "aer",
>> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
>> +	.port_type	= PCIE_ANY_PORT,
>
> Why this particular change?  Seems that is a lot wider than simply
> adding RCEC.  Obviously we'll then drop out in the aer_probe but it
> is still rather inelegant.

In order to extend the service drivers to non-root-port devices (i.e., 
RCEC), the simple path appeared to only require setting the type to 
ANY_PORT and catching the needed types arriving in the probe.  Would you 
prefer extending to a type2?  I’m not sure how one is more elegant 
than another but open to that approach.  However, this seems to require 
less code perhaps and seems consistent with most ‘drop-out’ 
conditional patterns in the kernel.  The same applies to pme.

Thanks,

Sean


>
>>  	.service	= PCIE_PORT_SERVICE_AER,
>>
>>  	.probe		= aer_probe,
