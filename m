Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47555EDEEB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiI1Oie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiI1Oid (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 10:38:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E1AE211;
        Wed, 28 Sep 2022 07:38:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c30so16391241edn.2;
        Wed, 28 Sep 2022 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8DnDko/nUiaNQfilebzmtyXvqhSN9KVnALbnVAuYDqY=;
        b=WgvQ11R+E2jsOCPT8ZNGJjq2pseCnFfA1rrwcat2ovY/RqY6+BNQ7i5E83cuRSedBe
         fXZ4WpYRCddesrDjbvOu+snt1NOyX8KTgiS6p3AuUzOmOGZlyB35e1XKyx3gXwGrxXUZ
         xHmOm5yClT7SHgmmZakm0WWiWCMxmjc184Nh7XQ0XCe5tLmeXNml9Og2T9m6KKlWNZg2
         QMSO066GUcY4K0PY0X2SgVFgC+i+yyHURlMepAAkd9X73P6Y2v9MT7/zcKZlVJNdgNt1
         BZXO3fvTN8pnQWSjkFrTXMgrjX+VtClkUUGfKg03eVoL540aoE7LSriP9D0v/i91w51f
         tPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8DnDko/nUiaNQfilebzmtyXvqhSN9KVnALbnVAuYDqY=;
        b=7AgFrpjrMsjY1KwU3WXpFf4eE1PCFLDBmnDSRoF/TQH9qBrxLM9IKAq311p/38nE60
         5Kwao3uJ85jbeJUfFtL4RzEdvoMO9dxlrdmvjN/g5kmC+lN9Cnao3XhAUy69RerRkCEx
         p0e7OTv5+xPT302VSPMPUmIVeFKv/yvhxlUVmN1VhodBTbcpXRzUwwxrfPsL5J/Kjyod
         PO5TnmzWZGcJuySV0xg8dR6KbkZvLsPpM+IHG8Yf5XjTzJlDLqRAv2uKixRlyJgesgPW
         ySvUS1xoEy2VL2x4lLQCKrZTnx3tNkie56lO1trsAdWLif4lxAWUW6GYKY50kp6VUoUL
         l2Ag==
X-Gm-Message-State: ACrzQf2HJPRwtFH75lzpIiSMIh0znZFnBdw7lq1nSZNeLujvHKmEhSar
        MhrYmKxGGnc3QizX1wvsm2c=
X-Google-Smtp-Source: AMsMyM7CRrMZVNMHkmmpmNiBvIwdWVrrsRiJWkkGrnazyApe61Bk6BWnrn+7kLLA0mP/it3HOZnSig==
X-Received: by 2002:aa7:da08:0:b0:456:ea2b:3ce3 with SMTP id r8-20020aa7da08000000b00456ea2b3ce3mr24742806eds.181.1664375910066;
        Wed, 28 Sep 2022 07:38:30 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709060ee200b0073dde62713asm2493593eji.89.2022.09.28.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:38:28 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:38:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Update comment about config space
Message-ID: <YzRcYwQYlawV10QS@orome>
References: <20220911113216.14892-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PBUmyu+1rqqoAJH+"
Content-Disposition: inline
In-Reply-To: <20220911113216.14892-1-pali@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--PBUmyu+1rqqoAJH+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 11, 2022 at 01:32:16PM +0200, Pali Roh=C3=A1r wrote:
> Like many other ARM PCIe controllers, it uses old PCI Configuration
> Mechanism #1 from PCI Local Bus for accessing PCI config space.
> It is not PCIe ECAM in any case.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-tegra.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Perhaps this should be rolled into the PCI_CONF1_EXT_ADDRESS patch? On
the other hand there's really no use in keeping this comment around
after that other patch because the documentation for the new macro lays
out the details already.

Thierry

--PBUmyu+1rqqoAJH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0XGMACgkQ3SOs138+
s6EUKw//e6+EBVbBjmdErmRkedqQRSc8/R4Y7cyWp8xtevza46OFYc837j7g+Lmp
wqru1VugD6Zz0+t/ppR/84mjEr5EcsOnXJmbvz0QCq0oGUkvUfYULtMUpLPCy59n
pbLQ/buBsGaE9kbGs0QWE+A1dBr7AWigRv5osD0ahl7OkkIuXSfYA5j0EgkTfslf
jSoIrw4jyfiXTF01FMdb1Qsnq3qcOYsoCgwXXRoarhoVtS/NvN71hUQbohBrV675
Y/C8zwngKIx0EO1X9VmcxpyWtgdTG5HgbdTS0eN7QckLFyATCoz1FsZ8tPwwAWix
iY3iV5lpjCr7JCC7rNj1tTtNpdfaqpnb/sRDNLKu2E2RDomueKkO+YzRTMLqTacF
6tEZk+W1evdPfTnfc/Oo6IIEEGhbMViQS4sYKiNiHG0NxjWoy/I0mt/JJ5uAapY6
0LMD+hqHTl+E0VMsd0Q0n9bMMW/qloZKW8Fgm6P8Eu9WtXQ3W7EnR76q6/Zn1a9Z
3u27DfG39rebzY0mAAHbqZDz70kU9XxHXrH1TJ6YPytyKBg5Oqwcp66IJ1B8qDqr
Xy1sthcegoYWjpaIHRCN5R7eTX8LKQnqdqtNfBb4GnGoCFzXwB430Mdfao5w+wBZ
79PqcMXD/v03WiUhthfZor8sA8gxb9R5BBp8hU92D6MTeqR4LIw=
=KBC4
-----END PGP SIGNATURE-----

--PBUmyu+1rqqoAJH+--
