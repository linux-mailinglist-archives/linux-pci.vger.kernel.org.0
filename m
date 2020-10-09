Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90C289179
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388144AbgJISxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 14:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgJISxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 14:53:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC29C0613D2
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 11:53:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r21so4560960pgj.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyLV6sLV00caFgGk9PiR+O+gn3aUFBh8cwMoQ42GGvM=;
        b=ybliSMPV1SASp0fh0b6PIeGTFZPbqpkzLnXc4auPBEvKcRwjAeBJAhaE+hL35MJM5l
         0rOMteoN1Zj/Ago1AvSzIc4xZoCKsoy0R91LwmIQCsQZyJYPjkuqi4yFzCzjyWkZ01M6
         z30KDVrdJbo2y97In7slYRqx5tlbZIbgPULDzCWpo+IPimh/yE8AE/m4PQfP+YpRVyS7
         ofwbtNjmd7UM6eBdIiz155IqHBVoQNKRttK2FnvSqMHEH5hJ3tc9oExDFjl0TlSS4mae
         8eC+jbM1mAdRQEpu9ujpvUN21XDb9FNmWUF8T/j5G1MGsA0UFhet01TWppDiS/m9p+DI
         DDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyLV6sLV00caFgGk9PiR+O+gn3aUFBh8cwMoQ42GGvM=;
        b=NuS7RIm5F7cGxb+jEXoWrZX4v46DyTw+ThyMMoiMvRmI8klunF0S9U4Qj5/0yAetTM
         RswmPD0Lp0NmxYg8IHeBJMUkM4E+SFX0TfHkChZZH3weALnmfZDGRTadWomdvIN2VsQu
         PqaIp4xXHNyARadNcofZuC+AkZAu780Co/NYOIqKk+IYMNA5v/2epJ0DbmpD9kf8kswq
         qtBcKNepKQDaF4rsCFeMBBGhFuR6H4/2Sog4uU0DrDZ77wbOh9CdvSODpMLZ2ROqj3sK
         P0AIZ0EucKtOS3Wq/M+0CNDi/I2iAIaUWKgr3jrdsVW/Rst8MUAjg1qpFyKOehLxWC4h
         mwTA==
X-Gm-Message-State: AOAM530U7b3+eQP+IFNb7avL9tDgrrvj1ZVJogy+tBPTUHbRcjegDL/U
        N3epLBcVOZwKybXSzoRFYnkrjQ==
X-Google-Smtp-Source: ABdhPJzdYYpTC4/utkBMI8hkwLu9MoVuEzFaf9ptmb7SP77Uo+l75JUFR9e9XtYFf3lo7QWWCNLfdw==
X-Received: by 2002:a17:90a:7c0c:: with SMTP id v12mr6062226pjf.71.1602269614526;
        Fri, 09 Oct 2020 11:53:34 -0700 (PDT)
Received: from [10.213.166.37] (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id s13sm11267035pgo.56.2020.10.09.11.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:53:33 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Fri, 09 Oct 2020 11:53:31 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <B3F01188-01A5-4807-B2C8-33AD5AD4A506@intel.com>
In-Reply-To: <C3CF4A15-B00B-4347-89C7-B331E17ECF69@intel.com>
References: <20201009175745.GA3489710@bjorn-Precision-5520>
 <41B2B0A9-80B0-41DA-9FF3-A5D9465E6E08@intel.com>
 <C3CF4A15-B00B-4347-89C7-B331E17ECF69@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9 Oct 2020, at 11:34, Sean V Kelley wrote:

> On 9 Oct 2020, at 11:26, Sean V Kelley wrote:
>
>> Hi Bjorn,
>>
>> On 9 Oct 2020, at 10:57, Bjorn Helgaas wrote:
>>
>>> On Fri, Oct 02, 2020 at 11:47:32AM -0700, Sean V Kelley wrote:
>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>
>>>> When attempting error recovery for an RCiEP associated with an RCEC 
>>>> device,
>>>> there needs to be a way to update the Root Error Status, the 
>>>> Uncorrectable
>>>> Error Status and the Uncorrectable Error Severity of the parent 
>>>> RCEC.
>>>> In some non-native cases in which there is no OS visible device
>>>> associated with the RCiEP, there is nothing to act upon as the 
>>>> firmware
>>>> is acting before the OS. So add handling for the linked 'rcec' in 
>>>> AER/ERR
>>>> while taking into account non-native cases.
>>>>
>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>  drivers/pci/pcie/aer.c |  9 +++++----
>>>>  drivers/pci/pcie/err.c | 39 
>>>> ++++++++++++++++++++++++++++-----------
>>>>  2 files changed, 33 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 65dff5f3457a..dccdba60b5d9 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device 
>>>> *dev)
>>>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>>>  {
>>>>  	int aer = dev->aer_cap;
>>>> +	int rc = 0;
>>>>  	u32 reg32;
>>>> -	int rc;
>>>> -
>>>>
>>>>  	/* Disable Root's interrupt in response to error messages */
>>>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>>>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>>>
>>>> -	rc = pci_bus_error_reset(dev);
>>>> -	pci_info(dev, "Root Port link has been reset\n");
>>>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
>>>> +		rc = pci_bus_error_reset(dev);
>>>> +		pci_info(dev, "Root Port link has been reset\n");
>>>> +	}
>>>>
>>>>  	/* Clear Root Error Status */
>>>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 38abd7984996..956ad4c86d53 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, 
>>>> void *data)
>>>>  /**
>>>>   * pci_walk_bridge - walk bridges potentially AER affected
>>>>   * @bridge   bridge which may be an RCEC with associated RCiEPs,
>>>> - *           an RCiEP associated with an RCEC, or a Port.
>>>> + *           or a Port.
>>>> + * @dev      an RCiEP lacking an associated RCEC.
>>>>   * @cb       callback to be called for each device found
>>>>   * @userdata arbitrary pointer to be passed to callback.
>>>>   *
>>>> @@ -160,13 +161,20 @@ static int report_resume(struct pci_dev *dev, 
>>>> void *data)
>>>>   * If the device provided has no subordinate bus, call the 
>>>> provided
>>>>   * callback on the device itself.
>>>>   */
>>>> -static void pci_walk_bridge(struct pci_dev *bridge, int 
>>>> (*cb)(struct pci_dev *, void *),
>>>> +static void pci_walk_bridge(struct pci_dev *bridge, struct pci_dev 
>>>> *dev,
>>>> +			    int (*cb)(struct pci_dev *, void *),
>>>>  			    void *userdata)
>>>>  {
>>>> -	if (bridge->subordinate)
>>>> +	/*
>>>> +	 * In a non-native case where there is no OS-visible reporting
>>>> +	 * device the bridge will be NULL, i.e., no RCEC, no PORT.
>>>> +	 */
>>>> +	if (bridge && bridge->subordinate)
>>>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>>>> -	else
>>>> +	else if (bridge)
>>>>  		cb(bridge, userdata);
>>>> +	else
>>>> +		cb(dev, userdata);
>>>>  }
>>>>
>>>>  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
>>>> @@ -196,16 +204,25 @@ pci_ers_result_t pcie_do_recovery(struct 
>>>> pci_dev *dev,
>>>>  	type = pci_pcie_type(dev);
>>>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>>>> -	    type == PCI_EXP_TYPE_RC_EC ||
>>>> -	    type == PCI_EXP_TYPE_RC_END)
>>>> +	    type == PCI_EXP_TYPE_RC_EC)
>>>>  		bridge = dev;
>>>> +	else if (type == PCI_EXP_TYPE_RC_END)
>>>> +		bridge = dev->rcec;
>>>>  	else
>>>>  		bridge = pci_upstream_bridge(dev);
>>>>
>>>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>>>  	if (state == pci_channel_io_frozen) {
>>>> -		pci_walk_bridge(bridge, report_frozen_detected, &status);
>>>> +		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);
>>>>  		if (type == PCI_EXP_TYPE_RC_END) {
>>>> +			/*
>>>> +			 * The callback only clears the Root Error Status
>>>> +			 * of the RCEC (see aer.c). Only perform this for the
>>>> +			 * native case, i.e., an RCEC is present.
>>>> +			 */
>>>> +			if (bridge)
>>>> +				reset_subordinate_devices(bridge);
>>>
>>> Help me understand this.  There are lots of callbacks in this 
>>> picture,
>>> but I guess this "callback only clears Root Error Status" must refer
>>> to aer_root_reset(), i.e., the reset_subordinate_devices pointer?
>>
>> The ‘bridge’ in this case will always be dev->rcec, the event 
>> collector for the associated RC_END. And that’s what’s being 
>> cleared in aer.c via aer_root_reset() as the callback. It’s also 
>> being checked for native/non-native here.
>>
>>>
>>> Of course, the caller of pcie_do_recovery() supplied that pointer.
>>> And we can infer that it must be aer_root_reset(), not
>>> dpc_reset_link(), because RCECs and RCiEPs are not allowed to
>>> implement DPC.
>>
>> Correct.
>>
>>>
>>> I wish we didn't have either this assumption about what
>>> reset_subordinate_devices points to, or the assumption about what
>>> aer_root_reset() does.  They both seem a little bit tenuous.
>>
>> Agree. It’s the relationship between the RC_END and the RC_EC.
>>
>>>
>>> We already made aer_root_reset() smart enough to check for RCECs.  
>>> Can
>>> we put the FLR there, too?  Then we wouldn't have this weird 
>>> situation
>>> where reset_subordinate_devices() does a reset and clears error
>>> status, EXCEPT for this case where it only clears error status and 
>>> we
>>> do the reset here?
>>
>> We could add the smarts to aer_root_reset() to check for an RC_END in 
>> that callback and perform the clear there on its RC_EC. We just 
>> wouldn’t map ‘bridge’ to dev->rcec for RC_END in 
>> pcie_do_recovery() which would simplify things.
>>
>> Further, the FLR in the case of flr_on_rciep() below is specific to 
>> the RCiEP itself. So it could be performed either in aer_root_reset() 
>> or remain in the pcie_do_recovery().
>>
>> That should work.
>>
>> Sean
>
> Thinking more on this, you could still pass dev->rcec to the callback 
> (eventually aer_root_reset()), but you won’t have the ability to 
> handle the FLR there without the pointer to the RC_END. That’s why I 
> suggested passing the RC_END and checking for its RC_EC in 
> aer_root_reset() if you want to also handle FLR there too from below.

Where you get into trouble is that you don’t want to do anything in 
the non-native case and shouldn’t be going to the callback. So this 
would add complexity to aer_root_reset() for checking on dev->rcec == 
NULL…where before you never would have invoked 
reset_subordinate_devices() in the non-native case.


>
> Sean
>
>>
>>
>>>
>>>>  			status = flr_on_rciep(dev);
>>>>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>  				pci_warn(dev, "function level reset failed\n");
>>>> @@ -219,13 +236,13 @@ pci_ers_result_t pcie_do_recovery(struct 
>>>> pci_dev *dev,
>>>>  			}
>>>>  		}
>>>>  	} else {
>>>> -		pci_walk_bridge(bridge, report_normal_detected, &status);
>>>> +		pci_walk_bridge(bridge, dev, report_normal_detected, &status);
>>>>  	}
>>>>
>>>>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>>>  		status = PCI_ERS_RESULT_RECOVERED;
>>>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>>>> -		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>>>> +		pci_walk_bridge(bridge, dev, report_mmio_enabled, &status);
>>>>  	}
>>>>
>>>>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
>>>> @@ -236,14 +253,14 @@ pci_ers_result_t pcie_do_recovery(struct 
>>>> pci_dev *dev,
>>>>  		 */
>>>>  		status = PCI_ERS_RESULT_RECOVERED;
>>>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>>>> -		pci_walk_bridge(bridge, report_slot_reset, &status);
>>>> +		pci_walk_bridge(bridge, dev, report_slot_reset, &status);
>>>>  	}
>>>>
>>>>  	if (status != PCI_ERS_RESULT_RECOVERED)
>>>>  		goto failed;
>>>>
>>>>  	pci_dbg(dev, "broadcast resume message\n");
>>>> -	pci_walk_bridge(bridge, report_resume, &status);
>>>> +	pci_walk_bridge(bridge, dev, report_resume, &status);
>>>>
>>>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>>>> -- 
>>>> 2.28.0
>>>>
