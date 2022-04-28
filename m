Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94451301A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiD1Jty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiD1Jbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:31:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95537CDF4;
        Thu, 28 Apr 2022 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651138074;
        bh=eFZgk6Xo2r3J4Uyb52jBFgNOfo4TczpA6Hj0VOCH+fc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KybraM88HC2T2G0LGan/LS+n9CzRPrOBDDIBvAioIqaWJNOLeUtVseyee/Y0T7Kcq
         LWdWNTWCbMfu2XeVGgMaoIUlf8cT79s1ygIPBCs02IebsHpjuz1z2uArPMqFlkZYh7
         Ee+IbmbZ2B5UfBhe/IOs3VVGYYs7cj3zkofscUNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.42] ([217.61.145.42]) by web-mail.gmx.net
 (3c-app-gmx-bs20.server.lan [172.19.170.72]) (via HTTP); Thu, 28 Apr 2022
 11:27:54 +0200
MIME-Version: 1.0
Message-ID: <trinity-3a10bccf-c3ed-479f-81c8-b48712f34432-1651138074158@3c-app-gmx-bs20>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Aw: Re: [RFC/RFT v2 03/11] dt-bindings: phy: rockchip: add PCIe v3
 constants
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 28 Apr 2022 11:27:54 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <918f5bc9-77f6-4d65-7432-ab53aadd6734@linaro.org>
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-4-linux@fw-web.de>
 <918f5bc9-77f6-4d65-7432-ab53aadd6734@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:wsQjhvHw03OY5IcD6GPw8L4IfaYMll709s1rJPu7F6jKvdMZbJupKHX3aXdWQlSwHl4rH
 q0y5TobR7HbHC3eFkpcjhICc9UC/uOE0OBigf/Wu1N6mJCT+t/Y//PUmpjx0gFT5kWUUrj3aEKIu
 E3/z8H9gidwVF9SoYPeD7VsBuhFfUkofarIvcD6lWGWP+ms+2Dwyg0dyMPWD1eJAO0zW11TA3L20
 oTr/fD+AB5krvbWGdwY9xiZIa2MMB/1XtU8Vz1gJPCBnnCullBnye99PKFJHKYRp2qpEPcsHZrzk
 Xc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:d32c7QI5lGY=:gXg4gqErt5WQuXniUhwPna
 dltdAKRieo9JCv/AzGBuT8q2L3ioqoFdiRHc2q8qiyy12CbQHMz7X6fW1Uy1CIwdI6UJQe1E7
 Z4jcGj5NeGCN2FRDkQ9fLB0jk1w088ZXcYNdPmJCCs4vSRzqGrk30ErRnv5V5Gjg74NQiLCtn
 oWDRW6Zq3XJxD7MGiStKRMovX+be8+4P/AZKm9KxdtL3845U0g4hv5qzTUQYwMmJTkgSwkaK/
 CNwzZkYCTI1DTJdozfvCBeUsXHmouGv2S9HQs0gD0R0rJt2kfJUvNaW/N9qYnSTqC86BAk1fG
 ndi5wWby4pQNhU5I5IgAVoYEjfjSH0bQG+LE6q6AcKnlMRq/6zlN7Y5CflytnkdzdVKxQD7Ty
 UkKfHelrUHw0NhNc6jLmYY99P580fVmpi/V0YEqLo2P/8umNsPdQstZhC+8a1nCEKKfEtwsVH
 qup3Ke+X3zFi+1bVLqAr7KfyMI8H15mAxWuWjafWV3qK1Rby8//TDmqxcS2u54swPpLwW4VYy
 MjP/T/OwLH9gsXNTuztUMQyO9uWOgtLouKBjDKM+Oe1Cj6ht8Fi1Sp6Ewk15fTurCgJ3Hs1hy
 CwGHvQ6RlntTKaR72EraJo2xy2qxLiPEURHAfmum56fL4cC8drgFm7JDuE5+07mV9gaXZRG8T
 0bugyhfpWo5lZa+J/EfvDT0M5EeswAo3tYJj4J0M7AOYutTU7agIs5tnlqNd/jtlSw4DCG37S
 +OazLnHHFjyshW+eY/UdJdTy1B0g2QmE0xHDT0WAQbHqSHUqak/vskqtUCXAAiOLxt+9IobXR
 xj4VJ/d
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

> Gesendet: Donnerstag, 28. April 2022 um 08:34 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>
> On 26/04/2022 15:21, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> >  include/dt-bindings/phy/phy-rockchip-pcie3.h | 21 +++++++++++++++++++=
+
>
> Naming - vendor,device.

ok, would rename to rockchip,pcie3-phy.h, is this ok?

> > --- /dev/null
> > +++ b/include/dt-bindings/phy/phy-rockchip-pcie3.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>
> s/MIT/BSD-2-clause/ just like bindings because it is part of it. Unless
> you took it from something and it is already licensed like that?

took this with this license from downstream-repo, only removed snps from n=
ame and changed name of include guarding.

regards Frank
