Return-Path: <linux-pci+bounces-41479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFAC67C4B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 07:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3172E4E2CCF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392F2ECE82;
	Tue, 18 Nov 2025 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="li9ou6xr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59A2DEA8F;
	Tue, 18 Nov 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448361; cv=none; b=WU+62G3gMO9SEXaXeA3TECAN1ijjw/+f2ObhPr5pKcdOzgC57bvTQ2sd7xYVTpqjrQYQiDnwT7MMDKVIwr/rrW2Ym4uWIvjx/5X4MQTnPRaxCjT260kwODsiE6rAm3luxpGif6JNyIG41SGREkdrEXIpsl2+ypQoFv3ry5HPLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448361; c=relaxed/simple;
	bh=PSiUpa/eDkNZRBNCEBFgVrc9bSKxramRSEbePZoOX1c=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=IAG/tQeTt5neuym45ZfPJxq1k4yzi4cLYrhbYPNOvQUY6wAHDkrBzavFbFYHQecb1p3QWi6uQF5+MTFZ6/dwlkGsPaJeeTHALFkGu3F/LEZ/ra7D9HaNk0YHkxIkrOIhab3rarTGyZhcuBaK5snoQlrjwr0K6ax6SM8SZT6FouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=li9ou6xr; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 714004103E;
	Tue, 18 Nov 2025 07:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763448350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=oza7QOE7STENTsJELxhbxHGoxqd5ZR6iMq7QEFYudIk=;
	b=li9ou6xrplD4MYbzDfkTc1D7NTfJU2VUnP4HVmRY9YIr05y8/wiiH+UWnmjQywITY3UrrD
	i90LEN67mmU7jeDZeMqnDA6fo/5ejlzI8RPO6cmxn+JLcZAE5I86t+poXikES4Ccxh+E+p
	+3yQVS+vkClHN2T6s2Xh1mpe64KIsBM+ZEU+eYHJtrVw11OVX/IokCW2kNK3DGIWd5QFIB
	mGeG/C+oEYFyTNahUOol0r2k8GTPVRNmzMQGRMHhx789UuvC16teo+la/AReO+yfXTMWNv
	HPXtqeMaJI92lm9gq/nFI9dZ3q71ESg5X8RMpC4KMuWF+Z7rx7RvEjVlZo5M0g==
From: "Dragan Simic" <dsimic@manjaro.org>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 18 Nov 2025 07:45:45 +0100
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e5d5c0dc-81d6-ae0e-7552-c2e4fb39bb0a@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 0/4] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_5=2E0?= GT/s speed may be dangerous
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

Thanks a lot for the v2!  Please, see some comments below.

On Monday, November 17, 2025 22:46 CET, Geraldo Nascimento <geraldogabr=
iel@gmail.com> wrote:
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core. Even if the odds are low, to contain any damage,
> let's cover the remaining corner-cases where the default would lead
> to 5.0 GT/s operation as well as add a comment to Root Complex driver
> core, documenting this danger. Furthermore, remove redundant
> declaration of max-link-speed from rk3399-nanopi-r4s.dtsi
>=20
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

As a note, Signed-off-by tags are redundant in cover letters, because
there's no source code in them that can actually be signed off.

> Changes in v2:
> - hard limit to 2.5 GT/s, not just warn
> - add Reported-by: and Reviewed-by: Dragan Simic
> - remove redundant declaration of max-link-speed from helios64 dts
> - fix Link: of helios64 patch
> - simplify RC mode comment
> - Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/

Technically, you shouldn't have included my Reviewed-by tags in some
of the patches in the v2 of this series, because the patches were
either modified significantly since I gave my Reviewed-by for them
in the v1, or they were actually introduced in the v2.

However, I checked all four patches in the v2 again and everything
is still fine, so just to make sure, please feel free to include for
the entire series:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Geraldo Nascimento (4):
>   PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
>   PCI: rockchip-host: comment danger of 5.0 GT/s speed
>   arm64: dts: rockchip: remove dangerous max-link-speed from helios64
>   arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r=
4s
>=20
>  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts |  1 -
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi    |  1 -
>  drivers/pci/controller/pcie-rockchip-host.c            |  3 +++
>  drivers/pci/controller/pcie-rockchip.c                 | 10 ++++++++=
--
>  4 files changed, 11 insertions(+), 4 deletions(-)



