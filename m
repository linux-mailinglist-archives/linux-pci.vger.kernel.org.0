Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABED23CF64
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgHETUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgHERsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2020 13:48:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCAC06179F
        for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2020 10:48:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so3466685pje.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2020 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=AN9lXxTtUIqeSqnhtWqPoGBSysu+7woyVZhyjrKsSws=;
        b=i1T15cW+HRL+p852S2fTs1hjBZSveLXDnk5dyOQ1naPnB8IlqcrYRJ2raHvn8KKQ+t
         3AmssaQxfBZL5DwXppRiWMwzjlEg6F4gsvrulkvmWdqO+0ADxQklRCHhse2fTsYd13f8
         m37Lo9uNFOYZaW/n+uWZF/gd+ECIMVc3JcrUQrz6A7JMbq45dfwz++RDsO3y76yf1zA8
         NPqfUuiUOMXUoVm2W9Q78t7IG2kI5pldoyxzGCuiwPvQpTlLuIh9Z5Zk3ZY1DHx1mE4Y
         Dv2T356bWIPPw9Dee7exTc3Ld0vX45KMgINZVyyuKCy/77jqGYOwpSadK5zIltWDT4G/
         AyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=AN9lXxTtUIqeSqnhtWqPoGBSysu+7woyVZhyjrKsSws=;
        b=ODssJrNykoKkmJILLMqJE3FHxkhABMSHFHU6RlfS8mS9q8l/ZKkiqRRgJvrwEBYnJ8
         pOmB7VK7B+AeEL6NDBPVk9V/iez/slHOYsH559p3oTsEw+vJ2zkIgL/biXAfmE0HzrdW
         iqdf/WDjPPBfl8TeN5XuH9rXlofU+y9m9YVai6cx+ZfaVrzapBMWzUmglE75v8Jqh0xy
         LFfaAn5jo3YcUBnLg44TjT21Vp135otY5PpSKrWuimJInPEH4MbN1W6Rz43FzCb/Fjkd
         M3OG3e94ivY0wzsJ3w1Xa4/xIUwDeKYDQd5vSShKs2q0BkLvJsV5Pjc24TY+B0hJ24x2
         v5WA==
X-Gm-Message-State: AOAM530PV5x6JcCXZuzy8k20xOr3s2uf9zkGhhOp7v2LdqXEsZeViOr2
        qiE3rT5wNmwJ2EJ8LFxUywadwQ==
X-Google-Smtp-Source: ABdhPJyj978+UEa8ClNSaHWi3r3lQbgAj9hS3PWUrlDsGOSW08sBlMCtMtXlqGVUaieKyXqEzt3+wg==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr4643433pjb.2.1596649730064;
        Wed, 05 Aug 2020 10:48:50 -0700 (PDT)
Received: from [10.213.170.159] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id z25sm4219247pfn.159.2020.08.05.10.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:48:49 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 6/9] PCI: Add 'rcec' field to pci_dev for associated
 RCiEPs
Date:   Wed, 05 Aug 2020 10:48:46 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <BE94DF65-ED67-4113-A932-58BFE86B1152@intel.com>
In-Reply-To: <20200805184020.00000cf3@Huawei.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
 <20200804194052.193272-7-sean.v.kelley@intel.com>
 <20200805184020.00000cf3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5 Aug 2020, at 10:40, Jonathan Cameron wrote:

> On Tue, 4 Aug 2020 12:40:49 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When attempting error recovery for an RCiEP associated with an RCEC 
>> device,
>> there needs to be a way to update the Root Error Status, the 
>> Uncorrectable
>> Error Status and the Uncorrectable Error Severity of the parent RCEC.
>> So add the 'rcec' field to the pci_dev structure and provide a hook 
>> for the
>> Root Port Driver to associate RCiEPs with their respective parent 
>> RCEC.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Hi,
>
> One question in line.
>
>> ---
>>  drivers/pci/pcie/aer.c         |  9 +++++----
>>  drivers/pci/pcie/err.c         | 12 ++++++++++++
>>  drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
>>  include/linux/pci.h            |  3 +++
>>  4 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 87283cda3990..f658607e8e00 100644
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
>> index 4812aa678eff..43f1c55c76db 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -203,6 +203,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
>> *dev,
>>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>>  			status = flr_on_rciep(dev);
>> +			/*
>> +			 * The callback only clears the Root Error Status
>> +			 * of the RCEC (see aer.c).
>> +			 */
>> +			if (pcie_aer_is_native(dev) && dev->rcec)
>> +				reset_link(dev->rcec);
>
> I'm not sure about this pcie_aer_is_native check.
> We don't check in the normal EP path.  Perhaps we should be checking 
> there
> as well?

Looks like we should.  Will make adjustments and test.

>
> I can contrive a CPER record that hits the reset_link for the normal 
> EP on my qemu
> test setup.  Just for fun it causes a synchronous external abort that 
> I need
> to track down but not related this patch or indeed reset_link and may 
> just reflect
> an impossible to hit path in the e1000e driver.
>
> It needs a very contrived combination of blocks that say the error is 
> fatal
> and others that say it isn't so I'm not that worried about that.

Okay, will also test on my end.

Thanks,

Sean

>
>
>>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>>  				pci_warn(dev, "function level reset failed\n");
>>  				goto failed;
>> @@ -247,7 +253,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
>> *dev,
>>  		if (pcie_aer_is_native(dev))
>>  			pcie_clear_device_status(dev);
>>  		pci_aer_clear_nonfatal_status(dev);
>> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>> +		if (pcie_aer_is_native(dev) && dev->rcec)
>> +			pcie_clear_device_status(dev->rcec);
>> +		if (dev->rcec)
>> +			pci_aer_clear_nonfatal_status(dev->rcec);
>>  	}
>> +
>>  	pci_info(dev, "device recovery successful\n");
>>  	return status;
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>> b/drivers/pci/pcie/portdrv_pci.c
>> index 4d880679b9b1..dff5c9e13412 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -90,6 +90,18 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops 
>> = {
>>  #define PCIE_PORTDRV_PM_OPS	NULL
>>  #endif /* !PM */
>>
>> +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
>> +{
>> +	struct pci_dev *rcec = (struct pci_dev *)data;
>> +
>> +	pdev->rcec = rcec;
>> +	pci_dbg(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
>> +		pci_domain_nr(pdev->bus), pdev->bus->number,
>> +		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * pcie_portdrv_probe - Probe PCI-Express port devices
>>   * @dev: PCI-Express port device being probed
>> @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev 
>> *dev,
>>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
>> +
>>  	status = pcie_port_device_register(dev);
>>  	if (status)
>>  		return status;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index ee49469bd2b5..d5f7dbbf5e2f 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -326,6 +326,9 @@ struct pci_dev {
>>  #ifdef CONFIG_PCIEAER
>>  	u16		aer_cap;	/* AER capability offset */
>>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>> +#endif
>> +#ifdef CONFIG_PCIEPORTBUS
>> +	struct pci_dev	*rcec;		/* Associated RCEC device */
>>  #endif
>>  	u8		pcie_cap;	/* PCIe capability offset */
>>  	u8		msi_cap;	/* MSI capability offset */
