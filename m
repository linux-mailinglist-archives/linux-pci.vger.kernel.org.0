Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9B289B41
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403784AbgJIVyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbgJIVyp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 17:54:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201BC0613D5
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 14:54:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d1so9164847qtr.6
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=FbC6aoE3uRHszoq5GVAO+4jwFCIkUD1I1BvVoR1AJiU=;
        b=J/X8mT4ZgVAq/PbPe/JqXMXjeNkdSSGHB4WGI1GHe5skPBzFRkSNKZOXIc6sDmORXP
         sN2oC+5KhOHhFsoejoXP5jrPqANO/bDmpqEZH4fH1KkhwQTXKodwm7pHz5TBhuh0+6RK
         e8JpWs52uTpq1mwuuh6rvud9WZlDOqi454hI8TDpuCZlqwrPTafbP8stbnXVv6zCJ3DX
         zV4QPX5V7uAP+c4YJJas2/b+tD7rmnSYNaxJZhQ8F42JdbFAZEWlkGQUQWwafB45qYif
         twO+CWvENN0aQCWC/WWDNgbmgRU7elKI4VTnpBljnHMAdlhTsSiweeZeOzILW7UGxE1Q
         OQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=FbC6aoE3uRHszoq5GVAO+4jwFCIkUD1I1BvVoR1AJiU=;
        b=JRsiU6cf7eOdlFawJzGmFjzKp8BzgUP57yd8kVYptPJxp6zIg3WLx18hKwoe1OkUYz
         d6TEIFVo2+nrWwmoYcZZbFE/RrhPDEhU3GeToR43is7T/IzQIVwN2gcEZnR2ARQysMPr
         l+h6lMsGFrzfKEkgq1FufcyMndsUEVp+H/djye5OQiPt8EX0kVMsydSkn26wdmecujd1
         YwPQd2JClG5aRbphoIcWYBwsID7Y8wnIgXSJIMEdckVym8ukWUOvDbFh+5EIlUpn+R/b
         f1y3CIG6tVZmGXpi5XekNkQh67zkB5hhu4/M/9gskeQK5MyYruSgO//YFj/GRVpm9V2i
         D8XQ==
X-Gm-Message-State: AOAM530q6Lcbg1E6hM+CPGQtVdTQmaqALPSDKYrc0Fg0HIWY3MWGrFih
        A9vD7qzlfGT0sP+qBYZHPLYC3w==
X-Google-Smtp-Source: ABdhPJxDyNkULIpel03Ojc9hUYJBDwCyVw2/TyQK//ilSGyvIYPVLqzv+H+IozVoEc0YBbeu/FzMAA==
X-Received: by 2002:ac8:4e01:: with SMTP id c1mr32136qtw.343.1602280484765;
        Fri, 09 Oct 2020 14:54:44 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id z66sm4767298qkb.50.2020.10.09.14.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 14:54:44 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/14] PCI/AER: Extend AER error handling to RCECs
Date:   Fri, 09 Oct 2020 14:54:41 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <B4D9FE02-CEF8-4CE9-BFDA-E2E09A1B0AA4@intel.com>
In-Reply-To: <20201009212721.GA3503883@bjorn-Precision-5520>
References: <20201009212721.GA3503883@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9 Oct 2020, at 14:27, Bjorn Helgaas wrote:

> On Fri, Oct 02, 2020 at 11:47:29AM -0700, Sean V Kelley wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Currently the kernel does not handle AER errors for Root Complex
>> integrated End Points (RCiEPs)[0]. These devices sit on a root bus 
>> within
>> the Root Complex (RC). AER handling is performed by a Root Complex 
>> Event
>> Collector (RCEC) [1] which is a effectively a type of RCiEP on the 
>> same
>> root bus.
>>
>> For an RCEC (technically not a Bridge), error messages "received" 
>> from
>> associated RCiEPs must be enabled for "transmission" in order to 
>> cause a
>> System Error via the Root Control register or (when the Advanced 
>> Error
>> Reporting Capability is present) reporting via the Root Error Command
>> register and logging in the Root Error Status register and Error 
>> Source
>> Identification register.
>>
>> In addition to the defined OS level handling of the reset flow for 
>> the
>> associated RCiEPs of an RCEC, it is possible to also have non-native
>> handling. In that case there is no need to take any actions on the 
>> RCEC
>> because the firmware is responsible for them. This is true where APEI 
>> [2]
>> is used to report the AER errors via a GHES[v2] HEST entry [3] and
>> relevant AER CPER record [4] and non-native handling is in use.
>>
>> We effectively end up with two different types of discovery for
>> purposes of handling AER errors:
>>
>> 1) Normal bus walk - we pass the downstream port above a bus to which
>> the device is attached and it walks everything below that point.
>>
>> 2) An RCiEP with no visible association with an RCEC as there is no 
>> need
>> to walk devices. In that case, the flow is to just call the callbacks 
>> for
>> the actual device, which in turn references its associated RCEC.
>>
>> Modify pci_walk_bridge() to handle devices which lack a subordinate 
>> bus.
>> If the device does not then it will call the function on that device
>> alone.
>>
>> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex
>> Integrated Endpoint Rules.
>> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling 
>> and
>> Logging
>> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface 
>> (APEI)
>> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
>> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pcie/err.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 5ff1afa4763d..c4ceca42a3bf 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -148,19 +148,25 @@ static int report_resume(struct pci_dev *dev, 
>> void *data)
>>
>>  /**
>>   * pci_walk_bridge - walk bridges potentially AER affected
>> - * @bridge   bridge which may be a Port.
>> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
>> + *           an RCiEP associated with an RCEC, or a Port.
>>   * @cb       callback to be called for each device found
>>   * @userdata arbitrary pointer to be passed to callback.
>>   *
>>   * If the device provided is a bridge, walk the subordinate bus,
>>   * including any bridged devices on buses under this bus.
>>   * Call the provided callback on each device found.
>> + *
>> + * If the device provided has no subordinate bus, call the provided
>> + * callback on the device itself.
>>   */
>>  static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct 
>> pci_dev *, void *),
>>  			    void *userdata)
>>  {
>>  	if (bridge->subordinate)
>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +	else
>> +		cb(bridge, userdata);
>>  }
>>
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>> @@ -174,11 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  	/*
>>  	 * Error recovery runs on all subordinates of the first downstream
>>  	 * bridge. If the downstream bridge detected the error, it is
>> -	 * cleared at the end.
>> +	 * cleared at the end. For RCiEPs we should reset just the RCiEP 
>> itself.
>>  	 */
>>  	type = pci_pcie_type(dev);
>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    type == PCI_EXP_TYPE_DOWNSTREAM)
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type == PCI_EXP_TYPE_RC_EC ||
>
> What is the case where an RCEC is passed to pcie_do_recovery()?  I
> guess it's the case where an RCEC is reporting an error that it logged
> itself, i.e., no RCiEP is involved at all?  In that case I guess we
> should try an FLR on the RCEC and clear its status?
>
> (I don't think the current series attempts the FLR.)

Correct, we can get errors reported by that same RCEC that are not
related to the associated RCiEPs. Further, an RCiEP in reporting an
error will trigger logging to the Root Error Command/Status and Error
Source Identification registers of the associated RCEC. The assumption
in pcie_do_recovery() here is that I can cover both scenarios.

We could attempt an FLR on the RCEC itself as well.


>
>> +	    type == PCI_EXP_TYPE_RC_END)
>>  		bridge = dev;
>>  	else
>>  		bridge = pci_upstream_bridge(dev);
>> @@ -186,7 +194,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
>> *dev,
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
>> -		status = reset_subordinate_device(bridge);
>> +		if (type == PCI_EXP_TYPE_RC_END) {
>> +			pci_warn(dev, "subordinate device reset not possible for 
>> RCiEP\n");
>> +			status = PCI_ERS_RESULT_NONE;
>> +			goto failed;
>> +		}
>> +
>> +		status = reset_subordinate_devices(bridge);
>>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(dev, "subordinate device reset failed\n");
>>  			goto failed;
>> @@ -219,7 +233,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
>> *dev,
>>  	pci_walk_bridge(bridge, report_resume, &status);
>>
>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    type == PCI_EXP_TYPE_DOWNSTREAM) {
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type == PCI_EXP_TYPE_RC_EC) {
>>  		if (pcie_aer_is_native(bridge))
>>  			pcie_clear_device_status(bridge);
>>  		pci_aer_clear_nonfatal_status(bridge);
>> -- 
>> 2.28.0
>>
