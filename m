Return-Path: <linux-pci+bounces-3274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6484F186
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB22287142
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39B65BDC;
	Fri,  9 Feb 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTd2Xnid"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1667C53
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468047; cv=none; b=izxjaXWuZyPYl4M3tHjOKLLey3+nN/J6XbZUJMrlL0UguP13TmS0Yqe0Qc9flh+d62uEZquKr4boRhrzecsiwA42CQBZ2YLqNAaIhJkzfFne3/vvXm/frdXegUWrrxdf9foWv7ICx9PlzDbAIFFxHbpYosAmOxbvhTXSe3l+nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468047; c=relaxed/simple;
	bh=L03SiEDixVoCXTpd/RTYIrFTUuUxJJDE2yFlLIzPwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idSJY132lexnV0Nkw81okMWM1OU7uJyjaRijmZJ9GaYHPZF2Gc4BAI6ydtXupTXFkvlxQTH7eSLwrEKAwGHdoeXkawMpInlW5x67ho5UItHlbZR6BTtokRz7Uo33/zuwsoTsL0FWqUuU8JpahbOXR8mSq36eX4QfAFLekpfVqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTd2Xnid; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc36e501e1so454100a34.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468045; x=1708072845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+allSi6dNgOI5NZL+tvSAcPNcxZb8/83v0dMPt+LNgM=;
        b=UTd2Xnidx9h9Ip40o35ofbVC0cTOGZfQ/HJ4bL1QSJYZHPxVu/WDGF5Av2Z7sXY7jd
         i4gOlQwlFP4sFXRrMnHj4XJ6FscUPz6ZCFd0JlLSkkcVhcmWhUCby18Z7YUYIccL1XE7
         2SKM6zQIVbOpcq/OpnQGmoF7pdnmzIO8GIN+wqWoAHwftKz0cyX3RKacu+MNsYbqgkIL
         beE7w5up1lZp62vVdgCOkk0jGwElxG14jhT0Ur1NqYztLYsClzzS0Grym5+ZM9+PGXqs
         u5YMK5PMOVvxTHmKaAq4dl6PkEJaEKs+xLxyDm/7G9Yp4SKbdXphVoGFM8DWNXgVlTlv
         nx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468045; x=1708072845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+allSi6dNgOI5NZL+tvSAcPNcxZb8/83v0dMPt+LNgM=;
        b=fRyaGwGIlXTbq3q9Uz9LsGNk7yH9EQUvcfzkfKBUpoZelZF4kppqwcq8kgj77B6Q3Q
         djQKCb8xNvHFl5L+hmVX3OwRytF8eTSfwjeqBlpLdl29Lkxr3eptux7fDbUBVfoXkT2F
         q33/u+IwOpAZoUjs3LA0AWcD4CmZJju16S0+zVHeHILWr0NJ2RScTK31evn7NaHq3sVy
         iOP3RTPzhJKRXHV64zLoijnMVON2yDicVEo0FVm7cMZ7YVklvYvsoXZyeka7TwVMjjif
         VlxhWw9ysebi2eMoxXo4z5b+pQ9AhyI2u8L4ErRrDZmpgDM4Li5ED/OJZwgwPuPUeb1l
         cJ2w==
X-Gm-Message-State: AOJu0Yx5TnO+yv2ZMnWX5/yoK8/CGVDlYQTSyh+t4KywzT79ndCIGWWF
	R1EK40dNNucY9wXRqMjojxb7HFQRedWlY6Ksxxx3al1gNmTkc4PAJ2mAafYVqg==
X-Google-Smtp-Source: AGHT+IEL/WiMV9BROlTfuJQzV+HukGeXp9zIsgMMifzgDpaLRJ7Ov4fqalCTwSIVKauCxnDfiqBC9A==
X-Received: by 2002:a05:6358:8a3:b0:176:d0a8:8df with SMTP id m35-20020a05635808a300b00176d0a808dfmr924032rwj.8.1707468045150;
        Fri, 09 Feb 2024 00:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFmitalR00woA5PwCCf0fiytsYvIAsD2pwl0lT9B4TsloVDvLV24nUw7wEQh9iWMOW2rXvZugRmiLrrqEXu6yF4Wu1hrGfNvmMnNzYyhi6WQCTYXJueg1tO7AfbBJoDY3bkzXystS6EEYWEQfV0vrIj2nOe2dLwuHjVToRcrO7Ad1c4eSU2sYvuJubfro/bb1Uu7FIn7iJvDfvj6ZOxLKEZvSQv5CmNuo2uvLipwDQ80aB15EfTrIY9ZP1yDnXcQctRVW76zraGoXiJCGpnvs8BbhJmzZdR2zKWg8+gd0YVz9dw6ZH3lUaMHiUmpGgLQ32auKGjw0Z0qTb
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id qn13-20020a17090b3d4d00b002960e3745d9sm1188318pjb.13.2024.02.09.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:40:44 -0800 (PST)
Date: Fri, 9 Feb 2024 14:10:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: endpoint: pci-epf-vntb: remove superfluous
 checks
Message-ID: <20240209084040.GE12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
 <20240207213922.1796533-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-5-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:17PM +0100, Niklas Cassel wrote:
> Remove superfluous alignment checks, these checks are already done by
> pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ba509d67188b..eda4b906868b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -527,7 +527,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> -	u32 align;
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> @@ -538,16 +537,6 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
> -	align = epc_features->align;
> -
> -	if (size < 128)
> -		size = 128;
> -
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> -
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
>  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

