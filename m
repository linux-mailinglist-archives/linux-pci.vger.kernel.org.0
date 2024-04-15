Return-Path: <linux-pci+bounces-6296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BB8A5C10
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E1928183B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE37215686C;
	Mon, 15 Apr 2024 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZFANBZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20E15666C
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211843; cv=none; b=o5V/G4F5sNp31HCUu6MCQ4HkcXWyb2aWaVF9JXe5kLZSvOvc98ExJMPHC7L5MUbGA7ey0IT46dAEF/l/V0dUYXPzmrZrjhHs4M0kV9O3K6dNI5h3w14VIB+QO2mBkRBMJLOKIhkJ5KtkFfOcK9d55SLYh8EI2p3unmsnbYke8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211843; c=relaxed/simple;
	bh=HlV7PNxjhHZXhDEySUcwKrxlmqDtJcya54wZ5/zd6IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alNixvh/OIvMgkC7onPXTlfXw2AG4MRr6wcPgNfX7gDmQlvg5XUtCexwi0nAg7Z6cE+KRKMyWQblyqikb3G0ci9k8KkHRT8TqkWJISfgjkJuWSmbhLL9BiqLk7/lj2TOMiIVA/Ytt+HyJdYuqm3nsAZXMQtBrjTHNG/JA0MV734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oZFANBZw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed179f0faso2828276276.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713211840; x=1713816640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+78Ths3N+m/trnfB/LCX44mWfPui51vN9doYTN2NYM=;
        b=oZFANBZwkHu8WvJVRRD+CRFuevxDlhxI+A9lkRvRlSigCwdUAO6hZfxFwTWQ7u7eXB
         AlypVnLUDVa3aaGgnP7RpSVsZv+mcEQUHEG7mXmt7mDySMdaUwlq9JvfkfiaHArMI7Dr
         vKkTldcwX5Aa1iAuY5QBrEVsPuzyWkx+5nsbH2PpaeknYgiMoLk4cSTHiF0dv1vFGj6H
         2MG9Lu2ILCx7ucX1q9UMJ6kaJouIo5EMz+LNzRYWmVV/bOHD8ej6K8gu9nXS7OcumUjd
         6LaZKON0FXWLW0m3ohDAJmpX4AmRymqrQK/qrrsc+S1H+xn30xG0r7SX64FbmIwe+HQv
         aYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211840; x=1713816640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+78Ths3N+m/trnfB/LCX44mWfPui51vN9doYTN2NYM=;
        b=Ih9Tt3cXH8fflqsPmK0DrpskPontOXGeQlJ62HiClVgM7dmWtgLZ3ukEwojAAKCpfH
         qeN6YToZ9aU0UvWT6BsuDQtIMiwWETXtoKXItY1fUP5mVg3As9DvVUHTtoF46X37COq7
         kvIdSWTNbTqxgJc0Yl3vOJcGKpUnwvf6OqZ1Qm3kj5P9KzQepYCrNehfP6DTjYD4deMN
         5MPAwb4Vr6sV/4gSkk+/Opw4P4h4dBisupT77/ZjsorJV8JJ/Z+VLNULHBkv+5bj3n4s
         UgyPb9ekDzfVGANMDBQoZ1WquYzlO9lhDY0wdIoknzIPil7+3WQVhZRTgWPFTW2Tcl9F
         AIOw==
X-Forwarded-Encrypted: i=1; AJvYcCXpb4z5ApUW+DJhv19aSULQqax7AJcPI8u3c1wY9gKbtoQm3lnlZm/A3LoN34n3wwSjEbN6g0RdS1eQO1eF3qhSNdmjGRFnw8b6
X-Gm-Message-State: AOJu0Yw/CDdxpmTqETxORJ/fgtHlnIA7zAq4LnoGm/6jh8vtJzujOMIt
	j74V9WEvOjNGtF5pgs/fefyNUa4evqYL9bZZ4ceiTXRYreULw+GDQxBn1dCw0eIdWp+IeU0l7m4
	9sq4V3d1qIleZOl7szz1Qctji8DdJHtI65xWUKA==
X-Google-Smtp-Source: AGHT+IF3dCILXKJoWIQJ/KpG+i09kWimSM1ct7OC41doCnBTN0/8ltTd5BS3mmOyeIOPSukUr96ntaZGG8MklU++vOk=
X-Received: by 2002:a5b:90e:0:b0:dc2:23b1:eaef with SMTP id
 a14-20020a5b090e000000b00dc223b1eaefmr36360ybq.18.1713211840182; Mon, 15 Apr
 2024 13:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-7-mr.nuke.me@gmail.com>
In-Reply-To: <20240415182052.374494-7-mr.nuke.me@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Apr 2024 23:10:29 +0300
Message-ID: <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>
> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> being reused from IPQ8074 and IPQ6018 PHYs.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>  2 files changed, 149 insertions(+), 1 deletion(-)
>

[skipped]

> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>
>  /* list of clocks required by phy */
>  static const char * const qmp_pciephy_clk_l[] = {
> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"

Are the NoC clocks really necessary to drive the PHY? I think they are
usually connected to the controllers, not the PHYs.

>  };
>
>  /* list of regulators */
> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x1 = {
>         .rx             = 0x0400,
>  };
>
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> +       .serdes         = 0,
> +       .pcs            = 0x1000,
> +       .pcs_misc       = 0x1400,
> +       .tx             = 0x0200,
> +       .rx             = 0x0400,
> +       .tx2            = 0x0600,
> +       .rx2            = 0x0800,
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
>         .serdes         = 0,
>         .pcs            = 0x0a00,
> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>         .phy_status             = PHYSTATUS,
>  };
>
> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
> +       .lanes                  = 2,
> +
> +       .offsets                = &qmp_pcie_offsets_ipq9574,
> +
> +       .tbls = {
> +               .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
> +               .serdes_num     = ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> +               .tx             = ipq8074_pcie_gen3_tx_tbl,
> +               .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> +               .rx             = ipq6018_pcie_rx_tbl,
> +               .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
> +               .pcs            = ipq6018_pcie_pcs_tbl,
> +               .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
> +               .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
> +               .pcs_misc_num   = ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> +       },
> +       .reset_list             = ipq8074_pciephy_reset_l,
> +       .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
> +       .vreg_list              = NULL,
> +       .num_vregs              = 0,
> +       .regs                   = pciephy_v4_regs_layout,

So, is it v4 or v5?


> +
> +       .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> +       .phy_status             = PHYSTATUS,
> +};
> +
>  static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>         .lanes                  = 2,
>



--
With best wishes
Dmitry

