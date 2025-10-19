Return-Path: <linux-pci+bounces-38663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B81BEDF9E
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 09:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3164E423A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9421FF4A;
	Sun, 19 Oct 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYTsQ6og"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2B354AC1;
	Sun, 19 Oct 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760858444; cv=none; b=G3zvSfCMuRAvORTWle06l8tv1QuyrJpDcVE5TFDYdrOlIu4/Q3bZpevs1ewEkdmORYWoSvoWI/hedwDRrX02u6xcxQ6hFjlHelvQoT5dXUsu/mEuzNWG9BL8fVaIwmlHdfMNKQcLketQp0rVb9hejlWIr3iNPHrUkMJoHCFoxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760858444; c=relaxed/simple;
	bh=E1KMY2AmpHwrokV2dPfDb4Pya+/4OzhBXOQPSDpVJKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+uyvDMpNr2/B18N/MjI6iSrkyq2SDCvBRBo2qMItJp7qT7axonKAS7Kmx2cSlBujwpqvzyFYeOgfQJhMao0bqCcE4ATi9wMs7q3dTVqr/KLclm9hcLccBH7tLq2h1+oO7TFcPF9Xnhzh3/k+wJIktRsyP98bSbx7HTPlE82TNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYTsQ6og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76672C4CEE7;
	Sun, 19 Oct 2025 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760858443;
	bh=E1KMY2AmpHwrokV2dPfDb4Pya+/4OzhBXOQPSDpVJKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYTsQ6ogzr3fgCfhRydcE0RdvcnjlufXTeGkXVBiTrPzhZwcFDCidG6WrMAkdK8rA
	 7w2nIEfrSwFFQH6Y/Cj5WckrDr6c8aUohokWIAvbhrufx3k6WIQGHZnAbosRuCfNZn
	 fQcIltKMTR14fiTYwDV9pY59ca75ja3aj4qSJsQx0bQJjT4/MSs0ygSuOnQCDrftaF
	 trfOQ2U3HVQntHKVLiqUASBEgZdI+PWKfatk9OGGm4h7t0li/5v4Y3VH4ZJZP+VC9j
	 LcQ5QtcxSkNJksyXWxA6Dsq9KDcaZFONO1ffSqqUBnmcaBztQlP/Pyr34mu1jQ4k/q
	 1QuGCIYkDv1jA==
Date: Sun, 19 Oct 2025 12:50:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v5 4/5] PCI: mediatek: convert bool to single flags entry
 and bitmap
Message-ID: <pqd5e46fa36wmdf7vgt6lvejpsx3cmkmwcaccaubt4uvzi26mb@r55x7lns5sbu>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-5-ansuelsmth@gmail.com>
 <675d5338-09f0-439b-b22c-a3d50b243b5e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <675d5338-09f0-439b-b22c-a3d50b243b5e@collabora.com>

On Tue, Oct 14, 2025 at 01:46:04PM +0200, AngeloGioacchino Del Regno wrote:
> Il 12/10/25 22:56, Christian Marangi ha scritto:
> > To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
> > use a single flags to reference all the values. This permits cleaner
> > addition of new flag without having to define a new bool in the struct.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/pci/controller/pcie-mediatek.c | 28 +++++++++++++++-----------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 24cc30a2ab6c..1678461e56d3 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -142,24 +142,29 @@
> >   struct mtk_pcie_port;
> > +enum mtk_pcie_flags {
> 
> enum mtk_pcie_quirks seems to be a better fit here, as this is used for... well..
> quirks.
> 
> > +	NEED_FIX_CLASS_ID = BIT(0), /* host's class ID needed to be fixed */
> > +	NEED_FIX_DEVICE_ID = BIT(1), /* host's device ID needed to be fixed */
> > +	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
> > +			  * external block

Add comments as Kernel doc.

> > +			  */
> 
> Also perhaps... MTK_PCIE_FIX_CLASS_ID, MTK_PCIE_FIX_DEV_ID, MTK_PCIE_NO_MSI
> 
> > +};
> > +
> >   /**
> >    * struct mtk_pcie_soc - differentiate between host generations
> > - * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > - * @need_fix_device_id: whether this host's device ID needed to be fixed or not
> >    * @no_msi: Bridge has no MSI support, and relies on an external block

Forgot to remove @no_msi?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

