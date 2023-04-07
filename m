Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D146DAB23
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDGJ6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGJ6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 05:58:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F247ED8;
        Fri,  7 Apr 2023 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680861496; x=1712397496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMm49nZx3reFlxHU+RGccvmujRLFyp4/7YbOx3zlUNA=;
  b=C5WeISoVVs+ht6KPdcOBieIh6LnFdpIxnpXS96nJ5Gu+P/unGxyd+caA
   JCu9ERFSHnHwetrW4IKApZFRYgAf85gzRmISKlvRHKnjLA041M/BSDjUE
   cDHEIq9Z7H9dI6yMpn9MJtuYCvdMwBDZiwhvjHkKu+r2se/QgFJCYgLdB
   3diIRsCTCFtImSUVPnYLjVKvsmo8TRz4aEXdKQZGKGgyTM3Q4pbHBSHeR
   1bTi3UfoBSrI1CTWWljROym0jga7r9E80tvgdfrSxhl3rjCSlLp1Gxq3P
   i3NpNW5n51sAENDDerdR/45daO4zlcmy8yyGAGNqZADmdsOIvNh1qHE5P
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,326,1673938800"; 
   d="asc'?scan'208";a="145992168"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2023 02:58:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 02:58:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 7 Apr 2023 02:58:10 -0700
Date:   Fri, 7 Apr 2023 10:57:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        <daire.mcnamara@microchip.com>
Subject: Re: [PATCH v1 0/3] Add JH7110 PCIe driver support
Message-ID: <20230407-splatter-greyhound-edc706148337@wendy>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406-quench-unharmed-2c11b2617e9f@wendy>
 <20230406-coming-stuffed-26f89610959c@wendy>
 <d9dde509-8923-a930-4c82-4bc8bd78ed0d@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jlip8xfO52SkZiZp"
Content-Disposition: inline
In-Reply-To: <d9dde509-8923-a930-4c82-4bc8bd78ed0d@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Jlip8xfO52SkZiZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Fri, Apr 07, 2023 at 10:32:51AM +0800, Minda Chen wrote:
> On 2023/4/6 19:54, Conor Dooley wrote:
> > On Thu, Apr 06, 2023 at 12:47:41PM +0100, Conor Dooley wrote:
> >> On Thu, Apr 06, 2023 at 07:11:39PM +0800, Minda Chen wrote:
> >> > This patchset adds PCIe driver for the StarFive JH7110 SoC.
> >> > The patch has been tested on the VisionFive 2 board. The test
> >> > devices include M.2 NVMe SSD and Realtek 8169 Ethernet adapter.
> >>=20
> >> I was talking with Daire last week about some changes he's working on
> >> for the microchip driver, and we seemed to recall an off-list email
> >> sent to Daire & Bjorn about extracting the common PLDA bits from the
> >> pcie-microchip-host driver to be used with an (at that point)
> >> unreleased SoC. Perhaps Bjorn has this in his mailbox somewhere still,
> >> our corporate mail policy scrubs things from over a year ago & I could
> >> not find it.
> >>
> >> I realised that that may actually have been StarFive, and the driver on
> >> your GitHub [1] certainly felt very familiar to Daire (he said it was
> >> very similar to his earlier revisions of his driver).
> >>=20
> >> I've not looked at a diff between this and the version you ship on
> >> GitHub, but first a quick inspection it mostly just looks like you
> >> did s/plda/sifive/ on the file.
> >>=20
> >> I'm obviously not a PCI maintainer, but if there are common bits betwe=
en
> >> the two drivers, extracting common bits seems like a good idea to me...

> Thanks. It is pleasure to using same common codes. Does common bits chang=
es
> will upstream soon?

I don't quite get what you mean. We've got some changes that are in
progress here:
https://lore.kernel.org/linux-pci/20230111125323.1911373-1-daire.mcnamara@m=
icrochip.com/
We've been quiet there for a while, but Daire's back looking into Robin's
comments in there about the range parsing/window setup at the moment.

I'm not sure if that's what you mean though, since you said "common
bits" & Daire was doing that work in a world where there was no jh7110
driver in the mix.
Extracting common bits would be part of the process of adding a new
driver, as I don't think there's any real reason to do so without
another in-tree user.

> And I see there are many difference between pcie-microchip-host and our c=
odes.

Right. I'd expect there to be a fair difference between our integrations
of the IP, and therefore there'll be a bunch of non-shareable bits.

You need the stg,syscon & phy bits, and the clock/reset handling is
clearly different too.

> >> https://github.com/starfive-tech/linux/blob/JH7110_VisionFive2_devel/d=
rivers/pci/controller/pcie-plda.c

I had a bit of a read through this again today with Daire to check what
the differences actually are and it *looked* like the main,
non-implementation related, differences were the extra "event" domain
that was created to simplify the driver & the bottom half interrupt
handling.
That all came out of the review process, so it's likely that some of the
same requests would be made of you by the PCI maintainers anyway.

As an aside, you should probably run checkpatch --strict on this
submission, there's a rake of coding style "issues" in the new code
you've added.

Cheers,
Conor.

--Jlip8xfO52SkZiZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC/pFwAKCRB4tDGHoIJi
0vDrAQCzfjkmLgmto/G84NJvLmBRLa1PWCSIuMVxr3sAxUVWcQD9GoHqqTaYnFzv
/J7frufpjB6/uXpEKzEcprsEZSWfPQc=
=NyKG
-----END PGP SIGNATURE-----

--Jlip8xfO52SkZiZp--
