Return-Path: <linux-pci+bounces-2884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022CC844001
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3589C1C265DA
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452317BAE6;
	Wed, 31 Jan 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7ROWugx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14B7B3D1
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706299; cv=none; b=FmVUJ3cbCZkuriojBQFj9NjMMd8Iif4WkCwKzovQQWm6itjG73ikGQHD5Aqc+0mJS7qYrhcHVfpeaSdoVk/5eitIWzc2WuyZmQrbMHzgrjqL/A4HBwts1nA/+iUsCuxMC8H4U6WbzyrWtf3s30uWG3R8xOIjLvW1mA8mzmU72lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706299; c=relaxed/simple;
	bh=DoTM2f6VGFsINx+G19Tv5Dll84Au+XUo51wOu8X7VJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKxFsjYYJoo+0QpPE/oOGG7EQXkSvcKrFSjDRSt5SMqQsIbBVMn8Yv9BgukHCj1b5WJUSpmqXPStsVJJHAMNltmafB99pCIJueI3AwQxwNt7j9S1eLHvGdKQthnoJzJ6WkF5FO7aMUT5wKTQStVvghlwCxvMz0vh9nzL+Bo1UoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7ROWugx; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f3d27bfbso241590185a.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706706296; x=1707311096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UKUcd5D+1JPbwtYljd5Shz+Q2IVEZGi4e7Ge9AkNoXo=;
        b=t7ROWugxbL4AuuEqERS8NNuCvU/L5UIjQq0KaHbCT2l3JsIa98JpjsC5UO+WvH0hT2
         vDDpLfLM1ph27lmdUk5WegUmMdotkx8XGxunRRJoNrOMogbRGUGyQ+mZRc3M0atBU/p2
         h3exKt1hsmKhl7f6Jk6pJcMYmhK+gOdiA+5nGQenDON522fRpobqup4SNdB8uM3d0qvt
         LDpn5XsTHtASmrqqzTYCXOiCUyVmyUmfNvrhOMKZcBBqRBQLuadXJU58hD1N8Jv9biI7
         CL257nBX6Xgwnag8Y5zc7DETcdNeIIQOMde+EQhsTMz695tjUV2dWJcnyigsVfv/J0eH
         bIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706296; x=1707311096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKUcd5D+1JPbwtYljd5Shz+Q2IVEZGi4e7Ge9AkNoXo=;
        b=F65O+oZd8zfE9o3l3CU3RL3wbhC7tz8IOcI9780asQU6ONwqN/L/vsgKTiekij8rnB
         1wiPp44qMveDhOhyvF/2tuYRGAMD3nC7vuWiOvIOAG/agZL9BBjHJ19mqcpdxM9BLToB
         llSpysXcCdgExy2d9pqngrRZS3L1jQAuZaEYl6G2o7fZXuSdRZCsdpbJQ3zxfq+jbq4y
         34L/Ji5DDLANbfyK1sQNFxpGW+ikTTM6yBoBlbNTsaf2XLi3cbD3t9rdRipsnrf5FVqI
         6r5kBuzU0hSZi4anE1QRwM+KK7U1b9fTgEzMc4U+AEoRhNxHJ7WT7JbRuEib7a5K0x/Q
         1N9g==
X-Gm-Message-State: AOJu0YyHO5hFcwYfVZifTc4+ZFUuIiPugsnE6Pprke5xkRDtqkiKxQFh
	TQBb7VewgHeTS21j+94yIglFjBdX9ua3MKZdrR62ugAqIfYFEsX4kWQdLc+EPQ==
X-Google-Smtp-Source: AGHT+IG97UTdVjdz1JnrDlOVjZrOHB3xPrp1BJA+YTPV8AlFQ5iotfZVZqv8MP3IW+unn/4j8W+iLw==
X-Received: by 2002:a05:6214:2025:b0:68c:5a4d:35ac with SMTP id 5-20020a056214202500b0068c5a4d35acmr1976438qvf.1.1706706296263;
        Wed, 31 Jan 2024 05:04:56 -0800 (PST)
Received: from thinkpad ([117.248.7.45])
        by smtp.gmail.com with ESMTPSA id ma9-20020a0562145b0900b0068193a74edesm1081585qvb.52.2024.01.31.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:04:55 -0800 (PST)
Date: Wed, 31 Jan 2024 18:34:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240131130450.GA5273@thinkpad>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129165933.33428-1-lpieralisi@kernel.org>

On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> The PCI endpoint subsystem is evolving at a rate I
> cannot keep up with, therefore I am standing down as
> a maintainer handing over to Manivannan (currently
> reviewer for this code) and Krzysztof who are doing
> an excellent job on the matter - they don't need my
> help any longer.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks, Lorenzo for your help so far! I'm delighted to step up to maintain this
evolving subsystem.

- Mani

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..a40cfcd1c65e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>  F:	drivers/pci/controller/pcie-xilinx-cpm.c
>  
>  PCI ENDPOINT SUBSYSTEM
> -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  M:	Krzysztof Wilczyński <kw@linux.com>
> -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Kishon Vijay Abraham I <kishon@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

