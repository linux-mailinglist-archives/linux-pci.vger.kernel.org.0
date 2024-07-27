Return-Path: <linux-pci+bounces-10873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587D93DEBC
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AE7B20EF8
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B334502E;
	Sat, 27 Jul 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4990Zqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36EA4502B
	for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722076366; cv=none; b=e5rftBio5hztnPMGbb5bEV8d/CdWq9uYJLNcMqLBg5gVHWEFt5wRuuOnnjpiinW4uLpiffgzlTsfc57WBwh7LReuQqnlTs/+46EMBcVUNSvCoyBF3t6mxBegNGON++hnoyaVq4at+gF1TC4unw4MuNR6kVzEzz714sirwDNNJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722076366; c=relaxed/simple;
	bh=5ggE86s0WpzXdAAD4YHoIcPOJhiobskLJTJnK0W4rKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssm8HVJQexKmi3jt/R+GX68xBC3wplXKM12IqMjBht7JcVoqqfAJIMvFlJfNzVR93dS4MjIVMMfnUXszt3DbS+L+nX5Z59YFD3XR6BvhFT83/1an8qrLMG0fzvXzBTwM3dLucYx+nePf8zf40YbP0CHwqI37OGS3hOoVdId7oTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4990Zqz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f00ad303aso3088152e87.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722076363; x=1722681163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET6l0g34PgpKAWKJpgrZAvTqr8erTPkKLFvd3pB2OJY=;
        b=v4990ZqzV3skMDD/S3u5zaQaOrEHaJgDsi4qvMniJrbPO0/E671POYy1vWTGwVdCad
         8GAJ//dguw3JsnY4pbvRy91dHzDWEaNdtlKLxjKqbsf0F8J4OrxdPKU6Razb7Uz8Ru29
         qupSiptspKj8bqcypNQ9cAtmF8FsvzZOJCNLgEiBjmGCzPFD8QvCYVi7fE9CsYWb+TmA
         n5D6j6Sl+APgJjDJBIx7Z7uC4qOw/Ok06fXDaywi/DeVy1aFtsDbqwRcDYb9SQDy0viO
         tIl20LfD5zKsELp3I+EDrpetfW85pRtq/rBC/37sqStojPYpAm9adpw9dVEKhax8HonR
         cgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722076363; x=1722681163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET6l0g34PgpKAWKJpgrZAvTqr8erTPkKLFvd3pB2OJY=;
        b=mG1HLIZGSyayfLerddvNjsM388svilYBLSp/+uQQQrC1nZuyQ+RoBYv5Y/KAsm5cvz
         j153nDFheZCO8tAFl78d3Z/bl30yCoCZ6lyDZ84kXLPbn1o7Qpfs1Abn+b6qZAFtHL0J
         g1TeyDfL5Ch1caaCaGc/ebVH/MuJFWGKj7gxWsavOtthpJASyPEC/LG7ok+QqcGBZmGx
         28bTc2yjZx2+Yfx3DdZZcU/uRUVXAeJydVdOYgKtB52N6XcfCHdrV6BJWngc2b1rRhx4
         RgcxVF+1fuY/e2WcJJqLj9AQ5tf7+4ycO6yB6AcURAQzvotVHZttmTAUHvmADg0IBwD2
         89NA==
X-Forwarded-Encrypted: i=1; AJvYcCUsz15QhyilhCTqImu0Csd+BiKDnGTn96KZwwDo+uippJaFrXnKNgmjRvl1QQJyEXySg2O8vF7p0FXbQoNoS0a+kfCTtKKTEc5h
X-Gm-Message-State: AOJu0Yy8kh37n0wSgPB6WUEj63Fo1YvYo/01BdKhKFbTN9GP6/0SnPdu
	R5F9J40VWmXpGGKWlnDxq0ZB4qfc7ior2kNHM4OUggGbRYY26t/SdJrqv/usLGg=
X-Google-Smtp-Source: AGHT+IEw/tDWe7raRiUpnpq/rkzmIxJKZb0S5kGCKw4xruIow36Ec6uEWJLhRmuAC5jlEM7k/C6Lvg==
X-Received: by 2002:a05:6512:2c07:b0:52c:dfe1:44ea with SMTP id 2adb3069b0e04-5309b259b1fmr1580619e87.6.1722076362296;
        Sat, 27 Jul 2024 03:32:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc4262sm739487e87.58.2024.07.27.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:32:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:32:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>

On Sat, Jul 27, 2024 at 02:36:04PM GMT, Manivannan Sadhasivam wrote:
> Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> for drivers requiring refclk from host"), all the hardware register access
> (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> from host.
> 
> So there is no need to enable the endpoint resources (like clk, regulators,
> PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> helper from probe(). This was added earlier because dw_pcie_ep_init() was
> doing DBI access, which is not done now.

... moreover his makes PCIe EP fail on some of the platforms as powering
on PHY requires refclk from the RC side, which is not enabled at the
probe time.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> EP controller in the case of failure.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

-- 
With best wishes
Dmitry

