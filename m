Return-Path: <linux-pci+bounces-34723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D2B356C9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0CD178205
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC192F9984;
	Tue, 26 Aug 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR/wCl6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3612F6573
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196826; cv=none; b=jJuiHWdxggBO3Mud8gXYREjha/Nh7AQHZrB0U34k0QLd26tV/R23F5EPzhcVLshYfhIIg64U9cHeCna/WHHcFOr7Fz9tSwbuVeeknHMWIvyeeDkvbP6fIR2RHnlxn+6PK7lQhrtkP5Bc6DrqWfHpUw/bpvoYWRsKGi1ehBSCYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196826; c=relaxed/simple;
	bh=CmOw9MM62MUmPOH9GRufRxbgMIWxnIxG8qJRDX5brlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKXDrXE/+Enl26ECkL3x8K6jy+rpczySzaM043EKahc9DtL8aUhGArucd6wU0KhJNyPqYXMe0WS4PLZSfHWyOyTWYvuNqNkYbBRa+mPYU6BKvCjbsAPMUx8MwzAwtUGigNZF1zdoEF+tmtBMmrlYqkbF3KZ3dQIo7fVC/H69oxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SR/wCl6v; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24458272c00so62055995ad.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196824; x=1756801624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=SR/wCl6v2M7KXdsxchwPb1r6tpsOusoiJk7yPEzIw4pcdR3K/2NdcMpyNyrYgSdSB/
         Hf0j5sHxXtLBwI+4aZqOUqLjv2fKE5WJ6YnUi2Y2aEs/SzzeupKP+eLD2c+Cuz8+ODDb
         EP/Ki4RqhGkzLtBPURANsVXZ3mF1eHN3oVchtlVmJudKiP7yC/JE9IK3aQR7/EbgvSBY
         v5PUnDdVVBtcZQv376MXELz/9LklRqvm1CUK1IfSy2IqnUxQYkbmwaREKns9G6B920G7
         FWyCg1SaTAa7wE4IzctfZadTn8Rap6qGLQ/v4Y6wn5oFsS7k9CChQpUkb5BWe4zQf9Cu
         gb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196824; x=1756801624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=BdhUhxQs2EPkIsK9eQytd2qD2BFI4edJeOhXft4o0wM5UnAD22Sw+anB9ARHFmTIGf
         8gHu4BFqZ3GKQ0paeTzmOgM8FtxZw6RGQLraGY1z2aEypaP4QQICcE2Z3ORFcJa+X5OX
         kpRoN9FKL1SWsBWyJuwKPyi2FxyENZBDNAENkZOQ9pi0kDs9kyUpZ+34RBZ88a9HZk7k
         8BCfnsMv5GRSwwagPzV32BWT+t0AJ9bPcHtuH9g+kSaLmte6hx28/woGG7Qai6nnAkZw
         bbW5uhgkzRCNAsHAN+7PGWOiGJ48ET4iJbztu0etmoeM++enQW5FydYki2+FyImWy19z
         ilSA==
X-Forwarded-Encrypted: i=1; AJvYcCWy+7VMxJjl4Ag5YMHZEFi2bBLvbLnXbPp9ptgmB4MhfHWJQG887LqRqvG4Y0waSqFWT2OSQW1Txcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbREdBBfWSRvqIpAJbkPyoDhA+UiB3s4mXwM9bWz8vycyW1BI
	FQ6F4vm22DySBbAIB5gKCBk09/inkqIm6bLfQm+RTbSI0rnZioo+DK1Cs4yg1vl/2H8=
X-Gm-Gg: ASbGncsAhcBX3Oo30R2Qoab21s8L51SxDSrcl7yMTvFpoGs9pE3J32I6B7eXjiyZBfB
	v9ejYFojEt6C8M/yc2pmU8GbuKVL0QS6k+rSru/pNa1BIp6WCUAc4YV9eKVM9ICjJUAKJoPO3VF
	4F30Yu8UQMAZQHAKlZ7/ULtYbDY2a0H5FvUm+pBtQYZzSDmormfslTzwrAT0FEH0yA3AjfrCh1G
	yeBt6b727a1gimBtnEkNotBH2qt43MwdpNnRLnfmSLGXYqwwl5TWYuWa4LO+UxgBTeN4do17HKI
	dXGKyuTtQa0ksOkGdtpvYBcYp+DOPqieci1i/5SC20TFwKmMDh0DQcLHzQ3z3kn4NQRVbpeLiSs
	2iXTzhbyMWZ3XR01j0pqDfTgy
X-Google-Smtp-Source: AGHT+IECSU/SDSD+0Cr5TrycnubLdgbitEMB4/KAzano/y2obaZMbKPJEOdIDdWn74RnHNtuJKk8kA==
X-Received: by 2002:a17:903:1b65:b0:246:b1fd:2968 with SMTP id d9443c01a7336-246b1fd2ab8mr81877715ad.9.1756196824113;
        Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm89224405ad.122.2025.08.26.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:27:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:57:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250826082701.tv56zzg2hdavy6lq@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
 <20250826052057.lkfvc5njhape56me@vireshk-i7>
 <20250826053606.zktmwgfdwymizv6k@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826053606.zktmwgfdwymizv6k@vireshk-i7>

On 26-08-25, 11:06, Viresh Kumar wrote:
> Can you help me testing this over your failing branch please ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 81fb7dd7f323..5b24255733b5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>         list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>                 if (temp_opp->available == available) {
>                         if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
> -                               *key = read(opp, index);
> -
> -                               /* Increment the reference count of OPP */
> -                               dev_pm_opp_get(opp);
> +                               if (!IS_ERR(opp)) {
> +                                       *key = read(opp, index);
> +                                       dev_pm_opp_get(opp);
> +                               }

There are other issues too, dropping the patch. Thanks.

-- 
viresh

