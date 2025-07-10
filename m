Return-Path: <linux-pci+bounces-31841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E8B005F3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 17:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD58E188E230
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327F271450;
	Thu, 10 Jul 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="SegZ+jEG"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D9154BF5;
	Thu, 10 Jul 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160050; cv=pass; b=EP1B4NqLph3N6u/vdDKG+SqQyvCfSP4KXYwpoaKRNr2FwNqHLGeVzLix8VRcbJf44WQiGMtE3vgvvy9Jx1+ZI0s4XDl35euBbZH6q5c0dc0QBLjAIdLWNeHZvUU/G8luoBW7e+RWaddWmBhc3MUVtqbP6EHCUXZ95Sb+t7j+k4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160050; c=relaxed/simple;
	bh=te+QesjkfZV1lnlFSbAdZUz3r0Wrt/PT7jvFYDjXsLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIXKKIyPYnINmPYmwInfxalN2g5OJEJD8qx1R/Ui0uuEwd/+xtENLLJ15/CAoCyhQx+R/TCAlkcMgdn/y+XRR+GfRQqojQv8xoloJ51PEUnMuEwo6RiGb7wvPxx4L5sdxw2mX1VqLPt48VPtkdi8+09lkvNzhH14u2Y3TLCn6bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=SegZ+jEG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752160019; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S/0iPgFLijaC9J1SwO3PwYiSYcnmJnoh7LyfCLclhEGFat2r5o5h6hkRZ00xs9jvgJaBzrx/wfGKwW7Tsid1TQkup170oc4FkoFvrgOa913I1ISVb7Y4m/6lHeXsmnixUXzcnKYpE4XGGKevJHW3rIdFaSZcy0lobv5wNKiRDU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752160019; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=te+QesjkfZV1lnlFSbAdZUz3r0Wrt/PT7jvFYDjXsLY=; 
	b=SvUMtILhxfUcBl3kHOzXxrAxM7XL90wIGK2L8XhjrBPGOR+6xDkO++k3BOj7Erh+D/RX0eE7XaLIjwNAweN1NmukV9Vq61B5zKYRYSSkhYff7w9DTuvCh0Gj1hfQMRTIzzEucpU5eFN0OLAG8Agj0S1POaBKNUQUjE4htGp89so=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752160019;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=te+QesjkfZV1lnlFSbAdZUz3r0Wrt/PT7jvFYDjXsLY=;
	b=SegZ+jEGaeYh2x8qxxp/zI4F2eiDdyq2us7x+BjvoH2y6Dz0plBcsy3m+2cIxu9j
	EEA7n7Rz5+CxCensMoTLJ0kSBbXrNetIJMIx9pUrOA4Kmc5x6KpVFWqV2Lze3cDwqDu
	sqNKoqNAM21T8ewgtKmqzfgfusFVA6+fdOVsStRg=
Received: by mx.zohomail.com with SMTPS id 1752160017391654.4434834354436;
	Thu, 10 Jul 2025 08:06:57 -0700 (PDT)
Message-ID: <6c132018714402d0a46fb8b59c862fb7f96a77f8.camel@collabora.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert MAC Reset only for a delay
 during PM suspend sequence
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Ryder Lee	
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Manivannan Sadhasivam	 <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas	 <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Matthias Brugger	 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Thu, 10 Jul 2025 11:06:54 -0400
In-Reply-To: <20250709-mtk8395-fix-pcie-suspend-v1-1-0c7d6416f1a3@collabora.com>
References: 
	<20250709-mtk8395-fix-pcie-suspend-v1-1-0c7d6416f1a3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Wed, 2025-07-09 at 17:42 +0200, Louis-Alexis Eyraud wrote:
> In the pcie-mediatek-gen3 driver, the PM suspend callback function
> powers down the PCIE link to stop the clocks and PHY and also assert
> the MAC and PHY resets.
>=20
> On MT8195 SoC, asserting the MAC reset for PCIe port 0 during suspend
> sequence and letting it asserted leads the system to hang during
> resume
> sequence because the PCIE link remains down after powering it up:
> ```
> mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state:
> =C2=A0 detect.quiet (0x0)
> mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback():
> genpd_resume_noirq
> =C2=A0 returns -110
> mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110
> ```
> Deasserting it before suspend sequence is completed, allows the
> system
> to resume properly.
>=20
> So, add in the mtk_pcie_power_down function a flag parameter to say
> if the
> device is being suspended and in this case, make the MAC reset be
> deasserted after PCIE_MTK_RESET_TIME_US (=3D10us) delay.
>=20
> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

--=20
Thanks,

N=C3=ADcolas

