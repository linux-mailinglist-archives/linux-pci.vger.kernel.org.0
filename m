Return-Path: <linux-pci+bounces-13709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AA598D039
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF32428799C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996971E008A;
	Wed,  2 Oct 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qk7LgcV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BA14F9F1;
	Wed,  2 Oct 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861611; cv=none; b=rV+d+U6nT6PUvvHsJd9JUPuaF8x/Gd71FEJQc6gzeO8T11a3PiyjW/gQcCHzl+IctddFT2OZ0aAl6wNVzaUPpDxockDSJG2h29mFK5hTHorpL7jIxMXOo1oEod5BrWeH0sk/vmXsE0rUSYS/lckjmfZlh+YidTKyyDyn0LwbHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861611; c=relaxed/simple;
	bh=Nq9kP7p2LUwPE7XTmkw3W7IZnvP6w4fKaT6mxZ9wZbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ihtp4zekTCBrLJ2Ag3h8YxEXUs30x/FcmpWzEKTMsBCRT9bJya7COPNE6podr9QFTxV1fkBPfbFRlH9jUjAmxDXx+rVVfaaMV9F7+M6LOxkZ1woFmsio9x2n6Lm36I+VcIdqDg2WYB5ekZRwqOxuIvAgRppFCepMhTEcuz+f7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qk7LgcV+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861607;
	bh=Nq9kP7p2LUwPE7XTmkw3W7IZnvP6w4fKaT6mxZ9wZbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qk7LgcV+pW9t3qtRm5COEeLA9ch6WtSAb+ZcgFbZGRt2ddvzO2NbhOjvkWigZ6Vl+
	 ZXb6qfsXrbEcixpUbKZuGgbOifEIWxdnFXn1b28H1AiA1rIHncT/l74gjZ9Fud9+M8
	 mq1FlUBf/Sh56oxviFwCXtEULXt2s+u4YW1S9tb1R3gA3u5ubmQeY0rYbp0zobJ1xA
	 2Dqh8k1fwRHQtXD2oQ4/t1qxU8ZuTfWLaJXbvknO9MS6tVD8D8ks0Scmm+4GCcPznW
	 JKMLkAPhWb5KVqes7ikdEMvxuoRIv1bRiV0UePgn+Fc6mOlPCaAzo2bfl/kx7HCKXR
	 sDO2hVr8wREDw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7E5A17E1201;
	Wed,  2 Oct 2024 11:33:26 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Fei Shao <fshao@chromium.org>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Bin Liu <bin.liu@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Conor Dooley <conor+dt@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 MandyJH Liu <mandyjh.liu@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Xia Jiang <xia.jiang@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Subject: Re: (subset) [PATCH v2 0/8] MT8188 DT and binding fixes
Message-Id: <172786160676.39477.16621812934064031504.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 01 Oct 2024 19:27:18 +0800, Fei Shao wrote:
> This series is split from a previous series[*] to focus on few fixes and
> improvements around MediaTek MT8188 device tree and associated bindings,
> and addressed comments and carried tags from the previous series.
> 
> [*]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.org/
> [v1]: https://lore.kernel.org/all/20240925110044.3678055-1-fshao@chromium.org/
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[5/8] arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
      https://git.kernel.org/mediatek/c/ad9d9e15
[6/8] arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
      https://git.kernel.org/mediatek/c/c1134cbf
[7/8] arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
      https://git.kernel.org/mediatek/c/66c466da
[8/8] arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties
      https://git.kernel.org/mediatek/c/08ea5de5

Cheers,
Angelo



