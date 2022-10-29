Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7716124C1
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 19:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ2Rz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2Rz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 13:55:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE076B48;
        Sat, 29 Oct 2022 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667066124;
        bh=Kycf1XZFridgEvLb9sjdHDeiaD0OdfNkXClfb9amqkM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=a95ybDL6/m6NouR77Vfx/jrjpFe+vsBdD/+3panVqt9YNUw3PMjZysOt8njrj1aMt
         iQpVwmgSmAPG3zy7QNXbzJpaPRI+yQQoxyf5bRsA9sW05OVtnOtqFgRRSdVgYRaozu
         c5yrYq19bS46YJt5pcTTgKXFQlJnRJ1dGmZNFokvWRdZEex+pY/wvaxKXxc8IAfZxh
         2SkeDqXOBR2oQhvclZ8JYRvltBviOjtbtLcP5rOkMoEXy1YDdi0Qad4IsB6Pmq7nfT
         LgmIWHvf9eFnmQqUBWh0nWN5B9T0ao4Xs93bPOTgl2kcW9yzupreJbeRq8fPBCaJ1G
         poNPNV1Ac8pRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1os7qq0I7w-00EJMD; Sat, 29
 Oct 2022 19:55:24 +0200
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
Date:   Sat, 29 Oct 2022 19:55:13 +0200
Message-Id: <20221029175515.14526-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KxEWb7itPFWpTFXDzdkAlZkhTG+OLCfGNO1UX1xRxoigacLZp9n
 BHAdDh48FNV7BvYDFaZKZDAtM7nqke88BIiDjCNhLmveo9xisVCE3CzkDCw5JIxop09tCGn
 Of5NB7MZNqULn+zl8Wa3RI8EJgXmUbdmSmEnOX0vqbcsBBCne0xeq0syWyZXq6zbgKQaOhx
 qmr9cuOq9bdLj5o/oPjiw==
UI-OutboundReport: notjunk:1;M01:P0:UgbdyR0oegs=;WsBLUDG5xSh2G2iV4ajaVN6GcL4
 RxEPfjzboRWB7yNWnDB5IEJ1h+CD0fSkRtJYJXIaABYBJYdEBYi3a2gHL85n+yac2sgXPQVqh
 6st5Yuj+ipW3YPHU8DHQKAPH2avYDAwPd4aue9SKqFYaWwfcWgwd2IZRGJ1Qa0hbGlbb4Lcz1
 2IQdWus23mLM94MjwqSZlaCrODvisBHSLypch6jTUwJYH3m/BzvMz0UEY1pSp+6Sm/QilzOUm
 hUm910tYeWJxWUyBtqAtddpV9HlyzQ+55ZKuTpgoMdCftvq2n2SPB9xMSrkDSp2idUXE0Wz8v
 0ZfF6n3UYi0qFJBsxvbhLvIiJjcVYOVw3RQKRpmKy1qLgLIiPn60Bq0KHXR0w2LkUhJII1u32
 CFUl9EhdcnxdCmmRs48RwiCd23E388r66pgLb1qlH4PFjax9Ff16zoPD0BdyfKOEpMCNWw/b1
 0myOWaYZEZftAqJ8Jrif3zkr4DpJXY4jEYgH9IykGANnxzCJdHKAYbTSHLHsZs0d8iGIjvXv6
 SfSG/M9SlUqZJlbGTt2g2HN4zg4m/USyGBwEKwgwdPjuUgIW8LWXo8t1soi1s+abWwT3IVPNt
 N1rHMSB6rxr+oebOTrMrcCilwWJqLLuhWqiYGqqsCIO3pUJVx1NfGx8SvNR+noWNpsaxjZmor
 JoaDvEz5huovWu9hBe6ukU54JpLVM1SUKuF5gvQNP5V++k9gV8f+uXuiDUbS//b6LOutVe+yN
 IzoAGooUqgFONwiR/hD6kNjuH+dd/ZK9bXQgq17J/f7ZpaOa01hZ9zzEAxLGFmRiNqUPUGwcj
 lgR8d1RtVMZV+nw9j+9hyQjLyRuwqVv+J3gzR0Pj4zmOU6fGR/perUtEm1dUbCDjIdSHf8Eq2
 LDEuZdIvTi9j8KNkIUICEMGDWwSNkoZGAGqHIMN+9A9CYPaQktS1DWOSEUpDBQ2J8ouf4YOI0
 6d7U9g==
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

