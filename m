Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFD510567
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiDZRbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiDZRbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 13:31:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7E6F499;
        Tue, 26 Apr 2022 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650994054;
        bh=Ji+YlFlgCJoaZr9s7YJfnFKefy+/b9Uqn2Dl6qplgqs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PvlYceu8Uw36m7FLf8OmUfJ0plYzd9gG4Vk1xj7VhqKa7DiQ6hYZaAaT9vt1Ac4jQ
         MkAhYUu6CK2oXBB2uAW/jFJZW+IFXkCdTm1RqzMwWKUw+Ib4cdGWeAhk3h2lU/oQkK
         mc4+eIpkQbEQXmNYd/H6M0lEEq5Fshz0mt1/ucnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.37] ([80.245.77.37]) by web-mail.gmx.net
 (3c-app-gmx-bs69.server.lan [172.19.170.214]) (via HTTP); Tue, 26 Apr 2022
 19:27:34 +0200
MIME-Version: 1.0
Message-ID: <trinity-645b0d5b-4366-492c-9cdb-71d9e8664d31-1650994054170@3c-app-gmx-bs69>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Aw: Re: [RFC/RFT v2 09/11] dt-bindings: pci: add lane-map to
 rockchip PCIe binding
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 26 Apr 2022 19:27:34 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220426160409.GA1731042@bhelgaas>
References: <20220426132139.26761-10-linux@fw-web.de>
 <20220426160409.GA1731042@bhelgaas>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:1rhhhhwJUPynO1hGrbADbceOZiAPFPYXAkcyO4s521P1UX6wtPdRfIHJy4WiMKxdAl9Ga
 GZ036BRlqUZgnEmkKqpDYX10GXbjs7L7gj77aheAhHIJ4WhJQAEKJqna8qKGVMGnDu9UDoumdOQT
 jjis+uJsD/gDlM3RfgRLoo6M+sFc8wmx0Gvy2QV84L4tYdvHno4qokH1GLC1vMM0XIJka0HR8wlS
 7+fTOSkAPhiU4QTyr4LuIZmXLg0SIlDvdIe5iqorZl41D5rOBZTYkdzBbAAWoSSyOFfjDiqtaMwq
 jY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojw4Vv6ZXVk=:EcxcpbnZ5B5Qr+pY1IynEG
 HH4mjHal3oseLf72R3WAZEcL/SuJ/yx8lZpb86KWRYFS9a5rxZVjLU6LKBqVGv5ox2CIn1f01
 zdpazMYqLhnAWqlezZj9eyhc2THUi1xpIZ3UNgg8tIlSGA8WVYjfzTyq6FbElu5nDhN+OQR2T
 lNoCp4oy5jb7QKDtcjL4b2RKbHkzw0di4mzCalljbLq41w3xuANAd9s+bjd4mXsjCRYywZKke
 ZXdQ2MAbfdRZubwuqVgBCE+gIeTMZZmFGZhVHuZtorufufPF1mOjsVCpYuBvezvy9eEUR1z5r
 gDJofj9bBKvlK9VKZCDgYyZwBQ3Q14wdEF4SLcl6kxZIpNtQN/ZlCgqqlwhxN+94HtB8X3QyN
 ZQKTVn3FxCGyKY7tt8AY2PSvtNxL0FWSOY7z9INBhnaTIy3Ul0o2F0YgH+dxhcpAnLr8qEmET
 rnp1BV762m7kZJhzPyJl35gWC+bmHTEZhOE83O2a30DBmt64E/RS9dUbg/9QE4VJxbXEBVi9q
 Be1w1LHwPJwJgKGxYsaLQRQt1J8zz84p0IuGU0vzkLcINXeytxDsA1cmQXeBahH/CdosgylEw
 OLia6Xzw52zK+uwGm4Ri3/3Lbt5N4s8w6b5h0mm902JHSj1F6jrTUfdK3wQZrCno/H2AyP2R4
 //pXv6VwHSLc0Nr0h8n3OscVtmrTC+wrCx/jffY5fv+b/DMRB/3BQ7o4zawD2qlTAAqKrONLh
 sgACckEnTD4Mcjdn+2UoLcdYbC+S8aoaHUtbjJL11j5Sh5L5g1VK/yNdez9R9F7sT34Kz+STn
 KI/Arl9
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Gesendet: Dienstag, 26. April 2022 um 18:04 Uhr
> Von: "Bjorn Helgaas" <helgaas@kernel.org>

> > -  bifurcation: true
> > -
>
> Why are you adding "bifurcation" earlier in the series, then
> immediately removing it?  Why not just add "lane-map" directly and
> never mention "bifurcation" in the DT at all?

The original driver used the bifurcation property with vendor prefix which=
 i have dropped.

In v1 there was an Idea to replace this bifurcation setting by something m=
ore
generic supporting more that just true/false. So i added lane-map to start
discussion if this is the right way or if i should leave the bifurcation p=
roperty.

if the lane-map is right, i squash the commits before the commits should l=
and in linux...
this is one cause i tagged the series as RFC.

regards Frank
