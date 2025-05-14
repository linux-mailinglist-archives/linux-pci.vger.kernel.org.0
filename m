Return-Path: <linux-pci+bounces-27742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD15AB7166
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926BC4C7EA3
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF83278E60;
	Wed, 14 May 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z98WSOM1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6831DF994;
	Wed, 14 May 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240171; cv=none; b=eKBpcc7Do31ndnhew0t12ATRTc8dO0eQsQUsUerIgLDi8ZW1KInueW0RHWicqeVGbB6KKqvMEcloJ8vIvWykgCLpdw/uPHvMh+mPgz7XIN3gBTpwdChF37OO9FIlBmrx+W6eu1s3dXsa4/D1mKyC3CW54u9SlZbH2oy8tZPvgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240171; c=relaxed/simple;
	bh=0TLgoK7Gs4ddSH1MAUNifrUlpwnTT08O7PTx0UW/was=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrne9DKBctWLOqE2a7HerZGJFP0IlE6orj1v3veZsZnajYuHcAMD7KMhDCGLCKszDNgWt1f1+1CEPLKpAY+sThFF5VmZB2PptW7EhB77hTsF0hqg9/RNld2O1jZrLnBCAhTR82/jWqkSvenyKr+LmaEluRsAy5BMOc6OFvAMIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z98WSOM1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b6aa08e5so838310f8f.1;
        Wed, 14 May 2025 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747240167; x=1747844967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVJVw7FLXuXnBLkyBJnMW+owWDNIHrc56quEF7c9tr4=;
        b=Z98WSOM1EvPe00msqM7DNpiiQr61J3OdbxD96Mwh4iVrfuZwPxoq7t9/t7Yc+19sb1
         YY+4CWq64CmoQp6gLdytbo7Dz17yoxShuOikRl3edL5vxfbJdzZt8PHWRiZj9S2sat3g
         uEjfLLE5D5nPZEYujFfyoIYp7iE8OJe8nj5erIvGGvZuseGDZQVjy7ASw9TnKhexI9Nb
         wPiLL/FtB3ZFY4dIS7my4ynk4g4uOMQ3nhnQuIK+3ngkfNdUmFUDUEo4MmNinL/4dj5P
         0nxnXelpUq2joKYLn0xtesf/EIuMTSYK601Ogs+TdaWBj/55ZQED3rSS2uqsJyZrCQdJ
         GlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240167; x=1747844967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVJVw7FLXuXnBLkyBJnMW+owWDNIHrc56quEF7c9tr4=;
        b=LvDXQHRZ8X6dRr9udzhItbaeyWdNwRLoO7L23MWV+fgq2bp9/jsRjY/mXw4PEJoLO3
         10CltkK7wbX7R4mhw+g3YSQyF/yqIpt21XavEHJcjDbvvsoxr61TPdYm6mZFWdnhOhJ3
         A/Vzk08iGsLq/c7gsxnfPcx7iXkAt2U0PAiYuVqdbb+cNfCFZ2LmKyOJc9EWkGqLN2V7
         ZX/j/mNxQxkI6OVnIdb+HKkq0SG4O7OkWp1EoqOUJh56cKBmu1LDxDnlz7v/hLV/fet1
         xAnR8V1EQOkqIIIPLVN+UfitaNDWiGgNHihlGlvWYxbga9yIC5sdW3gvFyhpBzUDFffq
         gZig==
X-Forwarded-Encrypted: i=1; AJvYcCVO2qZXwN/D9QuptH/rjsm8atox4EoqK+eCaUU50WzifC4xygOVyfA/Uqg65pmU1sX1zn/sOWe8WW4xlfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFphiGQdfCYNKRcB/nK0M2m8JZCQmO7KYlUa+xAG+EbPvsrXgi
	3V5oXpzWp5XI5mB7fJC5zaFlokC/MVfWeQP7WVmgLpQbhJYMlDU56vNw
X-Gm-Gg: ASbGncs9uCNorYTghp78YbLOWIZAffVGI0MJ0Axmz0+3t1zPgONbz5taWkGARFHKl2r
	auS7VGflBjLQslE7/PjpWGbIvmMkfoWsD8ivsGj4nEVXMCfz2y0re74rzkjsBpQxBEY/dSEtTx1
	0RjJ9LZXHzaOlAi/fChFFJKLEqT8Vy3OYBws3C4ofQdRK1/i31q583u6Bh1OSdsgeYA4QSAn9GC
	kRVKE60kr97xjs6PSoPuz0HX1OdtqhtclTM2vaFlL6Z15cu+THrfF20PoJvaAhD1PfRQcf0SSeF
	tif9MOnXZfp1k5BItr4bOVKO/v5Dl4j3QHNN2KL0GpAqLbbgIjgQWDba+eTtEWE=
X-Google-Smtp-Source: AGHT+IFaPwLMJybZgs0MOXNkpAzB87GgJsOEz9Jh5PzFZVDEDe1FjxRm3LaRLhUFnU7KopRGXdtUyQ==
X-Received: by 2002:a05:6000:1a8a:b0:3a1:d06c:4e5c with SMTP id ffacd0b85a97d-3a3512231edmr159304f8f.26.1747240167414;
        Wed, 14 May 2025 09:29:27 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm36259565e9.18.2025.05.14.09.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 09:29:27 -0700 (PDT)
Message-ID: <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
Date: Wed, 14 May 2025 18:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
 Mario Limonciello <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
 aravind.iddamsetty@linux.intel.com
References: <20250504090444.3347952-1-raag.jadav@intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20250504090444.3347952-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.

you can follow an example of my problems in this [1] bug report.

I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.

You can see the dmesg here: https://pastebin.com/Um7bmdWi

I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.


[1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/

On 5/4/25 11:04, Raag Jadav wrote:

> If error flags are set on an AER capable device, most likely either the
> device recovery is in progress or has already failed. Neither of the
> cases are well suited for power state transition of the device, since
> this can lead to unpredictable consequences like resume failure, or in
> worst case the device is lost because of it. Leave the device in its
> existing power state to avoid such issues.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>
> v2: Synchronize AER handling with PCI PM (Rafael)
> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>     Elaborate "why" (Bjorn)
>
> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>
>  drivers/pci/pci.c      | 12 ++++++++++++
>  drivers/pci/pcie/aer.c | 11 +++++++++++
>  include/linux/aer.h    |  2 ++
>  3 files changed, 25 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..25b2df34336c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>  	   || (state == PCI_D2 && !dev->d2_support))
>  		return -EIO;
>  
> +	/*
> +	 * If error flags are set on an AER capable device, most likely either
> +	 * the device recovery is in progress or has already failed. Neither of
> +	 * the cases are well suited for power state transition of the device,
> +	 * since this can lead to unpredictable consequences like resume
> +	 * failure, or in worst case the device is lost because of it. Leave the
> +	 * device in its existing power state to avoid such issues.
> +	 */
> +	if (pci_aer_in_progress(dev))
> +		return -EIO;
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..4040770df4f0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>  
> +bool pci_aer_in_progress(struct pci_dev *dev)
> +{
> +	u16 reg16;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return false;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +	return !!(reg16 & PCI_EXP_AER_FLAGS);
> +}
> +
>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	int rc;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..e6a380bb2e68 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +bool pci_aer_in_progress(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,

