Return-Path: <linux-pci+bounces-43504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02027CD4D9F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BD9C30010ED
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A6306D2A;
	Mon, 22 Dec 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRasm9Z2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F43306B3D;
	Mon, 22 Dec 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387678; cv=none; b=cYNt+NOtPrNriev3ZhplY5Iz1e1x/YT6eBljPaIViLhBRbo3jPrkrh10g2FBn8uZ+fRwi6UnnfKDjEo3l+Rt5LluOXn+aKNU6blcKuykfhJW6CqdOFOkm0NcH786TPLJJwpkxLtbuuyvp/3Q/KnAL1Trq41ZajM6tIdYub+cqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387678; c=relaxed/simple;
	bh=ramD+pB8M1ocUTcEA346GaBNt1NAclV8L/r+mOrpc/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwWKbqsray4nnFyRCnsKU1fRDRoNANHJu322pIyjrceux1xcq2Fdjx//V+Bn+g//AAGk5ofU+uq1tkmzIM67GE5RDBPi9NVM4XO1ukV6AqZhMYKrt8tQia4zeUe5e1diq8JxIMX4PdFojXSrgEDJeTglnUVFXIXFefwkMldJ/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRasm9Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F5C4CEF1;
	Mon, 22 Dec 2025 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766387678;
	bh=ramD+pB8M1ocUTcEA346GaBNt1NAclV8L/r+mOrpc/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRasm9Z2ibC9liizwvBxtlCgAq6RWu3DFF8oyTyrIemKJ2TAW08jnS5C1nWKP+s4S
	 xbWosagCttuBf+zcQkDrU7UhtnUaT00Bbabie4D+WzMKpe1JKeT4mjJPAcsiuMgycD
	 2jxvvMsWNNq/XczzN3fUL4CrKbOl/xCPA6GetVJ+wwGwdcggAEBWRNKAMaMcbDyZkG
	 OuTow0dth+ofWeMhvyj3SUkjw3KYukLpPEbNk2CSjGjKqdovGhAzVoXjvJQOMGeXDU
	 r+nczwkCUS5fhcRYbBBenTLvb8Clp+BxMbrv5HRBA++8h4yOwegQ77BjVP76ClIen2
	 D+W0NS2BfpYrA==
Date: Mon, 22 Dec 2025 08:14:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] Revert "PCI: qcom: Enumerate endpoints based on
 Link up event in 'global_irq' interrupt"
Message-ID: <aUjv2FwfoDqNMKoR@ryzen>
References: <20251222064207.3246632-8-cassel@kernel.org>
 <20251222064207.3246632-13-cassel@kernel.org>
 <efa4b3e2-7239-4002-ad92-5ce4f3d1611b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa4b3e2-7239-4002-ad92-5ce4f3d1611b@oss.qualcomm.com>

Hello Krishna,

On Mon, Dec 22, 2025 at 12:21:16PM +0530, Krishna Chaitanya Chundru wrote:
> Removing patch 3/6 should be sufficient, don't remove global IRQ patch, this
> will be helpful
> when endpoint is connected at later point of time.

Please see Mani's reply here:
https://lore.kernel.org/linux-pci/fle74skju2rorxmfdvosmeyrx3g75rysuszov5ofvde2exj4ir@3kfjyfyhczmn/

"And neither the controller driver."

Sounds to me like he still wants this patch
(which removes the support from the controller driver).


Kind regards,
Niklas

