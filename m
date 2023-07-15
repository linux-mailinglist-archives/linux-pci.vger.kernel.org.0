Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B075482F
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 12:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGOK3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jul 2023 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOK3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2023 06:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD935AA;
        Sat, 15 Jul 2023 03:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E978A60B94;
        Sat, 15 Jul 2023 10:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C87C433C8;
        Sat, 15 Jul 2023 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689416991;
        bh=CH/l+e3PeGDEEGxcizi8F/Qwtn5DnbYB9Arg2+4cEzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BS7tNxA4PhjrLdLFPXcSc/hOWx2p+Q5Y3/gWbVbGoEL07TdkjGj7pPdGkdoLJPCU9
         efQ4LK9E+DgYJI+4rFb6XFartpO56lpPaf261HnpICqDHppIbdxZ1DKLDfZLg+4EIs
         tJFXn3VzSc/Sg3Swv0XdccXFce8PH5bHpjL38PopjMwrEYLvOioSb0n73CyOcxun93
         TatS8CrNJmxux8zpjpNLY6fZThxN8QFp6lvroh7NIllI4YCIPh3K1A8OBJ6GaeKA5J
         IbVtzrc7Se2vRdSYvKvZ1Y5sTuvuuLu61QuXVbiPt3WRRoy46fMHZpMYbT7Jd5b+Mr
         TEtLSTLgYihoA==
Date:   Sat, 15 Jul 2023 11:29:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
Message-ID: <20230715-rudder-unbent-ff7754bec4b4@spud>
References: <20230714175331.112923-1-sebastian.reichel@collabora.com>
 <20230714175331.112923-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A9wMCNuEv+mNAcmd"
Content-Disposition: inline
In-Reply-To: <20230714175331.112923-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--A9wMCNuEv+mNAcmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 07:53:30PM +0200, Sebastian Reichel wrote:
> When the RK3568 PCIe v3 PHY supported has been upstreamed, RK3588
> support was included, but the DT binding does not reflect this.
> This adds the missing bits.

Thanks for rectifying that!

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--A9wMCNuEv+mNAcmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLJ1GAAKCRB4tDGHoIJi
0qC2AQDLhuOu8q2be4MO3J7WuzO0cCDIq88igm6teBgavhzglQD/S0kOknT+dRpF
RgFKkdHBfEi2/D6JSy9HXCkHgpbkdAM=
=cYpP
-----END PGP SIGNATURE-----

--A9wMCNuEv+mNAcmd--
