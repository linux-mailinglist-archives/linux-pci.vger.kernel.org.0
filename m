Return-Path: <linux-pci+bounces-18110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EED9EC930
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7A1285E2F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB21A83E9;
	Wed, 11 Dec 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haC/g3zt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B8236F8B
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909695; cv=none; b=Aws2ZjtIrXsaTn/N5Er54rKTNonR8+O8ttv6qf1nDteX8hNGyg8LSvUxcm95TTZ6xsZ33HxzWd0gdGTWU1TByRY/XKyeFKfr5rxcBccY1NNlXZU6ve/fz5CzByIgjy/y72h6yDvOHF59EMowbPXoJU6epQx5tHuqT9JZtUr/bP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909695; c=relaxed/simple;
	bh=H5mXvbU0KXgZqtkfo2Z05aVUMmoMZboGKCvt69cfWdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqsXI5dqnkW8qtNLPYkPUmyrypfVsWC9MvXKoZihf2RTgNpHsP7iFqwshsy1zZnNnLs9uqQGf5ql9N9ExdyvlCgTA+Qe4KU3EyEjbuGjjtjv8I0ajb5F0Y3j6cKczwZnK2yyMLXgRzIH3/aUPfB0cnZGHZCNYjRj8B/5HLYL13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haC/g3zt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724d23df764so5918965b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733909693; x=1734514493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cgqV/JO6oR6aFw7Aik89l/GQyuFFq78Hr5VL5rEr7CM=;
        b=haC/g3ztJM7g9KcDgNrzfFHoObTbDiYNu73sOtQXB84/2JOh2N853NmVnwD8k5fKQU
         5+8zUKwinmB2VQMtg9MndlpKpasPiuSzNalWF2xBXocQC3m8nMbTHNvT/AstxYIbA4Av
         CiKYa8ypVIzel1WCpvBHohPzITRNJpBRPjHgeXvlS/1WnLmSQ/HjoISvFhRIonKmvHMZ
         l8r1lqYJOB3qnTuUjIVybssfbGJ4TqbJ3NuUGEOoxiSZA3CP9KW2zC/TK1PEGL3/jMjS
         QxMFkDYHPPZFzyfn/7hMLWQNERkkrOL7f8KAlbIyq5UGOvPusLVF5ZndetlPIrx904Hz
         u6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733909693; x=1734514493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgqV/JO6oR6aFw7Aik89l/GQyuFFq78Hr5VL5rEr7CM=;
        b=kC+BIUncb7Jh3rEwLQRsFMzKG7Gqkeg4AHtoVgi+fc471cROWJWKak/bAmpAyUlxqI
         R0K4nffyO63vDT4cFw/2b9HRnH6Vb3O/Uy7hiXWYVDDj2Zc0Ryljb2IjenDGxzpv5T4t
         pmbUgTfo1dRdI8A3d5V0Xe0gNLbGC5PdhpYH1Hru0DGYO4Iv0skvWlqs0LU0+2UYciyn
         jfKFXOuJXw2zAyszjoY4Yni4ZsfTYyTQih9rGkKgCXWmWUjWdX8hc4jQtE8TO9s0SejE
         49rq1eJ26HbnDyHMsuRy7CZ7UAUm1mpCHLSPPkkBBwvuvPepH2C/qlhlRgBJfuv2E4YK
         NWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFWgKCN4q1uSCkNorp7k/M7tUTHcYUxx/4C4+9oawAe7VEd/YhpRjG8zaZITw29krchybLLFQNyIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVbOi7xfveo1Zv3SLkc75dSaYttPduwvtvwrhZ2qxD5hFYfnA
	wteiLD7VrFGDPoxa9vulSdt41q6p0Jiy11JZ3A1aZeTr2IT8Fq7u9uvn2Uo17oYhFVCy91FlRS0
	=
X-Gm-Gg: ASbGncsQG4Y24OYWv5GcQaipfOPzm5H9/uQe6o2ig6IELnxLU6Cu1wd4IXbIo/3SgbV
	jF+vp+nBBJ0gtUchmjIFsGFm/iBDkDZnohA3TapTDxzWMWASItOY+6yFQto/fpHSsWFXNnhyKnG
	L6ng8RvFNIRJTtCGjunDnZ4lYj7bjz5GJljf8YVQZmBAC4lKb2ZyTdGrR0j5I7PBe7Tcrtdw+iS
	Y+t3F7WtoYG5RJ/L4oy1PQEZ8js4COyjtTteIFK/MzMaz9hiRVYUBixtvwIKHI=
X-Google-Smtp-Source: AGHT+IH07+qa/4yb9DxmiZHmFWco0nSmlHI3Wipl6jd6BWnIU+MGk8r8cehLwq5q837AcEZzgzZO4A==
X-Received: by 2002:a05:6a20:cf83:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e1c12df490mr3814479637.21.1733909692958;
        Wed, 11 Dec 2024 01:34:52 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fdde228459sm2593605a12.40.2024.12.11.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:34:52 -0800 (PST)
Date: Wed, 11 Dec 2024 15:04:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 4/6] pci: qcom: Add support for IPQ5332
Message-ID: <20241211093445.ykmr23zameie7si5@thinkpad>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204113329.3195627-5-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:27PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> The Qualcomm IPQ5332 PCIe controller instances are based on
> SNPS core 5.90a with Gen3 Single-lane and Dual-lane support.
> The Qualcomm IP can be handled by the 2.9.0 ops, hence using
> that for IPQ5332.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

As Krzysztof mentioned in bindings patch, you can use fallbacks to avoid driver
changes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

