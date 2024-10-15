Return-Path: <linux-pci+bounces-14511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8599DD94
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 07:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6FB1C21123
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E017554A;
	Tue, 15 Oct 2024 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPUyfUd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A263C3C
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971013; cv=none; b=BcMWVU+RvcaugT6BwE+3WzPmG8V/V9qqGX9IjiBc67z/e7+I9mcFiKSl+Bpg+EYfRzXImjAgSsxJsmWIMLNtVls6lHTuBhey+rn+BqFPYLIClK++pI3gTM7AUycBBBhgDf1lTpxiC2B3BWQE4iXe/8gZbJm1s42GWo+H8lbX64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971013; c=relaxed/simple;
	bh=aPyhvsIHWKafSuj+wxn1ADDM1UiltHIRxewY3Zi+d50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuYeGz0a5wkRyEKUOV/KbyMPmaA7P04XkJM7niDkzYuuYQl9gsj9F8J0q93KU+gZYJ8zfFZiHWYpIkuM5R7ONFTwWfmT/IrJo0ge2467YiiKjLBEQTbWM10MjjV7WMiL971GRyfwj64kssUetuV2Z+LcVIm5DsC/PFqVnBcJkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPUyfUd2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1072567a12.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728971011; x=1729575811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3eScfC9pibKk1KgtouCoKIY5BFTTzGD7fAk0dcgWsg=;
        b=tPUyfUd2qtedSHp83IUqbw9iSeikGkwsHn07UQRYyKxR/6Lv9hCH2Ata2tYgSyfZMM
         stHWc64f/uSrULTCLwmWI4o9Vi0N2VNvbBgR7gNJ5Zzd3EMrhip19XsWMMlzcPauiOrk
         GQDhUBD3RMoO3yl9IBZf8+J6HrJAqvo28/yDwya9QOXp/QriDs4Qaz8qMclSxC2ZnfmE
         lCMxtIJKR+fsOOkTBT0zD7ZFfYINUTO8h+eeVDh9zlFnmQF1Et7IGTcnPuwXoNLSbs3K
         7Uyr7w5T+MQu4zsNJfNsy2R5FciwpYYKnKGrofeGJa2JjtAq+hdM8RyL5KvTtC5iZ7az
         Vopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971011; x=1729575811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3eScfC9pibKk1KgtouCoKIY5BFTTzGD7fAk0dcgWsg=;
        b=MkWoFk42Gmkfi0w2r2pY847FrpwVDqZcGSg7VSIDY3I4cYHVyA0+Dcbx8ZXwflQInx
         sYvw7b9WcNhNcxwp2gRd8ztmOcrOGIuBPGRySm6JVqpEemTIoYPTKZf6WRg4gttu+2ev
         d3tNIhUcYNF+zyeilkFvSbuJjfrByXwwsz/Zk3rFu419ZIiK+rIcL+0Y2NoxUDIv/+qR
         QXcXGGdv3Ll1KNV4hLuYSva0oLmCtDJnduHuxa+wRS/h9E+gcE0CHUcBzdNfrf853be/
         rfpeOhwOPyo/aaeO4hTikklIqMcRxy1ZgosW09kIjSXQhxg4OD/NPvxJjW5rsDTQj+mE
         toOA==
X-Gm-Message-State: AOJu0YxgNC5M7xJdZhRevMISfwe6SK3BENWVCf5N7bBRln1Khu8rJGkK
	HWdCQ+fBpAh1plwsQJSzU+SnIHOq2rgi1Q52WRMoGxDye8EuRMeP8atw7oWIAA==
X-Google-Smtp-Source: AGHT+IESOLiaapZ0ZMB2cR/4YUD2x4GW92A9FhG/YQpCKRJrBdRhOVTqQE4np+PahiUmSLdK48YB4g==
X-Received: by 2002:a05:6a20:30c3:b0:1d6:e575:c347 with SMTP id adf61e73a8af0-1d8bceef32emr15003211637.3.1728971011605;
        Mon, 14 Oct 2024 22:43:31 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84db0sm4561325ad.22.2024.10.14.22.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:43:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:13:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com,
	Nirmal Patel <nirmal.patel@linux.ntel.com>
Subject: Re: [PATCH] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel
 client SKU's
Message-ID: <20241015054327.umb7lhn5zntlotyk@thinkpad>
References: <20241011175657.249948-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011175657.249948-1-nirmal.patel@linux.intel.com>

On Fri, Oct 11, 2024 at 10:56:57AM -0700, Nirmal Patel wrote:
> From: Nirmal Patel <nirmal.patel@linux.ntel.com>
> 
> Add support for this VMD device which supports the bus restriction mode.
> The feature that turns off vector 0 for MSI-X remapping is also enabled.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.ntel.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/vmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a726de0af011..4429a3ca1de1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1111,6 +1111,10 @@ static const struct pci_device_id vmd_ids[] = {
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xb60b),
> +                .driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xb06f),
> +                .driver_data = VMD_FEATS_CLIENT,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 2.39.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

