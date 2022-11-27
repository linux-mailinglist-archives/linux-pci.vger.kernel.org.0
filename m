Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0097639E3C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK0XgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 18:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0XgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 18:36:07 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D7B869
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2022 15:36:04 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C8C32100004;
        Sun, 27 Nov 2022 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669592163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eMRJl5sTuIkPBcRNM8NFzVjAYsmGrDM3jIU4r/70Ck=;
        b=gz7de+4rn1ILNiAOhvtTLoTccYZfORNUC8hNA3oDTg0AZ/G+flcyu0PWgTMkv7rT0HPMYJ
        08nspse8SdmPpMADmxyTBGqs+I8YhFiv1qCh8ekB2XaTsSTvE58+Lbri1WbprVDuSo4gd3
        nttMpSamtJrsLPq+X1muFhwlGrKwe5szuYBDK+5C5kWP92uv/Fr7HqmKhpxnw41nvjFlsP
        hq1nDrh1iaNtWn2869lQAe3YU4nChnnjDXEzHabeurmkDbvX5wJIXuU/bd3+bu21M9wXLp
        3UzyWFFDPFzDiNcTMPUyHL07ow3GjTiV6JscmaQeJkhwYdnhldRkDUgVX/SQwg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, pali@kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH v2 04/10] arm64: dts: armada-3720-turris-mox: Define
 slot-power-limit-milliwatt for PCIe
In-Reply-To: <20220927141926.8895-5-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
 <20220927141926.8895-5-kabel@kernel.org>
Date:   Mon, 28 Nov 2022 00:36:02 +0100
Message-ID: <87ilj09di5.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marek Beh=C3=BAn <kabel@kernel.org> writes:

> From: Pali Roh=C3=A1r <pali@kernel.org>
>
> PCIe Slot Power Limit on Turris Mox is 10W.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index ada164d423f3..5d2b221dbd96 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -136,6 +136,7 @@ &pcie0 {
>  	pinctrl-0 =3D <&pcie_reset_pins &pcie_clkreq_pins>;
>  	status =3D "okay";
>  	reset-gpios =3D <&gpiosb 3 GPIO_ACTIVE_LOW>;
> +	slot-power-limit-milliwatt =3D <10000>;
>  	/*
>  	 * U-Boot port for Turris Mox has a bug which always expects that "rang=
es" DT property
>  	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) a=
ddress cells and
> --=20
> 2.35.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
