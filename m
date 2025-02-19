Return-Path: <linux-pci+bounces-21813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A5A3C622
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A771899CF9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633022144C9;
	Wed, 19 Feb 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0yPSBsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCD21423C
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985966; cv=none; b=a7ID5utY2jI2camgjeAZqqcAGSgN3gqU4p84SjV9eKNLSj2QifeDL693ntpa2aKzSnAUBNxr8/mUD2Q8Y0uqJrp8joq0zR6CKxuVgC6ASlIyX70WMVPH9jIICT1C1zEAWbvfKxf66cM3Ov8aRfT5X782nQZLjyJKO5BiXcVjctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985966; c=relaxed/simple;
	bh=ulOsjEOfVm8YkMLH+aXxDRnk6Xt768RpVXoZH1BNI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7yFP9iZEu/ClWJKL//cIl0Rio3eXJ86PLwRtzPTR7kJeHTd7RaIbSTIW5dPZYf7MomAvyKlTJ7tEwp5tDFViNNX0PIrSNgxuHX8PMTtjr3VEV0sUqbY51qOeKopiW8cNPyKOCMd7y7M2/YFnjHJ4Kt3QW4n0NkcWrx+rLwxvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0yPSBsc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220dc3831e3so18729895ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739985964; x=1740590764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ItX7zE9hMj849T9BPOJKf5S+2mXSEwH+VlCgkwRIGtU=;
        b=D0yPSBscw9uhAasSiI4IOhkH3r80S3uBePbu/reZ7a2PgF/j83ezaOGJjJFNE+VD0Y
         cffuO5NXRSn8AuCKAK2EKw0sf2B30oDNHuyGeCs+K16T5PAAiVORRc/Kl2fb7P+Gki5g
         0Xz/3i204ZuyRgnqdok25jraVWhuo3+9T+/ETIOEIOhfUCkK5jle5j19/lAV61GqfPCj
         ZxUYk56CswFhNqVJqaENBIRaTHX0djJwQEI07YmxJ7ktdBbehiR8PvyBpwKTtsRycuCO
         dIIEoMWOP4UvbGl9h5oboI3dWoJW9QqanjX4hKgG/XjYdDENx9v80fM48QLNm+IIf+zV
         AtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985964; x=1740590764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItX7zE9hMj849T9BPOJKf5S+2mXSEwH+VlCgkwRIGtU=;
        b=cCZ6dIQ7+yOfLSgLmVjQd6aiKICbXPpRIA+0F+MFpSOtAUUcjxT/QY1HV+7R9c4slU
         J0eJqHyLYqsCZcoi4it4py8vitOUzVRVfRJQwN5pVsfKbe33OBZc4s+gGzPRARXR0YhB
         azyru/vC184GKu0dUb9tgpNyXJoFXyj4ldanu8QPvw9vKnMg5WENGi43VNGoURLrwdwf
         nMPEOdkeP2SwnhuPapcls/YYeIEsRB56b5Lbdwi6iW41onHdfQEqX4bqCiAgV67hHA3+
         lR1SIC9vpmlLVSFLIt4mcOo4OzY3goY3AoZ9H0c6XZKM45/Px9VNVbmSWPvh4ywFj4BH
         tdOA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Sfp3ee1AVy1t98QND6oexcYk0VDxT37Auf2ku4rQ4feAsR5PCwY9qfwkOcYJh+QrmCsNyJPFXwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uguU9uuAgtuXf56MT4rsFxE5Rw76n91ukci4KPZHYc7TMCYA
	DqoAmavsOFyeH7zcY/KYbVDqfuEZRaerBb5cxGTDun7SsRBbIQDOc/JOk+ogqQ==
X-Gm-Gg: ASbGncsycRKceICZY9t0hGDa/UliTpWT5I2O1QnEl8LffD0jGnk0qrxXQCVse3iSTp5
	Qx2Mzry690EQJEB8HQJFNZFjJGE7J6t6MMChJwYTEZxHw/NKrjhhe+oj61U55+V+YIpX2L82dpO
	1z38n/9GQIAEh0HEgdsxIGZ1SjXNBaGQ76hN52j1LpOykdNjjGt46tF51cAsoheqNs6JfCpRmB3
	JWIa45/z7OlT+bxY8e7/Jn7hgEIU1sozZpvFmrHE1BfoVJKMgA7kk5SQhSgJnLOOtRsUt9AltGD
	vnbyujCrGuN6ulAmnz+gziFNtA==
X-Google-Smtp-Source: AGHT+IE4UXkGgMlA8o3pjxI8CheC3QL6wLEUYm3amez3YjAzstYSiKsyvNFX+xWyygB44r6MV7FC6g==
X-Received: by 2002:a05:6a00:2e9b:b0:730:949d:2d52 with SMTP id d2e1a72fcca58-7341407d288mr90410b3a.3.1739985963877;
        Wed, 19 Feb 2025 09:26:03 -0800 (PST)
Received: from thinkpad ([120.60.141.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73252051ca0sm10328602b3a.111.2025.02.19.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:26:03 -0800 (PST)
Date: Wed, 19 Feb 2025 22:55:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Improve reference in
 pci_epc_bar_size_to_rebar_cap() comment
Message-ID: <20250219172559.u5cffxqioulwkv5o@thinkpad>
References: <20250219171454.2903059-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219171454.2903059-2-cassel@kernel.org>

On Wed, Feb 19, 2025 at 06:14:55PM +0100, Niklas Cassel wrote:
> Improve the reference pci_epc_bar_size_to_rebar_cap() comment to include
> a specific PCIe spec version, and a specific section in that PCIe spec.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Feel free to squash with original commit.

Done, thanks!

- Mani

> 
>  drivers/pci/endpoint/pci-epc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5d6aef956b13..88cb426d3aec 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -649,7 +649,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
>  int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
>  {
>  	/*
> -	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> +	 * As per PCIe r6.0, sec 7.8.6.2, min size for a resizable BAR is 1 MB,
>  	 * thus disallow a requested BAR size smaller than 1 MB.
>  	 * Disallow a requested BAR size larger than 128 TB.
>  	 */
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

