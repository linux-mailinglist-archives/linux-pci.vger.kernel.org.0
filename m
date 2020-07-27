Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4822F330
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgG0O7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgG0O7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 10:59:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181AC061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 07:59:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so315378plk.13
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AP1LTna2M04fZEH/VKZDdBtI8gQnZY3UmFMJJBlF6Io=;
        b=duuZVQqGZKuShRNquZ0TD4MlQpDZaLcxeI7hopqCCA+cD4SQTlKZQ9AYC2QV2fl+v4
         ka4Mw7AC7URqYwhmd3v+ro5tmsu/vSNWQAoTiu+HB7S/06wrjPRHTcifu0Gc7ly/6+Yt
         kpi5bFeu1FqSHsUr+/uNazcS+ZE0+IbFNhY9l8NdVykux9ZxIXj9ILa6bMy0G/IJEwuN
         B/nu47JP4sDcg4XaqOnRPlfYIOIc587rgagl9HjTQLqQpmyRkzIb/+S8/6vZb/K5B0TN
         vMDCpCUOvW8xpDa8cNqIfE63EVSQwomrAkYJe7FChNOwx5t2K1DLtdlbZLLTVzbRIqaY
         CAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AP1LTna2M04fZEH/VKZDdBtI8gQnZY3UmFMJJBlF6Io=;
        b=p75J620bb7w2q4b+XHriT/nmBS6ZOMXFCiHrvnchDwxBur7KDCtPZtUJEWmUqYtUt5
         g8NSccvGIkyts+bih0GTLqyhG5T0LNPptS81Kw+9Ye0m+waNbqRFis9rC2dLnUXmUIjQ
         9rzfwV6zfYa8ljzJ8mc8q2aTXk/7kGSR+X0wlD2ys1cURrN4hUcADK3chED/0e2oNSte
         iFQ6BkvDtaM2AcYkdtkf2jYrrrbdXEXsACijgr9OzsrZbPLVIqLuhDyg10AvXYgiydwD
         pBChJNcb79buV0lKE7AKk8Hqmcy9MGiOtLsyjMyCGs2ZKDFD34aZJZvIqjs6y1wh6RpE
         D1hw==
X-Gm-Message-State: AOAM5310S0NlOpqGWUS5XpyTAo8nLE+BaHgnmjcF6x/6zeFEFDQfQdAl
        rvmmTlSMLOpF8HvLnoAnPmXnBQ==
X-Google-Smtp-Source: ABdhPJyJ/m/BBDazh7PpwjIETEev09YyhBdQ3pP1yk22rr0dQXdrhsp+5g6V2S4Kfr8qhViDOdVmGA==
X-Received: by 2002:a17:90a:6946:: with SMTP id j6mr16822132pjm.223.1595861939620;
        Mon, 27 Jul 2020 07:58:59 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id x8sm3204289pfp.101.2020.07.27.07.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:58:58 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, ashok.raj@kernel.org,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] PCI/AER: Extend AER error handling to RCECs
Date:   Mon, 27 Jul 2020 07:58:59 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <763CB36C-4D47-4A59-BBEF-577E48FD1A18@intel.com>
In-Reply-To: <20200727120019.000030d2@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-5-sean.v.kelley@intel.com>
 <20200727120019.000030d2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 4:00, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:18 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Currently the kernel does not handle AER errors for Root Complex =

>> integrated
>> End Points (RCiEPs)[0]. These devices sit on a root bus within the =

>> Root Complex
>> (RC). AER handling is performed by a Root Complex Event Collector =

>> (RCEC) [1]
>> which is a effectively a type of RCiEP on the same root bus.
>>
>> For an RCEC (technically not a Bridge), error messages "received" =

>> from
>> associated RCiEPs must be enabled for "transmission" in order to =

>> cause a
>> System Error via the Root Control register or (when the Advanced =

>> Error
>> Reporting Capability is present) reporting via the Root Error Command
>> register and logging in the Root Error Status register and Error =

>> Source
>> Identification register.
>>
>> In addition to the defined OS level handling of the reset flow for =

>> the
>> associated RCiEPs of an RCEC, it is possible to also have a firmware =

>> first
>> model. In that case there is no need to take any actions on the RCEC =

>> because
>> the firmware is responsible for them. This is true where APEI [2] is =

>> used
>> to report the AER errors via a GHES[v2] HEST entry [3] and relevant
>> AER CPER record [4] and Firmware First handling is in use.
>>
>> We effectively end up with two different types of discovery for
>> purposes of handling AER errors:
>>
>> 1) Normal bus walk - we pass the downstream port above a bus to which
>> the device is attached and it walks everything below that point.
>>
>> 2) An RCiEP with no visible association with an RCEC as there is no =

>> need to
>> walk devices. In that case, the flow is to just call the callbacks =

>> for the actual
>> device.
>>
>> A new walk function, similar to pci_bus_walk is provided that takes a =

>> pci_dev
>> instead of a bus. If that dev corresponds to a downstream port it =

>> will walk
>> the subordinate bus of that downstream port. If the dev does not then =

>> it
>> will call the function on that device alone.
>>
>> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex =

>> Integrated
>>     Endpoint Rules.
>> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling =

>> and Logging
>> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface =

>> (APEI)
>> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
>> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>> Changes since v2 [1]:
>>
>> - Renamed to pci_walk_dev_affected() to reflect the aer affected =

>> devices
> Make sense.
>
>> - Localized to err.c and made static
>
> Makes sense.
>
>> - Added check for RCEC to reflect
> That comment probably needs a bit more...

Will add to the details.

>
>> - Tightened up commit log from earlier inquiry focused RFC
> Cool.
>
>
> Looks good to me and I like the new naming.
>
> A few really trivial tidy ups suggested for things that were less than =

> neat in my patch.
>
> Jonathan
>
>>
>> [1] =

>> https://lore.kernel.org/linux-pci/20200622114402.892798-1-Jonathan.Cam=
eron@huawei.com/
>> ---
>>  drivers/pci/pcie/err.c | 55 =

>> ++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 14bb8f54723e..044df004f20b 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -146,38 +146,69 @@ static int report_resume(struct pci_dev *dev, =

>> void *data)
>>  	return 0;
>>  }
>>
>> +/** pci_walk_dev_affected - walk devices potentially AER affected
> /**
>  * pci_walk_dev_affected
>
> There is a bit of a mixture in pci files between the two styles, but
> I'm fairly sure kernel-doc is supposed to be as I'm suggesting
> (I had this wrong due to cut and paste in earlier version!)

Will fix.

>
>> + *  @dev      device which may be an RCEC with associated RCiEPs,
>> + *            an RCiEP associated with an RCEC, or a Port.
>> + *  @cb       callback to be called for each device found
>> + *  @userdata arbitrary pointer to be passed to callback.
>> + *
>> + *  If the device provided is a port, walk the subordinate bus,
>> + *  including any bridged devices on buses under this bus.
>> + *  Call the provided callback on each device found.
>> + *
>> + *  If the device provided has no subordinate bus, call the provided
>> + *  callback on the device itself.
>> + *
>
> I also had an ugly pointless newline here. oops :)

Will fix.

Thanks,

Sean

>
>> + */
>> +static void pci_walk_dev_affected(struct pci_dev *dev, int =

>> (*cb)(struct pci_dev *, void *),
>> +				  void *userdata)
>> +{
>> +	if (dev->subordinate) {
>> +		pci_walk_bus(dev->subordinate, cb, userdata);
>> +	} else {
>> +		cb(dev, userdata);
>> +	}
>> +}
>> +
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  			enum pci_channel_state state,
>>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>>  {
>>  	pci_ers_result_t status =3D PCI_ERS_RESULT_CAN_RECOVER;
>> -	struct pci_bus *bus;
>>
>>  	/*
>>  	 * Error recovery runs on all subordinates of the first downstream =

>> port.
>>  	 * If the downstream port detected the error, it is cleared at the =

>> end.
>> +	 * For RCiEPs we should reset just the RCiEP itself.
>>  	 */
>>  	if (!(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> -	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
>> +	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>> +	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END ||
>> +	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC))
>>  		dev =3D dev->bus->self;
>> -	bus =3D dev->subordinate;
>>
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state =3D=3D pci_channel_io_frozen) {
>> -		pci_walk_bus(bus, report_frozen_detected, &status);
>> +		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>> +		if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END) {
>> +			pci_warn(dev, "link reset not possible for RCiEP\n");
>> +			status =3D PCI_ERS_RESULT_NONE;
>> +			goto failed;
>> +		}
>> +
>>  		status =3D reset_link(dev);
>>  		if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(dev, "link reset failed\n");
>>  			goto failed;
>>  		}
>>  	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>> +		pci_walk_dev_affected(dev, report_normal_detected, &status);
>>  	}
>>
>>  	if (status =3D=3D PCI_ERS_RESULT_CAN_RECOVER) {
>>  		status =3D PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>> -		pci_walk_bus(bus, report_mmio_enabled, &status);
>> +		pci_walk_dev_affected(dev, report_mmio_enabled, &status);
>>  	}
>>
>>  	if (status =3D=3D PCI_ERS_RESULT_NEED_RESET) {
>> @@ -188,17 +219,21 @@ pci_ers_result_t pcie_do_recovery(struct =

>> pci_dev *dev,
>>  		 */
>>  		status =3D PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>> -		pci_walk_bus(bus, report_slot_reset, &status);
>> +		pci_walk_dev_affected(dev, report_slot_reset, &status);
>>  	}
>>
>>  	if (status !=3D PCI_ERS_RESULT_RECOVERED)
>>  		goto failed;
>>
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_walk_bus(bus, report_resume, &status);
>> +	pci_walk_dev_affected(dev, report_resume, &status);
>>
>> -	pci_aer_clear_device_status(dev);
>> -	pci_aer_clear_nonfatal_status(dev);
>> +	if ((pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>> +	     pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC)) {
>> +		pci_aer_clear_device_status(dev);
>> +		pci_aer_clear_nonfatal_status(dev);
>> +	}
>>  	pci_info(dev, "device recovery successful\n");
>>  	return status;
>>
