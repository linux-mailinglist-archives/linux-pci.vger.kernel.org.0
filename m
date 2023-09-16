Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29597A2B2D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 02:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIPAHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbjIPAHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 20:07:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2998;
        Fri, 15 Sep 2023 17:07:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBAEC433C8;
        Sat, 16 Sep 2023 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694822826;
        bh=8Yu+GwYPHDePl3LqNlzEzfrFvMmCmV66DDHEshoQFPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNH6CLgxFzU1zRS0ABaVNSmRwjWQmVfC7I+QNZrLanrYn2S10zMTqneXnbPwIx8U+
         9+DYbJCYWmEjSRJLFUD0KnU4SrTfH4U70goBTEtWJYYgE+3CDQj+S3xahTybXlvnI8
         4+hXbVGzT3NrhxXoS7XMOoswH8SBrs7wuJAcOF/OO9C3feM3vkPLoLdSn2ljVt86RK
         5e7cGHkB2Lxc38+DNvVOM9w4WpQtgBzaL7RK4nBiIaLc/XKkVS+PdQE+h/FYgT5qjw
         v+xWeWSrzk26/qThAn9dkn6BUyKeIP3f7IuSP+BCNnVyKI4KQN3Z7AGLxQNSa/LO+P
         g8EQp9/9wUiPw==
Date:   Sat, 16 Sep 2023 01:07:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v6 19/19] riscv: dts: starfive: add PCIe dts
 configuration for JH7110
Message-ID: <20230916-monitor-idiom-86d6894b1e88@spud>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
 <20230915102243.59775-20-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+RcYDkBcBEoWjbZf"
Content-Disposition: inline
In-Reply-To: <20230915102243.59775-20-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+RcYDkBcBEoWjbZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 06:22:43PM +0800, Minda Chen wrote:
> Add PCIe dts configuraion for JH7110 SoC platform.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Not really important, but checkpatch whinges about the double signoff
here, since both are you"

--+RcYDkBcBEoWjbZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTxpAAKCRB4tDGHoIJi
0lj9AQDNWfMti/9mi01vMJjKM7GVM2xrI3XaabEtUXwy9R9NmAD7BHYTvEI4JQ/I
+ECDoV1Pnxx67atTC+kUEC0W38scYQw=
=uVmt
-----END PGP SIGNATURE-----

--+RcYDkBcBEoWjbZf--
