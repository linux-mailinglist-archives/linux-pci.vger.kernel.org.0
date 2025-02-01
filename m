Return-Path: <linux-pci+bounces-20623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69371A24A18
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC896164978
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D1374EA;
	Sat,  1 Feb 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vis1zqnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C32F56
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738425721; cv=none; b=Z0ua3zNT333j5Mx+ChxBnTyFKrRaIXrge4LS+VHEnIUlwvrKJNlxyw3wUcV6ZB0gHrFZREAGt/+NiOllajXzxHYDJWvjT1hqY9QFejkG46gin/i1H+Y8XozgfysKyZ+x6WMRnsS3NJzcidprIFm8qbHuXlDEvA4viNNtaLqMsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738425721; c=relaxed/simple;
	bh=8/5/k4fgbcBn4rcIaQPrhaiIAFikiXWp+u3KGzNKIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvKVMVGrB98kmrHQw2yWVS3XqvobkJ73twVJHLRvNsagU2Y11Bbf3Vx2LjBwlMI0YKlteBukEzOVdEUIs8RP0DWqNIw7nZLh3RgipgC+vZVJXoU2ltC1jihKSl9c5UxunxV53rXcKjcQdTVmdbC3WT786/ZWt99yGLY0LuY2cEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vis1zqnp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so3978700a91.2
        for <linux-pci@vger.kernel.org>; Sat, 01 Feb 2025 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738425719; x=1739030519; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAT5jbH2Nsu+SR1wKRhxhJRaEZ3K6oGY9UDf81Cf1no=;
        b=vis1zqnp+W03MfjYHeR/VNLNwBVgPIv5EN5Ek/nWyjRi3YqXaZDJrMWH8z+jKNSf+j
         QIP9rEQQ+IO6PZjkNv+Lyfn00NF6ijMhZHI44ZB/0rHsrRsGPAciEGxeAoPcZk6oW5vh
         uMVSa1cJ0UyInoApSU0CGn+ahhQ5YTI3iC1tj8/3FJZ29xKsTuD1ZkIkQv8KFNNaFypK
         ZgtH3yz1ch+CzuKfSfvwqTyurZZn0R0/YlCeCDkwjDMIcCsC3NICHO6WmTq+z2AW91Wr
         uF29zJ6XgBdXutRdDpB+xn9c+F61B5upx1X+27CJAgito9HV4OYpit5GA8ciCiJNdvy/
         +e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738425719; x=1739030519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAT5jbH2Nsu+SR1wKRhxhJRaEZ3K6oGY9UDf81Cf1no=;
        b=YJhIRXx3vLyQ/A6qygY0ID9tBqE5gV9P3h9d4T7zwQzDK3ysQXjQb4Elh3cvs8Xi2D
         jf0WBhh0azBEvWECbB8Bp3RGXrnLy4w5jeV/3mu9suss3J/ikm1eXoBOc7/1mTixW/1y
         XenC4SYOd5dZvRmGMbpQW2++4ykJTnFdcbuCLypODO9rkD7+6TTutSrJ9tATRNOjcRir
         mhE19y7yCebab1rlDI6k+mYr/48uv34wY7Pj7Ii2XkLbt1rBYFrhWyWAPGnk7nGwVPU2
         RpEn1sshx78BW7k1TPMFrq+tIytMvgOFvGwLhc2LhkI/4Y84SGJS/NCZMpd2GvYBI+FF
         024A==
X-Forwarded-Encrypted: i=1; AJvYcCWMfAvy1WfnR9cR0OeahH6gUu6Q44sZT+VarMA2aJjMSdTvu4TuvXOcn5XcGB+9R/mlhnNQuICHD3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0sq2kkHvsDQ5f9VhmjwgqgN63ObPelgdKTym5ClLk0PgVJr4
	rlBfqFFzMQj9QPtvKFvtjXMbojShYHGKFZ3qErq6CeQkbEyzoG6+5GmQaCERXQ==
X-Gm-Gg: ASbGncvAx5Uirl+3qjGPjc+0JGTlz86DMdGNaqDL4RMLH2LbfGLwiSV0xo2XeRIfCYn
	ZCIlPuxYI/2qqWpHRInV+q0NGdAAEvUJHN05/Yafzxz2fPJkOBfF8C4wExFb6Wkice53EjC/h94
	8R0oYrP6uY/mqBR3IK+CzKEAezZDwTCixczBy9jD39hY8ayZ8qWR+GGk2JJ/1rfWYUUjncbS8Qq
	8xSrR0t4vCWwFoMPg8/TmExWKf3IHwBa3lc10qyA6FZNHEGww6ui2uC6/w+RXdp88R9o96le/qs
	ynn9NOSw8wnm4bEHTXStWYaSecE=
X-Google-Smtp-Source: AGHT+IGS29a+wHppu2mTxig9bcfT7RnOrLu5b5VrvuB2DSesTeY2a9p+zLLq8+/KIQJWWrvfExS5eg==
X-Received: by 2002:a17:90b:51c2:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2f83abda30bmr24528450a91.10.1738425719348;
        Sat, 01 Feb 2025 08:01:59 -0800 (PST)
Received: from thinkpad ([120.56.202.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfbe630sm8750691a91.41.2025.02.01.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:01:58 -0800 (PST)
Date: Sat, 1 Feb 2025 21:31:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <20250201160154.ih7qhpj2ovjtowcu@thinkpad>
References: <20250124093300.3629624-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124093300.3629624-2-cassel@kernel.org>

On Fri, Jan 24, 2025 at 10:33:01AM +0100, Niklas Cassel wrote:
> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> is e.g. 8 GB.
> 
> The return value of the pci_resource_len() macro can be larger than that
> of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> the bar_size of the integer type will overflow.
> 
> Change bar_size from integer to resource_size_t to prevent integer
> overflow for large BAR sizes with 32-bit compilers.
> 
> In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> have needed to use a function like div_u64() or similar. Instead, change
> the code to use addition instead of division. This avoids the need for
> div_u64() or similar, while also simplifying the code.
> 

Fixes tag?

> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> Changes since v1:
> -Add reason for why division was changed to addition in commit log.

You removed the history of this patch that was present in v1. Since there is
no link to v1, you could've kept it here for the sake of completeness.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

