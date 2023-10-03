Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15D7B69D5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJCNHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjJCNHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 09:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA993;
        Tue,  3 Oct 2023 06:07:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1115CC433C8;
        Tue,  3 Oct 2023 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696338447;
        bh=ArFpsG+rmsCSYEIB4kkM8QPGFJQJDJOHz7UBLDI+9zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVPVFPEs1/OCC8qjCciwFIU3setxljjE5Q0Nh12gpiXrCBm9YrwGGTLL2Sll2nnhE
         xAMKRJ6B6fsIaABPHnnbZfVRbUrFGePnVkrdlppa8RyN1Z4gEMfLbKOjI5oywxUJBk
         Cq5NltCK3+O6rDxH0Qpy0Uq9bln0sPMiJiPZnhxZS6po30gpPOzFnzsrxDa4O90TQL
         zNm9yd8tHbjBhEOdayrG3eI3/Hz2QNqwcmgHbutDi8Yy2c9d7PDirN6x0uRw4BMT4b
         b6hXS+0+aMwKD3xgJeEk33u1xRYcX7JUtwSp31Xa/b8I1bY9AYdRqUr/QcyxEIRmL5
         +0NjjPeTuc8/g==
Date:   Tue, 3 Oct 2023 15:07:24 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: Use PCI_HEADER_TYPE_* instead of literals
Message-ID: <ZRwSDNOlZwUu+vqE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
References: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
 <20231003125300.5541-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/zJ+jH2FaDITq/3"
Content-Disposition: inline
In-Reply-To: <20231003125300.5541-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8/zJ+jH2FaDITq/3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 03:53:00PM +0300, Ilpo J=C3=A4rvinen wrote:
> Replace literals under drivers/pci/ with PCI_HEADER_TYPE_MASK,
> PCI_HEADER_TYPE_NORMAL, and PCI_HEADER_TYPE_MFD.
>=20
> While at it, replace !! boolean conversion with FIELD_GET().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for Renesas =
R-Car


--8/zJ+jH2FaDITq/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUcEgwACgkQFA3kzBSg
KbbwZQ/+OWN+pr0W3mgNuEkqIJy1gENxgZSQwTuDfc50jkQ+QvaDabXZyduk5uDf
QDqFHQCwuodVcB2FkK+WUddSmLHChpSSX4imzxhhd21YAAd2mZMwKxvW1T0theCe
ZdRnxE1S0H/B4OsULDMppn+3DZVW2aGre32u7lq7hIpmj2dRbpH4TBbTLchXoMQY
RCOUJ0baTYSXiDjgbmq+urT98IqO4gMxuEmzuoICqZCsb1gFUOz+aM3Jfxc/9BJw
su9LoOCg/Ud447vnOkzs6BlkBgocWXFJPb/dIPPiaMkDIPyxrljWU9S8MVpcC2/7
Fhd0phffcjTn1W0cSRwTJPpS9fagWYduMrLjFimhR1a9ERmTzzI8QAOH5/Dk9zoO
b4AQ4dysH08lHur+o+tMnlhtGS3xbcvymorR4uqA35gzCTVDSdNbnmIi+K/WutuR
8N1DsSwyvMpwAMLvoFeQZGY2zNAP83/CGbITi6Gj3RUmEMP9jCkEl1r+YKOC5bjQ
rkv1pRvPgG/am6hzVx3RyIdOUddcKCsgQt+3nBfby6HG+PbuxxKtrthxXUHmunDX
p/zlkUzjNKryvwL09lzLs3Ys13EBazLZAbPWN0lZYuekcbKrL//m0N7qvNmLo8oy
ZcMD9javfLimKe1u3MffJ7RMnEjwcPViS/7Ym54dm5YjNmLMTrI=
=KypN
-----END PGP SIGNATURE-----

--8/zJ+jH2FaDITq/3--
