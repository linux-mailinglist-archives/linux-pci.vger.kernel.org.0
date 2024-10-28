Return-Path: <linux-pci+bounces-15494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019C9B3C36
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 21:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DAC1C21453
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434141E04B5;
	Mon, 28 Oct 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InLWI0wz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA881DEFC6;
	Mon, 28 Oct 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148567; cv=none; b=XDcLe8nacOpdgyx5qhblxKd1fzX+yxfRKoMv583gxvKMjjuVBPy8dnEy0fCPCl0DTqs5J0KRSKE7Ojju2jRB7FvpgqV3jOFwZnfXweXVl0j17s2jmkc64ZRiyWmPJAPF8VdT6PWbasq8TpjMqTv6nYc7XdzQGrtUEIPh28wYbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148567; c=relaxed/simple;
	bh=TI+qLJoq5HDIk3wJkvog9/wWZXEwMxh7IdG7SqWr62g=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=RrEWeu8FLMyLWn2pM3enEoazp1vl1DsZ9pdTm5fgJK57CFlFlqLoRlx/VoGZYBQxZB9dK7UM3qWnW4exh+Ee4r/o4GGjDQuEQLKNDUj6CM6YYjwhPpuXSMTPB8yBjI6axemom6RIRmjrN2HymDXELxSfRcIU9RTYhyv9J+tLkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InLWI0wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CC0C4CEC3;
	Mon, 28 Oct 2024 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148566;
	bh=TI+qLJoq5HDIk3wJkvog9/wWZXEwMxh7IdG7SqWr62g=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=InLWI0wzus/bF7/bgWeZzdLCKp+hvAerz0S1tOiJxeNFPOkE+vUVTw0SZnqOFy59K
	 aYC6RD3b8OeWSbffRvHLH3v8PBO6ZgD2rW29Nz5J1PdT4oKfrvw23VuopUmdnHKHFq
	 b9K6ptyqtq1CDW/mrtRT2s3psaNSCp2e+jB4uIeJFdxTocKxhO42GZXG3HVn6TYPwE
	 6eJWAIzZmMqd4ConcJyDYwEqrVcqMHEgn20qs7Fv8FrCmt02GCVwRgrwUJ0WmxT5Rt
	 bhOYokhHM6x6SkzwQ0dI0A5vaCQyC5/nfGZRb0ufQLJUOsjfpu1+etCkVmAcKJL5DS
	 d0n2nPvTt4YGw==
Message-ID: <eb1b630a7ee8222322d213f72ceb1c23.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <13ad41f172cc8605cb9b324ea0f22296c4c97033.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com> <13ad41f172cc8605cb9b324ea0f22296c4c97033.1730123575.git.andrea.porta@suse.com>
Subject: Re: [PATCH v3 11/12] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahr
 enst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Date: Mon, 28 Oct 2024 13:49:24 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-10-28 07:07:28)
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/=
dts/broadcom/bcm2712.dtsi
> index 6e5a984c1d4e..efdf9abf04c4 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -38,6 +38,13 @@ clk_emmc2: clk-emmc2 {
>                         clock-frequency =3D <200000000>;
>                         clock-output-names =3D "emmc2-clock";
>                 };
> +
> +               clk_rp1_xosc: clock-rp1-xosc {

The node name is preferred to be clock-50000000 now.

