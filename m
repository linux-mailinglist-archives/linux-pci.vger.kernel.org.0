Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9A6124C3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ2R6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2R6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 13:58:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961D59709;
        Sat, 29 Oct 2022 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667066264;
        bh=Kycf1XZFridgEvLb9sjdHDeiaD0OdfNkXClfb9amqkM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gcDPqIPhiTQ+pzawxtf3bhnipr/GmH4NIl1X328jXZCo/YAMUuCL6R/DBgEYClYml
         6/T2OrL+UQ/P0ZpD6GlNyAi16LmxnSVlz+EVpukOLDiLCIgCbq4Z6YAEXg0eMuR8cn
         JCqG7Ovm9/BBnXRusyYYAl4GJODfvhDjJhVspLYb8+DN5uLxd++yiqjvuNLr+8AQtm
         o3W6EBKNwvAEgs7TjmgG9aG9TE86SRvX+pv/nzh6VxO5yKrxS+neNXMocROTvm/4kn
         FJMp6egebAxgDfF/d1Kp41K1U9HuPpsXT5hiChZbn1eAPkem4/Q5tLxpjUIPi6T/k8
         WhHafbOUhO8VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1ohyKH2HzV-006sfm; Sat, 29
 Oct 2022 19:57:44 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] rework mtk pcie-gen3 bindings and support mt7986
Date:   Sat, 29 Oct 2022 19:57:35 +0200
Message-Id: <20221029175737.14834-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y9FHqWI6q/ps50bB8NVirHxE+56q04DIKv1dG+cnZsKTTeVERc8
 KfhfxYgV30IQD4KTR8uYZEAkj7lV2sUY3rQfOuHELKIAOCvg3cw3r0FbuizmYBGh4Cf24ur
 IBP8a1RVZ/+qN49KsTKpaPXoOJ6JV2o1i55we0LCBKfvCBizXhqv/wfTufFYOVdB/4z85ml
 FPsi5rhHMTHcgD/LwzG5A==
UI-OutboundReport: notjunk:1;M01:P0:R/lddGv2HO0=;S3AAUs1/LjWeXAC1CYf7F4QMJSn
 ide6VGdiypJSGD5BMUXOwmp2JkmqcDtRPfWVx4kMqnqtb2D+F+LmJMa2Dd75eF/h3YWjKR+Gp
 kuopi+qQBpnNalVwpurqAARZgFlT0w7Cm+eSbqpBWXZRRDGWuUM1ic/5o+O3BagOvLVlh3NiJ
 YQ6QA0ZWoWa4cUphFktKrf/MD0Jqq/2FTcFYFXAHlnAQ3Kj7F+o6zUjQAvuUtm29CAe/ctnpU
 WY0CwfBDF63j9M4P5yYDL3oy3lwH7h4SXRkQIheTQ7F15Rp0YUNZ79ILPZ7CxPnriTvNiVhj4
 cNz1KrKCR6nZ6+XVNazv0SL68bTi/QjVJlMadQI1H6HuhU1PPHkH76CjVN3m/QB1w28Fqj8Sm
 dW6dlvUbQYrodrmCukxGqHvIM7O7ljbClTFWmxtpO985FPsTQ1cWkYchCFk4H0nHJD55qrfb8
 Zjw6gYvSPMfG32grGW3u9N7624YbpImipfXT5uo2alJfmXEf+siZttiwY1adVFIILV2uyGaR/
 9BHIqr8HDASyEWjWjemHCzxwpbshYjGsKjgax9Lwbt4J8UyXM/QpTWB/wwFsPw5zhkFX7enO/
 urBvIXDsInHsJ4U2j1iw+3/ffOYg5kFANsXe1iczkWEI9Dy9mq4oO8LYu41qvZRgCLBo07wNY
 oDsW17Tyr38NTwM6s7IsRX3SJS6C7FG23AsX2nbMj1oEpOxk3HwwKI+kW+yTlBMJq7aZyO3Bh
 T7StM4cejMBmjOh5xQCoiuazYDHi7+MIOg4EGE0MCZHObGWDO35pFN5Dm9lADVsYRQ7pncptb
 zGfIgJOzzaHlO7FrThGGNV4jqrGeBuAuBFdl/C6iqfoltleWiHgQo3l44KXTDKUCwyiv28CPQ
 wp9DpiKEjgvByZ6eKyFrvElw2D2v5rFs74jVOLUzcIKREBuNu4AcCv9UIRKEQHD+gmJ79z0cm
 c2OaKrkE+EQJPRRB8oNFzupmghE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Series prepares support for mt7986 PCIe which is basicly gen3 PCIe
but with slightly differnt clock configuration.

To make differences better to read i split the exiting bindings which
has already different settings with a compatible switch and then add a
new one for mt7986.

v2:
- fixed typo in part 1 (SoC based config)
- squashed part2+3 (compatible and clock config for mt7986)

v3:
- fixed problem with fallback-compatible not compatible to main

Frank Wunderlich (2):
  dt-bindings: PCI: mediatek-gen3: add SoC based clock config
  dt-bindings: PCI: mediatek-gen3: add support for mt7986

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 64 +++++++++++++++----
 1 file changed, 52 insertions(+), 12 deletions(-)

=2D-
2.34.1

