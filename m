Return-Path: <linux-pci+bounces-6479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2C8AAB70
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F051F210AA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A278276;
	Fri, 19 Apr 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGUF9Kg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8A7641B
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518798; cv=none; b=VWbaTla6UHO73ZiCCfb5TrWjEUzB+7pxvyuBEni8QdjZ3yI890Lp2cEkG8MgJpc0Kst389S6VtNEN/xCR3i4jqrmxV3Ve5u3K7mc6jPHBoKfPZIcvRWUXTXZBu18/mxXinKNEcffJrTnDEVD4UtEToV6o+0vNYqN88JtodLqpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518798; c=relaxed/simple;
	bh=nEQE1bgcahfGAeEROm4nIOqoBwmVPoodJbRFX+eJFiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU1WMo+0Uathou1EiJtkTegXNRlDxvqFf3k4OI0e/bJgD6PSqMwq4UFJjpCCrwRl+wUW+Zz8ZAnzN5vyShD0RfJ0vgoAZRpssC14rTwELTpYG+erzONaQTI9nL5gVmCRIgKVyskbOpicTq1flQ+hVF3oqXiFKOJEi2+MAz2DDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGUF9Kg+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c74b643aebso119495b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713518796; x=1714123596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2k6wBjEwpSJIIcZ8MPn1YroTKsxMSXWDSsv1Yc3sRE=;
        b=zGUF9Kg+YfIg5reVeeXUQSnLyDkpUGj4ulcrTG/5U9jobWew3+UbDq2OCWNOICgrin
         7hq+3cPPix++lBy9F14RWm5Kz62j93bljrW2wyIbZfSBeV6hVlDONbm0khRSoONFcdlX
         m41WZ3vCnL/HRQCbm9Qj5cOGZ83h+9xNVYIElD3ISyaC3qoGA2OXFv93nWqtkEmGcRmf
         xia1REZQMbnyGTtMXEg7PqQug4haRsaTWrvhTunIto3xjfTmbDau0evVRjD2xId5dtLs
         XrYMSEZPOuvjnznpUiRiIb5UH5FkSK+75423udCleJnPXJH82URJBsBFXKV9Z6T+oSqn
         DmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518796; x=1714123596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2k6wBjEwpSJIIcZ8MPn1YroTKsxMSXWDSsv1Yc3sRE=;
        b=js+qLfiuL6gQICum/ZmJGwjs9zmmY0weVXUvRW8dJ8b3YqsOo11wFd5MfJTE3f+H9H
         Oc+q/2scOEGI3kEkTJDetQ9YoopcQpFpFUr97dSgwNwcOqVN3WojIADucjbX+93tt40J
         oiv9rEH/WFSbKW0+F8Lr62FGZfOxofUF2dAEHa42/2u4FyQDnzt5CqUO8fgyQdFQVx+O
         usEZhYvUOJOGy3tS7fgJ8w611ABNanSn9Y2ECvWXIqN8xxPQxUPal57GykBvMNE33yZz
         /CkhjkPaZp6j8W079qSfZg5GkafUZS2MeT+UC5e+ATYpI1jUcZVTOjZiOHguR4sCqbrI
         9EgA==
X-Forwarded-Encrypted: i=1; AJvYcCWdvGZ5o3FejPgdjgntixVskHNiuMiD+0yKpIS4BxDXF4f6RH4KehBbkMvxAUEQL/R+xn31g4dig2+ja4sTNP1Qi+Pkstgr74xF
X-Gm-Message-State: AOJu0YypA6h2GFnkmCEsOold4gMvH7NKizW/zbyqQhxukFtLOVQRGgnN
	CbEj3jBooAoD0zpR8MBsRNNJE8k2vqiBqhJ4TZ8bP4v8pBPSOm23ogLmVlUAUw==
X-Google-Smtp-Source: AGHT+IGPIPPIitXX4Yw0hrulDjF2tnglO0Qdegfb3hKjRqYEF4E5wtIteUhkJR61YJc1aF7VAjq+9A==
X-Received: by 2002:a05:6870:12d9:b0:22e:c37c:453d with SMTP id 25-20020a05687012d900b0022ec37c453dmr1625314oam.30.1713518796449;
        Fri, 19 Apr 2024 02:26:36 -0700 (PDT)
Received: from thinkpad ([220.158.156.51])
        by smtp.gmail.com with ESMTPSA id z17-20020a634c11000000b005f0793db2ebsm2715872pga.74.2024.04.19.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:26:35 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:56:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <20240419092629.GA3636@thinkpad>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
 <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>
 <ZiEy4EVcVpUry9qn@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiEy4EVcVpUry9qn@ryzen>

On Thu, Apr 18, 2024 at 04:49:04PM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> > BME which stands for 'Bus Master Enable' is not defined in the PCIe base
> > spec even though it is commonly referred in many places (vendor docs). But
> > to align with the spec, let's rename it to its expansion 'Bus Master
> > Enable'.
> > 
> > Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> Outside the scope of this patch/series:
> Do we perhaps want to add a bus_master_enable() callback also for the
> pci-epf-test driver?
> 

Makes sense to me.

> In my opinion, the test driver should be "the driver" that tests that
> all the EPF features/callbacks work, at least a basic test "does it
> work at all". Other EPF drivers can implement the callbacks, and do
> more intelligent things, i.e. more than just seeing that "it works".
> 

Agree. Feel free to send a patch :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

