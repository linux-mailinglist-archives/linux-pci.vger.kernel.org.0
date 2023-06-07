Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6634F726E01
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjFGUrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjFGUrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 16:47:08 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E712132
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DQFMItI8WSZBJks5Ol+S6LgTuB53
        uFenY05fX50QZiY=; b=F3GKggsuRRULhu+EaZO7fMH459bJ/wUB3wRYHUJGDika
        LuKjYUpsUL+W2kfGkxlpUh9mc4Df72tYnS3osp7v4Dhb8ySYH/TWky9rZPEiykCV
        KT/GWWbzw2jjVLqtbuxHSZhdRGLeT/4l7NCaRajSE/RBNPvdiruZ51dUIm2uZi8=
Received: (qmail 730414 invoked from network); 7 Jun 2023 22:46:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jun 2023 22:46:44 +0200
X-UD-Smtp-Session: l3s3148p1@huzUO5D9vJ4ujnt4
Date:   Wed, 7 Jun 2023 22:46:44 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: user proper naming for R-Car
Message-ID: <ZIDstP+WiM1jWVb7@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230607192144.27190-1-wsa+renesas@sang-engineering.com>
 <OS0PR01MB5922792E5FAD151BB18D1EE28653A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxflMeq+EFHlzmBz"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922792E5FAD151BB18D1EE28653A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nxflMeq+EFHlzmBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Typo %s/user/use/ on patch subject??

Yes, you are right. Will send v2


--nxflMeq+EFHlzmBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSA7KwACgkQFA3kzBSg
KbYrGRAAk9b+w5KtH4v4qZhVOmCh9GzfgdYNZNAwyXw22R6ffOX5XEbBbL+eSdvH
rXhZcYZLvkTpqftM5rdWiShJI1rUFjcfvp7ENuLzL+YHWUA7Ss2ebmtkC5cnCMTU
j1gGyaBMuGqjz2l2OWv7cHvLFLSM1DaGtBGRB1z9xTyhxOlmyD6PKgs5NiyGjNTV
K6WNjMs/VbgHWFK1Y1xiJXW8KqBWqGdDYZ6m5el6FYWX9SEj4lpCkWZ+PycSkwkk
d4ovYRbgmgtGFNrxQzOfaT5yeWDIseHEgX6vyfvvoWNoLEjpxDbCAhUEciXx5hQs
zgxZTLSP7ZJ8Fi6niGl/rwLencgcPMcOr0HubGqXHFqa1htmI0SQajflly3YINy0
1y/CfKdDqlyfbXeKPvJajQWtBmX+YeGzCnaUX72/nYQ8Dh/uHoqxjEyhIt8yoTE+
J+ArfIpuulJLdW+cWR8CbuWyCnjAi9nYDyxGmKKrc/j6IKe5PhP+4UwS+jswdveM
VO7TiCcbV03oRmy63JdyxZiYCzNW7Ko+5j8Ev5D8kW54fl40k/P5eppE2lCoCOXO
77UEZ1vMY4R7b2gOViGwmidbA8etqqNDms0X8RGKNQUQmK9Mj672q79ysDY+Xx2Z
DRKBwJJcIRHwh6coehlL6dWGyf8rlVIg+toB8ewnQ3mZBmDHXmQ=
=FH4D
-----END PGP SIGNATURE-----

--nxflMeq+EFHlzmBz--
