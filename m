Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E15523D5C
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiEKT01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346813AbiEKT0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 15:26:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98926109;
        Wed, 11 May 2022 12:26:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u23so5316954lfc.1;
        Wed, 11 May 2022 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TAIvow1w3Et+3EUX6RKiHJdrCLZdYL3A3uXuaUYdtpA=;
        b=V713DS1JCS6qIh5Klw7+BbgJh4RBaaNWS8aYlzkD9Nq37WNfYf/Lg4ittzS8AMMVv/
         kP7VUwtiQoakcEW8e9wk1JC/MIL3mQ7UpJZQQvDMJ/CTABzcj5gkywF68X21Pd/Upr6e
         1EjOM0VHpDXUSjDUO+RddUBYocL2Kh/6Nnvnd2GTRxUAoHrmSPlX0Pbmd9lrVzAIIKym
         zJrByGbel8/FGgtqQKnpnOMLPuxUDusCXxzfG92W+tOGisH0AmnLiBuDCbjQLRs3xXEC
         FExiKLRBw0Wrkejpti0qhRTNmPeyL8swcvymSYnAoeZKQcu2KHfH/lQdMp+r5BxECgXI
         Qnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TAIvow1w3Et+3EUX6RKiHJdrCLZdYL3A3uXuaUYdtpA=;
        b=btDnBpWgRGcWTK0rHS2HBp8rUecmH6PW48dPb/V0ONTdSdQ4mzzMegNsQhPrGSicL9
         eRHgT7lb8rFVJv66rqTN3OLJMA6CAl2PTXl+/LSBZl4RFHEPBogvG03iANCI/G8FRDmA
         pzH306NtJkjYMF+2+TwX2ysywwLQDi+L0tTe7k8wq7uZJQmVe4dUneZgy+odabzfkhfP
         zDv/LlojwX/r6HpXNoc8ndefQyKToltAmGMXP0AKCvP1qjM9cMA/3kCJsr+IZqONFYty
         XcmV6R6z3ZtVEK/IVev7XCw13OEdfa66FaSzC99YagItvi00tlyJIIrAi++IQ8Fy++ke
         7sJw==
X-Gm-Message-State: AOAM530VwvIEXKPmZmW7M1f/EwmRmNJRvN0LE2/shYNlKy4yr5dwvfdk
        lHzG0jH0AxUWxFhpv/aYyWs=
X-Google-Smtp-Source: ABdhPJyu5Qf/d2LtNP4I7uWFCrmVH4cTwPhUEAQWDxrQhVhT85X00ycU/nNHTnxMJIBVbYsl4NwbxA==
X-Received: by 2002:a05:6512:1196:b0:473:be8f:e921 with SMTP id g22-20020a056512119600b00473be8fe921mr21626419lfr.242.1652297176346;
        Wed, 11 May 2022 12:26:16 -0700 (PDT)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651c088700b0024f3d1dae93sm494219ljq.27.2022.05.11.12.26.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 12:26:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC/RFT 0/6] RK3568 PCIe V3 support
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20220416135458.104048-1-linux@fw-web.de>
Date:   Wed, 11 May 2022 21:26:09 +0200
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E2565E4-DBF3-4324-BE1F-4C20C6FB95EA@gmail.com>
References: <20220416135458.104048-1-linux@fw-web.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Frank Wunderlich <linux@fw-web.de> =
w dniu 16.04.2022, o godz. 15:54:
>=20
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> This series adds Rockchip PCIe V3 support found on rk3568 SOC.
>=20
> It is based on "Enable rk356x PCIe controller" series of Peter Geis
> v7: =
https://patchwork.kernel.org/project/linux-rockchip/cover/20220416110507.6=
42398-1-pgwipeout@gmail.com/
>=20
> Compared to PCIeV2 which uses the Naneng combphy, pciev3
> uses a dedicated pci-phy.
>=20
> Frank Wunderlich (6):
>  dt-bindings: phy: rockchip: add pcie3 phy
>  dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
>  phy: rockchip: Support pcie v3
>  PCI: rockchip-dwc: add pcie bifurcation
>  arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
>  arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro

Frank, Peter

FYI:=20
This series gives me nicely working PCI-e WiFi M2 iwl7265 module on =
rock3-a.
Great work!


