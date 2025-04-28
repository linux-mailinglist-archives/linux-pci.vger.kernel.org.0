Return-Path: <linux-pci+bounces-26891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0BA9E67F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FE1176063
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C25192B84;
	Mon, 28 Apr 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKLpsuRl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA418E02A;
	Mon, 28 Apr 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810824; cv=none; b=il/MXHEcnwvRuHfYpuqTiTTR+korUMCvoYA2R+3cwwxOWhsuKxcx38OxgJQlTjeBgOmXpgzxiS31mCZ1gvSHRmruf9zxB0afkPcIX5Wc83w1vdGbMZdAHb2pnFlK6mZQrjUbhDc6kOA58ml2qtCTFi+KvG+NbkFA9TA/o+NjTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810824; c=relaxed/simple;
	bh=r/8So3UcgNUvbdUJRjKs10nCNkoHkZO0UYie2/dD5Zc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GS6/FWvA++/FdqILeUQEmU69ghC1E/TRttA2GfRm2SDDjhPT2VAriTDTkQCFWJVtvcAZyARfVLA16QVCspPjqqfOdwx3molQIvUmy303MjBdDsWxAAzUxWNVRTCtfV45D216xlMRBkeArPvzR+XxBHfqKe/7K6Xx8skvdnPouN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKLpsuRl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7369ce5d323so3369483b3a.1;
        Sun, 27 Apr 2025 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745810821; x=1746415621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJ6vyOIM9wkdrOEiU106peP/FFpNedc2E4v+uxxalSo=;
        b=eKLpsuRlGJCjCvJkJZH0oh27GSlO/efK4eZKgxP+PARMvYakAeGDoR1fK9FopG7+Z9
         zrFYcudD/ecKgVPtKJlpccqKX0tDyKPGo28wDmVe3zLsTe1d1ITW8b6cmb3zw9hYn3Ki
         huVRUpJwBg3TzG2E3uAzM6Dj/GGBg47RrZbgkrtg5ZXTpKwiii4oMTJpNydmpPcMaHyc
         k9PlzJaZfU/eSiXQtdyJR0+CYaVAbP3+QWtQtwbmDcxWMAwbzE134L+z64pXn+rZ+zmr
         hJcEEf5FhhDKIluuxHAeJXKcMw5Fr+QFjqS2py3dm9aoENcikAENyQpY9xriS86ktM8G
         16Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745810821; x=1746415621;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ6vyOIM9wkdrOEiU106peP/FFpNedc2E4v+uxxalSo=;
        b=ZmitRkMVZFXQ8z7wIHoMm0vpzMDdSeQDdAutvphCe2HAZ/h81RThdJAOyRxpJq+xzQ
         75TVaf1L7bo6LDz7OHIVTAyHUNOLI2xvO2f5T5zx9t1VAI4g8T9rIoioUPqL6NXnAqIH
         /tmIN59r4V44jl8mkIo2bjs7uZxtlbbg6ZGOzqbdZmwqxW7e+t+XkmO2gGSCI1zCtvLF
         iZJ/i35k45Zzf3qVvzkt0vxiAcI/6bbm4C36VUOGIAzcBr67uO/g7OQfU8oUcRqr8dbx
         08pTsSoanjEp0jO/bg/EXp9PuwIijuJmPgSECn0BGJ01/ZhjiLwU9+ktvEyu5j9KXVPm
         /agQ==
X-Forwarded-Encrypted: i=1; AJvYcCV43NkxN7W8WcBAk/ZPtew7SR6NDLhONbzlMPD8jgcYoJs9D1cZEEXbmPFbSstCT05Nfw+TtPVO5SxT@vger.kernel.org, AJvYcCVpIhzcLKXTsgqVWoJh2hMb41ebf3P622ovXsM0fU68mcFw1EYTjIDs6uTB3vG/WCCns5EdNn4HW2qA9Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlFak0f2mt0u2lUxmeIkgKqoyolPXw8l2VqZQ3iwWVfwHA50n
	4DsCdsHtkph70l/qAnK2l1AT++4mXj61GJpHKJVhBcCJNmqbJBgl
X-Gm-Gg: ASbGncuyoanflyirWGuEK9Om/Jyj+rFf1Glk5sIc/7TIytEKSQtVQ67AYduwH5ED3jZ
	SkMHiROYhpsDt/KdJEuksnBz/NUfpeCquBhn/68O9BXkO0gcovEAV5JZEXEtxwsulzHQcK0NCit
	HfjmargefYHxjlCfFO+XQCA+SxQ10AFw0dSozG+VIHO/IyVy5Oouaks37hpR4jDJJRAyucpM85D
	ejKR+kmSBj7q8jKcJ9QP4ndG3eX2w12Oqt4tbAoH2HhRGdEtxYtXzZqa2NpNHY3N8hfK7vclcmJ
	8JkqRF1Mag8Vbi3CA+AbcD9AxDFsv/zrISA0fBeRer2S/0s4P/2xMU89JJiBv829hw==
X-Google-Smtp-Source: AGHT+IGSn8lCAerx7DuOG1U5CfTH5vI5HpaLXLhOBS6XWfNOWxIMc0ZRLqV/T3WZk/YLDAM61fYHPg==
X-Received: by 2002:a05:6a00:2e83:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-73fd8f4e0d2mr13242252b3a.23.1745810821519;
        Sun, 27 Apr 2025 20:27:01 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912ed6sm6961386b3a.31.2025.04.27.20.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:27:01 -0700 (PDT)
Message-ID: <40232d5ef59383dc44fd8b91dbc2b0ba71f1d84f.camel@gmail.com>
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Date: Mon, 28 Apr 2025 13:26:54 +1000
In-Reply-To: <20250427125316.99627-4-18255117159@163.com>
References: <20250427125316.99627-1-18255117159@163.com>
	 <20250427125316.99627-4-18255117159@163.com>
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
> Link-up detection manually checked PCIE_LINKUP bits across RC/EP
> modes,
> leading to code duplication. Centralize the logic using FIELD_GET.
> This
> removes redundancy and abstracts hardware-specific bit masking,
> ensuring
> consistent link state handling.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> =C2=A0drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++---------=
-
> --
> =C2=A01 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index a778f4f61595..bfc47dab32e5 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -8,6 +8,7 @@
> =C2=A0 * Author: Simon Xue <xxm@rock-chips.com>
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include <linux/irqchip/chained_irq.h>
> @@ -60,9 +61,8 @@
> =C2=A0
> =C2=A0/* LTSSM Status Register */
> =C2=A0#define PCIE_CLIENT_LTSSM_STATUS	0x300
> -#define=C2=A0 PCIE_SMLH_LINKUP		BIT(16)
> -#define=C2=A0 PCIE_RDLH_LINKUP		BIT(17)
> -#define=C2=A0 PCIE_LINKUP			(PCIE_SMLH_LINKUP |
> PCIE_RDLH_LINKUP)
> +#define=C2=A0 PCIE_LINKUP			0x3
> +#define=C2=A0 PCIE_LINKUP_MASK		GENMASK(17, 16)
> =C2=A0#define=C2=A0 PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
> =C2=A0
> =C2=A0struct rockchip_pcie {
> @@ -188,10 +188,7 @@ static int rockchip_pcie_link_up(struct dw_pcie
> *pci)
> =C2=A0	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> =C2=A0	u32 val =3D rockchip_pcie_get_ltssm(rockchip);
> =C2=A0
> -	if ((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP)
> -		return 1;
> -
> -	return 0;
> +	return FIELD_GET(PCIE_LINKUP_MASK, val) =3D=3D PCIE_LINKUP;
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> @@ -450,7 +447,7 @@ static irqreturn_t
> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> =C2=A0	struct dw_pcie *pci =3D &rockchip->pci;
> =C2=A0	struct dw_pcie_rp *pp =3D &pci->pp;
> =C2=A0	struct device *dev =3D pci->dev;
> -	u32 reg, val;
> +	u32 reg;
> =C2=A0
> =C2=A0	reg =3D rockchip_pcie_readl_apb(rockchip,
> PCIE_CLIENT_INTR_STATUS_MISC);
> =C2=A0	rockchip_pcie_writel_apb(rockchip, reg,
> PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -459,8 +456,7 @@ static irqreturn_t
> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> =C2=A0	dev_dbg(dev, "LTSSM_STATUS: %#x\n",
> rockchip_pcie_get_ltssm(rockchip));
> =C2=A0
> =C2=A0	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> -		val =3D rockchip_pcie_get_ltssm(rockchip);
> -		if ((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP) {
> +		if (rockchip_pcie_link_up(pci)) {
> =C2=A0			dev_dbg(dev, "Received Link up event.
> Starting enumeration!\n");
> =C2=A0			/* Rescan the bus to enumerate endpoint
> devices */
> =C2=A0			pci_lock_rescan_remove();
> @@ -477,7 +473,7 @@ static irqreturn_t
> rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> =C2=A0	struct rockchip_pcie *rockchip =3D arg;
> =C2=A0	struct dw_pcie *pci =3D &rockchip->pci;
> =C2=A0	struct device *dev =3D pci->dev;
> -	u32 reg, val;
> +	u32 reg;
> =C2=A0
> =C2=A0	reg =3D rockchip_pcie_readl_apb(rockchip,
> PCIE_CLIENT_INTR_STATUS_MISC);
> =C2=A0	rockchip_pcie_writel_apb(rockchip, reg,
> PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -491,8 +487,7 @@ static irqreturn_t
> rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> -		val =3D rockchip_pcie_get_ltssm(rockchip);
> -		if ((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP) {
> +		if (rockchip_pcie_link_up(pci)) {
> =C2=A0			dev_dbg(dev, "link up\n");
> =C2=A0			dw_pcie_ep_linkup(&pci->ep);
> =C2=A0		}

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

