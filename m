Return-Path: <linux-pci+bounces-10756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61793BBD5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46D0284AB4
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6541C286;
	Thu, 25 Jul 2024 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5itf1fE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BF17565
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882902; cv=none; b=GIc7GwMd2r3BQdscReTZOF7qqVk7hYks6vO9GUA9zogZqjsnRKMDyn8H0uortJv0BPo8fMnCn7OFiAupjt4CmFwH6PQ+5r7EVJDBTs2LglSszo8mP0fXmU5kG7iPFSK2n+SeDpBfxrVHjFI/GquHsiNxoK58LDC8eCtoaeQvZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882902; c=relaxed/simple;
	bh=4tkzV4CrdLGLyLxeqqrIR9odUjTIIvuyAKEAUZasaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoiG0FwHEOBJQKRQKAgn9K7PZ5MltsI62mORuWG4IJlS5wnHFcvoOweMSi2t/Km52PslmQ7AnYZKqznzwrFEiB9KT3Z6ppGTC5NtgMQCChUfFihWneOnVrANofdKuDWwW3gn47ERKhLYFptTnGATShBQr14rlcYJzHPDSj/A+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5itf1fE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-71871d5e087so387772a12.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882899; x=1722487699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuLrTOMZXwDvrh3Gcss0q0VIdIl/tmC7R+/hGCD5mQk=;
        b=n5itf1fEcC/Fe1QSCWu9b0tXh85FplQ3qRWFHq5FctPL8exhYKOpMOt/iFFstZlTcE
         ozGlzgHcVy01s9nzZ+iYgDSNTNYId+ntYgigCKBrf9njRzJEf75QlXvIuSZTd+/1qqEK
         0GuOOKF58koSgfcUY3Ycvf6hZ0z7Xgh3iMbp5aZwFUGXhtvC45m+xhoo3FSflEnvRQ9/
         5rMcm5zsBAckA2Re9cMnwov/+VLJvw4VY1lX3Xq8ELl36L4//zHHcMpVac2KdyctseiL
         3cIkoF5RLn3BkpDHkhMSgB1nfvrckRGHZeHFu4SjinU8reMKzRTOp+BYqJ5yLLTmw6As
         Cpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882899; x=1722487699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuLrTOMZXwDvrh3Gcss0q0VIdIl/tmC7R+/hGCD5mQk=;
        b=huBzMMZ1MWCHnAr+50Dju93mfRD1nDD5+TL7bBv/IIjT2CJ7lb0uVW2yAfPKnWo4J3
         6AyBexpt2fuwm0dDudHBNRgGurvlJ169gFcGytiah9sMk5BxsjccsrWSBeEgiGDFxc2D
         anrpenGktt90uohLTccAUIjanALYcQvdghtmEu66rdZ+MbpgMGfL2lPATfVNLdOWPYeQ
         B+Ms0Cu3qWXEZz1uEOHEac8CYSkk3oCQqWX80lj0G9FIzyW8tTPV6bSYnOgPeg7AS95y
         w3TLFJm+XV2b8uGk6BWhXK+ZhIGECIAYR+9SfWGsYhLBhCIgpk9Lo/aeciOwcYYFVHt0
         /kgw==
X-Gm-Message-State: AOJu0Yz8S9K6wA3Yr0a9qRtFoOjCe0Whr2i452lgMtP4pM03+uKmnojc
	e7GyQRPiSl6eCCusjoBwYavLou1pxCvCyUKTcjLbGmhBF39kbkYpjJMC1s0iqg==
X-Google-Smtp-Source: AGHT+IEWwStak5o3MjRefRdeyCr2slwkGT9/t8cXU3b6WSdv7rBu11QlEfyQkbgSO9bxXTIKVaFdDg==
X-Received: by 2002:a05:6a20:72ac:b0:1c0:f594:198c with SMTP id adf61e73a8af0-1c4728035d3mr2753100637.11.1721882899113;
        Wed, 24 Jul 2024 21:48:19 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e62e6fsm505267a91.57.2024.07.24.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:48:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:18:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/12] PCI: brcmstb: Don't conflate the reset rescal
 with phy ctrl
Message-ID: <20240725044812.GI2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-9-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-9-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:23PM -0400, Jim Quinlan wrote:
> We've been assuming that if an SOC has a "rescal" reset controller that we
> should automatically invoke brcm_phy_cntl(...).  This will not be true in
> future SOCs, so we create a bool "has_phy" and adjust the cfg_data
> appropriately (we need to give 7216 its own cfg_data structure instead of
> sharing one).
> 

In all commit messages, use imperative tone as per kernel documentation:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index dfb404748ad8..8ab5a8ca05b4 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -222,6 +222,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	const bool has_phy;

'has_phy' means the controller supports PHY and the new SoC doesn't have a PHY
for the controller?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

