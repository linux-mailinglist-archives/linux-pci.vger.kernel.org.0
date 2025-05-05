Return-Path: <linux-pci+bounces-27137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28435AA8E2C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A687A2E46
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E111F30C0;
	Mon,  5 May 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izfqsK0K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859F1F37D1
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433484; cv=none; b=VmDAPZsluHF7EWjR9TKXUInyOkzZASYT+NIC/OlCTewwJICHnKvHJxf8lMQ6pqFwIyo1MqABto/Auy0vobrP5yT3ZM9KOn8G65r1EGTSZINwmZi58EgoKubYT0d+nx2SzR1srifK14O56aN5L51b7FYozZqDvi7Iz/sb1rWpAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433484; c=relaxed/simple;
	bh=qORKuU3vb1cjfT1bxyPIwH3ijIYk0g/RaecJjYjAq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCw7kC3nzH2ZlBan4K8KeAe24RurIg6F+oJwSzow3RIvchw0pXkwCsSCTkK+DYOKz+i7mhr732Rzi88Nz7bsAZNZFYkzfkuaGsY4BTu26GrgVeb4VugdBdjm2ujUYZfUJbSgDrZXPwJi4u02o30x5myFNp88uMzwE/8XTcKgVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=izfqsK0K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso51058295ad.3
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746433481; x=1747038281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68nceW03d24h3XPl8Ecm9vp6ySFut8dycHsfcJVfie4=;
        b=izfqsK0K/sujp2gTNeZCfZ2sLNHoBU49IdgXrM+TpwNUHf77ZgnDeEJkQyLten3yNr
         zhgPVi0JIOXocl4/28J0iqcPlBhgSnT5gtNjmIs/Ng4gWM70uJemmxhLS2B8faD3WK/b
         dolDKBsxW4z2TAyXak2pPjWwBv80kt0xS9065o0J67eIOTPAKocZtXuakducrVwiJtxo
         EpXAnWWHYqW5zuJI4BlmDYfNNPvW/dVdHqvhsOOWJkiJ60D8w65jZdARTh0pqI50YVcV
         OOBVuegoexVtt7Q2dlGLIQfJb/ZGHja7fwHVmVomNuVw2WCAQ8ZDBq77Wz8C5auNDtlV
         ORug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746433481; x=1747038281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68nceW03d24h3XPl8Ecm9vp6ySFut8dycHsfcJVfie4=;
        b=H6caN8NSlNANqCM2zDptvoKNv5DKeljN2n//ti5Pb3BNLvIL+RL5WqZbZmUoLJDMj3
         koAWfm/ZHW63UsSvwu3ZkHJDYpD4zqYVjFFlFaL762zrcgQX/+S49fM29kPIA+kZq/Xd
         q+jJJnvdzTZ3nB9WZhnpBKRUr5wbL9LK8f6yeWUKT7wL4mcu5bGPDgKr3Rzk19nwjgKi
         1q67fOId8zTOPLInlsPm8mjvCyklFQgf0Y0/sUWNC3jEC6ppxu8nZyzB+H/lwEDfh5DB
         WN9c9BHaIi1w+88ZNS003XgnaFJm7IU9gwQXwz+oA/mfY/cBzV4hyXpGrXQrhZ66vyuF
         q2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMtU8EIETsp2fGs2G1r5297wosZB9s/8+S2HGr1jYTWqM/c89Brjs2QVjDnhLFD/viHPD/AI8JZMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pTpZDIWydUHLkr7hxPsRk0TEDLXGqvBhPXwEphrMwk7Set8B
	MHpMrmGz00He4+zCp5nH/MV5ASAX55K1t5Trb5ogdjcCI3CXgp47VYTrgnJo4Q==
X-Gm-Gg: ASbGncuXIuKBSjwrq1OXMcCxnY21bkNSTXb6WJu4/4ZeNJQUejJ8QrPzAmRQNYnkWFb
	FN/feHt9ad5xNsW7DJj6xL8QkAMmcmqbV9DQL6dnr7jrJQXLSXA5j62Enc0fq/h8mYpJUvA7Ix9
	D8uUTmZbkdtUO3ZGqaDFt/BQOsGuLQJfIwAkz7rna6V9lMwANmFRA/B3Ofm6cshgmZr6rWGi2JX
	VGaMhvg+FeAXPlCEaEsR/5FlmZi1NT9z6aIpRq9BIVfDWnp/CK7zyRUYHwFoVOZKzdP+XWNY6Pt
	JQLRNw1E5iC/ij9AKhksfW0iLyN/Pn5V3wQU9vAKKPRUfQ501Sc=
X-Google-Smtp-Source: AGHT+IGLhQnLyNiAlToJpYp8qq06+C8yuSXZTpN/AelxN609WUfQmyW/IvndZCZKUnXVgINsasK6lg==
X-Received: by 2002:a17:903:2f83:b0:227:e980:919d with SMTP id d9443c01a7336-22e18c4f079mr113098375ad.47.1746433481549;
        Mon, 05 May 2025 01:24:41 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522ec04sm49029085ad.216.2025.05.05.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:24:41 -0700 (PDT)
Date: Mon, 5 May 2025 13:54:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org" <cassel@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Krishna Thota <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <p7res56nt2khlblt635js3xqdytlxqaypu2sfrigfaamqcc4ch@7oatwsmashin>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <vrqkwvwwjrirsrrionoqbdynha3pahabmkhzk5rs5vfb3wugh7@4zagyt7ycbbv>
 <SN7PR12MB8028F87148D1B635F832EEB9B88E2@SN7PR12MB8028.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR12MB8028F87148D1B635F832EEB9B88E2@SN7PR12MB8028.namprd12.prod.outlook.com>

On Mon, May 05, 2025 at 06:21:41AM +0000, Vidya Sagar wrote:
> Hi Manivannan,
> Please let me know if you are expecting any further changes to this patch.
> 

As per Vinod's comment, you either need to split PHY changes separate or get an
Ack from Vinod to merge both changes through PCI tree.

- Mani

> Thanks,
> Vidya Sagar
> ________________________________
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Sent: Friday, April 18, 2025 22:51
> To: Vidya Sagar <vidyas@nvidia.com>
> Cc: lpieralisi@kernel.org <lpieralisi@kernel.org>; kw@linux.com <kw@linux.com>; robh@kernel.org <robh@kernel.org>; bhelgaas@google.com <bhelgaas@google.com>; cassel@kernel.org <cassel@kernel.org>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Thierry Reding <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Krishna Thota <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>; sagar.tv@gmail.com <sagar.tv@gmail.com>
> Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
> 
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Apr 17, 2025 at 01:16:07PM +0530, Vidya Sagar wrote:
> > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > check, allowing the PCIe controller to be built on Tegra platforms
> > beyond Tegra194. Additionally, ensure compatibility by requiring
> > ARM64 or COMPILE_TEST.
> >
> > Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > ---
> > v3:
> > * Addressed warning from kernel test robot
> >
> > v2:
> > * Addressed review comments from Niklas Cassel and Manivannan Sadhasivam
> >
> >  drivers/pci/controller/dwc/Kconfig | 4 ++--
> >  drivers/phy/tegra/Kconfig          | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d9f0386396ed..815b6e0d6a0c 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -226,7 +226,7 @@ config PCIE_TEGRA194
> >
> >  config PCIE_TEGRA194_HOST
> >       tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> > -     depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> > +     depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> >       depends on PCI_MSI
> >       select PCIE_DW_HOST
> >       select PHY_TEGRA194_P2U
> > @@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
> >
> >  config PCIE_TEGRA194_EP
> >       tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> > -     depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> > +     depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> >       depends on PCI_ENDPOINT
> >       select PCIE_DW_EP
> >       select PHY_TEGRA194_P2U
> > diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> > index f30cfb42b210..342fb736da4b 100644
> > --- a/drivers/phy/tegra/Kconfig
> > +++ b/drivers/phy/tegra/Kconfig
> > @@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
> >
> >  config PHY_TEGRA194_P2U
> >       tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> > -     depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
> > +     depends on ARCH_TEGRA || COMPILE_TEST
> >       select GENERIC_PHY
> >       help
> >         Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x
> > --
> > 2.25.1
> >
> 
> --
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

