Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787F612451
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2PxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ2PxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 11:53:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDB2BE19;
        Sat, 29 Oct 2022 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667058753;
        bh=Kycf1XZFridgEvLb9sjdHDeiaD0OdfNkXClfb9amqkM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hw0j53BVtFbC1xnqlHkNqtba6jEmor1AECidmrkh3ggV/tYuIXNsb8DlqLOBpKPUW
         qCWZo+dk/rPSKumoAY/NC0zkXxDY5wUdATd7JhGrjWuNHiOWF/KMjA9CJZDhsikVji
         cv9zyWW+2NbST3BAi67O9QIqegtE7QctujJUP47s5mhxwPAsqBEokJsWep8BCIdbqH
         3Pa8np+C5TMVSc1gsq+O4BepvCsB1Drrz/+dxf700LTOdmKVmwIAiT+T53men9WeMK
         T7b2guUVjmFG/VDi74Jz/cH18ymAKWoyclI0GScHy1hKulDNheWxyYwGt5BOirElK4
         1B6uzTaVebU9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1pBism26KD-013Kf9; Sat, 29
 Oct 2022 17:52:33 +0200
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
Date:   Sat, 29 Oct 2022 17:52:23 +0200
Message-Id: <20221029155225.7104-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:diT2Gefmafn/nZ+zWz2K9Sc7U/zf7MWKJVX6SrzI9Fk1bXLYPHD
 o1XqCd1Ag1j6hIDROr6UzLx43dkgDd+7JZu8NSLvyAnG0dWiBqAt6v6JouGaJnzBzBOHM0z
 8rpAcRv0Lvsx/BrnBOQ0xX8cIUBToqff+sTKW5AFQlVRIsTpRLRNNhRBw1uJKGOP2cQz7R1
 jvWHNfvQf7mBWY31E5Gag==
UI-OutboundReport: notjunk:1;M01:P0:n9GfSGB0G2w=;ZjGUNKuL/LJM8mRrT1iGH82btnK
 OAESaaRGx0UxdcBWNW8gvgEleJGJ7JSxpxUDkfzScm4UyQx960VlXBPZdnn277knBdtd75ZFN
 JAqdy+H7R7LdBgDqhaRg5jDwtLulhJkDLOKFBWc2CdJ+xHQnHrQbhYhQUykQQ8hD+LtNADit2
 k9GHCzwCSg1ff0+QzbJ3IhqhdT8Zbj/3wN2juKSfKm9C/Yguq4JDfPxEqP1vss+5yt8Pyv+Bj
 OV+KDHtSb4nKE2ZzkGR4d/N+VMSFd5pxdlHv/oDFShf0w762npceEPhwgCoCsf9AC8ipPq2ix
 MI0tByo+oUv+q8qKF7lyV5o80T+mmnTYABJKXKIzUUR8pfD8QZkJ5Axv5To9iiPPtr9ppEf2l
 6ORf0/7bn5WIsuPFTl6cem2Oq45KyKNfrhVy1BTPvRbbw2eHIB8p/hChp08eR1tsjgeO93eME
 koNIk4u/VaE5wT681X+m3YuBjdWUT2llAEb1H2kqfshYkLOGYD3N49lsNwPjOfMhQqYVYdmYg
 UnYArzVoC0Nfb6KBbZJdZHuCQpCYcUf43kCZJU7+BHsTVm3pFRqv/8JIF8gRuQIhKPtF6GfHn
 a61q1Gu67yI1BZU0TwYcLngRqfPHomE2B/e+7qtFZTHlWXwzeNHEy/qvpA4HS8WDdc6ibuk+Q
 9hhmlvZElw+EVqNVlTK67K245fQelDUOQHScvnadyeUTMO6JZKqLslJ4DJgO88zjdKkwGlgcH
 id4TO/fGhHwPb6sq9TsDvxrjb8isAbB2XSPSRwlJt5Z0q+s7F5M2R5HDg82QOnYh/uVEyoOcC
 61Ci5VJhKnH/Llqixke9UI1RPR/DQJK3HhYkG3B7+wo+NYwD0j+Gvo2QqVgHGNx8I4xSxwPg+
 KCd0Ow5Fy0ulNWXqEd+TwkpUVe6vHsT8V0Oda9gRQI7TkSDHzDKoW47tto9M9R1gj+jwyd1tq
 3RyW6rsdbQB/IO2sBzMomyTlX9c=
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

