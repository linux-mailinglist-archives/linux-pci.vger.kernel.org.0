Return-Path: <linux-pci+bounces-43521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC34CD5EAF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EB4E301B2DF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36C221540;
	Mon, 22 Dec 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSDZkowi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D921CC43;
	Mon, 22 Dec 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404826; cv=none; b=Yx+oBD2xc+87HebNP5fG/pGhVzjkzAwbonI2WEMcKjsE3qE8khcNIFJaigY0rDbcAUNa+/kaUTUrmeJtT9f2xBKrcNWaPgV97VxnNxaEzk+mLlW6hARSUXFGoSQkcK2gcoZQRC7lQBVJalRZW83e7r7XT+JpUewVDqMEtpC1eDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404826; c=relaxed/simple;
	bh=O6Csq9jMvfYvTC/+4nroZN8MiC1XgFhothYWprMkHwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRE4shnbzVxdZUKcPdyYiAVviL1UvRgx1Dgf4AF1R32En+yrx1yzwZZCJ/z+BmS0kMfU/+xVSuqLA7zHGcLgG8GvcXEOFjrKpzdS2xwGfWod9JU3/mp5+SuxnMfzCYC0O6Gy5bD+XB1DcDdcmcO3sQY870qu/BM68GU3XIWz5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSDZkowi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8647C4CEF1;
	Mon, 22 Dec 2025 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766404825;
	bh=O6Csq9jMvfYvTC/+4nroZN8MiC1XgFhothYWprMkHwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSDZkowiNhwQ2LXH4oFSLCs6cx+0r3YDCV1kbGzZdpC+7mEFsnSo6yqgKYiRKcbPT
	 OuQavEuTc+mv1lDvmxp6/A1vnGFRpnWcBPLxzCylX0e/lZamHxqYq3I41zoaMeXGza
	 G39xZSk47bII4ct7EQ0h7LrPmHK90KOlfgF4IGK8bC5ygnpldH1to5aa4eWuk/hLIN
	 1p1K1rDZQUCF32n09yg6Aj01ODSSnhZtzMODlWEAxZOeW+/ikyjBjitZL0yUK2tOmQ
	 3Ms8091YCIknWH6BZeLT0d0DFQisFE4+UUrkj/TaU4R7umc/PxB/fUqDUgDObDGqiu
	 TKBHbjktDY6uQ==
Date: Mon, 22 Dec 2025 17:30:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/6] Revert "PCI: qcom: Enable MSI interrupts together
 with Link up if 'Global IRQ' is supported"
Message-ID: <o32dmwprscjt36bfek37pmq7x7mvkc4wegzqd63yfbvid7hw7k@dzajw63jpdrt>
References: <20251222064207.3246632-8-cassel@kernel.org>
 <20251222064207.3246632-12-cassel@kernel.org>
 <6f4eba26-86ba-4510-ac0d-b6e54fd5f51c@oss.qualcomm.com>
 <aUjsqbIaL86Kj1AA@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUjsqbIaL86Kj1AA@ryzen>

+ Qiang

On Mon, Dec 22, 2025 at 08:00:57AM +0100, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 12:18:32PM +0530, Krishna Chaitanya Chundru wrote:
> > > @@ -1982,8 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   			goto err_host_deinit;
> > >   		}
> > > -		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> > > -			       pcie->parf + PARF_INT_ALL_MASK);
> > MSI's needs to be enabled irrespective of this series as part of global IRQ
> > otherwise
> > MSI's will not be triggered in few platforms.
> > 
> > Mani, exclude this patch while applying.
> 
> From the commit message of the reverted patch:
> 
>   The MSI bits in PARF_INT_ALL_MASK register are enabled
>   by default in the hardware, but commit 4581403f6792 ("PCI: qcom: Enumerate
>   endpoints based on Link up event in 'global_irq' interrupt") disabled them
>   and enabled only the Link up interrupt.
> 
> 
> Thus, applying this patch should be safe, or at least bring back the
> original behavior as it was before the Link Up IRQ patches got applied.
> 

Yes!

> But if you prefer to enable the MSI bits explicitly, in order to not
> rely on HW defaults, that should also be fine.
> 

I believe Qiang reported internally that we need to explicitly enable
PARF_INT_MSI_DEV_0_7 for all platforms as the hardware default is not always
correct. So that should come as a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

