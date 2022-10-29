Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507556124CF
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ2R6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJ2R6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 13:58:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2859E9D;
        Sat, 29 Oct 2022 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667066288;
        bh=Kycf1XZFridgEvLb9sjdHDeiaD0OdfNkXClfb9amqkM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UsPVdHkaWEBcPgy9htvvrIQT3hEkQwmUwDBPienJyCYI+AtAFEhMYnchSg8bVHpDE
         KXGiLaczW5z8F2ZboyrXCSFynY+6bkbIbLnKTwp+/Aqnt+FbCV8ZdxoHFdgfWZ9MnK
         HACV4Ez82Q7R36/mUfZfaqoyfC9UV4A/9f5VOG7fVgYM5A/eTtlGyi28D9naCaoRpT
         YJqOjIaNvjYrBP4LpsQHOlAjZW7A0z5dk9MdZh1lVI2h2Cy0fCqzHF7Ef8C/J3FMMA
         38lV5nO+8naQVvGfkT5FZND5kgDVFdd7p8F4tP2FV0VBF5zLfwSxv2DeGpt0dVo1Yo
         rIV5o45YLi4uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1oYnny346I-00YeoW; Sat, 29
 Oct 2022 19:58:08 +0200
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
Date:   Sat, 29 Oct 2022 19:58:04 +0200
Message-Id: <20221029175806.14899-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O8JulodXz6iNhGWFYBR5Cj6XqvHcQPN5n3A5elUNyc8v/6ddcN+
 3m5Eu5scvKIpc/c0Kt2FhLfHZW5dLloOapBj6o6pCcZp1yom0ODWRqPJgcsGktaEY9JP3/M
 WJUYzqPrCZKNv+8Dd/xhS+wsYl6mCFjbwVC+0+4rJ76MwbE3AHJ0gM4jNrxe7SteSvFKp8f
 58ctIM3jobvwp6YsPlh0g==
UI-OutboundReport: notjunk:1;M01:P0:OqLcNjY3+us=;ZQkvU2y4h+VNqF0k6uFxn4tIBJz
 5lrhIWbcICbr+bMK9s0/2SAc1pzkYvfefzP+K91+7WS9TTDMYFJfZTCsU/27nCi4VQIGTAPKW
 ItbQnOzxKsZLQBpBslHH4ZIVYoeM09UA175b39Q5DX/CYvKQL6blmp4rrSBwPbau/EP4qgXQL
 Aweh9eBkE1iuVFdHVi0ajHsVOzX0fnICRG3YWCD++fSbZmlNshwGMXHLUkysNTAihOYK5snbE
 QPCB3mg9yJFR7IGysXo3iUjxIn4vq4A5onWUMgFO2KuaCylCs5AyFnxWfvllpB1W86w1XsbE/
 7P2ehVxeneM7W8dLUJYpumSw9jqmRHoqs0HASxsJH8llhLQHq4NmxADUEsTgvA/kxlayoWZ8Q
 srG4d8oafS0dXL/Rif70joKXFE9M00UattmjsfcG/Jklugu26slYv/cWtJFu10oUxf2zjX6jX
 bPB/BtvIMh47Yq3uW3KyBo0rg7zSJZ5AMh9zYkn9AMrKocUT95du0xAE88Q0g2cU1j9wQDjWc
 NqYZgxzHtNEVZKsRPgyReYw9fC+1OEzuzI09rnE2k5e5y5dC/iwaBKGfT8Czk++q8r+NKg83o
 G0DYHcqpjBAvPK4kfra1uKfoCn3kBTx9U0ydFMfJRUHb2TSCAtnhsUqzKcdBvtwbQF5RDqcOD
 BsFtmr6u3XV5n3oJiY5o42oH8owrWi57++QuyUjI+lEmmg3lkfdE5K2NLKILaFsW3Lpw2d1JG
 o7nZ4YsZW5u+uXZl/cDIsg0dysbJzl/o8E+q6FgwK0JYj298vaASGmNyVOoC8jbPUu544T9OL
 J8vjL4f24ZmEFqha6omdjRvPM+jeZOdpQ7/lAVGnG3UwIfm4Cjpm/iwtRNifnpzccVqMh235i
 BlmnWJlv8nRUOdc+zDoSvhCPscOybAdXl8TGtQshppD7YKyo2jrAeDckV2lRYpu8vDSxDYOuD
 2BiOTg==
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

