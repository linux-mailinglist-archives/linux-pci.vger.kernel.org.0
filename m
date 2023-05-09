Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E36FC0B0
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjEIHr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjEIHrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 03:47:21 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C872DD8D;
        Tue,  9 May 2023 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9mfOEh12/KcZK8TFY/ZX3oxJrF5qjW2s2MPzvQR6Ugk=; b=ANXdghA1pad72REMAS3MA6NTWc
        5jN+DUGCfIxMy4hgzzLjDSJTCbQsbFC7bFAXLPPF4uNx2A10yMgN94ZJHTR0eGfW1+Kxd/JO5IRXg
        kJiqfsKryN+TBskVUgHOi1CkGD+kxtw1fcIdWyxOv6ntwxbXabNM0XN+26fQRfnpzP45ouIOGA/NF
        FLHEzwwk6JqZ3tA+XWfTJtr459eri2EhsfEZcP3POXSDe2fhKUAvYe2g5hdImx46f6yLDsGCAEGmn
        H53iYpWbotH2phcQDEqKTTDQzSVgx7OA8shwTeBsYBh3sT+0xwKwZw1DvqMHQwKlYmAQiITk13CJJ
        a3/e6k3Q==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pwI3j-008YQj-Ep; Tue, 09 May 2023 07:46:56 +0000
Date:   Tue, 9 May 2023 09:46:51 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20230509074651.ixcqhhmazjngxur6@mraw.org>
Organization: Debian
References: <20230508220126.16241-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ogfywygslxit6od"
Content-Disposition: inline
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--5ogfywygslxit6od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2023-05-08):
> v5 -- Remove DT property "brcm,completion-timeout-us" from	=20
>       "DT bindings" commit.  Although this error may be reported	=20
>       as a completion timeout, its cause was traced to an	=20
>       internal bus timeout which may occur even when there is	=20
>       no PCIe access being processed.  We set a timeout of four	=20
>       seconds only if we are operating in "L1SS CLKREQ#" mode.
>    -- Correct CEM 2.0 reference provided by HW engineer,
>       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
>    -- Add newline to dev_info() string (Stefan)
>    -- Change variable rval to unsigned (Stefan)
>    -- s/implementaion/implementation/ (Bjorn)
>    -- s/superpowersave/powersupersave/ (Bjorn)
>    -- Slightly modify message on "PERST#" commit.
>    -- Rebase to torvalds master

Same results as with v4: looks good to me!

Using an official CM4 IO Board, I've successfully tested the same 9
setups as before, combining each:
 - CM4 Lite Rev 1.0
 - CM4 8/32 Rev 1.0
 - CM4 4/32 Rev 1.1

with each off-the-shelf PCIe/USB adapter at my disposal:
 - SupaHub PCE6U1C-R02, VER 006
 - SupaHub PCE6U1C-R02, VER 006S
 - Waveshare based on VIA VL805/806

Each system boots successfully, exposes the Kingston memory stick
plugged onto the PCIe/USB adapter, and happily reads data from it.

Note: I only tested each CM4 with the upgraded EEPROM (2023-01-11),
and without tweaking the DTB (i.e. without adding brcm,enable-l1ss).


Tested-By: Cyril Brulebois <cyril@debamax.com>


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--5ogfywygslxit6od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmRZ+mgACgkQ/5FK8MKz
VSCWQA/8C/o/6Lqq9PIxjWkSNDHEMmI/V+x09sfj0zDIX+56AVJmlYW9PbUrRM+b
yXjmElnr++pl2ECeXyGgocO3YIfxKqNH+06/2xplScb9PlIfXwiyf5p6uxhiFoTn
ROH6QqM17MUl3Fv1zYZfvB/AQqAfhi5Fx4kepc3I2wLxZREl6f627+xJ5R7p9bfe
e4UnFTpQht4CVZj7HJ9KXsTibpeqzR79CnjX9iyFmYcDWSqHQ0jiM9glG6/HgbHp
wMRHyswZp7sLsDTSkk31pL+VXSRFF5ABGeITw52LJnjNh+i8TYZbxpuYlPP4MlUo
HzegbF2DdJDFssNkxXeBNRe7L5a82B2Bx5SW+DHNB5dmtaCQrM+2FzV5mBubba/L
gEsbNLYngQZCoS3jV09mqc56dSpp7B+EC2IoDuJkhFqCB3UjLvimzM9CGDdM5Jm7
NbQeeo9RUbdEOv9GLQwimp+h7S7N38XMnpTqDol0XQyYOMBRl5Ploi7JJwbGt6N7
VvyTh5tGVtXycIDJ/+Gwy1RUIokMqHns+FPbJSig7oMdttz6GDk0Hr1QctFtN9CL
3F61fVxJ+8QsXyrUtcnEPM6F9AmRJAtekOl4EjhJWlWlmXUkYwbcoKquzOUhJd1X
OYLCHVj4DIA4NlXtump3gi68cW+SxUl/H2o0lBF27vLWGPKBlMU=
=m9/Z
-----END PGP SIGNATURE-----

--5ogfywygslxit6od--
