Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88F504750
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiDQJLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiDQJLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 05:11:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A627CF3;
        Sun, 17 Apr 2022 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650186483;
        bh=HiCerFGpE/ayU2rNlzN03bfcN/5dOTZBCfCNgKlWJ0o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RF5LsLbH2pRh+HPMUdHXYyIBKr+lyPFri3MbyzolzXymfWSog757kCMGuw2EDSBPj
         gcp95NvBQcqc6iX/vCYQOvzo5AcGGQ6Hq0QeisYuj5/ex09d4/68Hob4Uk2OIVc3qi
         VDJacmm5WsMHG5GPWztGJXgqTW50DwwsiYJQAZ7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.151.209] ([217.61.151.209]) by web-mail.gmx.net
 (3c-app-gmx-bs58.server.lan [172.19.170.142]) (via HTTP); Sun, 17 Apr 2022
 11:08:02 +0200
MIME-Version: 1.0
Message-ID: <trinity-a220fd81-2ee9-474d-bd65-505b9ed904b2-1650186482865@3c-app-gmx-bs58>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Aw: Re: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Apr 2022 11:08:02 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220416233047.GA938296@bhelgaas>
References: <20220416135458.104048-5-linux@fw-web.de>
 <20220416233047.GA938296@bhelgaas>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2bpGmb0SGB/uw7Zt7eXuN4pld6iukRT7tzTTsFyOx4YULzjSB9kfUHZXHXv87BGPUG1fF
 Ea0IN1aJksF6SwZFzKGn4eBJIt3IH8e8T1HeghhbpvbIzv8UkKCIIfhdLOdPxJWBdK4fC8S5/ceS
 F8/4MRTjwu2r6Hj3MTb7GJJktcfcSXWinWqfZHoHhSCxqWiyf9nTJQ/nN7ADw+m5s3R68WLA30qN
 WVdjwONHPS4oTdl/p/ar5oVZO5LO5c3Vn3r/xfaicL03CI3/JTzMGZJvUOodWCpp2+/iwlnT16Tf
 Zc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfuaCt4JPa4=:SvXYLMCMbDSlLrN7ezprt4
 om6bbWzv0yCV8/obOHIlm947NpThP8O54jmXsFPHcKL2NvznDfiM3GQhRGnJqIbb+DYf1P9pY
 UXLLKrWgrDEltMyrscIJO45o0UEgsA2v/s4VZhazYCVyoIVP1YtKwNUsD93MTCxOIgZsGw43A
 YVHzaE8EGaxXz6aG8LnmT5UWt3P9mOX6gBImUxbJvXMNESiW5w2rxseRIiKF8G1Ceb6xMx1sn
 RyhmRCA5+OcitHzHP3Ca4ySaRJkc6XQ3GuRbjsTlnOLpYXOzFM2N+xrQxxMWaq7Ej2FsuV56l
 i+vkfx+ecru+OP+ehU3+gKL2u2WWYWSCz6CViszAkU7Y2k8hD/L5OFLdJw5amTPD7hD6uYIIh
 CJ2Bhh8WeLtkWClvfVbDE7cgam5OBXrk0Aigg1IW0v3I1oMyn2Irg4RMJuu0d+ZIrkHMBugsK
 DqvVQwA3zzpECG+VksAFMasJn6aeZWzbA8BX7UiwvVrEOdSRq88w+VX6p8AimzTWyFOsLPA/N
 dPxW2JVnWp+nytRvRqaGm1bHG+t7oqWj7iuakk2M9AclYnAdh9gmNj7fUChOs6ZNQn5K16QjJ
 7rKsQeoFdW6pXJAOcn/V3hJuMVab5ONJOTxDfrfLDx3nzfggTeNMBIZWn1KqRtchmtqd062gs
 bNO1e6zHL/qIoovsuucAEKsd/6gPad5g+Lwd044BN05SRFUZvSv/lP1wvFYHoEgaNMF7MlTVO
 EzoOcTUrYdFi4moapEwgKPHby5l5b4lKrjxM0W5TbFjqvAWLie5e3zTzj758vCxZK91wAjGIX
 9Ennnk3
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Gesendet: Sonntag, 17. April 2022 um 01:30 Uhr
> Von: "Bjorn Helgaas" <helgaas@kernel.org>

thanks for first review

> On Sat, Apr 16, 2022 at 03:54:56PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > PCIe Lanes can be split to 2 slots with bifurcation.
> > Add support for this in existing pcie driver.
>
> Please s/pcie/PCIe/ in subject and above to be consistent.  You also
> have kind of a random usage in other patches.

will do

> Mention the DT property used for this in the commit log.

good point

noticed that i forgot to add it to pcie-bindings  (rockchip-dw-pcie.yaml).

> Is the "rockchip,bifurcation" DT property something that should be
> generalized so it's not rockchip-specific?  Other controllers are
> likely to support similar functionality.

I do not know if other controllers support similar functionality, but i ac=
k a property without vendor prefix is better. Should i use "bifurcation" a=
s name or do you think about a different name which is more generic?

regards Frank
