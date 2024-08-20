Return-Path: <linux-pci+bounces-11882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B2958862
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7212837A5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77F190486;
	Tue, 20 Aug 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtlTyHdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07143AB2;
	Tue, 20 Aug 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162496; cv=none; b=V4w5umU+WfE+IohpGzpF2MmWtZ8FsEjnyhZn5tHg13RxmD973yMSQOk1AWhhgMxoK4v8hp64bpggro9vabYLlAg/gkolU3Vu2Ac/qsVMD79YTM624gasuHbnfTPRVcbEZ4WjbqVkhp06TIO1V27SBt+SnWjuOCBo3JQof2MfGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162496; c=relaxed/simple;
	bh=tMDVgSdrmUt0o/yr0SfdNlxwNnAf8+M9He9ObnMuKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eKfcl9sjQ0idwbkT5vBEq/siMYwkiQxA7s3S1oo50mh6+86QjY1c/a+g22ww7QWHs52AtYz6Bf+zDb96SduC4C6TN0xI+q6M3nP9J6sBhlx+gj5fyEyTfWhnick09Re0EsqOP0YjGxESaS0YrrIrpI8r3BA9SUYMsJa9U2RRkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtlTyHdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F1EC4AF0C;
	Tue, 20 Aug 2024 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724162495;
	bh=tMDVgSdrmUt0o/yr0SfdNlxwNnAf8+M9He9ObnMuKnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QtlTyHdwklxJiNDl1CkBntI64OwQmmIL/QJE+S3XpXS94qiUgxFWHwmyx7NREFN8f
	 fn/3zqHETJtME/zWnFx/z2IMXN4x0fcyg8iDF2cSDA056DwAU1pVjquIqLi2bV3Knp
	 ZFxCUIeFaxW4//jkoo22CwWmfhcDpNG+6Yiq+Y4DDmQRG1TAzIxjKdBOIsq0Bdap0p
	 YLyOGEr8w3P9xW7H5MNW9Z02FwROUpCkvycnQGJdh6uU38f1ZmxdsravoLIUJPM3Vf
	 iocd0Gv9qhHk7/ZYb7wY97K2gb1XN2f13WLE2MtZzTug6sYqV+NF+uzGt74Yk0JoLV
	 wArz/EvMvMuFA==
Date: Tue, 20 Aug 2024 09:01:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 0/4] Add Airoha EN7581 PCIe support
Message-ID: <20240820140133.GA207494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsRX-Hrn2fCITK4P@lore-desk>

On Tue, Aug 20, 2024 at 10:46:48AM +0200, Lorenzo Bianconi wrote:
> > Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver
> > 
> > Changes since v3:
> > - move phy initialization delay in pcie-phy driver
> > - rename en7581 PCIe reset delay
> > - fix compilation warning
> > Changes since v2:
> > - fix dt-bindings clock definitions
> > - fix mtk_pcie_of_match ordering
> > - add register definitions
> > - move pcie-phy registers configuration in pcie-phy driver
> > Changes since v1:
> > - remove register magic values
> > - remove delay magic values
> > - cosmetics
> > - fix dts binding for clock/reset
> > 
> > Lorenzo Bianconi (4):
> >   dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
> >   PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
> >   PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
> >   PCI: mediatek-gen3: Add Airoha EN7581 support
> > 
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      |  68 ++++++-
> >  drivers/pci/controller/Kconfig                |   2 +-
> >  drivers/pci/controller/pcie-mediatek-gen3.c   | 180 ++++++++++++++++--
> >  3 files changed, 229 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.45.2
> > 
> 
> Hi all,
> 
> any update about this series? Am I supposed to do something? Thanks in advance.

No need to do anything, I think Krzysztof will likely pick this up
when he has a minute.

Bjorn

