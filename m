Return-Path: <linux-pci+bounces-1503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EB81F956
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12ADB22F53
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A3D279;
	Thu, 28 Dec 2023 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xkhfcba5"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F9DDB2;
	Thu, 28 Dec 2023 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703775696;
	bh=f5uBxFja9DMkfap4ZKntPYZpZ4ZCc3Cy9poJ6+NQsxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xkhfcba5stsYFFBMs8uvuCqj7wU29mNZ9esC/bGRgAABwJ4zVcoYhfdAzJOtf0Hft
	 mDdPr/ePtvE/595TqtvTVl4nj+tg9bpDpoN0O2EcUblUiVf7PLx9EGaxZ9YlJy25WZ
	 Kp5QSGeC1PkiYUXgAlL7fFoZ0+gVFQC2z+LMEY6c+49eQSPATck/uFUGdjOuTS/3/W
	 I5WrwvxAsHJkSCapDLqCN8DuSmYa/D/97DqVihNtloLdt1doP4ZCXN+KStLWaNiHai
	 FBVRO74QUSTfoIQGWzRvH8yr+AI7FpiIyCVAOpEr4u8DzIhx0U/fbBPhZIRhVQz+/N
	 AUaTRHkWTT/KA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A87F537813C4;
	Thu, 28 Dec 2023 15:01:32 +0000 (UTC)
Date: Thu, 28 Dec 2023 12:00:59 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Message-ID: <d8cfb804-e47a-471c-8bc0-e974ee045655@notapiano>
References: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
 <20230504113509.184633-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504113509.184633-3-angelogioacchino.delregno@collabora.com>

On Thu, May 04, 2023 at 01:35:09PM +0200, AngeloGioacchino Del Regno wrote:
> Some SoCs have two PCI-Express controllers: in the case of MT8195,
> one of them is using a dedicated PHY, but the other uses a combo PHY
> that is shared with USB and in that case the PHY cannot be reset
> from the PCIe driver, or USB functionality will be unable to resume.
> 
> Resetting the PCIe MAC without also resetting the PHY will result in
> a full system lockup at PCIe resume time and the only option to
> resume operation is to hard reboot the system (with a PMIC cut-off).
> 
> To resolve this issue, check if we've got both a PHY and a MAC reset
> and, if not, never assert resets at PM suspend time: in that case,
> the link is still getting powered down as both the clocks and the
> power domains will go down anyway.
> 
> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hi Angelo,

It seems this patch was forgotten but it's still very much needed. As you
describe above, the Tomato Chromebook (MT8195-based) is currently unable to
resume from suspend due to this issue. Upon resume, the following error is
printed, and the system hangs:

[   67.018281] mtk-pcie-gen3 112f8000.pcie: PCIe link down, current LTSSM state: detect.quiet (0x0)
[   67.027162] mtk-pcie-gen3 112f8000.pcie: PM: dpm_run_callback(): genpd_resume_noirq+0x0/0x24 returns -110
[   67.036791] mtk-pcie-gen3 112f8000.pcie: PM: failed to resume noirq: error -110

And further investigation showed that all PCIe registers return 0x0 when read in
this situation.

Commenting out the MAC reset in the PCIe DT node fixes the issue: the PCIe
registers can be read correctly upon resume and resume proceeds succesfully.
Your patch here essentially does the same as not providing the MAC reset, with
the benefit of us still being able to describe the reset in DT and thus having a
more complete HW description.

But this patch no longer applies, so please rebase it so we can get working
suspend/resume on MT8195-Tomato :).

Thanks,
Nícolas

