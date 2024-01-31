Return-Path: <linux-pci+bounces-2885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A0F84400C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 14:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EF72960CA
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF17B3E5;
	Wed, 31 Jan 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMZn55e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCA7AE65
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706396; cv=none; b=FfqmMZ9OWX5Sbb4cuyixos6HpBlWB7OmD7sCmngvqVgxBrinRYpDb6Atwwx5VwnaiyG94uXBi+R7RqDLYgSESBOiKMRD3hkU5/jXVIMrn55L7DJ9DwuQYdZrP5ilY1PQzbloO0uwUzIHoCYnA5vMwK3X1ztahPxH4pMcdabxLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706396; c=relaxed/simple;
	bh=UWd6hxmzjst2tmlJYuu/wEkr38i7qrWlsq1SqRUtK1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJyHi6g5rq7OGLH5YKDLw7Gxhn4Ba6JtsiHE1++PMyEOe1MvsoAihfKdb5miNVluENweCv8wRZU4oyRnFs36tBReAYVlZziqYyHGz53IC6xJum2FHk8FDldfMWsYMTNKv5VcFWoQoePrSAUS7ZUcb56fYUKLzUQ01FfFwA0dS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMZn55e9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e11cd97960so2314613a34.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706706394; x=1707311194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pT4FU5pRnshAjRYitOLrEWUECqNIReMX/bO9hZqR15Y=;
        b=pMZn55e96zZ1erZT3/BBvYNh0Z/gkSO+OljHIj2HEiW91G7jXNfPCYZk/+2Nb1VhwL
         /I9WSm6KezPm2kd2Jm8weXyRqNqSYSUMvKapbQAXfp6t5DmXpoIZSnFpuTPRxBuQy02b
         TgPeLh1w92sLvvCKqom+eUbT/JPffWQ60KMxC2O+kteuE44ddxG7KmAIpsxEFI1x1q6f
         V3pCGIbvOjsjL6NQjP4tlek1wOu8fu6TmnQ1FUn0ifJgovYGClqX6+tKzJggDGt8eoIS
         fN/IKbtM+VFbC8iReEUmeMYRGDJaAaG1JixeDGnX4zXmqfSMlPodhPf/SopHuY90NmuT
         3ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706394; x=1707311194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pT4FU5pRnshAjRYitOLrEWUECqNIReMX/bO9hZqR15Y=;
        b=M8G8jXeNER27KReWmrRVheSPbOl+fpA8BAyZ2fTK73E56whQ8PbU++5ikUwHY3Md4T
         A7kqxSLX9y2WbFQ4VBOk/gh8FF8n6MSrRSRK1qxubGmYHd9B1hQh9kuA202pS08xXAIZ
         darMuuMsYoN2gJSsau8k5odblVyZW5GyNr8k0wF6yERSBxkXyvL3f1HatGszwTnpKoSa
         JcuKXdLJXMJXwUef5SMlz92HYSkYpsBN3j6yy4HF/s3uBhSQ54CyiWEE5TIsbQsr78YQ
         iNrbjoyLM5lHsbULgnxMP0rmU5/PsDC0E7FGmA9WSzV9owHnlz+t3y9pu6BGYtc6G3DM
         aiEg==
X-Gm-Message-State: AOJu0YwQ0T7UnQKPQtsLRRrmvxkbsvfoYu7LPeRLue7SatFInezetJDe
	HNPNZKV6AS4ajUPDKcJunlmpOlsqQr9BS1RM0AK7fRxrr2jNaBbLObCGlzsG5w==
X-Google-Smtp-Source: AGHT+IHEvuTXeoIZkbi5Q32g6UFdTGDY2fx6KtFvOEjO6m0fOI9Fr33QQfHBO13SONWpgqrwaivohw==
X-Received: by 2002:a9d:4e95:0:b0:6e1:3d4b:4b27 with SMTP id v21-20020a9d4e95000000b006e13d4b4b27mr1417284otk.27.1706706394166;
        Wed, 31 Jan 2024 05:06:34 -0800 (PST)
Received: from thinkpad ([117.248.7.45])
        by smtp.gmail.com with ESMTPSA id lh10-20020a05621454ca00b0068c5eb56dc9sm1705667qvb.63.2024.01.31.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:06:33 -0800 (PST)
Date: Wed, 31 Jan 2024 18:36:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240131130628.GB5273@thinkpad>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
 <20240130195501.GA562748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130195501.GA562748@bhelgaas>

On Tue, Jan 30, 2024 at 01:55:01PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> > The PCI endpoint subsystem is evolving at a rate I
> > cannot keep up with, therefore I am standing down as
> > a maintainer handing over to Manivannan (currently
> > reviewer for this code) and Krzysztof who are doing
> > an excellent job on the matter - they don't need my
> > help any longer.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Krzysztof Wilczyński <kw@linux.com>
> 
> Happy to merge this, and would be good to include your ack, Mani.
> Would hate to sign you up for more work unless you're expecting it :)
> 

It's my pleasure :) Thanks, Bjorn!

- Mani

> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d1052fa6a69..a40cfcd1c65e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> >  F:	drivers/pci/controller/pcie-xilinx-cpm.c
> >  
> >  PCI ENDPOINT SUBSYSTEM
> > -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  M:	Krzysztof Wilczyński <kw@linux.com>
> > -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Supported
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

