Return-Path: <linux-pci+bounces-21510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D194A364DD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D784F7A17A8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA02245030;
	Fri, 14 Feb 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJAFu0S2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C405267AEB
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554917; cv=none; b=SWJ7CRzWPNzenELWlQyBcxZfFcySsKUpIPpemBEm+UPDxxQphp4p5f/ClR94tWwMtCUr6wAgCZWCJ+yc4b2yuTueijBTxX6HnEaDD3NfAMgU2VqG8lqFfDc2MHUEkOMIfl57JHBRr9+D9X1G/XH/LwkacQzUxIMuVIx/ijqvB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554917; c=relaxed/simple;
	bh=2xFzOiWi8H/SUD17Zxt9CWOLnx8AjU/UsWzBkbGvrOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQtgiGVZZy83W/PydJ/JsEmUiknn7kDg8qAjtUJx/Pb8qj/jP/JyTXb/H/2Ieu4W/YUl2YSE6L3WiYSgvWJi9ksMzTucCGc7CA88scA7ThG+pV7T4DM9+lV4jTfSg7rpShawpsqVZY5WktlX6l+zr2R5zwUkS+tHwN6afWVKB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJAFu0S2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8f38febso44073965ad.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554915; x=1740159715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sV785Cyzy270ygh3KqBoGqdrcTx+12Day/lO+hTY5rc=;
        b=nJAFu0S2nnT1DjvJ1MyMsbqCpG8fwRe7fV8PiYKOf1XPsTIaQ+LnmEcnQDW3CQ6L6z
         R5BGB9NrQtLWtGUI3WvL9ynIEUnfDkSlYHN03zstP8HaSpruj0ntUIlAFTCi9bi4H6Rc
         aUI1RxYx1zb8t8jkQ9vMwrbM2dN8l4YYCeM1bVuHEtMN2JD2MYF58OlEf3Si0/u8uUWg
         W+kdfMLoLjxj2eyL2SGJUopLgB1Lrm5nxZJR123Puhyy+c4dEHEPDPMFRX1UzhMHOzOL
         Ovi7WnW6axnsT9jtw2sUikqzc1o/UuAx2Cj2sNRTY2fG6jflIhwR1S60kcgqCgGbMKTm
         3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554915; x=1740159715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV785Cyzy270ygh3KqBoGqdrcTx+12Day/lO+hTY5rc=;
        b=GXCyZWcxoXOlvUipYPzhi6xS1mCls5UFSVQcDdsydn1ZOs4cDlF8ukZAPxMdA6VDes
         FwMk8aKIN5qrTnljW/DBcK9899MHpj85D2fl+6QVE7o9np+MFjug5C9/hRzzgLK+PEqT
         UR8jT92Em+RMMpKPu1yJrd7b30VpSTd3X0ZZf2/I5nIC2vyliDy2U90LHeBjvPIos3eF
         owDzHbknk7cflMGaaI8G4upLRMmh4CCbA3M6KwRMQuplwNw+SI5Yq4uOixPlV98RHTRo
         vIz+s4oKqULn3uHB6rOAama4Ausel7f79cG5939jnK42RSvopgkloeJJvi6yPOgp8NyZ
         hByA==
X-Forwarded-Encrypted: i=1; AJvYcCVv/uWX8cP4fV39hWI59LR9nkDq/+ktTPXYw8gBfRHB95da85KtHKpt3/rw1zMi22ylsDLw/BZNx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2H8MLzmtsEmbAipm6eRurR68rBck0ZJKevYDv4rlX5avwp3WS
	oV56RMeyYTi4YgOvE0mzOxsuRWbVGYPhAfkAFyZ5mEHky6q1URk+3cLtCpQ7lg==
X-Gm-Gg: ASbGncvcyd/WhofLj59w1uVc3Jxqyv5Lu6QwzAcH3XcUsX3VYYSe9FF6O3wfvFtoaxN
	2Kkn7bpGKZAi0lEFcdKkAbjDKJDm9zaPO0sh6Z6hgLMcMIxk/wtWXh4Phje4h+fHtIoCt3vZf0W
	jSoQGSuKfDHsf29X4VagHTWNQrLiSifuvIfZxgaA9Mpm1+qTKWtGPVzmbctG8yZSg+t8CsPL3pC
	ycLTliGnrGl9fpS46v2Htl9Ea+F+B0xAP/PlpXceZ+KKFJyiZ1mkNl6mawcCxIqZ2rs9W/Uwqro
	T4rBLr7b2HeQFG9kmi+YIUj+taE=
X-Google-Smtp-Source: AGHT+IGdSxRofGb5vUG6rz1SyK+te+omozMDKgMaJdwlsRPS3AlmZb6BiEwuk60WpS9KflvMnR3cfA==
X-Received: by 2002:a05:6a21:1519:b0:1e1:f40d:9783 with SMTP id adf61e73a8af0-1ee8cc259a4mr505686637.40.1739554914817;
        Fri, 14 Feb 2025 09:41:54 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324277f274sm3375571b3a.160.2025.02.14.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:41:54 -0800 (PST)
Date: Fri, 14 Feb 2025 23:11:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Fix
 pci_endpoint_test_bars_read_bar() error handling
Message-ID: <20250214174151.67cbdb4xyg5tyult@thinkpad>
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

Applied to pci/endpoint!

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

