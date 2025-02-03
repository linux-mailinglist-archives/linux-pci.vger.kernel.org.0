Return-Path: <linux-pci+bounces-20669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE15A2608B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843997A2768
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384D20B21E;
	Mon,  3 Feb 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdVwDtVy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246042063CC
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601367; cv=none; b=c4wQu8TRg8qSomT01e6t3BHPqX1RRXrqqQFje5bZekPxQY33cgkLOrmMXrQrhmI5YRZBmsGsNssxl5vUZCKesseVdd1BgdX5GAYE+ALGXIZA5rx9dxH3zzBteSd00crg8iVgtMh37zUIjj4gs+DTfftTttCknXllB1pDaQ1L62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601367; c=relaxed/simple;
	bh=+UyR62zTgCr1lGwsuyjbDBvoQJqiSJUA2EWl/uEDU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV6wVLIra8w39w9l0Fd630RO5jinh8d7kQPIzvXW9MKL/bvds8kyHw/Y4ehSWsZnbES4IdaUrJ+3+6Slq6kHfmL91m4KGAAYizOJWNoP66JdmQMcdmIgrSNkjGd0HwHhYYp2z5sa7wUtUlA7mg+YdAHfc/XjoFZcP+39Fh8a+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdVwDtVy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb95317so79587125ad.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601365; x=1739206165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xddVJAtP16YTUeYljd46EP8hHDLsfmX6IxpdykZZ3ws=;
        b=hdVwDtVy+mopd6CSzSaA7ieBaDawSATD7GDdz6QLXHWs0cMTL8Ez3EFgxPRgGW8SqW
         +WnoEK5Aelf0J0+pHZgcOjZoDqOFvoyPci5YFSvTvdKQMmaMDMLJipnvhuln1CPU8Ifi
         MYY9B9G06EFixjmi7weQ0oxj0fjUFOnLTTacY71N8kzjjzP3f2P8g8RUB4j9tjHz5jxZ
         /2hZXyRTjO4bl1lDDRPMYGx3ukRl1B2gHpZ6de8PylLnmsRomksHKNmC5UMnVuTzckft
         WzFets3MDihIRL+udQYneFsjPnSDTpWUeSU2AWmDwU4Wa7aTdWS4reaO7NDomgQvflDd
         Aqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601365; x=1739206165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xddVJAtP16YTUeYljd46EP8hHDLsfmX6IxpdykZZ3ws=;
        b=AK2psYp+dzWU5B8Ev4OxdVkuzMCGYfh6Bzv3jqk0UeCPUBjToC8UWzAB8iP07tyCdv
         00afNGdEjo1XcmUNCR6mD93e+uD2R2qADt5flABAJ0aLdTZk4bmmkhfomDav68wI6B3p
         mLeqJ05FVIbUmIt7o5RHwS54ZhkLnZSaaKNq0r5Tm1yHj4FH8SXzMeHuKmF0pcO+TkHD
         LfRGNTN6eqWLSUQllKHi+oBBG6tby6gmUMPuOgX3PiRFSiKzLS/D5GHVhzqlX1CPIg94
         1dtVpnyo2T6gXt9KBsl5UU/GCmOLF/2LkjVdVOjyTLUxustar1EuCN7q1/5GIySv/+vK
         oH/w==
X-Forwarded-Encrypted: i=1; AJvYcCX30p9hWYnw5P0INpYqyWkVSS+koRn9dW14xru2qnrEuuHvkk6vv0qkSgF4TlbNf/3ckiTh1Qi0tgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAIeqfXpB8mChLgJPX/OTWjVkl3Bfh+/eZvgE/v9w48o/QNaK
	MAvW+HrFTbE+jMRHvJ2HwkYijKBgTU7TTwj094Ag+hh6ciVaqDoIk+BLkdSvRA==
X-Gm-Gg: ASbGncsAzw/K7I2Y+zPiDh+6eaY0dFGg2hFksKEVBEkfKTvJxmf5wIAonJppg7xNYrg
	LQtni3gDviHEb6tWKMnwFIRaoIA6F48xvf1RIUmZQ2ecQNkqlldHBLWUZyZMhVpHQHTDwYcuEXq
	mUnDxZJvxXkfi64uLrS/Ds1p3BhZ7dq+TjKZvqLwQqcNILyWNOC9FA1CTyjkR8o7WZTPmBR9x63
	5gMaDyXxiRSQpzO/DZHvijBRmOPLa8PN80fFuzmfp1m4l2MUGEGq38XUoOqQ8NbHH/q3WSZglBF
	x/rQd2pwqPleBiKCYJFogsSNAg==
X-Google-Smtp-Source: AGHT+IF2HYH7tkkxi/7uRTkKqdlCtvWmxGsmA8l7XQB4XkL8zo4HNy1c2T8FM6N7NBKlOO2+px++7A==
X-Received: by 2002:a17:902:ced0:b0:216:5448:22a4 with SMTP id d9443c01a7336-21dd7c56007mr398076005ad.10.1738601365325;
        Mon, 03 Feb 2025 08:49:25 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331fabdsm78765805ad.221.2025.02.03.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:49:24 -0800 (PST)
Date: Mon, 3 Feb 2025 22:19:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: pci_endpoint: Skip disabled BARs
Message-ID: <20250203164921.elqigp5cuqz4dg3p@thinkpad>
References: <20250123120147.3603409-3-cassel@kernel.org>
 <20250123120147.3603409-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123120147.3603409-4-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:49PM +0100, Niklas Cassel wrote:
> Currently BARs that have been disabled by the endpoint controller driver
> will result in a test FAIL.
> 
> Returning FAIL for a BAR that is disabled seems overly pessimistic.
> 
> There are EPC that disables one or more BARs intentionally.
> 
> One reason for this is that there are certain EPCs that are hardwired to
> expose internal PCIe controller registers over a certain BAR, so the EPC
> driver disables such a BAR, such that the host will not overwrite random
> registers during testing.
> 
> Such a BAR will be disabled by the EPC driver's init function, and the
> BAR will be marked as BAR_RESERVED, such that it will be unavailable to
> endpoint function drivers.
> 
> Let's return FAIL only for BARs that are actually enabled and failed the
> test, and let's return skip for BARs that are not even enabled.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I was thinking about doing something similar since some of the BAR tests are
failing on my Qcom setup. And you beat me to it :)

- Mani

> ---
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c267b822c108..576c590b277b 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -65,6 +65,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
>  	int ret;
>  
>  	pci_ep_ioctl(PCITEST_BAR, variant->barno);
> +	if (ret == -ENODATA)
> +		SKIP(return, "BAR is disabled");
>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>  
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

