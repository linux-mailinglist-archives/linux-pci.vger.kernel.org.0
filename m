Return-Path: <linux-pci+bounces-20617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBEA248C6
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 12:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03F2164AC4
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740D156887;
	Sat,  1 Feb 2025 11:51:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10F12A177
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738410665; cv=none; b=tjTSDrdKRhtfTt2iQ3X1sxhyBR4s8cuh8b+JCGa5glkR/21Gh4rFetlCusoXCMOROINPUwP3odpKqK8y2vY+SZKk2X6n66GOE2aUP6bwTAFNhNR5fEVko9c/9Cy5tCpf7ZWz5wxy/Kpu++bB2T3p3t3oX5DUpsXBqlWaegC5gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738410665; c=relaxed/simple;
	bh=t/IjVeii3PN5DNkJGkrdkPMxykmDD56iWDeJDlt/54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1GDl2udb0ydgVhwHXXIxTLO6Xceaj/WY7yubaEetyk7jMo8srdmya4Qn1AZap8AJTU+vQyQisH0qyxPVs6UnrgBnljs674V/Izc5c53txUr9AfNb+IfQiD3malRpg0u6m2tF8CJTpWhJ0GrUHrxeejqKqMExoFd+27cXZkTMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <pza@pengutronix.de>)
	id 1teC1D-0004FA-LI; Sat, 01 Feb 2025 12:50:35 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <pza@pengutronix.de>)
	id 1teC1B-002xKx-1k;
	Sat, 01 Feb 2025 12:50:33 +0100
Received: from pza by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <pza@pengutronix.de>)
	id 1teC1B-008EGS-1M;
	Sat, 01 Feb 2025 12:50:33 +0100
Date: Sat, 1 Feb 2025 12:50:33 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Remove leftover mac_reset assert
 for Airoha EN7581 SoC.
Message-ID: <Z54KiWqgSiLZ_nZj@pengutronix.de>
References: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On Sat, Feb 01, 2025 at 12:00:18PM +0100, Lorenzo Bianconi wrote:
> Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up().
> This is not harmful since EN7581 does not requires mac_reset and
> mac_reset is not defined in EN7581 device tree.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

