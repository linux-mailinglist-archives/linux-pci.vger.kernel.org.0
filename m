Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C10280C9E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 06:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgJBEPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 00:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJBEPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 00:15:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A1DC0613D0
        for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2020 21:15:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so359232pfn.9
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCG+f2QSNVgoR18fTBsnkmJJglqEGdhf6XYE51k3PwA=;
        b=mRQgnespe5/t+naQoqSBDCHqf1WGaJTPOLKX2ZOx6umUHYzOPET5n4GnIln7WSp29P
         QgSfoOL+fktLQc2+gFVeA36vae+MW63Og8ug/Y6xLyCo8UHyhHDp57wnqXYp6nyIGU2i
         MxtrTgDhno/D/VLX88sJkIuQJM9lWFsPySRboT/xnLJ4o9mM16z22DBuc/Zl2A++RAU5
         yeb4cGryNfY92Vv3OB4yXZlc1pSY0hZdxkPn5T7Ml8YdCqhllvnNf7Hkyhir11dc5snD
         9sImLRnkKc//A/AGHjA02JZmiQIH20c/AaEBEshDN4eVCIfLW+POF9FpW8m8IZP78JjP
         pdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCG+f2QSNVgoR18fTBsnkmJJglqEGdhf6XYE51k3PwA=;
        b=EtMdJ4JzgTKpaMkuAM15RaQTx4J7iukeZeO4yiKpPqTYDiCzFA8nl0x7NWXOXlpNZn
         gNl+OOnE90htdQ7AWm5jj9LdEPqWiwvqtWpJbwKPSoVngQc5OvAUCz8fx6GJk74QcJ41
         dpFjBtTxpO5kVCcZlX4/GBHEhq2Ro1420eADhMV8k9sSxz28aSh8QVVmHtuxmPcvUO0J
         fjelY/2es6IPOJuexUpPufRQ05IfbU0tVqIqwrXDwJnpxZFhhAuji3y7dhpf2dokYx3U
         Qr5SVoR0mU1mb1A+m/qyasyNdT0OfPp5JnF7lAPjb6jyEamsWoCkeyYUZU6gmh8dzhUB
         AOLA==
X-Gm-Message-State: AOAM532OHaTiRSbE8vcM+0wi1MvT1Y/a9JqHTxsdE8EMeZxOH+f18+mJ
        qzazxeA9JozyQlbJbbHe44ZiUw==
X-Google-Smtp-Source: ABdhPJzgBbNizousJDYI/cl1jEY2YddBxSt+TaGRCT78Uf6lUwXy715tNZhzd5vfpoOhB8nJJCyHWw==
X-Received: by 2002:a62:301:0:b029:13c:1611:6587 with SMTP id 1-20020a6203010000b029013c16116587mr582826pfd.4.1601612112834;
        Thu, 01 Oct 2020 21:15:12 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id e2sm209209pgc.29.2020.10.01.21.15.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 21:15:11 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/13] PCI/AER: Extend AER error handling to RCECs
Date:   Thu, 01 Oct 2020 21:15:10 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <927A388B-E682-4420-9EEA-B62C10E64CB7@intel.com>
In-Reply-To: <20201001231407.GA2743007@bjorn-Precision-5520>
References: <20201001231407.GA2743007@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1 Oct 2020, at 16:14, Bjorn Helgaas wrote:

> On Wed, Sep 30, 2020 at 02:58:14PM -0700, Sean V Kelley wrote:
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
>> A new walk function pci_walk_bridge(), similar to pci_walk_bus(),
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
>> ---
>>  drivers/pci/pcie/err.c | 52 
>> +++++++++++++++++++++++++++++++++---------
>>  1 file changed, 41 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 9e552330155b..c4ceca42a3bf 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -146,44 +146,73 @@ static int report_resume(struct pci_dev *dev, 
>> void *data)
>>  	return 0;
>>  }
>>
>> +/**
>> + * pci_walk_bridge - walk bridges potentially AER affected
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
>> +static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct 
>> pci_dev *, void *),
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
>>  			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev 
>> *pdev))
>>  {
>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> -	struct pci_bus *bus;
>>  	struct pci_dev *bridge;
>>  	int type;
>>
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
>> +	    type == PCI_EXP_TYPE_RC_END)
>>  		bridge = dev;
>>  	else
>>  		bridge = pci_upstream_bridge(dev);
>>
>> -	bus = bridge->subordinate;
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>> -		pci_walk_bus(bus, report_frozen_detected, &status);
>> -		status = reset_subordinate_device(dev);
>> +		pci_walk_bridge(bridge, report_frozen_detected, &status);
>
> Wonder if it would be worth splitting out the pci_walk_bus() to
> pci_walk_bridge() change -- initially pci_walk_bridge() would do only
> this:
>
>   if (bridge->subordinate)
>     pci_walk_bus(bridge->subordinate, cb, userdata);
>
> so basically just rename it and move the bridge->subordinate
> dereference out.

Sure, that’s fine. It was actually something that crossed my mind when 
I was doing this prior splitting out because I realized I still needed 
to dereference the bus and was disappointed to keep it here.


>
> Then the next patch would be a lot smaller and would add the
> !bridge->subordinate case (which I think is only for RC_EC & RC_END?)

Correct the check on bridge && bridge->subordinate comes in with the 
RC_EC & RC_END

>
>> +		if (type == PCI_EXP_TYPE_RC_END) {
>> +			pci_warn(dev, "subordinate device reset not possible for 
>> RCiEP\n");
>> +			status = PCI_ERS_RESULT_NONE;
>> +			goto failed;
>> +		}
>> +
>> +		status = reset_subordinate_devices(bridge);
>
> I missed the reason for this change:
>
>   -		status = reset_subordinate_device(dev);
>   +		status = reset_subordinate_devices(bridge);

This should have happened in the ‘bridge’ renaming patch. This was 
going to be either a reset of dev or dev->bus->self depending on the 
type via the assignment of dev = prior to renaming in (5/13). I should 
move this change back to the bridge renaming patch.

Thanks,

Sean

>
>>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(dev, "subordinate device reset failed\n");
>>  			goto failed;
>>  		}
>>  	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>> +		pci_walk_bridge(bridge, report_normal_detected, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>> -		pci_walk_bus(bus, report_mmio_enabled, &status);
>> +		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> @@ -194,17 +223,18 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  		 */
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>> -		pci_walk_bus(bus, report_slot_reset, &status);
>> +		pci_walk_bridge(bridge, report_slot_reset, &status);
>>  	}
>>
>>  	if (status != PCI_ERS_RESULT_RECOVERED)
>>  		goto failed;
>>
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_walk_bus(bus, report_resume, &status);
>> +	pci_walk_bridge(bridge, report_resume, &status);
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
