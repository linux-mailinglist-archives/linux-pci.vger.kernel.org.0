Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9675AE02
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGTMNi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTMNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 08:13:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD672106;
        Thu, 20 Jul 2023 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689855215; x=1721391215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qkDXQ93pEI6ao4XArtWOlAwCt1REKU2ZVqOJKv7aZYo=;
  b=zinBMc6V5YtnDgIE0wBeXhmnG7wNd6vIlNWlLbQZfaZZutW9bclsNRkb
   Zi95dwo7aBXBsypoyo+ylS3ku9aHQu4eg6UptjTAndKm422TgwnlEQrHm
   aR0diUKKM+bCmqNzWQS1kDUChbhKIvr0LvhzsazWYWPk7UPQhV7bPjoSh
   xrKveVqjDpg7jg2RfbT/gO5522WumwrxPSdeDaJDVPvyDaHCI6vhOw4As
   g3cnGy/wZggIBdAH9L7ZvftpSxt4kjqXLP5yx9cu7smeTtcKP/uZKtGEH
   Vdm+YGHlkbj+BRUFkiKNc18KGsYXHNMwAm9ayW+6HY6Xopet8hSqGjyOK
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="221309888"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 05:13:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 05:13:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Jul 2023 05:13:19 -0700
Date:   Thu, 20 Jul 2023 13:12:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Message-ID: <20230720-unkempt-bath-9d320d55577c@wendy>
References: <20230719152626.GA502469@bhelgaas>
 <52ebc991-0e73-8df4-61b2-32989ab4e62c@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kw3EZ33X58KK0EKz"
Content-Disposition: inline
In-Reply-To: <52ebc991-0e73-8df4-61b2-32989ab4e62c@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--kw3EZ33X58KK0EKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 10:15:51AM +0800, Minda Chen wrote:
> On 2023/7/19 23:26, Bjorn Helgaas wrote:
> > On Wed, Jul 19, 2023 at 06:20:48PM +0800, Minda Chen wrote:

> >> This patchset is base on v6.5-rc1
> >=20
> > Doesn't quite apply cleanly for me:
> >=20
> I am sorry, The driver need stg clk and syscon driver, which are have't b=
e merge to main line.
> mainly dts is(patch9) rejected, Must apply this series patch first. (I fo=
rget add this link in cover letter)
> https://patchwork.kernel.org/project/linux-riscv/cover/20230712092007.310=
13-1-xingyu.wu@starfivetech.com/
> and this syscon patch=20
> https://patchwork.kernel.org/project/linux-riscv/patch/20230717023040.788=
60-7-xingyu.wu@starfivetech.com/

You could detach the dts patch from the series & send it independently once
everything it depends on is in place. I'm going to pick up both of the
patches you've linked for v6.6 in the next day or two.

--kw3EZ33X58KK0EKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLkkvgAKCRB4tDGHoIJi
0tHHAQCC0e6XIbYkG6LkrgL69/4niNdKZfvj9lofo9snvGUNxAD+L93odnBwIMIi
9NNg/AiwINvTb2x+ys70gaGFwrSk5wM=
=x0aD
-----END PGP SIGNATURE-----

--kw3EZ33X58KK0EKz--
