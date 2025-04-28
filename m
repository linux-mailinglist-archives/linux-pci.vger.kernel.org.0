Return-Path: <linux-pci+bounces-26892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7BA9E681
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 05:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15772189ABEB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C3191F94;
	Mon, 28 Apr 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxzsVEMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699362AEFE;
	Mon, 28 Apr 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810914; cv=none; b=H4bSQ+KtaVgF2fViKs1jEBXw0oWnyWZDi57UQlXAEkNoHGy6556CGg4R6SFQt5uUPTfx99eGLt5QvzbaT8vbCom9ymD87GRIBhYChXSz6Yv00BgsF6xhyztDk/llqsLKOIBwTrdgOIExixyZYzvOw32JxQrADP24NMLGbapCKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810914; c=relaxed/simple;
	bh=j9T1Reiv7wtpM0xGPRvhNh/mxeeF6hN7TS7Eadaq98c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjn3zjD3GJw/hq1lywSffC8BlfB5Nx0E+qA75oCfvJNIN04ZT4g66dgtEMu2zrxysGm2SJDX+FuyW+mq0p+npBRSfDZ3FqeFlXlIOpp5vwJWuL978gbXJ3c6Cxsub76xFnbHgq9wgdjb+PreoPPMjSmtVLDhU+UtnFfrgeTq2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxzsVEMK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736bfa487c3so3504749b3a.1;
        Sun, 27 Apr 2025 20:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745810911; x=1746415711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5Q9fuybEUTDIxLrBP9D0OFcpvP5/dYYz5nqQrm+/wc=;
        b=ZxzsVEMKlwpf35szUh9QbgM8f/Lq3pur64bJLbxxPuTx5KqgF5aC/Zpn0CleIw2+7J
         FBQ0dIIBB4OgsIzA/3sXcEYxCzpYpVHvtcFD+VnjC5JNx32nK89rjHb3FpGLR0f3iwvk
         cw3ICTGqA63i8icAfoeib+umCsR5z0KpM75niWEUghe5CyJ+CXaGZqF7gB1lPmyBtJHj
         MrsDfaUokvpm4iz6gk09E5Zq+GUo2f7wCGAVw75JBj/cVClGNgqfakrrHdW+rrUYEIAo
         PnjYeAKwd2BTALu70I+nAxSsIQ4GvfgBW4swNszYW5y9I/l0HP8Hc9wXhwc4Asv06iJq
         BuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745810911; x=1746415711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5Q9fuybEUTDIxLrBP9D0OFcpvP5/dYYz5nqQrm+/wc=;
        b=bFBOkRxIMopP0y8sPH8RfJ10KWtqEp0SR2oINL8VZzqlznJFtzyN+6wl3I6E3gNaX+
         GFnAjzw2heLS5ZxQQU607Ed4+1iWMPBng52xvWuka0F2IJIwgRaD/edMcLSEFJWqCNCI
         hMfGObbLF5+l00ib6F+yiXjSflyefdvkG+CokXu0957EDeqLscFiA156+RwpNcmVmiVB
         CFBURNbVhnq05auouuHMfDWL6iG0fYAXhtXkub+rtYxGFo3360KcupCsd1Cne7yu82Y2
         o9T46VjV4aXKUbOPT1hvxDFda9LpPoE4KqxKejWURgh3VCFfUWT/TAGXSARf+hWX1OiB
         CL0A==
X-Forwarded-Encrypted: i=1; AJvYcCXE3PUea279T6c0EVtzDmCKkInR9uNI5x0f39pvq/aTtnjPq3dFRCsaLpCuaUGEPchVc+q3Ub4hIqG5oVo=@vger.kernel.org, AJvYcCXXpXjroguO9ObqsPC3alOsWVu7fVfKjauVTJp59cg/l2Rg+Y4vfoJzAQIzZEH6TZ5rLx6dteJOJvVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyriDftJZMwPRIcC7BDCKm1bK3kfXhnkOT1T93FYwWVyXzwqKTs
	YsQUyOOrqpw6smV87V/wiH+6mQ2eRD5n3pld50GAu6kCuMJX7sQa
X-Gm-Gg: ASbGncu0sslPWO50Ib8StdW73w1wDmILfz8ipqC5Pc0zKvmj6ZE21svkbFMB5FQJWyV
	g4EBiCaUSPwofgtIrnM6i4ItIUQ0cpWi3xkRen43b5JK/oWwKaqJtAobVJ2xPb9A+NzyOurnU0r
	gYWy2ZkH9Vt/x0AJT9nqvplAU1jLq0okbiae8ux6GvZMdBOF+Zp8C/Z5sGda7RR8pPaX7d6V/GO
	20AtUgyL6rlgeM40oIpAG4qGqFNlrfBn7SIkW+cCum80uAEZAYIDGBwihuHnF2bOY8/eRE+lBVR
	4MBvBHtFdtOfkmatjKFc+tNPfTxOHIGjayDWf/mo8LhnEnzmze4svJg=
X-Google-Smtp-Source: AGHT+IEbxs/4V9TZnrbGIxSSQDdBr6hgNCgTC0sP8McrXgtriENdhKpXL/j3USePpUKA4WH5weOwTg==
X-Received: by 2002:a05:6a21:9984:b0:1f5:8d3b:e272 with SMTP id adf61e73a8af0-2046a404462mr8961207637.1.1745810911645;
        Sun, 27 Apr 2025 20:28:31 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acc4casm7148852b3a.172.2025.04.27.20.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:28:31 -0700 (PDT)
Message-ID: <9e9ff312eb019bce9f6c31ebda4e1aa6b1a91f33.camel@gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: dw-rockchip: Reorganize register and
 bitfield definitions
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Date: Mon, 28 Apr 2025 13:28:24 +1000
In-Reply-To: <20250427125316.99627-3-18255117159@163.com>
References: <20250427125316.99627-1-18255117159@163.com>
	 <20250427125316.99627-3-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-27 at 20:53 +0800, Hans Zhang wrote:
> Register definitions were scattered with ambiguous names (e.g.,
> PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
> hierarchical grouping. Magic values for bit operations reduced code
> clarity.
>=20
> Group registers and their associated bitfields logically. This
> improves
> maintainability and aligns the code with hardware documentation.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> =C2=A0drivers/pci/controller/dwc/pcie-dw-rockchip.c | 49 ++++++++++++----=
-
> --
> =C2=A01 file changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index e7d33d545d5b..a778f4f61595 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -33,24 +33,37 @@
> =C2=A0
> =C2=A0#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> =C2=A0
> -#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> -#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
> -#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> -#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> -#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
> -#define PCIE_CLIENT_INTR_MASK_MISC	0x24
> -#define PCIE_SMLH_LINKUP		BIT(16)
> -#define PCIE_RDLH_LINKUP		BIT(17)
> -#define PCIE_LINKUP			(PCIE_SMLH_LINKUP |
> PCIE_RDLH_LINKUP)
> -#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
> -#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> -#define PCIE_CLIENT_GENERAL_CONTROL	0x0
> +/* General Control Register */
> +#define PCIE_CLIENT_GENERAL_CON		0x0
> +#define=C2=A0 PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> +#define=C2=A0 PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
> +#define=C2=A0 PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> +#define=C2=A0 PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> +
> +/* Interrupt Status Register Related to Legacy Interrupt */
> =C2=A0#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> +
> +/* Interrupt Status Register Related to Miscellaneous Operation */
> +#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
> +#define=C2=A0 PCIE_RDLH_LINK_UP_CHGED	BIT(1)
> +#define=C2=A0 PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> +
> +/* Interrupt Mask Register Related to Legacy Interrupt */
> =C2=A0#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> +
> +/* Interrupt Mask Register Related to Miscellaneous Operation */
> +#define PCIE_CLIENT_INTR_MASK_MISC	0x24
> +
> +/* Hot Reset Control Register */
> =C2=A0#define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> +#define=C2=A0 PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> +
> +/* LTSSM Status Register */
> =C2=A0#define PCIE_CLIENT_LTSSM_STATUS	0x300
> -#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> -#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
> +#define=C2=A0 PCIE_SMLH_LINKUP		BIT(16)
> +#define=C2=A0 PCIE_RDLH_LINKUP		BIT(17)
> +#define=C2=A0 PCIE_LINKUP			(PCIE_SMLH_LINKUP |
> PCIE_RDLH_LINKUP)
> +#define=C2=A0 PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
> =C2=A0
> =C2=A0struct rockchip_pcie {
> =C2=A0	struct dw_pcie pci;
> @@ -161,13 +174,13 @@ static u32 rockchip_pcie_get_ltssm(struct
> rockchip_pcie *rockchip)
> =C2=A0static void rockchip_pcie_enable_ltssm(struct rockchip_pcie
> *rockchip)
> =C2=A0{
> =C2=A0	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +				 PCIE_CLIENT_GENERAL_CON);
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_disable_ltssm(struct rockchip_pcie
> *rockchip)
> =C2=A0{
> =C2=A0	rockchip_pcie_writel_apb(rockchip,
> PCIE_CLIENT_DISABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +				 PCIE_CLIENT_GENERAL_CON);
> =C2=A0}
> =C2=A0
> =C2=A0static int rockchip_pcie_link_up(struct dw_pcie *pci)
> @@ -516,7 +529,7 @@ static int rockchip_pcie_configure_rc(struct
> platform_device *pdev,
> =C2=A0	rockchip_pcie_writel_apb(rockchip, val,
> PCIE_CLIENT_HOT_RESET_CTRL);
> =C2=A0
> =C2=A0	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +				 PCIE_CLIENT_GENERAL_CON);
> =C2=A0
> =C2=A0	pp =3D &rockchip->pci.pp;
> =C2=A0	pp->ops =3D &rockchip_pcie_host_ops;
> @@ -562,7 +575,7 @@ static int rockchip_pcie_configure_ep(struct
> platform_device *pdev,
> =C2=A0	rockchip_pcie_writel_apb(rockchip, val,
> PCIE_CLIENT_HOT_RESET_CTRL);
> =C2=A0
> =C2=A0	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +				 PCIE_CLIENT_GENERAL_CON);
> =C2=A0
> =C2=A0	rockchip->pci.ep.ops =3D &rockchip_pcie_ep_ops;
> =C2=A0	rockchip->pci.ep.page_size =3D SZ_64K;
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

