Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0247127B32C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1R2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1R2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 13:28:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C95C061755
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 10:28:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so1475098pgj.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5wHrqbA3BFE/yXMIVXV5TxVPWZuFJUtrSjQifdJ3Ko=;
        b=Dc5/cE0ZOYgBtGqB4bTM9PZwgB94XaeccXmyvi9CG7y4tKg8hxoTX4ZVH0uLMuqPZv
         hvhe+pphVypljddP4xbM2tutD8Y4hDqegd24tZ5i5rhDft2IFdH13mxEJdQJmeDDsNPs
         z2aZkd5Qg4N2om1tbDM+mB2+sPgav2vaaeBm6pa3tmYNb6uxgDSJdpz7+pzS6yJb6znl
         agVJ5rwFLWYNejENNMk/UxSHz/cNwM51Q8Qli1EwWUspUwsxe/bpLc9zCkf8nSPpj06m
         n3pvdYCSYpV8OUl0wYAj07f0qvGZxiOuZKxk2eU4Fr0yB9vTOCRs8r3r5P0Wm/0LPHNI
         er0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5wHrqbA3BFE/yXMIVXV5TxVPWZuFJUtrSjQifdJ3Ko=;
        b=SjoJEKZfrcezxCYCLvSu8JfBtAXcRULo1b3Y0T0QFHL8fIkyoxGFS/lVwVQdZHnWBA
         IMAYbxxyiVGf7youX6lEAcfni3af10Yzb/N9hNwWA+r3+VaSF8e5ii8LbsxXBZMCIiU9
         2blJPJp9Y6QK4jKg6w+T7EfrlfFNsmAGN6d5ow2fstJDrrnhbiTdXouUm3mXT5gjyPIx
         uOJ7x1GzN5q0M0DFvv6RhPcLict/nLb7GORYwKxTIku+lo5TxLdIZMsQVO04EkrHJ5U8
         lHTg2SmGFrzDU6KZKZn81QvAotmr1BQzWFLZzJDiACTE9Wqm06R+YQd4jvvp/chL7FCY
         WyYA==
X-Gm-Message-State: AOAM5314wV/KejzLeKXYQPfmN4c0CJsUmXu/eKYq19vy92MRzo3RUdZJ
        a2KLpSAI0vC7D2fEEmBT+CHKGg==
X-Google-Smtp-Source: ABdhPJxeKEPh1MtnSqX1aEZ9sb0PmG+Pvnb7PBxV8mM6ohLk/inzqjgHNsMYCoSWznwq607jeGBoyQ==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr107732pgl.345.1601314080087;
        Mon, 28 Sep 2020 10:28:00 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id w14sm2152789pfu.87.2020.09.28.10.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:27:59 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Mon, 28 Sep 2020 10:27:57 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <361B6391-A524-4928-97D3-D1131422B474@intel.com>
In-Reply-To: <20200927234545.GA2470139@bjorn-Precision-5520>
References: <20200927234545.GA2470139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Sep 2020, at 16:45, Bjorn Helgaas wrote:

> On Tue, Sep 22, 2020 at 02:38:56PM -0700, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When attempting error recovery for an RCiEP associated with an RCEC 
>> device,
>> there needs to be a way to update the Root Error Status, the 
>> Uncorrectable
>> Error Status and the Uncorrectable Error Severity of the parent RCEC.
>> In some non-native cases in which there is no OS visible device
>> associated with the RCiEP, there is nothing to act upon as the 
>> firmware
>> is acting before the OS. So add handling for the linked 'rcec' in 
>> AER/ERR
>> while taking into account non-native cases.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> ---
>>  drivers/pci/pcie/aer.c |  9 +++++----
>>  drivers/pci/pcie/err.c | 38 ++++++++++++++++++++++++--------------
>>  2 files changed, 29 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 65dff5f3457a..dccdba60b5d9 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>> +	int rc = 0;
>>  	u32 reg32;
>> -	int rc;
>> -
>>
>>  	/* Disable Root's interrupt in response to error messages */
>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>
>> -	rc = pci_bus_error_reset(dev);
>> -	pci_info(dev, "Root Port link has been reset\n");
>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
>> +		rc = pci_bus_error_reset(dev);
>> +		pci_info(dev, "Root Port link has been reset\n");
>> +	}
>>
>>  	/* Clear Root Error Status */
>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 5380ecc41506..a61a2518163a 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, 
>> void *data)
>>  /**
>>   * pci_bridge_walk - walk bridges potentially AER affected
>>   * @bridge   bridge which may be an RCEC with associated RCiEPs,
>> - *           an RCiEP associated with an RCEC, or a Port.
>> + *           or a Port.
>> + * @dev      an RCiEP lacking an associated RCEC.
>>   * @cb       callback to be called for each device found
>>   * @userdata arbitrary pointer to be passed to callback.
>>   *
>> @@ -160,13 +161,16 @@ static int report_resume(struct pci_dev *dev, 
>> void *data)
>>   * If the device provided has no subordinate bus, call the provided
>>   * callback on the device itself.
>>   */
>> -static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct 
>> pci_dev *, void *),
>> +static void pci_bridge_walk(struct pci_dev *bridge, struct pci_dev 
>> *dev,
>> +			    int (*cb)(struct pci_dev *, void *),
>>  			    void *userdata)
>>  {
>> -	if (bridge->subordinate)
>> +	if (bridge && bridge->subordinate)
>
> I *guess* this means there's a possibility that bridge is NULL?  And I
> guess that case is when pci_upstream_bridge(dev) in pcie_do_recovery()
> was NULL?
>
> I can't figure out what that means in practice.  Oh, wait, I bet I
> know -- this is the non-native case where there's no OS-visible
> reporting device.

Yes, this is for the non-native case.

>
> We need some sort of comment because this is really not a top-of-mind
> situation unless you happen to be working on one of the few systems
> like that.

Will do.

>
> Not too sure this scenario is really a good fit for the
> pci_bridge_walk() model, but I think it's OK for now with a hint so we
> can remember this no RCEC, no Root Port model.

Understood.

>
>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>> -	else
>> +	else if (bridge)
>>  		cb(bridge, userdata);
>> +	else
>> +		cb(dev, userdata);
>>  }
>>
>>  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
>> @@ -196,16 +200,24 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  	type = pci_pcie_type(dev);
>>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -	    type == PCI_EXP_TYPE_RC_EC ||
>> -	    type == PCI_EXP_TYPE_RC_END)
>> +	    type == PCI_EXP_TYPE_RC_EC)
>>  		bridge = dev;
>> +	else if (type == PCI_EXP_TYPE_RC_END)
>> +		bridge = dev->rcec;
>>  	else
>>  		bridge = pci_upstream_bridge(dev);
>>
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>> -		pci_bridge_walk(bridge, report_frozen_detected, &status);
>> +		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
>>  		if (type == PCI_EXP_TYPE_RC_END) {
>> +			/*
>> +			 * The callback only clears the Root Error Status
>> +			 * of the RCEC (see aer.c).
>> +			 */
>> +			if (bridge)
>> +				reset_subordinate_devices(bridge);
>
> It's unfortunate to add yet another special case in this code, and I'm
> not thrilled about the one in aer_root_reset() either.  It's just not
> obvious why they should be there.  I'm sure if I spent 30 minutes
> decoding things, it would all make sense.  Guess I'm just griping
> because I don't have a better suggestion.

I could also add some more detail here referencing the non-native case 
where there may not even exist an RCEC. Aside from comments, I could 
employ a descriptive flag such as “native_bridge”.

Thanks,

Sean

>
>>  			status = flr_on_rciep(dev);
>>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>>  				pci_warn(dev, "function level reset failed\n");
>> @@ -219,13 +231,13 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  			}
>>  		}
>>  	} else {
>> -		pci_bridge_walk(bridge, report_normal_detected, &status);
>> +		pci_bridge_walk(bridge, dev, report_normal_detected, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>> -		pci_bridge_walk(bridge, report_mmio_enabled, &status);
>> +		pci_bridge_walk(bridge, dev, report_mmio_enabled, &status);
>>  	}
>>
>>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> @@ -236,18 +248,16 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  		 */
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>> -		pci_bridge_walk(bridge, report_slot_reset, &status);
>> +		pci_bridge_walk(bridge, dev, report_slot_reset, &status);
>>  	}
>>
>>  	if (status != PCI_ERS_RESULT_RECOVERED)
>>  		goto failed;
>>
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_bridge_walk(bridge, report_resume, &status);
>> +	pci_bridge_walk(bridge, dev, report_resume, &status);
>>
>> -	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -	    type == PCI_EXP_TYPE_RC_EC) {
>> +	if (bridge) {
>>  		if (pcie_aer_is_native(bridge))
>>  			pcie_clear_device_status(bridge);
>>  		pci_aer_clear_nonfatal_status(bridge);
>> -- 
>> 2.28.0
>>
