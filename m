Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1522F51B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgG0Q2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgG0Q2E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 12:28:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FCC0619D2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 09:28:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so9946848pgc.13
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXQDDxZ+Zkeh+R1SuJXZKqQr0TVg18DhNGcIwMuix8w=;
        b=SxZleqeDUFQoMvxC5eVcFaIbEOKQlWfTcr3ZmrOnfngldqbbZ+Dc4+BeeaI2JxYz92
         vi2EWPLk7C/96bbcyxybaUh27cew6609PTX+b4QTBZNh692NOMYv4/mW/Yqa+FcvvdFE
         ccg4tVFGNCvsCTwkHxCUi3MUstrvv8LPzXIMnCLFqaxJ37EBphVIoRTY/vtYsCJ1bhKh
         DaoQRo56fmpLOAKuFCZ6rmbiDj//izMcZjbKHpzJCu6qR4UEvjUoFXsbivMz8KeSeCdr
         339qiTfCKJZWlNjtvf7BOy362lvsLkk6l1Pgl673zvFXmhkc/A7ImleCR3dwRRU5mlCX
         FWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXQDDxZ+Zkeh+R1SuJXZKqQr0TVg18DhNGcIwMuix8w=;
        b=dXu12G1gzKNYf9cYr6WvcLfR97qnGblrcgjHJOlQdJUUQe6/rTLljKIlY59gWHhjSx
         5l3g4MwejohYtJJX9eKqmji3MjaOFKMYQmPFLlK230E1WkqBHWtZ7K0ZEbxvGsTWVaqx
         wxi8Kja6T2hoJjmjMM949Kw0I/G7gpisYHkXlQTQJl/rq8CRl8qK4AtYgRXL3dcA0muD
         phG8jdM0p2obu8VjcrgS1cJAIwFPmEsVOfCP8ZDe1lJYxZlpGK8fU2M25u6rOplO1Kvk
         iNni61XdNAn/OZO0qOarOAHIEoUsPmgwD1GijM4ZDUoe3dTeDPDOZrLyxaApvc/moaw/
         1Csw==
X-Gm-Message-State: AOAM53310ZJyK6py6BLu+HgTjcmZPJYdPVyslC8CvYSR2hJoxmsZ+Df2
        vvoj8vOw8NH+91jyHo8YDcZ8Rw==
X-Google-Smtp-Source: ABdhPJzgEnGsUJvR3Wxmdbh2ZRFgFpYyYbZaVy5dT5HkL3ST10Ub02PyY+talO4RWDko4yy2Ro6XYA==
X-Received: by 2002:a05:6a00:224f:: with SMTP id i15mr21964543pfu.241.1595867283657;
        Mon, 27 Jul 2020 09:28:03 -0700 (PDT)
Received: from [10.251.2.111] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id b82sm15740762pfb.215.2020.07.27.09.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 09:28:02 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net,
        "Raj, Ashok" <ashok.raj@intel.com>, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 6/9] PCI: Add 'rcec' field to pci_dev for associated
 RCiEPs
Date:   Mon, 27 Jul 2020 09:28:00 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <4CA5C97F-34F9-48EF-B1E9-84AEEB9FA75F@intel.com>
In-Reply-To: <20200727171104.000053f8@huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-7-sean.v.kelley@intel.com>
 <20200727122358.00006c23@Huawei.com> <20200727171104.000053f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 9:11, Jonathan Cameron wrote:

> On Mon, 27 Jul 2020 12:23:58 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> On Fri, 24 Jul 2020 10:22:20 -0700
>> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>>
>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>
>>> When attempting error recovery for an RCiEP associated with an RCEC 
>>> device,
>>> there needs to be a way to update the Root Error Status, the 
>>> Uncorrectable
>>> Error Status and the Uncorrectable Error Severity of the parent 
>>> RCEC.
>>> So add the 'rcec' field to the pci_dev structure and provide a hook 
>>> for the
>>> Root Port Driver to associate RCiEPs with their respective parent 
>>> RCEC.
>>>
>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> I haven't tested yet, but I think there is one path in here that 
>> breaks
>> my case (no OS visible rcec / all done in firmware GHESv2 / APEI)
>>
>> Jonathan
>>
>>> ---
>>>  drivers/pci/pcie/aer.c         |  9 +++++----
>>>  drivers/pci/pcie/err.c         |  9 +++++++++
>>>  drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
>>>  include/linux/pci.h            |  3 +++
>>>  4 files changed, 32 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 3acf56683915..f1bf06be449e 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1335,17 +1335,18 @@ static int aer_probe(struct pcie_device 
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
>>> index 9b3ec94bdf1d..0aae7643132e 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -203,6 +203,11 @@ pci_ers_result_t pcie_do_recovery(struct 
>>> pci_dev *dev,
>>>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>>>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>>>  			status = flr_on_rciep(dev);
>>> +			/*
>>> +			 * The callback only clears the Root Error Status
>>> +			 * of the RCEC (see aer.c).
>>> +			 */
>>> +			reset_link(dev->rcec);
>>
>> This looks dangerous for my case where APEI / GHESv2 is used.  In 
>> that case
>> we don't expose an RCEC at all.   I don't think the reset_link 
>> callback
>> is safe to a null pointer here.  Fix may be as simple as
>> if (dev->rcec)
>> 	reset_link(dev->rcec);
>>
>>
>>>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>>>  				pci_warn(dev, "function level reset failed\n");
>>>  				goto failed;
>>> @@ -246,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct 
>>> pci_dev *dev,
>>>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
>>>  		pci_aer_clear_device_status(dev);
>>>  		pci_aer_clear_nonfatal_status(dev);
>>> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>>> +		pci_aer_clear_device_status(dev->rcec);
> This needs updating as well to match current approach in Bjorn's tree
>
> (reworked version of my fix for this in th !is_native case)

Will rework.

>
>>> +		pci_aer_clear_nonfatal_status(dev->rcec);
>>
>> These may be safe as in my both now have protections for 
>> !pcie_aer_is_native.
> Except I'm wrong.  That function performs a local check based
> on the pci_dev passed in, so blows up anyway.
>
> So this whole block needs an if(dev->rcec), or potentially protect it 
> with
> a call to pci_aer_is_native(dev) on the basis we shouldn't be able to 
> get
> here unless we are not doing native aer or we have an rcec.
>
> Jonathan

Thanks Jonathan.  Will rework that flow and checks on dev->rcec based on 
Bjorn’s current tree.

Sean

>
>>
>>>  	}
>>> +
>>>  	pci_info(dev, "device recovery successful\n");
>>>  	return status;
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>>> b/drivers/pci/pcie/portdrv_pci.c
>>> index d5b109499b10..f9409a0110c2 100644
>>> --- a/drivers/pci/pcie/portdrv_pci.c
>>> +++ b/drivers/pci/pcie/portdrv_pci.c
>>> @@ -90,6 +90,18 @@ static const struct dev_pm_ops 
>>> pcie_portdrv_pm_ops = {
>>>  #define PCIE_PORTDRV_PM_OPS	NULL
>>>  #endif /* !PM */
>>>
>>> +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
>>> +{
>>> +	struct pci_dev *rcec = (struct pci_dev *)data;
>>> +
>>> +	pdev->rcec = rcec;
>>> +	pci_info(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
>>> +		 pci_domain_nr(pdev->bus), pdev->bus->number,
>>> +		 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>>
>> We may want to make this debug info at somepoint if we have a way
>> of discovering it from userspace.   The PCI boot up is extremely
>> verbose already!
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  /*
>>>   * pcie_portdrv_probe - Probe PCI-Express port devices
>>>   * @dev: PCI-Express port device being probed
>>> @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev 
>>> *dev,
>>>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>>>  		return -ENODEV;
>>>
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>> +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
>>> +
>>>  	status = pcie_port_device_register(dev);
>>>  	if (status)
>>>  		return status;
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 34c1c4f45288..e920f29df40b 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -326,6 +326,9 @@ struct pci_dev {
>>>  #ifdef CONFIG_PCIEAER
>>>  	u16		aer_cap;	/* AER capability offset */
>>>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>>> +#endif
>>> +#ifdef CONFIG_PCIEPORTBUS
>>> +	struct pci_dev	*rcec;		/* Associated RCEC device */
>>>  #endif
>>>  	u8		pcie_cap;	/* PCIe capability offset */
>>>  	u8		msi_cap;	/* MSI capability offset */
>>
