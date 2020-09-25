Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C771E2793F5
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIYWIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgIYWIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 18:08:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38737C0613D3
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:08:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so201741pjb.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZxOp9tVMkxfN5SUB+XDS9nUQK1Eu5dH5U37a/M6GoE=;
        b=BaEN8KyJCF6NBhUqisFySpUDzKj1IIziINakIejJOH5OPzj0MU6loF2dN0r+JdSbIt
         WrK/6gfyc5lvXal98V+aXLUdyjM3MRkQL4pXVdS/KyMNDlU58hC5ayOKl6BWXWqMby9x
         xyjNiJ9RNfSDfYusdiTQz2VZibawpH/7a3g3wbs7Yy906rTuZzIwOwZPszbojcnTnsHU
         1AHepO7bY/0dxoOACk4Jg91d9la5uWkPpl2XaVMCUgRPoqeF/BmFXQoT7bGGqN+hif95
         nvjfaxm/41g/tjczKZJoXWwdgddVcZ09fi1QfwMPsIeKnlTLUjviufV+p+OhyYYb6scn
         XXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZxOp9tVMkxfN5SUB+XDS9nUQK1Eu5dH5U37a/M6GoE=;
        b=G7Xj/6q8HpJpVH2WE/jHoyA0NngJK6dh7xCCZI4tkGye0xeEpLwbIDAudpvjZvKlUG
         Z8dRlUOjftUELyunRyzFQkPDI7r+VRIn1iP+i0yl4PaLv0y1Lm2qKpDqQJJr9WycwaJA
         aUe2FjEaAlCGxP7ZbEO5tQIyrd85dERVunKPn0RGkmnIG2q5RNm1+T6i6iLEWL0hxzrv
         3abJAM+TDDMtn2PeR8F+zM0aH2wgSn904B+K7Mf7QeeW6BawZEF4fruW1Nfb1Bih2Fnw
         lyV2tApMJgdHfHp5fS5eeYx4/J/NmM8Wn3bfsvpKh0XnMTe96MF5ThnHWmnDlRWmEIux
         yUNg==
X-Gm-Message-State: AOAM533JCudylxPecRvslEtZkuKYHJbUOvUk1aolo1FrepOnfkv2XD8b
        YVPH1cnEYF0WrNyA8LrRASN4Ww==
X-Google-Smtp-Source: ABdhPJw0tEKLdmdxCfm53AhkjiCExkZGb69Mhfj2dejUvBsJrdED2GVLcEupZ2SbyyV4uZ2ekJdFDg==
X-Received: by 2002:a17:90a:f411:: with SMTP id ch17mr571481pjb.38.1601071703555;
        Fri, 25 Sep 2020 15:08:23 -0700 (PDT)
Received: from [10.212.51.97] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id b11sm3544145pfd.33.2020.09.25.15.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 15:08:22 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sinan Kaya" <okaya@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/AER: Extend AER error handling to RCECs
Date:   Fri, 25 Sep 2020 15:08:20 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <4F494177-8691-4110-9BB0-97D35F233892@intel.com>
In-Reply-To: <20200925211407.GA2457926@bjorn-Precision-5520>
References: <20200925211407.GA2457926@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 Sep 2020, at 14:14, Bjorn Helgaas wrote:

> [+cc Sinan, who's been reviewing changes in this area (thanks, 
> Sinan!)]
>
> On Tue, Sep 22, 2020 at 02:38:53PM -0700, Sean V Kelley wrote:
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
>> A new walk function pci_bridge_walk(), similar to pci_bus_walk(),
>> is provided that takes a pci_dev instead of a bus. If that bridge
>> corresponds to a downstream port it will walk the subordinate bus of
>> that bridge. If the device does not then it will call the function on
>> that device alone.
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
>
> I like this patch.  I think there are a few things that could be
> peeled off as "no functional change" preliminary patches to make the
> important changes more obvious in the "money patch".

Great, it was helpful to discuss at LPC to give it more clarity.
>
>> ---
>>  drivers/pci/pci.h      |  2 +-
>>  drivers/pci/pcie/err.c | 77 
>> +++++++++++++++++++++++++++++++-----------
>>  2 files changed, 59 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 83670a6425d8..7b547fc3679a 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -575,7 +575,7 @@ static inline int 
>> pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>>  /* PCI error reporting and recovery */
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  			pci_channel_state_t state,
>> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
>> +			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev 
>> *pdev));
>>
>>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>>  #ifdef CONFIG_PCIEASPM
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index c543f419d8f9..e575fa6cee63 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -146,38 +146,73 @@ static int report_resume(struct pci_dev *dev, 
>> void *data)
>>  	return 0;
>>  }
>>
>> +/**
>> + * pci_bridge_walk - walk bridges potentially AER affected
>> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
>> + *           an RCiEP associated with an RCEC, or a Port.
>> + * @cb       callback to be called for each device found
>> + * @userdata arbitrary pointer to be passed to callback.
>> + *
>> + * If the device provided is a bridge, walk the subordinate bus,
>> + * including any bridged devices on buses under this bus.
>> + * Call the provided callback on each device found.
>> + *
>> + * If the device provided has no subordinate bus, call the provided
>> + * callback on the device itself.
>> + */
>> +static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct 
>> pci_dev *, void *),
>
> Maybe call this pci_walk_bridge() so it's the same order as the
> existing pci_walk_bus(), unless there's some reason to be different.

Yes, I was wanting to distinguish it from pci_walk_bus() in some way 
because it incorporated it and I wanted to put emphasis on the bridge 
first. But in retrospect, I’m saying the same thing so might as well 
be consistent! Will change.

>
>> +			    void *userdata)
>> +{
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +	else
>> +		cb(bridge, userdata);
>> +}
>> +
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  			pci_channel_state_t state,
>> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>> +			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev 
>> *pdev))
>
> The rename to "reset_subordinate_devices" seems separable, since it
> doesn't change the interface.

Agree, it’s rather independent. Also changed a warning string output. 
Will make separate.

>
>>  {
>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> -	struct pci_bus *bus;
>> +	struct pci_dev *bridge;
>> +	int type;
>>
>>  	/*
>> -	 * Error recovery runs on all subordinates of the first downstream 
>> port.
>> -	 * If the downstream port detected the error, it is cleared at the 
>> end.
>> +	 * Error recovery runs on all subordinates of the first downstream
>> +	 * bridge. If the downstream bridge detected the error, it is
>> +	 * cleared at the end. For RCiEPs we should reset just the RCiEP 
>> itself.
>>  	 */
>> -	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
>> -		dev = dev->bus->self;
>> -	bus = dev->subordinate;
>> +	type = pci_pcie_type(dev);
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type == PCI_EXP_TYPE_RC_EC ||
>> +	    type == PCI_EXP_TYPE_RC_END)
>> +		bridge = dev;
>> +	else
>> +		bridge = pci_upstream_bridge(dev);
>
> This makes it much easier to read, thank you.  I think the addition of
> "type", rename of "dev" to "bridge", the inversion of the condition
> (major improvement, thanks again), and use of pci_upstream_bridge()
> instead of dev->bus->self might also be separable?

Agree, it’s separable. Will do.

>
> Of course, you'd have to add the RC_EC and RC_END cases later, in the
> money patch, but that's a good thing because it won't get lost in all
> the other things being changed.

Makes sense to me.

>
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>> -		pci_walk_bus(bus, report_frozen_detected, &status);
>> -		status = reset_link(dev);
>> +		pci_bridge_walk(bridge, report_frozen_detected, &status);
>> +		if (type == PCI_EXP_TYPE_RC_END) {
>> +			pci_warn(dev, "link reset not possible for RCiEP\n");
>> +			status = PCI_ERS_RESULT_NONE;
>> +			goto failed;
>> +		}
>> +
>> +		status = reset_subordinate_devices(bridge);
>>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>> -			pci_warn(dev, "link reset failed\n");
>> +			pci_warn(dev, "subordinate device reset failed\n");
>>  			goto failed;
>>  		}
>>  	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>> +		pci_bridge_walk(bridge, report_normal_detected, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>> -		pci_walk_bus(bus, report_mmio_enabled, &status);
>> +		pci_bridge_walk(bridge, report_mmio_enabled, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> @@ -188,18 +223,22 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  		 */
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>> -		pci_walk_bus(bus, report_slot_reset, &status);
>> +		pci_bridge_walk(bridge, report_slot_reset, &status);
>>  	}
>>
>>  	if (status != PCI_ERS_RESULT_RECOVERED)
>>  		goto failed;
>>
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_walk_bus(bus, report_resume, &status);
>> -
>> -	if (pcie_aer_is_native(dev))
>> -		pcie_clear_device_status(dev);
>> -	pci_aer_clear_nonfatal_status(dev);
>> +	pci_bridge_walk(bridge, report_resume, &status);
>> +
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type == PCI_EXP_TYPE_RC_EC) {
>
> Addition of this check also seems worthy of a separate patch (for just
> root ports and downstream ports first, then RC_EC being added later).
> That would make a convenient place to explain why we need the change.
> I think it's *correct*; it just gets lost in the noise and not even
> mentioned when it's done as part of one big patch.

It does feel a bit out of place here and having the space to also 
explain why this change is needed would be worthy of the separation. 
Will do.

Thanks!

Sean


>
>> +		if (pcie_aer_is_native(bridge))
>> +			pcie_clear_device_status(bridge);
>> +		pci_aer_clear_nonfatal_status(bridge);
>> +	}
>>  	pci_info(dev, "device recovery successful\n");
>>  	return status;
>>
>> -- 
>> 2.28.0
>>
