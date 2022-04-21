Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E378450A48B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390316AbiDUPp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390317AbiDUPpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 11:45:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484794927A;
        Thu, 21 Apr 2022 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650555699;
        bh=qO7WWncsu8pqavraYehTZbqYkoK5x7r8ZxY5T97XoXw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b+ULn39b+bj0QXQCBw1ebteDuTea9undETS0F3wjN4eLKsi4JB2YQXogVfc83LBez
         yKNmLOcb21RK7yGdjB5m6CjS2/vj+M6UcAbEkV7RpYjgtYRIZWuVVONj+tsRzKG1F3
         prFeyU+w5t492/e8TZXuRN8Tb0BY4Vy5259dV3Uc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.123] ([80.245.79.123]) by web-mail.gmx.net
 (3c-app-gmx-bap38.server.lan [172.19.172.108]) (via HTTP); Thu, 21 Apr 2022
 17:41:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-1c858470-8354-4ecd-ace7-a6e437cb5923-1650555699148@3c-app-gmx-bap38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Aw: Re: Re: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 21 Apr 2022 17:41:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAMdYzYpydGyQZT2n9Tf+ccQMLHzfhOgoyamMgspQDcjzm3Umdg@mail.gmail.com>
References: <trinity-a220fd81-2ee9-474d-bd65-505b9ed904b2-1650186482865@3c-app-gmx-bs58>
 <20220418155313.GA1101563@bhelgaas>
 <CAMdYzYpydGyQZT2n9Tf+ccQMLHzfhOgoyamMgspQDcjzm3Umdg@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:fMhCkXFkWk6jz1YC+ACHfChGGaYlwtUgwWcAnA0jyPbYw+1++3n2PWOoruUedVEe3O/nQ
 hDXeXjlmBChv+exHvKh31aXoT2WMSGUsSsGWqskuolAgm32mb16s6bTyLBSYtyP5Sg25cf0JPmXJ
 1pePEo7O+SI/2Uh8PWKiMger7oxtNy0YJJqYI+mBRs1lneD0he6ep57APIq3Euail8eSb3oQ1N1t
 QJ0n5Muonbp6RS4DYQMXP774RwDlOzQRQsjzLD/mjxpPK7b1IV/OtbmUTj8gaCQgDDN5tUv+dMym
 H4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nkMVzuz8fg=:WjCZA2rE/qwwh+MU3sEN/r
 je5+6b+/RRLEZWWlafKstjYHv9f42eqbK6znP181CwuscNFSZjPl+ZR0HKMM7EydWaRcZe/ll
 BCl+krEEXdZUBXvWxN7pl11y0YtJRF/i6dPA75W2WcZOp3+4A65+kN9+ny41jIuUEDMs74lhH
 mlr1cKsf35glpeo45jO6pK6jJcuXVlctuuf0NAvA2rMuAzjHtYFAbYULFQ4NMMKgwDzge1yo8
 j4Lyb7g1uK+V0PwRFsRsWTFrrgK7r3KeHAoy0yjxVTw10wa9hQaRqyS6AYEBnA9MKhCECi6BF
 IooRgAAog8qUceYmla24ULXMV52boFDwi50i7zQFDUn2JUCVw2wJIli0TtSDY76YvVfG16Rqe
 kRZ7vXEtrSLD0eBvjy9o1qoZ+XuRbzMvLC2uxvGwG4uKTT6R1jd59YbrosallEcZqsmO5+Kr5
 xi3NoAXZsdYMYVWQoOFYguVwJlJ05EaBIgoUYtmUx1SDO4JLZhypXT2uoKccQlEIwOS4KlvZO
 9HfdqR+WKJAllWAbVUtSrhGjQ+yaNXPWNmSv8K+1dqKdbXF65ccZxnET97oWwubt3p67rR0jQ
 affk8sssrapLyMlQ6zJ5CA2iC7h6xRXYxkwV0nYiaobtjCYLLwMOSvupflLa4xyk9lrgEXZt4
 aHim3uq8km4fyBx7FG4mygswCimCKLaiNJWINxGFUzliPO1i23YRcWaZKKUA7LGnEBdO0lazI
 V+/cc0pXMdiZYEG0k/hxV4sGCzUUphJ4RWxS+GvuKGrOQCGk+otFOoyS2Ncv4BdrqvmOOdXuh
 ALV1zmu
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Montag, 18. April 2022 um 18:17 Uhr
> Von: "Peter Geis" <pgwipeout@gmail.com>
> > On Sun, Apr 17, 2022 at 11:08:02AM +0200, Frank Wunderlich wrote:
> > > > On Sat, Apr 16, 2022 at 03:54:56PM +0200, Frank Wunderlich wrote:
> > > > > From: Frank Wunderlich <frank-w@public-files.de>
> > > > >
> > > > > PCIe Lanes can be split to 2 slots with bifurcation.
> > > > > Add support for this in existing pcie driver.
> >
> > > > Is the "rockchip,bifurcation" DT property something that should be
> > > > generalized so it's not rockchip-specific?  Other controllers are
> > > > likely to support similar functionality.
> > >
> > > I do not know if other controllers support similar functionality,
> > > but i ack a property without vendor prefix is better. Should i use
> > > "bifurcation" as name or do you think about a different name which
> > > is more generic?
> >
> > Really a question for Rob about what name would be good and where it
> > should go.
>
> It might be good to define this as a lane map.
> In the Rockchip implementation it's only 2+0 or 1+1, but that isn't
> guaranteed if this is made into a standard definition.
> So perhaps:
> pcie-bifurcation-map =3D <0>, <1>;
> pcie-bifurcation-map =3D <1>;
> pcie-bifurcation-map =3D <4>, <5>, <6>, <7>;

how about a lane-map like this (from controllers point of view):

rockchip with only 2 lanes (like rk3568):

controller 1:
lane-map =3D <1 0>;

controller 2:
lane-map =3D <0 1>;

here bifurcation is set if a controller does not aquire all lanes.Afaik rk=
3568 cannot select specific lanes so i end up with bifurcation =3D true/fa=
lse (an aggregation-mode on phy) again. but it makes dts-property more usa=
ble for other devices/SoC.

this contains the maximum of lanes and as mask the lanes to take by the cu=
rrent controller. It is scalable to support more pcie-lanes (x2 x4 x8)

example for 2 controllers with PCIe x4 (with 8 lanes available):

lane-map=3D<0 0 0 0 1 1 1 1>;
lane-map=3D<1 1 1 1 0 0 0 0>;

of course they can be mixed, if driver supports this.

lane-map=3D<0 1 0 1 0 1 0 1>;
lane-map=3D<1 0 1 0 1 0 1 0>;

such lane-map is more flexible

regards Frank
