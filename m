Return-Path: <linux-pci+bounces-21513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D21A364EB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0719B3A79D8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD549268C5D;
	Fri, 14 Feb 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDuCv44Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471B266597
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555111; cv=none; b=prCUT5SwYvd0UlJGmCBUMzcuuRpv9tbGbGFN+AH+nuIVRRsi+De50f5LRxj3vKzt/EiJqRGGV/ZyyzC3J3TreBxiaqBF5NkK2++KffWYmGaVTg7ntqEvbb+8Z+KpaIjaIXZwWO2IKqx5XuDWXyZMSD/w/BFgfPCNricUDSjA2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555111; c=relaxed/simple;
	bh=ybmFuF9ibx8fsXQXA1od1ZQ512hbYjs8egXp1ixsiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQFFU9cqXb1WvnkT+DlW5s78ZTfb6dqx5IDukaVcDBeJ5qfhP2fj7y25e/NPUF1bjrSLwddD9KPksitMIG9OXdMy/Zif+Dgtp4tEd2nKMgx1boqtl1oSIZdwnj00Wy5XTTPUsC9t2lyHE1QPR7q2dt1hs2IcOa6pLTcXxXsaauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VDuCv44Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f5660c2fdso48886005ad.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739555109; x=1740159909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mJWLq0PJ55ynNZW1CqmDU64iYck9U3dQjbL7H23J8o=;
        b=VDuCv44ZA0jDklNf/WlzOgVRgSDMMJqdxq9g2SSzncn6IKMbKnU4fWOAGmh5L4WMY3
         3sqsOypS+nd9DU/8Og2a3p49+v20xk2BlJmqnv7JYFDr1zT8+ZsG7urnF2fv5SMs2HKg
         5jvkqjMhKNHIgDLld68/OatgSUdo6RcEgpPG/Fifo00pDbmIwvy6u5I33TVYQM6n/YHs
         Mj3JQw0Qxefp7nA6W/gXjpGT6cGqGeci1CVVQhDafJava34V1oVymviZs+hBq0vsgTEJ
         qZ/CJncYVsxWWZ8aAH0XdFaQY96scm+V2hEVxl59HncnvJ+9c13h0VVjP19mNrhj/Da/
         fssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555109; x=1740159909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mJWLq0PJ55ynNZW1CqmDU64iYck9U3dQjbL7H23J8o=;
        b=BZTCdqsbxsc0Si8kl6aNLpUsE5n8Z+4R0jriLm6xiA7DwlmLHT2eIyzgkmAFjUE8mA
         yLrhxC+1YPBpGxuKaxQ2w/OZ4CpmHHm9eIpeNbQkooK6oXpiF3ahrZcO44eawhEFa+oT
         tc2rmtiyW63awIFBop+jgxWANAIF12jtP4Xe8CPEDn6wg861Xq19V8IwOWA482u7YOLo
         vFJAPJo6SwAoWP86UQmMBbrrRoq29ABPBUnwx8OqvZ7uhtLzkVElUnkA+FFztM6UmI9Z
         /Al4XnbOyh4zCSPZknfXn0ViKeppgRphrUa4iUtiC0cjdmBVz9tkDC8bE8ZdZiBs9w9B
         nA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOQlX+QxCe1mcwZg6RVt5f2eHehiZVTw+UQmMhLaJUyxHdm2BJqs/iYmHW0cP4UYsH3kbZKHrBMAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkaV3PqaVy5iEA+LrHuwMrPhkklLDmlcLXG9jc9jYLXnodFya
	UBqt17CEvZDrK4aSZAJpNtd6VlDmmKEbGASl68x9Okpl3eYEv2CtiN1F4LhwEw==
X-Gm-Gg: ASbGncv8ivIXl3WFiJilkrS6LFsyS3CZRA5/F5GpQE4UnosE5f2LtTler6mUJphGZG3
	t8nJmsm51pmMeIl9JPA7DDRH2yO8eVaBrEsckjNvlWmElJsvyfEa2AT6+dNbe6DKcfOpjPqSXI7
	7pyS4qfm/E4+Kbd0NakTkOefFibmDhBuRA43QGgwtc2mUQKuoWEawY1C59S0DBQILPoGmk0bMqr
	Vsom5HlySNJ0Vo+RD/FvXHGXWLSG/qNid+UMwJB34kzn/jPOMv9LuqGaGZXLH4euuaS5hlZB/60
	XSjB+IZNdn/d3vaRQsaA8iIYXjo=
X-Google-Smtp-Source: AGHT+IErjq3v7C8zZFbR9QpBV8b3Rae4Pp44QaWUlDQobtQDaZ0FJlpuEU0JZbEjGpy5/bpbsPDRFg==
X-Received: by 2002:a05:6a00:2e28:b0:732:5a8f:f51b with SMTP id d2e1a72fcca58-7326179ebd4mr449479b3a.8.1739555109254;
        Fri, 14 Feb 2025 09:45:09 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256aa6asm3514115b3a.60.2025.02.14.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:45:08 -0800 (PST)
Date: Fri, 14 Feb 2025 23:15:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: pci_endpoint: Skip disabled BARs
Message-ID: <20250214174505.5bo473evkpovjtyt@thinkpad>
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

Applied to pci/endpoint!

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

