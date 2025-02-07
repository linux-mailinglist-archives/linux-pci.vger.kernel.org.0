Return-Path: <linux-pci+bounces-20927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E31A2CAC4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512F8188C403
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABE19C540;
	Fri,  7 Feb 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbGZQXtf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75119A28D
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951520; cv=none; b=lqM5u/9AygasGncvmy2crSrLfPO3G3qZn37Erb/zExA1VjG1KRdAFfezyYWSJ979s1unCr8UsYioKMkHZjv8QB8DItlgJ7BF8sXZhgught1kHrUBpIRV+jVDi2y2OxrpfYhzhg2iY925jy/3CcMcE3D29nrWzL7scVgOMtQMIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951520; c=relaxed/simple;
	bh=IeAPkzhHc/L0Iy7jEMMKyG3h/siJHYkp/dzedVL+z9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw5A/65UZJnCACjkSrDzIWh+fuorM21rJi9pzzrIJ5vGF7wWnTRoBWvXc/iL5QbNYyHtLmlAUCHgOjEmDf3I4j37UuILNna4G2JJYFlP6zAN72j10ISDbnKgLnWgP+q/OqG1BU/N4/x8J8jDW99HH6mcXGNyUL6niVYUdJ59QSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbGZQXtf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f40f2bafdso27919445ad.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738951518; x=1739556318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r5ibt7KhatAWebsrlF5nwEe9WU/2iIlScMhSwjCoI5Q=;
        b=gbGZQXtfOh7rgkxcaire9i4Ae3ufA/92cLrYZFs2jZXpfz1UZnx/88WL1yGUHknWWQ
         cadKiGgxoYz/HV1TexYQelFG4X1AYwVp07uyz7dRGIMpzJJfJGYKiCYiOS3KN3/YCiay
         KAMpB+7YL7h7oTrWt4iRl04CnUjFWHpMsttiVucbG5ALHf+tKdBGzii9sBDdn5iKQqJM
         Vhe2HWC+XjXZDyLZ6yh0qMBdrwOQZsuBfzaC6l7saZ0QUBp5UtP5B4KNzCbrE6a/+Hoo
         zHzF37PboP2QFlnwWmB6BjIAo3h9chAv/OGlYL7rtDTxG+wOwAMTSnKP/pA8e1/BLyep
         U3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951518; x=1739556318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5ibt7KhatAWebsrlF5nwEe9WU/2iIlScMhSwjCoI5Q=;
        b=rTq2o1QnZvQIZHJQu2MhtH6zccyC8xytbR4ON4cIDyGJ0UW/qr+bgVH5+DHyU3TQfl
         M0BqJhtYAzqp+wkge2UsxYOZzfDqaNEueI3lGmFGTkTIyXv0FgQQv05gC6y2yYCovfLk
         Wr2opQytHDctFletH/1ZQ+jeBH7y2vdfDQ2wo2Ech8iYLTu4CUU/ddi1W9Do4Sq0rjDu
         r83ZS5GX75yiBt1+3PUn96oLxhwRKN/bfNADNAB5apRzdUsuDxzRLNrru6QGHf04Bu0V
         0u0KmStfYg4Rh6cFzMoszkXLhgMUtyE0dCyjLVYEm2pfa6jsSCpkb74bjw1d+PAcqAS7
         wdSA==
X-Forwarded-Encrypted: i=1; AJvYcCXDZwMyMd4XbWmDG3JGTe1UWetl1+uXG4fU/PBc8ZZOxrAkSzJgFUTAeS8xr6Ov2WXtfsZFNRSSwXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaD/wd0X9hfKzMHhl/3qhDMNqKJERJmaPC90CeyOgBIYrHEDba
	zKaIzD6kTorJ6/bgBlGjYEaYhhcRLijF3uhqYngrjnOG8CRlxKl1/kYh1PLC9g==
X-Gm-Gg: ASbGncsJCM/YBFBuePvhC1Xv4YskBwQwWQehO5bOlAW4FFjUr7gTRx8PCOvAwuvabu3
	a0gLEznbdZRIaB2nVvt20dyKpK8PLqfm/zWSgam15+V3pZPFTqi0ll8DBSBhKdQCljEIE2XW80H
	36r+UpaAsX2GHnf3PkFh6yUYZDZlgFChICYzAWzi3aJwQe0QEkVyRKdn3RjKZqfsvtPWAg6xDCn
	zQXHaypChYTCvfkB+SX46r7R08N78TpRkIC3ayzQzOPGT3JIuMjD/70fXSymngObU+vbrn5OPAc
	kVQSzgEOvAJEc2GUPSsvJMH8Sw==
X-Google-Smtp-Source: AGHT+IFC/JEZsJn/f9ED5rECVV6R5p1b6UQ63eJt533veDtlUzOF4st98yzlh4fW//CaFLgzvV0phg==
X-Received: by 2002:a05:6a00:c87:b0:72d:a208:d366 with SMTP id d2e1a72fcca58-7305d508bebmr8463194b3a.20.1738951518035;
        Fri, 07 Feb 2025 10:05:18 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162b4sm3260019b3a.124.2025.02.07.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:05:17 -0800 (PST)
Date: Fri, 7 Feb 2025 23:35:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Fix
 pci_endpoint_test_bars_read_bar() error handling
Message-ID: <20250207180513.afc4fm75wlnipwgy@thinkpad>
References: <20250204110640.570823-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204110640.570823-2-cassel@kernel.org>

On Tue, Feb 04, 2025 at 12:06:41PM +0100, Niklas Cassel wrote:
> Commit f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
> changed the return value of pci_endpoint_test_bars_read_bar() from false
> to -EINVAL on error, however, it failed to update the error handling.
> 
> Fixes: f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes since v1:
> -Changed the type of the variable ret to int to match the new return type.
> 
>  drivers/misc/pci_endpoint_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..7584d1876859 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -382,7 +382,7 @@ static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  {
>  	enum pci_barno bar;
> -	bool ret;
> +	int ret;
>  
>  	/* Write all BARs in order (without reading). */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> @@ -398,7 +398,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		if (test->bar[bar]) {
>  			ret = pci_endpoint_test_bars_read_bar(test, bar);
> -			if (!ret)
> +			if (ret)
>  				return ret;
>  		}
>  	}
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

