Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D5289B9C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Oct 2020 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390993AbgJIWHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389952AbgJIWHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 18:07:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A9C0613D2
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 15:07:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so12223129qka.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pD/uoL841Oprl6tCZJ99ccekwal8lf/pd6w7NW86z2s=;
        b=e/Y4DvGi7u6VngIUglorkhhICJMrlAGqPVn4GO/DdH2jIoo9a0rb84R7P1xYyeVkMO
         oO1OKfbyOaTFjUPrw5HuxO8Etw4tu1dP9xMFusuTo3ZPN4kweh9eBIbTCg0eAi/VUgQZ
         FzAr8N5Z+e87PtxjOCro6wbRB4f0e+df/Loz9EIh/nLLeh1FhZGq1vWpM3THn6te2vEl
         dVbpv8Ukdr5isI8yS3hq1yPpDeVn8EKsAXrN/ouwJlc13r98VhD95iCswJWPpz8tCgCT
         toXf9Qp/93IOHnZ2XMpCDdH7ft6dS7I7/ilbQp2QBJ7rDoC7RPRmR9NUuN3TCxIOHz4e
         T6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pD/uoL841Oprl6tCZJ99ccekwal8lf/pd6w7NW86z2s=;
        b=EnwX+iDnbLDIGRRH9XVxS64vdMEsY2lm1WrOlbgGc9fvw2d3GpZI18CODfJaoAFaWr
         yw51ObzANgSy2JZCHkuZ18/jUfIpRkdLiYIHf5yvrSb9/C3ZKeMQB+zlVu8/dhnthrcM
         7C2bZVMJgUrgbehe+ur982LyWfAyG7tqFzvLqBcyyOKT2RVHwkQNxizsnX0yxaockIDF
         lqZ2t2JueCFw5Bn3I5f2aYLSO+DJyg0d5YdJGosq0Za4apP3FuHLL4SX8GFisuAaN49j
         wSuBLy78iHVBDl4mAfxozbickSMNh4A7evEULj3X6rheR7zn/ADsOuG24aDmnRZ2QjI1
         9O5w==
X-Gm-Message-State: AOAM530u/vTWuPPVShbwtq4syXud2iaMNSbw5n6Po/Tlc6WO8wGBB2Y5
        FMH5EEsRo5DDd1sfCcC6wF8s9g==
X-Google-Smtp-Source: ABdhPJz9Q8ppedL+hFH26onQlQPr7R6GaRCmNdMmp00b84rVH4WAkxzG3O5iosyifY609ZDp0nqO0g==
X-Received: by 2002:ae9:f444:: with SMTP id z4mr109421qkl.338.1602281242524;
        Fri, 09 Oct 2020 15:07:22 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id p5sm7174801qte.95.2020.10.09.15.07.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 15:07:21 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Fri, 09 Oct 2020 15:07:18 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <56145784-8C7B-4206-B172-997F8D8C97D5@intel.com>
In-Reply-To: <20201009213011.GA3504871@bjorn-Precision-5520>
References: <20201009213011.GA3504871@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9 Oct 2020, at 14:30, Bjorn Helgaas wrote:

> On Fri, Oct 09, 2020 at 12:57:45PM -0500, Bjorn Helgaas wrote:
>> On Fri, Oct 02, 2020 at 11:47:32AM -0700, Sean V Kelley wrote:
>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>
>>> When attempting error recovery for an RCiEP associated with an RCEC 
>>> device,
>>> there needs to be a way to update the Root Error Status, the 
>>> Uncorrectable
>>> Error Status and the Uncorrectable Error Severity of the parent 
>>> RCEC.
>>> In some non-native cases in which there is no OS visible device
>>> associated with the RCiEP, there is nothing to act upon as the 
>>> firmware
>>> is acting before the OS. So add handling for the linked 'rcec' in 
>>> AER/ERR
>>> while taking into account non-native cases.
>>>
>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>  drivers/pci/pcie/aer.c |  9 +++++----
>>>  drivers/pci/pcie/err.c | 39 ++++++++++++++++++++++++++++-----------
>>>  2 files changed, 33 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 65dff5f3457a..dccdba60b5d9 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device 
>>> *dev)
>>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>>  {
>>>  	int aer = dev->aer_cap;
>>> +	int rc = 0;
>>>  	u32 reg32;
>>> -	int rc;
>>> -
>>>
>>>  	/* Disable Root's interrupt in response to error messages */
>>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>>
>>> -	rc = pci_bus_error_reset(dev);
>>> -	pci_info(dev, "Root Port link has been reset\n");
>>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
>>> +		rc = pci_bus_error_reset(dev);
>>> +		pci_info(dev, "Root Port link has been reset\n");
>>> +	}
>>>
>>>  	/* Clear Root Error Status */
>>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>> index 38abd7984996..956ad4c86d53 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, 
>>> void *data)
>>>  /**
>>>   * pci_walk_bridge - walk bridges potentially AER affected
>>>   * @bridge   bridge which may be an RCEC with associated RCiEPs,
>>> - *           an RCiEP associated with an RCEC, or a Port.
>>> + *           or a Port.
>>> + * @dev      an RCiEP lacking an associated RCEC.
>>>   * @cb       callback to be called for each device found
>>>   * @userdata arbitrary pointer to be passed to callback.
>>>   *
>>> @@ -160,13 +161,20 @@ static int report_resume(struct pci_dev *dev, 
>>> void *data)
>>>   * If the device provided has no subordinate bus, call the provided
>>>   * callback on the device itself.
>>>   */
>>> -static void pci_walk_bridge(struct pci_dev *bridge, int 
>>> (*cb)(struct pci_dev *, void *),
>>> +static void pci_walk_bridge(struct pci_dev *bridge, struct pci_dev 
>>> *dev,
>>> +			    int (*cb)(struct pci_dev *, void *),
>>>  			    void *userdata)
>>>  {
>>> -	if (bridge->subordinate)
>>> +	/*
>>> +	 * In a non-native case where there is no OS-visible reporting
>>> +	 * device the bridge will be NULL, i.e., no RCEC, no PORT.
>>> +	 */
>>> +	if (bridge && bridge->subordinate)
>>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>>> -	else
>>> +	else if (bridge)
>>>  		cb(bridge, userdata);
>>> +	else
>>> +		cb(dev, userdata);
>>>  }
>>>
>>>  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
>>> @@ -196,16 +204,25 @@ pci_ers_result_t pcie_do_recovery(struct 
>>> pci_dev *dev,
>>>  	type = pci_pcie_type(dev);
>>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>>> -	    type == PCI_EXP_TYPE_RC_EC ||
>>> -	    type == PCI_EXP_TYPE_RC_END)
>>> +	    type == PCI_EXP_TYPE_RC_EC)
>>>  		bridge = dev;
>>> +	else if (type == PCI_EXP_TYPE_RC_END)
>>> +		bridge = dev->rcec;
>>>  	else
>>>  		bridge = pci_upstream_bridge(dev);
>>>
>>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>>  	if (state == pci_channel_io_frozen) {
>>> -		pci_walk_bridge(bridge, report_frozen_detected, &status);
>>> +		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);
>>>  		if (type == PCI_EXP_TYPE_RC_END) {
>>> +			/*
>>> +			 * The callback only clears the Root Error Status
>>> +			 * of the RCEC (see aer.c). Only perform this for the
>>> +			 * native case, i.e., an RCEC is present.
>>> +			 */
>>> +			if (bridge)
>>> +				reset_subordinate_devices(bridge);
>>
>> Help me understand this.  There are lots of callbacks in this 
>> picture,
>> but I guess this "callback only clears Root Error Status" must refer
>> to aer_root_reset(), i.e., the reset_subordinate_devices pointer?
>>
>> Of course, the caller of pcie_do_recovery() supplied that pointer.
>> And we can infer that it must be aer_root_reset(), not
>> dpc_reset_link(), because RCECs and RCiEPs are not allowed to
>> implement DPC.
>>
>> I wish we didn't have either this assumption about what
>> reset_subordinate_devices points to, or the assumption about what
>> aer_root_reset() does.  They both seem a little bit tenuous.
>>
>> We already made aer_root_reset() smart enough to check for RCECs.  
>> Can
>> we put the FLR there, too?  Then we wouldn't have this weird 
>> situation
>> where reset_subordinate_devices() does a reset and clears error
>> status, EXCEPT for this case where it only clears error status and we
>> do the reset here?
>
> Just as an example to make this concrete.  Doesn't even compile.

Okay, I tried something similar.  Comments below:

>
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d6927e6535e5..e389db7cbba6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1372,28 +1372,45 @@ static int aer_probe(struct pcie_device *dev)
>   */
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
> -	int aer = dev->aer_cap;
> +	int type = pci_pcie_type(dev);
> +	struct pci_dev *root;
> +	int aer = 0;
>  	int rc = 0;
>  	u32 reg32;
>
> -	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	if (type == PCI_EXP_TYPE_RC_END)
> +		root = dev->rcec;
> +	else
> +		root = dev;
> +
> +	if (root)
> +		aer = root->aer_cap;

Except here dev->rcec may be NULL for the non-native case. So I had a 
goto label to bypass what follows.  I left the FLR in err.c.


>
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
> +	if (aer) {
> +		/* Disable Root's interrupt in response to error messages */
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	}
> +
> +	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> +		rc = flr_on_rciep(dev);
> +		pci_info(dev, "has been reset (%d)\n", rc);
> +	} else {
>  		rc = pci_bus_error_reset(dev);
> -		pci_info(dev, "Root Port link has been reset\n");
> +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>  	}
>
> -	/* Clear Root Error Status */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +	if (aer) {
> +		/* Clear Root Error Status */
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>
> -	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		/* Enable Root Port's interrupt in response to error messages */
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	}
>
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 79ae1356141d..08976034a89c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -203,36 +203,19 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
> *dev,
>  	 */
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    type == PCI_EXP_TYPE_RC_EC)
> +	    type == PCI_EXP_TYPE_RC_EC ||
> +	    type == PCI_EXP_TYPE_RC_END)
>  		bridge = dev;
> -	else if (type == PCI_EXP_TYPE_RC_END)
> -		bridge = dev->rcec;
>  	else
>  		bridge = pci_upstream_bridge(dev);
>
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);

We’d need to walk back the dev addition to the pci_walk_bridge() and 
revert to prior to the checks on dev->rcec.

> -		if (type == PCI_EXP_TYPE_RC_END) {
> -			/*
> -			 * The callback only clears the Root Error Status
> -			 * of the RCEC (see aer.c). Only perform this for the
> -			 * native case, i.e., an RCEC is present.
> -			 */
> -			if (bridge)
> -				reset_subordinates(bridge);
> -
> -			status = flr_on_rciep(dev);
> -			if (status != PCI_ERS_RESULT_RECOVERED) {
> -				pci_warn(dev, "Function Level Reset failed\n");
> -				goto failed;
> -			}
> -		} else {
> -			status = reset_subordinates(bridge);
> -			if (status != PCI_ERS_RESULT_RECOVERED) {
> -				pci_warn(dev, "subordinate device reset failed\n");
> -				goto failed;
> -			}
> +		status = reset_subordinates(bridge);
> +		if (status != PCI_ERS_RESULT_RECOVERED) {
> +			pci_warn(bridge, "subordinate device reset failed\n");
> +			goto failed;
>  		}
>  	} else {
>  		pci_walk_bridge(bridge, dev, report_normal_detected, &status);

So this is what I experimented with for the most part but with the 
changes that I highlighted - addressing non-native case in the callback 
and also in the bridge walk.

I can test it out.

Thanks,

Sean
