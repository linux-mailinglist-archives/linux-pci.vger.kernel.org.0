Return-Path: <linux-pci+bounces-34409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7820CB2E5FC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADB0188E605
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A7827FB2A;
	Wed, 20 Aug 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFLTaOeO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F071DDA18;
	Wed, 20 Aug 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719987; cv=none; b=BQ1Lh0wKGU/wMs7a+j4zw/ek3OInnDqEPXBT+knOVegy1v+qoOIAW13UQm4RAVuLOpZO+f+nKlXbUCuO4zSUU7WkFYxQZbI3a0el56MN0UrNyiD6ffiptFxx1CP+ZFPq5Hs1B/ogXikfLtyu02aOv32B4LUIQu26yfYIgg6pY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719987; c=relaxed/simple;
	bh=5YZTBg91StssS8CLY8edYTCDHeeCUPhH7a/Oy9Gtgxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlA5OkIKaksCU7BNjwI/BgvZL4Gp0AMLEHPFItxaT+i8KayRf61QVvNgpeCa13Lp4401xLYYAwtx2c//9U0OJUIrsTUIKOpwXx6tMui/ZV7dzSD/Bl3BtqVMu/d9CrrV4xMZgMYRZzYNZFiwRyg7IC6ki8kW93TlhBdtEqN6WSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFLTaOeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6973AC4CEE7;
	Wed, 20 Aug 2025 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719985;
	bh=5YZTBg91StssS8CLY8edYTCDHeeCUPhH7a/Oy9Gtgxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFLTaOeOOX21B+JnSaJ8f1fz70JoPxM4xSUwV2CLXvdXaBxgN5Ph3w8Z+0R+qmwiZ
	 xHJ4zbMyptHmxhbdDeaCziDELJCn+hKNP3l6LuY7VLXj71Y9w1G6sQ7bKuxUM8yKkk
	 O9/Xi/6l5rHJL891xzHs0O6xTuUHpi4UKyfVHCrR59Cs8pHvUYDke75YwKRfH+Ukff
	 Z87Hr52+3MOdLbOspdWplJHIlPOfJL3aA2F8sOH/iGMhyRrHVIg6DM3aeWvDaUv5RF
	 KSUCBmwirvRKyxc71oIgx0cYUJuH2dImiVuzmyvlpMjK5mdzviZNSfExiD3qRicrGV
	 WXr7a1oeVFraQ==
Date: Wed, 20 Aug 2025 14:59:44 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Add vaux for
 i.MX PCIe
Message-ID: <20250820195944.GA596147-robh@kernel.org>
References: <20250814085920.590101-1-hongxing.zhu@nxp.com>
 <20250814085920.590101-2-hongxing.zhu@nxp.com>
 <aJ4yuo6bULFy7uAv@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ4yuo6bULFy7uAv@lizhi-Precision-Tower-5810>

On Thu, Aug 14, 2025 at 03:02:18PM -0400, Frank Li wrote:
> On Thu, Aug 14, 2025 at 04:59:19PM +0800, Richard Zhu wrote:
> > Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> > asserted by the Add-in Card when all its functions are in D3Cold state
> > and at least one of its functions is enabled for wakeup generation.
> >
> > The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> > process. Since the main power supply would be gated off to let Add-in
> > Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
> > circuit for the entire PCIe controller lifecycle when WAKE# is supported.
> 
> if it is standard, it should move to snps,dw-pcie-common.yaml.

It is standard because PCIe spec defines them. pci-bus-common.yaml 
already defines these:

  vpcie12v-supply:
    description: 12v regulator phandle for the slot

  vpcie3v3-supply:
    description: 3.3v regulator phandle for the slot

  vpcie3v3aux-supply:
    description: 3.3v AUX regulator phandle for the slot

Note that these should really be defined in the root port node rather 
than the host bridge node. We've done the latter because the RP node is 
often not defined.

Rob

