Return-Path: <linux-pci+bounces-28072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B45ABD18A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06664A12D8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016525D219;
	Tue, 20 May 2025 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1+UPMy3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893C21A43C
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728700; cv=none; b=LxlSMjP3AbiPtHaMbsG6c7tLxMEHPylexPg0dG7cgB1R2jeucDdamw+7dX4ySZ+A3u01Ajm4w/mRUfBOftMha9LdYIYMQIrm4Al791UgTPXFq8cwuXyj7wGeAefqAU3wfQBaK5GJn/cPOlxP1WOhkWfIY+P1Fxsy1f8gtdM3XdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728700; c=relaxed/simple;
	bh=qjH47GrG87pNSlPUuN452xvygvFX5iLewuJM3iBM2pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbDvXqWssV4NoVkaBiFI1ephQIvO6Mqamb+zV94bLvtSKbMb1rMfIoHM2PvSCNHwWw/Pqdf0wr6/nizvWizJTupEN4c+f/+TOfRl9A0GuC33YPQjt3USL/mK7XINQiDAssQptCQLJmzR/DwohXwfdVaT0tmzuuDMTaGmwmMzQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1+UPMy3+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso40499545e9.0
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747728696; x=1748333496; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THF+HMUCeR+ZEHyvD0Jg4qnj89QwaX1MllBVWuesBV8=;
        b=1+UPMy3+WZ7HupT4yxBSzEPI1O0a8S9JOhoiWnmUwpLb5xjOhSpSa8BFZHC9+XANhF
         oLEAMwE8ypXpxH9qOrtej+JAtxFjIuNehCCW6Bzr1/iAKhTJms6WiNKLHbUqZ3KOlmvw
         rgjG8LkfhPQDIzWUfTP4xH1UZKMJKiIgA10ub7ywVr7WpwAW0O4WPnkbeQYER4KzeGUs
         pwpJdrmc8EqyMocHipOo4yY6nZ8GnZpqoy44eDAqxogPdrbW8olJJ6OC9iVtP3tmo+gf
         090FCSMtCBtzh6UL03r4f2cA956YsxmSFZX1aZJ6wYd1RLIBARqbtGp8wCUYYXpiHaj5
         ye1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747728696; x=1748333496;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THF+HMUCeR+ZEHyvD0Jg4qnj89QwaX1MllBVWuesBV8=;
        b=t/KUgFSlB1wu4v9q8Fh/P2TaIvTSZfI1RN1OEKABFi+rO08CSpHOrISGixy927g1I6
         hv5hM+mcrYP6Kcp47AQvNDhw+2s28YRJh3kVbtMduSoPVAvVQrclWNzIvlKGPKMdvNZb
         Y41W8NWOsL5YOdb/KNqWtNATiIx4o56tHxOm9Fok0+7a4uCvRb+IiK8odlTE2K4rmmjs
         qpkcwPs6QkpWxnqo4h8NLoEdwzllYYZywZTjotIHZan0I8nhLX7f0NNFcrY86j8KVIh4
         yIFjljHfMX50bSEFGVJdY+sktaqbSNxY8knzL+SL+Z57Cb3MOb7WkE3uo1mm8cS+kwZ2
         nb9A==
X-Forwarded-Encrypted: i=1; AJvYcCVmb9Yvj8e48a3WZwyR1tLXqRQl782GD07mY8IsXgEgakCRZOWd8rLjPSN3jeRtm2X2ovQb06/b3Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxZnyvvbWPDHZpIaI8JIfTJItpHo03sUmGo01Eq4yKDJEdM/l
	4M3UCCkDZq3G+9PtUIIBpseHbmYvvM12Cl16cvMIaps/8/jjvgCieu2aU4o9QcU1sqI=
X-Gm-Gg: ASbGnctrSMFNlCNLa8wVf/K2RtctqX6XqpkVsqa/R3dKfAiiKlGiwKbJSLRxn/wkevC
	NDCXxJwQLuz9MsTwlayRZNY6U7r5tQ7ZY4mwd/kIYvbhJ20sWdXvDDogOwlc8dV5us9lCtmX/iG
	0cZ3eWSpB1gJI9V73Aqq/o1nJgNBxJl0y448iR3gpevYUzFAguXm1hCIFkUmNN33cuSx/IOcQun
	FaxmpMxVOZdWAEH3zfvfYhQtzKa2Dmsf1w5pmCFsrz2tfTAcZATg2aFfqJe2BDV3zArfK/sDRrx
	0Tgu/mTcMJpGMh0Hg7n7o1vZWflt69ne7IM2CruUz69kzDYnPkY=
X-Google-Smtp-Source: AGHT+IHtId6x3szrS7b6effYezOLNKLAda69T0xvOKtzK7SCyXc6cFPh10PQsKA7MJT0nqyWBYBUvA==
X-Received: by 2002:a05:600c:5491:b0:440:6a1a:d8a0 with SMTP id 5b1f17b1804b1-442fefd6da8mr128464775e9.7.1747728696095;
        Tue, 20 May 2025 01:11:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f683:3887:7e7c:b492])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f45a8434sm22137365e9.0.2025.05.20.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:11:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
  Kishon Vijay Abraham I <kishon@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] NTB: epf: Allow arbitrary BAR mapping
In-Reply-To: <aCu0Wem4KkaybW4f@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Mon, 19 May 2025 18:44:41 -0400")
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
	<20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com>
	<aCu0Wem4KkaybW4f@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 20 May 2025 10:11:34 +0200
Message-ID: <1j34czn1l5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 19 May 2025 at 18:44, Frank Li <Frank.li@nxp.com> wrote:

> On Mon, May 05, 2025 at 07:41:50PM +0200, Jerome Brunet wrote:
>> The NTB epf host driver assumes the BAR number associated with a memory
>> window is just incremented from the BAR number associated with MW1. This
>> seems to have been enough so far but this is not really how the endpoint
>> side work and the two could easily become mis-aligned.
>>
>> ntb_epf_mw_to_bar() even assumes that the BAR number is the memory window
>> index + 2, which means the function only returns a proper result if BAR_2
>> is associated with MW1.
>>
>> Instead, fully describe and allow arbitrary NTB BAR mapping.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 108 ++++++++++++++++++++--------------------
>>  1 file changed, 55 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..9539cdcd0f8fa4b5c5e66477672f8f97d5ec4e52 100644
>> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> @@ -49,6 +49,7 @@
>>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>>
>>  enum pci_barno {
>> +	NO_BAR = -1,
>
> Not related with this patch, but there are too many place to define
> enum pci_barno. it need be consolidate.

I agree it needs to consilidated at some point but that's another topic
and there are tiny differences between the 3 definitions so it won't be
as trivial as one might initially think

>
>>  	BAR_0,
>>  	BAR_1,
>>  	BAR_2,
>> @@ -57,16 +58,26 @@ enum pci_barno {
>>  	BAR_5,
>>  };
>>
>> +enum epf_ntb_bar {
>> +	BAR_CONFIG,
>> +	BAR_PEER_SPAD,
>> +	BAR_DB,
>> +	BAR_MW1,
>> +	BAR_MW2,
>> +	BAR_MW3,
>> +	BAR_MW4,
>> +	NTB_BAR_NUM,
>> +};
>> +
>> +#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
>> +
>>  struct ntb_epf_dev {
>>  	struct ntb_dev ntb;
>>  	struct device *dev;
>>  	/* Mutex to protect providing commands to NTB EPF */
>>  	struct mutex cmd_lock;
>>
>> -	enum pci_barno ctrl_reg_bar;
>> -	enum pci_barno peer_spad_reg_bar;
>> -	enum pci_barno db_reg_bar;
>> -	enum pci_barno mw_bar;
>> +	const enum pci_barno *barno;
>
> barno_map?

ok

>
>>
>>  	unsigned int mw_count;
>>  	unsigned int spad_count;
>> @@ -85,17 +96,6 @@ struct ntb_epf_dev {
>>
>>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
>>
>> -struct ntb_epf_data {
>> -	/* BAR that contains both control region and self spad region */
>> -	enum pci_barno ctrl_reg_bar;
>> -	/* BAR that contains peer spad region */
>> -	enum pci_barno peer_spad_reg_bar;
>> -	/* BAR that contains Doorbell region and Memory window '1' */
>> -	enum pci_barno db_reg_bar;
>> -	/* BAR that contains memory windows*/
>> -	enum pci_barno mw_bar;
>> -};
>> -
>>  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>>  				u32 argument)
>>  {
>> @@ -144,7 +144,7 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>>  		return -EINVAL;
>>  	}
>>
>> -	return idx + 2;
>> +	return ndev->barno[BAR_MW1 + idx];
>>  }
>>
>>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
>> @@ -413,7 +413,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>>  		return -EINVAL;
>>  	}
>>
>> -	bar = idx + ndev->mw_bar;
>> +	bar = ntb_epf_mw_to_bar(ndev, idx);
>> +	if (bar < 0)
>> +		return bar;
>>
>>  	mw_size = pci_resource_len(ntb->pdev, bar);
>>
>> @@ -455,7 +457,9 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>>  	if (idx == 0)
>>  		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
>>
>> -	bar = idx + ndev->mw_bar;
>> +	bar = ntb_epf_mw_to_bar(ndev, idx);
>> +	if (bar < 0)
>> +		return bar;
>>
>>  	if (base)
>>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>> @@ -557,8 +561,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>>  	}
>>
>>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
>> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>> +
>> +	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
>> +		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>> +		return -EINVAL;
>> +	}
>>
>>  	return 0;
>>  }
>> @@ -596,14 +605,14 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>>  	}
>>
>> -	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
>> +	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno[BAR_CONFIG], 0);
>>  	if (!ndev->ctrl_reg) {
>>  		ret = -EIO;
>>  		goto err_pci_regions;
>>  	}
>>
>> -	if (ndev->peer_spad_reg_bar) {
>> -		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
>> +	if (ndev->barno[BAR_PEER_SPAD] != ndev->barno[BAR_CONFIG]) {
>> +		ndev->peer_spad_reg = pci_iomap(pdev, ndev->barno[BAR_PEER_SPAD], 0);
>>  		if (!ndev->peer_spad_reg) {
>>  			ret = -EIO;
>>  			goto err_pci_regions;
>> @@ -614,7 +623,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>>  		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>>  	}
>>
>> -	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
>> +	ndev->db_reg = pci_iomap(pdev, ndev->barno[BAR_DB], 0);
>>  	if (!ndev->db_reg) {
>>  		ret = -EIO;
>>  		goto err_pci_regions;
>> @@ -656,15 +665,20 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>>  	pci_free_irq_vectors(pdev);
>>  }
>>
>> +static const enum pci_barno ntb_epf_default_barno[NTB_BAR_NUM] = {
>> +	[BAR_CONFIG]	= BAR_0,
>> +	[BAR_PEER_SPAD]	= BAR_1,
>> +	[BAR_DB]	= BAR_2,
>> +	[BAR_MW1]	= BAR_2,
>> +	[BAR_MW2]	= BAR_3,
>> +	[BAR_MW3]	= BAR_4,
>> +	[BAR_MW4]	= BAR_5
>> +};
>> +
>>  static int ntb_epf_pci_probe(struct pci_dev *pdev,
>>  			     const struct pci_device_id *id)
>>  {
>> -	enum pci_barno peer_spad_reg_bar = BAR_1;
>> -	enum pci_barno ctrl_reg_bar = BAR_0;
>> -	enum pci_barno db_reg_bar = BAR_2;
>> -	enum pci_barno mw_bar = BAR_2;
>>  	struct device *dev = &pdev->dev;
>> -	struct ntb_epf_data *data;
>>  	struct ntb_epf_dev *ndev;
>>  	int ret;
>>
>> @@ -675,18 +689,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>>  	if (!ndev)
>>  		return -ENOMEM;
>>
>> -	data = (struct ntb_epf_data *)id->driver_data;
>> -	if (data) {
>> -		peer_spad_reg_bar = data->peer_spad_reg_bar;
>> -		ctrl_reg_bar = data->ctrl_reg_bar;
>> -		db_reg_bar = data->db_reg_bar;
>> -		mw_bar = data->mw_bar;
>> -	}
>> +	ndev->barno = (const enum pci_barno *)id->driver_data;
>> +	if (!ndev->barno)
>> +		ndev->barno = ntb_epf_default_barno;
>
> I think needn't check it because all .driver_data already set in ntb_epf_pci_tbl
>

A check was there before, I'm not changing what was done in that regard.
I'll another patch to implement your suggestion seperately.

> Frank
>>
>> -	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
>> -	ndev->ctrl_reg_bar = ctrl_reg_bar;
>> -	ndev->db_reg_bar = db_reg_bar;
>> -	ndev->mw_bar = mw_bar;
>>  	ndev->dev = dev;
>>
>>  	ntb_epf_init_struct(ndev, pdev);
>> @@ -730,30 +736,26 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>>  	ntb_epf_deinit_pci(ndev);
>>  }
>>
>> -static const struct ntb_epf_data j721e_data = {
>> -	.ctrl_reg_bar = BAR_0,
>> -	.peer_spad_reg_bar = BAR_1,
>> -	.db_reg_bar = BAR_2,
>> -	.mw_bar = BAR_2,
>> -};
>> -
>> -static const struct ntb_epf_data mx8_data = {
>> -	.ctrl_reg_bar = BAR_0,
>> -	.peer_spad_reg_bar = BAR_0,
>> -	.db_reg_bar = BAR_2,
>> -	.mw_bar = BAR_4,
>> +static const enum pci_barno mx8_barno[NTB_BAR_NUM] = {
>> +	[BAR_CONFIG]	= BAR_0,
>> +	[BAR_PEER_SPAD]	= BAR_0,
>> +	[BAR_DB]	= BAR_2,
>> +	[BAR_MW1]	= BAR_4,
>> +	[BAR_MW2]	= BAR_5,
>> +	[BAR_MW3]	= NO_BAR,
>> +	[BAR_MW4]	= NO_BAR,
>>  };
>>
>>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>>  	{
>>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>> -		.driver_data = (kernel_ulong_t)&j721e_data,
>> +		.driver_data = (kernel_ulong_t)ntb_epf_default_barno,
>>  	},
>>  	{
>>  		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
>>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>> -		.driver_data = (kernel_ulong_t)&mx8_data,
>> +		.driver_data = (kernel_ulong_t)mx8_barno,
>>  	},
>>  	{ },
>>  };
>>
>> --
>> 2.47.2
>>

-- 
Jerome

