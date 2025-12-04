Return-Path: <linux-pci+bounces-42638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A9CA4AEF
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C55E30A757E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528D2F7462;
	Thu,  4 Dec 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE5sujLC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431528A3FA
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867923; cv=none; b=FcNVLriPk+fK35zVREsorUMFGkfQ6ijcNKX52fkHlW1a5XNsH6pVte8QMXau6hoI+NYLL+EqkTuEtQDqSM3J4xzqxnfj0qr8n/52YeZUKAdT9yyDnVUB2BpEgsIw/NGTvrJV906j+7kmZmuFLZTNKVf7T37TfbrmYsJOcmNg6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867923; c=relaxed/simple;
	bh=+BQAo96K6gYDK9rIJ5sZBTh5/2wgpYrHzmz36YZ0h9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNldr+t65KdK5IqfusMtfmyRBUqpRMd+FTV8H1+JcKDCaDALbO7TJF60UQCuF+OAn3Abws6J978GEt1HWUTJVL6zjZGd0GxsyGk96tCbLNYWH3tvHXsWlQZIukuZgkcLCgYaLhuPUtdk2Dntd0H5pU7UhQwOUU1jkMaCjxR62UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE5sujLC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so1876030a12.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 09:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764867919; x=1765472719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kg3+GXQJrSRCIpl+szpU9K94sF3dPzVaXSDtfFd90yg=;
        b=iE5sujLCVX5hL6lLbgjGLRPacr7aySzPjaushkueJsEdM2dhnA3z2ZzvDRm3IRT45n
         18qxlJV/txY1YAMk4F8sLQc1ObxLUbMwjJb/pNG7jw+j7XRSb1hRwZL2Y8/4WXFfBJ/X
         ojk7Z8w0ZB3oJwwk9QnVFGhg+4W2kd+VXuaplmDRz3XNa0datV3QfvyC/jKY8UEx/mXL
         4zbnxE299VhS119NdnvPK/+fROF0bgsqphRiVT+5r7tfNLIJgX30Z+AIpEzJiERCBQto
         AIVLGx2hv+XPvDzgC4IJKJjQKChFXU05XfmpUlyCNSxX0Y57D5kRjLw3OAznmLDJlTpi
         8VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764867919; x=1765472719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg3+GXQJrSRCIpl+szpU9K94sF3dPzVaXSDtfFd90yg=;
        b=C3WV9LklT7RRuDrhQn53vNUPYgfVLmBLnUgX6h5783ZRfoDx1aII7gsaaH7QdBq2Vq
         rJzPojO8VOtaKiAV8gn2eapDsr+ZHbQNA+slhMS+B8j+hFNuiHf1L8dEq4rdW1FaUpze
         nOb8UvHPVEDanZuY31k9Rnvtx36nZSVK61iTVxiq2KD2NfiP7rbz4qMMeutd7K3OZwpe
         4K0a4+gr3GOeEQ7toA6WNpVLoiUGjjPhYgJg0QGoH0tzbyFwySUOsw8jNfcy6zzGMR/d
         OS5mdysn5GNfR+vRuOm6VjMP3Mu18HUaMw7rMag0ave971Db23TwzuBgeGFOIF3d1q08
         14Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVX58fuZl92xpiuf4oASBkiD8jmRF1zZDjNYi8zZoMpGEzb+6gf9ZFzIR6fQ1o5BAXrxfRUlNjmsl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0l15DWCh13uzjvkAMecnf2rGAu58EC7Xff9G5NsqmkQYIqRug
	o58qBoYR/7+2rIAuIzKykTSkaOhKuDIUNQVZfEUVSQXyLJ02rnLSUZVcwhUpJfUXt8B0fM1nx0y
	Kqpnwpam6SYWH5kwazxiIE70pBom8IfQ=
X-Gm-Gg: ASbGncs1VeOPFHvIhl28lwfcOUxlRugqL0Q4aSfBzFLqAK8Cfvc+HdOJR1Fpd66SA0A
	J3cNMzEqQoqmnA+qkyx7/sXdsDIyK3pVMkVA+cPVZ8mUIsQbO/fcCttGCLWZVmhOiluSTILPFlx
	k22qIYpix+RkhD2fZFzXHLb3FdhJqfQJHreH+E7IGBejDr++9K86hrMq5mtDOmZ30jzqI1E6IhL
	Q3w7/LTFiYLLx+ewlBMQkNFoe1SRBNwWvH1KFwp/t5mdy/eLRsM86ARx3CYeKS7X79F4A==
X-Google-Smtp-Source: AGHT+IG9AKS27UcSx07KoYOWwja6RVplBXqyc0tOREa2QICJ8kkCeFjeLh3AGbZxmPxO+LrN0uh7FoxQp64DfkzF090=
X-Received: by 2002:a05:6402:d0e:b0:640:ff5f:47a8 with SMTP id
 4fb4d7f45d1cf-6479c3f6532mr5947624a12.8.1764867919153; Thu, 04 Dec 2025
 09:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125075604.69370-1-hal.feng@starfivetech.com> <20251125075604.69370-5-hal.feng@starfivetech.com>
In-Reply-To: <20251125075604.69370-5-hal.feng@starfivetech.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Dec 2025 22:35:01 +0530
X-Gm-Features: AWmQ_blo07jkPZn5svQ8GwL_vHDmoWP8GFySAR6LM46D7PTJjpA9bu9AWt48b7g
Message-ID: <CANAwSgQSBB_yTw5rDz2w6utvjUueWJi9tWUY9oZcpNAT8Wm8iA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for
 VisionFive 2 Lite variants
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hal,

On Tue, 25 Nov 2025 at 13:27, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> Add a common board dtsi for use by VisionFive 2 Lite and
> VisionFive 2 Lite eMMC.
>
> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2-lite.dtsi    | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
> new file mode 100644
> index 000000000000..f8797a666dbf
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +       vcc_3v3_pcie: regulator-vcc-3v3-pcie {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vcc_3v3_pcie";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +};

The vcc_3v3_pcie regulator node is common to all JH7110 development boards.
and it is enabled through the PWREN_H signal (PCIE0_PWREN_H_GPIO32).

VisionFive 2 Product Design Schematics below
[1] https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf

Mars_Hardware_Schematics
[2] https://github.com/milkv-mars/mars-files/blob/main/Mars_Hardware_Schematics/Milk-V_Mars_SCH_V1.21_2024-0510.pdf

Thanks
-Anand

