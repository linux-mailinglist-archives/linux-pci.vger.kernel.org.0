Return-Path: <linux-pci+bounces-38577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69706BECCEC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5888D4E22CD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF21DFF0;
	Sat, 18 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzQcs3IZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84C944F
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781210; cv=none; b=SLz9a+hlQdNYXPS+V6ThCWSpt5SeYO0Ah0zPRttsHw12tTv/slXXquWVGh3e3yq6J2wqBDWaNQ5iFn77vOUv9Gl8f74wDxbkIZMCwjIdr80DfiGBRZXV5E6LP4Io8rdM1SRyPECCjja+4LaYsq8TDBY675PIPssr5kPjuWov4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781210; c=relaxed/simple;
	bh=jLj8RoSgzmMT2RBpQP/RNNqIQpG4p47ETDS+XypecR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEJCh9GEpZS1hvCdw4NkTAcsikq3BuT6SHEzpJJHBuRkgwJsgqNH8aL0OB7adT0d4+uSynJLPzm4MgpYYy7eQpC0Xv7FSvxP3anPI5TF0Pa8WriK1HOD5iF8uikKASRTsIw3BE3M17Io/7/pn6rU5Zvsu/ly7UVO8E8Qwrc4jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RzQcs3IZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711f156326so12968185e9.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760781207; x=1761386007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLcttbn5k16RAKKI+EzOZF6EXsPtXzfzb9zD7Ffua0E=;
        b=RzQcs3IZNLzsYNNaFFLWAojQdcRTdALXC5Y1Lwt376bv5iIP62cOMiMGGGiZYL8pPL
         Fks9AwNGse1GdPZ3Um96cYML4qU5NpRq0aY/HEt6skDmm5iyoGUt2yclyGyKHgr0Prmm
         yP0f78bLLIZaJvMmxQNWA+aXRdAe+LJq7cyKYCdHpZq4/chHidZF5uqyFwnTOCd1Q6qA
         SHXNTQwXpmcRefdbnuewarZlwKZbxxNlA2ZcYZr/7NwfH0udfkrzBybF4LtAOZ+EXXKr
         lVgEe1t/44XdB+35G4nWz5jqjUocXfoGWpRik+54ot5eZPCPNBnxCy/lezPPlSaxQelT
         Je3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781207; x=1761386007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLcttbn5k16RAKKI+EzOZF6EXsPtXzfzb9zD7Ffua0E=;
        b=K5s9ae0kExC3yZvimeCLCyFXRC+IuMk/0RCHdj6o21czLzI6ixIL1SYw5syBb0imwF
         vmwaZQAGJjtAsuByvZvqiYJinvOvKCnbG+UPbMNzS4q4U6J//XOexMsI1U1qS5Q9Jv3o
         dtIV80JWOwXWOuLtcDpiVQNYFQXfX1rQHyrU/0IFTEWQ229pg1d+WRNm5yZhY1rZPvMv
         Rl0FbGNYJZpQgcvFN5i56T8ibeRx6PwHF+e+tP014JoDkcC9MJlEqW+jEwpnsanD8z/F
         oLwFdLAJVFjlnaX18uy5VuZ4K7xQYkWQUzhYPbqFeaHPpeBNoqoUiBEMl3jQnnnTKJKa
         woAg==
X-Forwarded-Encrypted: i=1; AJvYcCXXb6derWkFev/i2KHSjY4KlKrOkb5hfPFyUJtGnVfAJ9fRGVGpySFm0QK+D3z7VQ+ekoVWO+RzH9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGkjmx2fOnZqLHtTYo6X2VQkRevA0on1HwdmRX94lHBBWbdeN
	W/STGFbyqRxoagHyD9s4MMv2Ze4VhKOhNK5SNRMKrJNIcQH387N1C+UcjpYUPP/GE7Q=
X-Gm-Gg: ASbGncvAH+NLbR6azLSChgmLUXw0O60pc5dihX63lNy1MkRWI+nyhFf/5xjsEDezgj9
	PmQhgtn//t4wBPB2WYtT8qqXq2NEWyORpQdbqmvOXf+SnWAtkEam65y0xcLpNuYvBeydkUQ6sI9
	Kn/jVtAjV1rE3Wr7s4Enq5VUmh6GtN05u5HSiWIPVQQwXlu1Stni4+wNwGoCbU6kGL06N1N+pOP
	0dZ0gjWuyjCqzCjb3pPrDxyiPyw2sGK5NqALPNBwdtOETEKEbBwENiUOBIlYBJVbLA1Od4t4rgK
	A0O3T8WrJsnU+DK9IbAXF0DK15CJDOvHA4PPSe10alLjgvOiOEOLpX3PAEAgOysxyYbAQDB16IK
	svp2Qc7hOSZcm1P0xs38DVRQNym3egf5hBEz8uk640NizHYBPHDKdi7Nc+fnvAr3ubeIvifIo5L
	4bHP86OpxEmaD2dyqi
X-Google-Smtp-Source: AGHT+IE7qvTI/bg1JlFoj/mWNWosxLYB/3XVkN4l0hbhMw4Lq63sfmg28D78UCq3lmimATW7krx+qA==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id 5b1f17b1804b1-471179071b4mr45155315e9.23.1760781207332;
        Sat, 18 Oct 2025 02:53:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a96asm4030365f8f.31.2025.10.18.02.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:53:26 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:53:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] PCI: j721e: Use devm_clk_get_optional_enabled()
 to get the clock
Message-ID: <aPNjkzrexmIyQXpT@stanley.mountain>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
 <20251014113234.44418-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014113234.44418-3-linux.amoon@gmail.com>

On Tue, Oct 14, 2025 at 05:02:28PM +0530, Anand Moon wrote:
> @@ -630,7 +622,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  		ret = cdns_pcie_host_setup(rc);
>  		if (ret < 0) {
> -			clk_disable_unprepare(pcie->refclk);
>  			goto err_pcie_setup;
>  		}

This will introduce a checkpatch warning with checkpatch.pl -f because
you need to delete the curly braces.

regards,
dan carpenter


