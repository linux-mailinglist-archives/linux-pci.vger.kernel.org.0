Return-Path: <linux-pci+bounces-29764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28BAD942C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C473AB4CE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A217B4EC;
	Fri, 13 Jun 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFCng4EH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD62E11AE;
	Fri, 13 Jun 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837974; cv=none; b=IE/4YAar+11gnD65utc5MZ2GqBJW4L0dNovao/2tXLiug5kS48VoXTS8OAOCXcRtonDh7WXiJomaObVO6cnY5Eo8ybzOBsGy2eIRCboBYixY5qGgICtT9we14c++IDb0Lmn9T+dBCPRcuKZeYBFCL6oZ8sodQkoLCLQrhvKYQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837974; c=relaxed/simple;
	bh=dBORS2sXwIaT1YbLaswzvJaaII22j9rnaQ7Yydo9Q+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBM634Po9q/F6eRfnflyE90kYko3DHhyM9s4Qq6eZECMrSMxld0WZlAeIqe5mKj+zBpoofprSL+5l2VdNr0X5SZA7b9owe+uTIh5M05tu9MTjFtJnxbYFpwNszbD3g+yEiD/fg6q8ze9BCE8v87/MM1AZpXqC21IVnOeiCHYC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFCng4EH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c49373c15so1945887a12.3;
        Fri, 13 Jun 2025 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749837972; x=1750442772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXUd6lfewKPENm5Aa8Bd/d/D/7UIBoRsbAQtScnCe8M=;
        b=lFCng4EH+M90wQFHsQGiVBIg9JcQO7mQQygANnN7HmxBIg6hThyGXjTPtLAw3GWuG/
         e12rXcs5wIfVrlgE607vZRGppk4pNkREGzcpgWy8Aa4BFvk4sgnzNnUYw2Ujngxpym8u
         NJ/I8NshNQ6Y+tTwmivywki9F6Ulfii5BT7tUdTr0Wx6MX9RQERNapjPeqUgtnZfU+U5
         FHILlhvwyri1bEADCk++1LKCVwJF6n9cQSxXm8/OS+F+gOTjMd7Mtqx1A4GsvQx0thz4
         mdK9mDwepHRHoyK4jITxrSeh1RcQT/1wdE05xTRrNVDg9AIO5Zq77HQEfTBNzWSoGfqa
         VhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749837972; x=1750442772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXUd6lfewKPENm5Aa8Bd/d/D/7UIBoRsbAQtScnCe8M=;
        b=BbU1tn2/V9OtVFRMVCuWk8J3O7Ees1L/nGIuKFS77kLam8WpcSXnDnLTELZqvxyekz
         dy5nXJZK+brTwYdmoqy8of64n6Ce1fsofy5l55qUm2RiIgHotlJmHh11PaoEcijD0JuJ
         fAuuL/fJyljA1ooJR+2XhYkkteBnQLoX1H+/v9IFYDh+4nVAGTcqTsCm5IutJkM+dcjL
         kLQnqkeM33EKZ397YtqEtNW+fm55i+U5hVq1bXdbYASDOf9D8l06EeL/tctS+PVBYGbn
         z97mdSjv7yHNdHyo6zHJ1uUO9bd5DteQf+PtJASsRbYmR7+0quo3suzdv/sSmVnSkqfO
         C33Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMlMnuhQkNGthJkp4tjzZT5y5oR9UcqbXbJ3W8WwTAzrAP5EaFxXUkehHKJ+RvP1A+Vyi2K/wWubxQY5M=@vger.kernel.org, AJvYcCUyDC6mYgU3QyrZDq0K3dOERBRs7WcxVXlU4Qomrzt+CloZvEb+a25CEsiQzotelHC90w03URZUSK8h@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lInmlKYT/cpzA7WMABJ1uCTGrcJUzCtZjPAs/AEkRLjiONsw
	vtNoCM7gbXe1JGxIy2hSOrXdIGNXYqs0oj+Fpcmpg4PE2Z/Nf+IjDRhp
X-Gm-Gg: ASbGncvWK/nYBUwo1dAd/LfH577hexay43TsU4/6jWdzaL9TwyyqwNu0TEa+qMbDctH
	LM6FCtdVYtjCHG1Yd634luLX0iZ0VeSQHaHZ3mG+MqWpSBzhAT5FaZqWPacSIGMkIt3XyQe3vII
	/l65YrVzWFpGH/B3NeIVlDEt7FOQkGYnrsWtMFvNiDxcm4KkxZ1WjEMYxf1t+svX6s8AgrxjI4o
	8t20gyhnXUuZ8nQaDqWCtgIzym+bmYLb6RWkiBJvXNExEkYP6/yDZ6OVDLFjQOUxUtSE6laZp0c
	Vj9F9LekPag2QUIN5Ijq+GaNr2cCvPruPRknY9ZCIm0xS7L91D2o/80S76Q2
X-Google-Smtp-Source: AGHT+IH2DqbuxD4MEb4wwFaAB966G/5kXTTb/l9FTKLx6klqy6VsZe3elDybbPK71Ba9qjzXcLhjZw==
X-Received: by 2002:a05:6a21:99a8:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-21fbd668c44mr392814637.42.1749837971960;
        Fri, 13 Jun 2025 11:06:11 -0700 (PDT)
Received: from geday ([2804:7f2:800b:84a2::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639f97sm1755775a12.6.2025.06.13.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:06:11 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:06:01 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/4] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <aExoiaPhqXPmv_Oy@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <1966f8ddc4a81426b4f1f48c22bea9b4a6e6297c.1749833987.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1966f8ddc4a81426b4f1f48c22bea9b4a6e6297c.1749833987.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 02:03:50PM -0300, Geraldo Nascimento wrote:
> Current code may fail Gen2 retraining if Target Link Speed
> is set to 2.5 GT/s in Link Control and Status Register 2.
> Set it to 5.0 GT/s accordingly.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 8489d51e01ca..467e3fc377f7 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		 * Enable retrain for gen2. This should be configured only after
>  		 * gen1 finished.
>  		 */
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
> +		status &= ~PCI_EXP_LNKCTL2_TLS;
> +		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
>  		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);

Hi,

I see rockchip_pcie_write() was added twice, in this patch and also in
1/4.

I'll send v6 with correction after I get some reviews.

Thank you,
Geraldo Nascimento

>  		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  		status |= PCI_EXP_LNKCTL_RL;
> -- 
> 2.49.0
> 

