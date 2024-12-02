Return-Path: <linux-pci+bounces-17505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0C9DF9DC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 05:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F4162A59
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104F1F8ADE;
	Mon,  2 Dec 2024 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mgH1bsQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB51494DD
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113492; cv=none; b=bmFbNWHoghpzjbLD0/j4j07PphBMmfLkIFwNIvlpjLREX9BHsaELQqZ7AT56gnvzSW2sg1c2Y388RS8EV1OWANDxJcetMk5xeFyOyGVLC6DarbCAguuZT/wjyz9azQMyKIE5zDTNAHECtp/3CTMhKOdw6o8OLW8qYYoGsbCqzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113492; c=relaxed/simple;
	bh=9BePlhVh1m9blV8z0hlxeXthOqOD+wGWyUCUxDq+MQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAzqMSpZm4qVdoR7qlHqRpP1Z/vwwyOnhkKBQSIuKg6IrJv/A2m7g7HsWQhZXmbA3/LegvxVWPezNIhi6Z4BYg2E5+TRrr2t8cdyrgmm4ahLeldY9z1tQj8m1018TOGvRZ/a0PbSp9gGMlDomeV3tCICbhIWZ27KYLtvhe2F9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mgH1bsQC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so6081237e87.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Dec 2024 20:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733113488; x=1733718288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jem2dHb0CIqQfqKZWUZqxzpx7Oxum1MlxW1zvUuUsw=;
        b=mgH1bsQCodit3ixwsTKWdBu/YQVoY1AcxL1GR0u/KTMpvViBMW+GTtSmCBNU9LHez6
         Zuu9/2KrMnG/8XIYC8VEZwYxQxj7wHyTzX2nM9bCk1COr1ASzpI3t+vwykyAcjVDnTF0
         AO5qdQg+oMJnSQbBbR0rz4FUCmcExD654YNYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113488; x=1733718288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jem2dHb0CIqQfqKZWUZqxzpx7Oxum1MlxW1zvUuUsw=;
        b=Eq8sQvHdG4+Wk85jNhNSPenY9nOfcX17T2qVYiDSZSQ2DDpDETL3qzyRGgfpECLCRS
         V6tr/WdhJagp7K2t9GyDXQP3PK/1dZ0Op5wXDk9tIEtq7iJj9d0mXEE7kcutKfhflQhE
         uHVNpk5BwsxQkshzKEjFS/mWUCUNQKsTXAhAYIV9bq5pfeBVK6yF7boWWBMHblT1P6aE
         OCk7rO/IeEiHG7y6AVzqAkxBRMa4IsAa3S+JXjohcVtnIDYlszWBaj1SomwCDFZJKdCN
         MY7B515bkrMHyFPcd2un8UXagCOfT4sT2xT7uh9K8knuOEnEcWO94VgPbVzgYAAoT9S/
         5dWA==
X-Forwarded-Encrypted: i=1; AJvYcCUg/PwIz3LAuaAde6KaffUez//4MwJOm5RkduVjJVddhdtCC4GN6x/ImTPlGIJHbE/ZOOvqLLzjl8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciMELyLJzcohVhfreLWazJ9C9dUM/1dXy3NIAhoKmkyks3n4q
	m+IAonO6fBHY+eoJzyFhG5ehgLd/lIbAEiKIsDvbGURvhVKUdq1iQoO15P55Q0E0Si9HwcvWAS8
	aFMqjdO/WTNbc8L4dHF/MgxCisiYVauBAOcMJ
X-Gm-Gg: ASbGncvd3Th7sgH+OgyKDbi2+BgL5708BlBtNt7U27AHvGp/DvhW6pNuBsXwYic+90o
	1ZOPY24G//hEIlNr1wz1BDM+CW68Db1Je6XA0Nc9pv+m6eB1SgcNDOQcqMvk=
X-Google-Smtp-Source: AGHT+IHt/vITEDYHnbNLIeuL8UfGCtEad48V6Gq5+hXkXt9A/7GYxhY5NyWdbJAiTmoRwPFhqaSLnctzzSQH8pUcJcs=
X-Received: by 2002:ac2:42d1:0:b0:53d:f09e:9a1d with SMTP id
 2adb3069b0e04-53df09e9c34mr11711959e87.31.1733113487710; Sun, 01 Dec 2024
 20:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001113052.3124869-1-fshao@chromium.org>
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 2 Dec 2024 12:24:36 +0800
Message-ID: <CAGXv+5E4=dKkUo73x5vCMHawcr9AUd71LyLmDbdyOdJZv0ZBaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] MT8188 DT and binding fixes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Fei Shao <fshao@chromium.org>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Bin Liu <bin.liu@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	MandyJH Liu <mandyjh.liu@mediatek.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Xia Jiang <xia.jiang@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 7:31=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote:
>
> Hi,
>
> This series is split from a previous series[*] to focus on few fixes and
> improvements around MediaTek MT8188 device tree and associated bindings,
> and addressed comments and carried tags from the previous series.
>
> [*]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.o=
rg/
> [v1]: https://lore.kernel.org/all/20240925110044.3678055-1-fshao@chromium=
.org/
>
> Regards,
> Fei
>
> Changes in v2:
> - new patch to MediaTek jpeg and vcodec bindings
> - new patch to move MT8188 SPI NOR cell properties
> - revise commit message of vdec power domain changes
>
> Fei Shao (8):

>   dt-bindings: power: mediatek: Add another nested power-domain layer

This one ^

>   dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only

>   dt-bindings: media: mediatek,jpeg: Relax IOMMU max item count
>   dt-bindings: media: mediatek,vcodec: Revise description

and these two ^ have not been picked up, and now v6.13-rc1 has DT
validation errors for MT8188:

/ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
syscon@10006000:
power-controller:power-domain@15:power-domain@16:power-domain@29:power-doma=
in@30:
Unevaluated properties are not allowed ('power-domain@31',
'power-domain@32' were unexpected)
    from schema $id:
http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
/ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
power-controller:
power-domain@15:power-domain@16:power-domain@29:power-domain@30:
Unevaluated properties are not allowed ('power-domain@31',
'power-domain@32' were unexpected)
    from schema $id:
http://devicetree.org/schemas/power/mediatek,power-controller.yaml#

/ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
jpeg-decoder@1a040000: iommus: [[101, 685], [101, 686], [101, 690],
[101, 691], [101, 692], [101, 693]] is too long
    from schema $id:
http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#


Is there any way we can get them into v6.13 as well?

ChenYu

>   arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
>   arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
>   arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
>   arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties
>
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 100 +++++++++++-------
>  .../bindings/media/mediatek-jpeg-decoder.yaml |   3 +-
>  .../bindings/media/mediatek-jpeg-encoder.yaml |   2 +-
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |   5 +-
>  .../power/mediatek,power-controller.yaml      |   4 +
>  arch/arm64/boot/dts/mediatek/mt8188-evb.dts   |   2 -
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  33 +++---
>  7 files changed, 88 insertions(+), 61 deletions(-)
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>
>

