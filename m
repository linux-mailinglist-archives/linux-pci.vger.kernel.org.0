Return-Path: <linux-pci+bounces-30271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8769AE1FE2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE216E06A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14F2E610D;
	Fri, 20 Jun 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="lOMwqZrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061523ABA9
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435970; cv=none; b=mmPrPNEv3NWKiQ1T6NV8v+tMgUfCop2stOtbQsKof4YDyIkBR/L5vl2ayujHoiD1TgSI6lDDqFznUfXTX+Zwv2sOAdjmSLVSHle16aGPqbtYNTR22eGWr0qTOQnqTcZ41a02RtrTMHbAj4mQPmww+TdBWc10CtbfmLz7Jyiz0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435970; c=relaxed/simple;
	bh=dSrlAF32I5lH3btMaCGJWgljcuhVLfSPBYtyqJZd7k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqyWdhE5VcAu7UgaWRBAl9A1d9XMItI3ECbZMLrZYSMffXeXb6Pvrh5P9syCFSfd+Wr5m1kYJsWoFtwiNjzBSCR4eCnziC8dpsxIEYNEj9kDeGCMaxdGVE+QZ2Q/k4u6aGRtEQu5Q2YCak2y5hEXqsTtIL/9ux3xXQ+LSJqVdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=lOMwqZrp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60634f82d1aso508607eaf.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1750435966; x=1751040766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk1h/OSRQW76dr7YBIYqdBe7lZw8tZ9KpxMBcLXXza8=;
        b=lOMwqZrpYw47239a5gbVxV4UugHMwf1jWYglWSLvgqTiklguqYBsn2wxqCMfTtSrjN
         AmcFBn/laW7MYphhKRHo0oAarn9o1QR+vwuxkQO9E8GortvmGYm85lc9AZY3xWb4vLrh
         FEbuY++jPa8u4pfNomINHaafbpPzG0Ypu4z1p6t4yq2J4C7CewxQ8U40mBTEde22Egob
         i7WCwGJPEeU6C0v/EcMlaD5nnCTa6nJwK/ud+AuHMjDnbWk0ZRVDT+FVJVTHRVML094N
         grLzQe0e4EOaOTs3tN4hVuk8wzJGEmG/DIjp+sajNiOqBCCIQa67JEs2IjQiBWxJ4Jxi
         Fihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435966; x=1751040766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uk1h/OSRQW76dr7YBIYqdBe7lZw8tZ9KpxMBcLXXza8=;
        b=kCEAGoAgTvZEBwWncVJFoUkVBTdHBOXRU/i8LJtDCjF6Xdw0JicsP6sLwBLozBJUNx
         6Go49iy2ydFs3pjJVtUQUw2qzWOsRxS0F0qC/F37XvEbIyf5apaTH5ep2zkEPy1lBEQy
         T5dVx/rscNMrBza3aK1W41Q55kmGjSaEJZYqhg+In7O47HVJEJK5q9irB9CsYLsCrbkb
         Sa2aRpHMHW825DUls6HvmqtJcRBsyQ3bRB/AcyGg4nN4/2THkqpANm/R6bTq3NxSrcen
         9PXhf787VJqBr8rkInz53tzY+Ow+YWB1nZyYxym+Jn4QP1eIQLpgcMQoIwjbRag4Kv2T
         8vxg==
X-Forwarded-Encrypted: i=1; AJvYcCWdr6xtG74AWYlwE0PCf/xtW5ziL4GxCZMKc7ou98XCYifZrlnVrhqIhgMkQwvlr7DDTvubqeRkk/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oa58vog7rypBqCrgMPjVXO1o0yf9qIou7zU0feVQ1nnN9CJt
	VWm4EaDgsTt8gbFvk5hwrFp8Zat7cVb2bS/4qT2R5qySi9U47qE1u9Nh54eFUCyuGLUZx0SGcv/
	gC+1x/RGXJuSPVUEqW8axhhNsSA60JWyK6Oz7JktKZA==
X-Gm-Gg: ASbGnctjFgtIDHmhhFW9ESlOvunPvCVyuEgeADeYcq9ofxcPgtn4R8NpQMHj1W9pzaM
	NT+H9kn1t1tRsD+RI9cU9y7wF5WVyqnwTDNaiYQ0EJwz6g6a7iMIoukQl1JpIpr/JgypsP9cLOK
	51bahkIrApIIwQjawc1oTc6bYomRDcedRf3So8Ehlho6I=
X-Google-Smtp-Source: AGHT+IEWHRk01AMNXUO3Iti/LVUHyPY06MPi2HY582F4LaypQ5ZkZqqgLLKeo/FHsS0LAg4XUMcQcmQIpTlGgPfCCxs=
X-Received: by 2002:a05:6820:1e87:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6115b8a077cmr2461053eaf.1.1750435966109; Fri, 20 Jun 2025
 09:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com> <20250616085742.2684742-2-hongxing.zhu@nxp.com>
In-Reply-To: <20250616085742.2684742-2-hongxing.zhu@nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 20 Jun 2025 09:12:35 -0700
X-Gm-Features: AX0GCFupqyePYKY1h7Imt92So6Th1StimJuRSWH0VvVxy1uS8kPjLbLXM76L3Es
Message-ID: <CAJ+vNU15XpyLuxO4EowyqO9P+ZUqNApoH2Wu261iu-5b2GrkGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:59=E2=80=AFAM Richard Zhu <hongxing.zhu@nxp.com> =
wrote:
>
> apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
> Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
>
> Remove apps_reset toggle in imx_pcie_assert_core_reset() and
> imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
> and imx_pcie_ltssm_disable() to configure apps_reset directly.
>
> Fix fail to enumerate reliably PI7C9X2G608GP (hotplug) at i.MX8MM, which
> reported By Tim.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Closes: https://lore.kernel.org/all/CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcM=
HDy+poj9=3DjSy+w@mail.gmail.com/
> Fixes: ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in imx_pcie_deassert=
_core_reset()")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 9754cc6e09b9..f5f2ac638f4b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -860,7 +860,6 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx=
_pcie, bool assert)
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>         reset_control_assert(imx_pcie->pciephy_reset);
> -       reset_control_assert(imx_pcie->apps_reset);
>
>         if (imx_pcie->drvdata->core_reset)
>                 imx_pcie->drvdata->core_reset(imx_pcie, true);
> @@ -872,7 +871,6 @@ static void imx_pcie_assert_core_reset(struct imx_pci=
e *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>         reset_control_deassert(imx_pcie->pciephy_reset);
> -       reset_control_deassert(imx_pcie->apps_reset);
>
>         if (imx_pcie->drvdata->core_reset)
>                 imx_pcie->drvdata->core_reset(imx_pcie, false);
> @@ -1247,6 +1245,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp=
)
>                 }
>         }
>
> +       /* Make sure that PCIe LTSSM is cleared */
> +       imx_pcie_ltssm_disable(dev);
> +
>         ret =3D imx_pcie_deassert_core_reset(imx_pcie);
>         if (ret < 0) {
>                 dev_err(dev, "pcie deassert core reset failed: %d\n", ret=
);
> --
> 2.37.1
>

Tested-by: Tim Harvey <tharvey@gateworks.com> # imx8mp-venice-gw74xx
(i.MX8MP + hotplug capable switch)

Best Regards,

Tim

