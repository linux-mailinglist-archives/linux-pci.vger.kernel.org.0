Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7C523F03
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiEKUjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiEKUjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:39:53 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D35E5281
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jz5xv5UGDELcNS0g7w77KHRkzqPdJlbRBk92OOO81H8=; b=qrns5de+igzZw5xrZnBofiijAY
        FJG6aUBQsFBSkL2bub5rz0JN9LziKFOsnWjlS9fPQvHcDMmlOJwpLCw/xEPThmwZKS+MIsLVgmpMy
        x5ZT2hyKUhBMJtvJ4rYiUyr1D4Wd4NDe5fSSLRtyZdd1+eI6WbJTHk9AYrpJWQa5eG9mhzpPNq+Vv
        r6HUJVx7KDvR2ILq3KaJeCMSnLnsbpf9JMwwgMaglOAWW5w91waJJ9fa8ltSw0d4qg0+kNjgSU9Wh
        BnFCmz/yoJXoxEC4iDrMSbSbECgen9cwpq8y50Bq8yfdBuQU9g0fOj87rQbn/mjcPc4+BkpCWTn/D
        TBs19zLA==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1not7c-004o8T-Hi; Wed, 11 May 2022 22:39:48 +0200
Date:   Wed, 11 May 2022 22:39:46 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Message-ID: <20220511203946.nr2qqzjlintrgxmi@mraw.org>
Organization: Debian
References: <20220511201856.808690-1-helgaas@kernel.org>
 <f9be7d36-d670-ef6c-8877-5b38e828e97f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="awkc2voxjp3fqrf4"
Content-Disposition: inline
In-Reply-To: <f9be7d36-d670-ef6c-8877-5b38e828e97f@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--awkc2voxjp3fqrf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> (2022-05-11):
> How about we get a chance to fix this? Where, when and how was this even
> reported?

I started downstream:
  https://bugs.debian.org/1010365

did some more debugging and moved upstream (the link is mentioned in
each commit message) roughly 10 days ago:
  https://bugzilla.kernel.org/show_bug.cgi?id=3D215925

As I wrote in response to Thorsten Leemhuis (regressions@), who looped
in a bunch of people:

   I had spent so much time bisecting that issue that I concentrated on
   trying to summarize it properly in Bugzilla, failing to check
   reporting guidelines and best practices (I even missed the
   Regression: yes flag in my initial submission).

Again, sorry for failing to notify everyone in the first place, I tried
to have the contents of the report squared away.

That being said, as mentioned on regressions@ & linux-pci@, I'm happy to
test any attempts at fixing the issue, instead of a full-on revert. I'll
also try to track mainline more closely, so that such obvious issues
don't go unnoticed for ~1.5 release cycles.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--awkc2voxjp3fqrf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmJ8HwkACgkQ/5FK8MKz
VSAphg//eUBGUgTb7rj6kZHMU0Ip3D01kCqIkQj3OX96Pa8HH5asKWEyuzaq0Jro
4cCJh25glm84QSQr8lJ4/rVd9CJfdOWwMcNaiCFzNFCjKaim8N1mhb4E3AbM71wv
22RPQ2Dz1zqmZSifwGRNN1dsesCfAOwE3gYkeUYwQIxQq4Om5ZzQywPFyEyk5Zmi
sj2uxDD3D3ynRGOqGaIv8gzuCD1VeASO7JhvPweqOthCnlIE1CP/1y5cnc3++pWH
sXMa04GwTBiW1Efp/xmJGYaPzYPgDRzWxGDtMrjSxbRhC/jolHtg/5APAg336CrD
T6nGIjlodUo7mqugukUjR4p1ghDufJYTLaheEUZJ4AZo+4Y8pjyJPhE3j+hsAsSo
cXd//jMo9K8cM64YpGINZB7z/xi2vgJUa8dx7ES7IjZ4TphMAJnPNlZbr/8/NSVM
6Del1i4hp8yF8lKH1YF4w+5DI7TC0ValP9aYTkctmjF/HxP2gA2n4RWiFJs3TNQ9
gMTnX3Yo/g/3iKjkN2McHNnOqmUORc6TDFMou6BXsAzWIfd91v9vZn+arogNd1Fc
i9fY4p6Dmb943iXRVya5rcOOlcZFIXLOq5QJYVSD1Fi0IqdycULscS0Ld99zLaCo
iKKxyTPM2BQfk5HOC3YS2t/5+Js9VyYHM7i6WY/ziPrbZgFeRL8=
=JX8F
-----END PGP SIGNATURE-----

--awkc2voxjp3fqrf4--
