Return-Path: <linux-pci+bounces-14377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A644B99B29C
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51621C20BD8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3CA14A639;
	Sat, 12 Oct 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hA64SJbj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA808BE5
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726154; cv=none; b=gWCPVKCPvL4/qwbfYdx125uPqIJxFSlAFuKAOesCXJmrXV7163swuvqjq2WbkfCgk8AiMz86tKuNhA/3VKDSnffETibz+UuOmuaGaZVpvd58oHneVRFMfIfck/lr6O2g+8AR4eeWnBbespehqmVAYjUzs5hO8GTlnP3F/q2SI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726154; c=relaxed/simple;
	bh=1MOCIBPNeE+L7fBnLSxc+tCEOPU04dH1DuG++vHZCAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM0MYXF0o5dNUsHbZDzak/aP5Q5uzUnMQpXWM6JJjILl+Lp1qSWlKAs46EQEIgSC6Bk1Lagn1JnZhChxhRxFoTpx//DqE1bp4ULnlkTqtoAesOtj+PFbVszw3NBBhTrmKOYkSl6QLr5v3NEqPA/ihKAjwjJ4P6/UPy/JfWVKo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hA64SJbj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cbcd71012so5837215ad.3
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728726152; x=1729330952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wv8Os/bVSj0D6j/Okv7oGUTwvKszDlpqSBU90nFMM+k=;
        b=hA64SJbjEVTV/A4/hDey11i2zH5kGLeMAgIFP+xVdKkKDdmzxsg5IEJ0+x0lPGAZxc
         OcOgybYycdZz7ey4Cq+KFmIFYzjp5sCHtxWL3THS0YRwYzoXetqWE35TyjyB8nclUE60
         mHtYB5z7uBIdHYm3JA6zHbKxOyHZDU06TFK+RSK9UyA5nzjcdSCsJbFbb3FsPOE5pN1v
         syLmth26NvF1pP/Wt7VlOOVMAIriTbb0wxnes1vPuS6rP1i4L54+jmLnH6KwpDTddO1Q
         WxWCd/oRFOJzAStIsLVUw+8EN89HOz/U6LnlHPC75YcEUVLHuRsMBZMVBNnHRPTb3FrO
         Mgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726152; x=1729330952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv8Os/bVSj0D6j/Okv7oGUTwvKszDlpqSBU90nFMM+k=;
        b=X+6rvajBSkHmAkNrbXLQjB3G/dBOKNRDcwDMtvcki5dKdEt2SKTMP2scecmGE+Z43n
         EVPth/zh8qIsgOj3JC9fW5Gi5V96SVU6LLlZQ3sXXk71BVVlNZmsVzvlxE5yhN7u3PKn
         BliarI2ZxiwkMM5VfIm679uJPz25S8Ucwh1xNuSqf+S0moMVljcl4bF3PR1MLl298mvS
         spxRtKXDhswwbJebF9PUcEC8irLPd2FCuqGBjfh9avLvC5m4wf+lT03T6xvc7VUJ6LJL
         RnBpL3sF1m2/IAFv9W33Nq6tO+06WF1oC9H7kqC60gpN0y+NPkBibnISll1YzlIIWt5D
         Q2AA==
X-Forwarded-Encrypted: i=1; AJvYcCWW+7jLeoB2AjQnSmgkjZ7AjLHsxLCs+uUfP7uwj8whaetoJfvILZLU+UB7YUak5ka8t9maJGWFX5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiOfHWzn/y1Jnn5HpI9zRj6eEfEJQH5Z0Ne0PUHXYIfaCZLGD
	XY9rdFM+Jvvwq4H99Z0plP/6r4DoczWQb6gPZ11u4LUcWSoifjeLKr3ByFTwdn/gmMYuloPANko
	=
X-Google-Smtp-Source: AGHT+IEkv1aKhRYQ+t87+dSinrc4MeTU3L+sniPCv4eQsfBUPsp8D8dYqAr46YTbuXeaLvcoCeLy0g==
X-Received: by 2002:a17:902:e547:b0:207:6fd:57d5 with SMTP id d9443c01a7336-20cbb236be8mr34901625ad.36.1728726152027;
        Sat, 12 Oct 2024 02:42:32 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33b5sm34787605ad.37.2024.10.12.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:42:31 -0700 (PDT)
Date: Sat, 12 Oct 2024 15:12:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <20241012094227.vp6hxipv44yve4kk@thinkpad>
References: <20241011120115.89756-1-dlemoal@kernel.org>
 <20241011120115.89756-4-dlemoal@kernel.org>
 <ZwkU68LjTkahz_RZ@ryzen.lan>
 <fb6d46ae-cbe1-4ba1-8064-10ebbb3edfa8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb6d46ae-cbe1-4ba1-8064-10ebbb3edfa8@kernel.org>

On Fri, Oct 11, 2024 at 09:21:29PM +0900, Damien Le Moal wrote:
> On 10/11/24 21:07, Niklas Cassel wrote:
> >> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> >> +		return -EINVAL;
> >> +
> >> +	if (!pci_size || !map)
> >> +		return -EINVAL;
> >> +
> >> +	ret = pci_epc_get_mem_map(epc, func_no, vfunc_no,
> >> +				  pci_addr, pci_size, map);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
> >> +						map->map_size);
> >> +	if (!map->virt_base)
> >> +		return -ENOMEM;
> >> +
> >> +	map->phys_addr = map->phys_base + map->map_ofst;
> >> +	map->virt_addr = map->virt_base + map->map_ofst;
> >> +
> >> +	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
> >> +			       map->map_pci_addr, map->map_size);
> >> +	if (ret) {
> >> +		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
> >> +				      map->map_size);
> >> +		map->virt_base = 0;
> > 
> > As reported by the kernel test robot on both v3 and v4, this should be:
> > map->virt_base = NULL;
> > otherwise you introduce a new sparse warning.
> 
> Oops. Missed that... OK, sending v6 with this removed as that is not necessary
> anyway.
> 

Please incorporate this in v6.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

