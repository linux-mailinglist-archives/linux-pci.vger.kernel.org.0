Return-Path: <linux-pci+bounces-42748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92ACAC17A
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 06:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202EB300B82B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AC3B8D7E;
	Mon,  8 Dec 2025 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCUkO5wH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E73B8D68;
	Mon,  8 Dec 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765172765; cv=none; b=e0NHPQ5VRgEthTKL01fWDTmCTi16lKFJjcCZRpVCP/BhCSWBXj90DcTdGPWjO3xyL3tiyG+wXiaaylogLV6LOMykxs0tNdNsb4qeYNiBqyqV04/gAfm/KVNUMxVzm7lb5rKRoChQvU8TLd5R/Vbt4YTxohXXd7KeKjlD1tDh2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765172765; c=relaxed/simple;
	bh=4oPFnaKOuwa795QouzAkLdFmxipO+zRI6ijexJF2Dxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/GitTG7m9BC1iEcjAcuh2EAP2oI2t6aXgBFzscFIfbiA1ss3knQu9wkjO5sIAfoZLBtGFx8p/ZJ4HQ2NGAaObm8eMH0hL5hQ9Vn5UwvrG0kTKNnTqN78Il4hg/t5xO1PZL6icqMtMLe7Lb6Z//n9xfX5slF7kjoC653IwPh0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCUkO5wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C384C4CEF1;
	Mon,  8 Dec 2025 05:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765172764;
	bh=4oPFnaKOuwa795QouzAkLdFmxipO+zRI6ijexJF2Dxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCUkO5wHsKZaS1oV3YA4xJ+CuE3qQlV6O/izT24g2LwTzWQM0yWZDfrfXf8XszMZM
	 pU7zjfUPgjvYmGK5EGD/fuhch+Ncj7uAQH/atF4qnUZpN/Zgfb5MtnJAPYXmYWlGdR
	 ecR1dkvQK7j0zb22jeMacLyxp0uqmxqs8jS333sRUmep9+h4otHPN2oyZdOtsai0+P
	 6fOmtKSOJ6BRwDZxmrNJb6jFgjopig9uDBC7tMPvRkQA7r4poQaIWDEur1i4fx9W84
	 hsb5RlkxjqfzLp/7IylsogbO5hf7pae/x2S4Zlba4P+0aiJ+uDNLuNM3jR6xIJKzbM
	 L3Rhlaf8d62oQ==
Date: Mon, 8 Dec 2025 06:45:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aTZmF5AEJQhQld4Y@ryzen>
References: <20251201063634.4115762-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201063634.4115762-2-cassel@kernel.org>

On Mon, Dec 01, 2025 at 07:36:35AM +0100, Niklas Cassel wrote:

Mani, could you perhaps try this series on Qcom?

I personally prefer this series over a revert because:
It allows to us to still use a PCIe endpoint that comes up after the
main system has booted, e.g. when the PCIe endpoint is a board running
pci-epf-test, without the need for a manual rescan on be bus.

If we go with revert instead, this very nice feature would be gone,
and the user would need to do a manual rescan of the bus.

One could even argue that that is a user visible regression.


Kind regards,
Niklas

