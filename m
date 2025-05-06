Return-Path: <linux-pci+bounces-27278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6215AAC2CF
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1443BA08C
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83827AC23;
	Tue,  6 May 2025 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K3vCZy14"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608284A02
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531383; cv=none; b=aGc4mPYvipr0z+wGeVmCjCEG//O0/xe427UcOtspzEyiTeaofbs/58BiYuAlThavwYc0ET8jwuRqjRseiW2SYt7G0lmXf360fxG/wdug65VnpR+bcRFnCzu/lGlNI/VbLoTbVK2zs3Z2eppfGwN7wtBnKbyla1JoLl08Aeu5bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531383; c=relaxed/simple;
	bh=n1y15ggPmlTmYTk4lxrzQIM3LojUkZqNoouqh7PA76Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT8fjArciYPFwqcmfqa2xhsAV+Azz0AYG7bIj9HzruPo09Y8RszUYkCN+k4b4Sq6qws1RvZpI1h3MnZY9mMexV27bhMDMPX+nbl4SAP6QJcY4DX2FwEIAG/GHANxn2jH1SJ2xhs5SxfxAwb624/MuELb9gxWnWM7MdWDJnDuWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K3vCZy14; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1746531371; x=1746790571;
	bh=n1y15ggPmlTmYTk4lxrzQIM3LojUkZqNoouqh7PA76Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=K3vCZy14k5jbFdGrLIREvPiswYrJrBnEHX8fn/aYLHBKObUzVtGecYIujWl0h9zbW
	 oNmSe4HmWO2TVucjFEeP5a/h5aujbtLvRIy1JSG8V3UCNmQd0Z50+rP6tXYQYdWc9Y
	 Ej+W3F3SylUmnLEkAOAJgxGHl8doy/fVJDIGLMax79XnSiGOrYT3udLiPaVJ8XSYpL
	 iyqmddgcFm5y7zuRhI3XGNp43vx7R61/L7W/xKbv8SNUtrxtpsBMeLpvUKtY7Got9V
	 HpPza4rZcl4j361eGtKVf0ZJLR0AUo0XDHBAxOIzBY8M809lUxpIiAS5HV4wIdtsfj
	 IH4AS4Fh6hlNA==
Date: Tue, 06 May 2025 11:36:04 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/4] PCI: dw-rockchip: Replace PERST sleep time with proper macro
Message-ID: <1reFy5Nwl2unAMz8eiJ8N2AJFavSwlPAjjrp8lv7ySl52ZYWZxTnpOfcTyejxHGfWDKFZdp0sKdIrs2v6QQqeEo0xm2hMPSFO_7j2WMOjo0=@proton.me>
In-Reply-To: <20250506073934.433176-9-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org> <20250506073934.433176-9-cassel@kernel.org>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 6be6925127c1ae6a773b742a8e5f443190ea74d1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, May 6th, 2025 at 9:39 AM, Niklas Cassel <cassel@kernel.org> wro=
te:

> Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
> No functional change.
>=20
> Signed-off-by: Niklas Cassel cassel@kernel.org
>=20
> ---
> drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 6a7ec3545a7f..0baf9da3ac1c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,7 +225,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *p=
ci)
> * We need more extra time as before, rather than setting just
> * 100us as we don't know how long should the device need to reset.
> */
> - msleep(100);
> + msleep(PCIE_T_PVPERL_MS);
> gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>=20
>=20
> return 0;
> --
> 2.49.0

Tested-by: Laszlo Fiat <laszlo.fiat@proton.me>

