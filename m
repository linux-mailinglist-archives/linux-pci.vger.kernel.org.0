Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FC4C716F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiB1QOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 11:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiB1QOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 11:14:12 -0500
X-Greylist: delayed 1940 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 08:13:31 PST
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0432E692;
        Mon, 28 Feb 2022 08:13:30 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 885031BF204;
        Mon, 28 Feb 2022 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646064809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+wOFMarUz086pJrlDuE85O9OvazGWES+zeixeQHza4=;
        b=XgAGB5zEk5DO3AewKTxzrCUedlsXMt0ceYjWpJNZ73Fzje3ZqzTk9MCYIlRD5d7fa7eFVQ
        ML01E4sH66cS/XkGNGLU0KVxe4Obux0GKgNnd45mchzq75+2QKBdX+oTNoQpkiXlRFzJGw
        jbU4oEkEKymHsT+XZxU0QF7qON3neqcR2CumtokTmjLE6XoXR3b1LkAE5ltGMCT4PqXAA5
        NoPvt1cRGtkVnaq9ryQkpADUrVq8Hy1OYWBS5oOHRfgVdwYZK7/8MmJscabytUsa1kBgaP
        AiGRULQpMUUltN04W4FGnAji3AJneMmHofxQeK5mil1YKRmlihMG6Bm7eZye8Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy?= =?utf-8?Q?=C5=84ski?= 
        <kw@linux.com>, Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ARM: dts: turris-omnia: Set PCIe
 slot-power-limit-milliwatt properties
In-Reply-To: <20220222163158.1666-7-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
 <20220222163158.1666-7-pali@kernel.org>
Date:   Mon, 28 Feb 2022 17:13:28 +0100
Message-ID: <87ee3n0y1j.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> All 3 miniPCIe slots in Turris Omnia are designed for 10 W.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boo=
t/dts/armada-385-turris-omnia.dts
> index 5bd6a66d2c2b..f240018148f6 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -71,16 +71,19 @@
>  			pcie@1,0 {
>  				/* Port 0, Lane 0 */
>  				status =3D "okay";
> +				slot-power-limit-milliwatt =3D <10000>;
>  			};
>=20=20
>  			pcie@2,0 {
>  				/* Port 1, Lane 0 */
>  				status =3D "okay";
> +				slot-power-limit-milliwatt =3D <10000>;
>  			};
>=20=20
>  			pcie@3,0 {
>  				/* Port 2, Lane 0 */
>  				status =3D "okay";
> +				slot-power-limit-milliwatt =3D <10000>;
>  			};
>  		};
>  	};
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
