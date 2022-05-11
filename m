Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB83523E88
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiEKULv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiEKUK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:10:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62232CC98;
        Wed, 11 May 2022 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652299823;
        bh=rBD/54OGORHu5g6jadCEHPsFOTceD/67+Fe7usVP7p8=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=ZSsfderyogWJZrYK9niYNnVJVTFkdzsvfAVrlCpbR7XUbBU1/tF36Pe061+pso463
         2sIBACOd5v4AQedtBR1XgrBxyCpqdib/KacP979R1brutN4MeKR/ZvtsVG6rTZY3Hi
         j+iLz1CdMzEzZxxYEYgwsf7AaioS4LZxQYQ9R2U8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([157.180.226.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1nutRi0pbh-013LOo; Wed, 11
 May 2022 22:10:23 +0200
Date:   Wed, 11 May 2022 22:10:19 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <9E2565E4-DBF3-4324-BE1F-4C20C6FB95EA@gmail.com>
References: <20220416135458.104048-1-linux@fw-web.de> <9E2565E4-DBF3-4324-BE1F-4C20C6FB95EA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC/RFT 0/6] RK3568 PCIe V3 support
Reply-to: frank-w@public-files.de
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Peter Geis <pgwipeout@gmail.com>
CC:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <A93F0CED-D363-4B16-BB49-2EFB569F0EFE@public-files.de>
X-Provags-ID: V03:K1:xhkaGCZurrZq98AQosYA1qdyfC2dWrfKqJ5+bZbZfcK7P8zcRjz
 AJs3LMH3ZRysCQK+yzpB9g5BzhV12dHBLpsi0IEhxg6r/jWwfIUFv9liVu1Cq/HrCNpgb1F
 SBZltFMe5jjMHL6cgsK3URh38YciE7y9fbSuq6WjdQ5Nvs4LlfUQQyyFXTYbNX7aYA5Dj1h
 L3+HRpoCa/YhN8u4q8sZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f8GKdfj5I5U=:pmOHV7GH1K2ZeSmVuoMme3
 jNezhOBNBQbA7T9Uaeeyedhb5G5H5fyYCPLo0Wel2zSyXl/PqQK0ZofTaMyAAgPrZ1lXgeNAV
 CM+Q6M5yJz/aWyuCVnNG1kFCXT90+LfFfw4WjlGoqN8wA6Zt0KivAL0L+nVV//3vLNF/hMxQT
 hbZPuNXNm7EWb4ZsvKW73eDuvnwR4HxBIkso8qZjw7O3dtx04d+qV/921GTdn1Lvjrxo9eWnU
 lTleUvV6nA9AlZsT+5ag10GXEha563xzQosN/yIs6JtZkuX5hdgr3/+yd3/BTxawmysR+Oc/g
 U8lfg2EdycTjk9C/AIedAAHUv8AS5KRBslER4usE3NQUqSArIwZ7aCnIclPcDbjPe7oCw0OVu
 5noW4sfkxUiQOHpXDB8u+LrMVv6YFBfqp2vVU//UvWjF0oRc6DJFiQcCeSUYZ3dmYBNdQbj3n
 m63lDib6xOGd6S2vWoPlLeYFEl09s5T9DDmT9d70PS0IJ4Oz+l7z0KguW/154FTnekCmXk+ir
 cpsdGCHXIv3ZuVft30EBJsGjFX4Lol2OsgJFx2s1ZElKDOw6CNXH7xG+UdIsHLD7R/qyyRCth
 qCeDc+xqjE2PZ5cCIkNeGHYr7kz0+7/unoWwf9SLI5koWf/6L/ro9HBzoT47bbzTPLI0tjmGP
 PIDStSVCLHDWLe7zWfndcA4Awf5uDCj2pNtsfdTf75fWMyvYi+ufj0dmGozDL/x4BV7s80djS
 rr8W7kX/YZymGoLXbZmspf6Uuvd6q1GTyDdgy1HM1q4ebHsOWzqaEFuUwfSNT1/8N6Nzgl+T3
 EuUjWgWTgWlFUGNHD7P0bNLENjBs+xqjhfAIGeFQkqhWyG7qusH0bUiT2dPSf/lTmcxY+OQaq
 iwXQ+wSDQfSalcwVnucUmPxTkOzPvcFbQ3JzxULGD4wtQWN9M+1SMJ7R3B50hMYR0AFj3dbwU
 et+0B7Mn84oAjle9NCRO8cfWbg548IHUceoWdZABh45avPdP9/XF9/KRv8fTUr2zTGcxkCFLK
 3VY0A2m5ltuf1BnwHCmzhLacRnWfseSZ2Z++qtpKZjqlp1sp0Lo/SJFqfczGbx3ptQwm7Pt/a
 sq7Y5u2Y2zfVg6bVtW+6Oj3+yZRwHxBipbPRTxv15nD60Ec/AnUW+6cjQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 11=2E Mai 2022 21:26:09 MESZ schrieb Piotr Oniszczuk <piotr=2Eoniszczuk@=
gmail=2Ecom>:

>Frank, Peter
>
>FYI:=20
>This series gives me nicely working PCI-e WiFi M2 iwl7265 module on
>rock3-a=2E
>Great work!

Hi,

Peter recently made some fixes and improvements=2E I plan to send new vers=
ion soon=2E

You're welcome to test it on your board and give a Tested-by tag
regards Frank
