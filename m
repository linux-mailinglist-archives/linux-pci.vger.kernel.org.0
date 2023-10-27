Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E17D9C3F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbjJ0Oz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0Oz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 10:55:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FF18F;
        Fri, 27 Oct 2023 07:55:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507d1cc0538so3006190e87.2;
        Fri, 27 Oct 2023 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418522; x=1699023322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96q2m+4Ifyz64+2ug+CpD5T9xkfpfc0ZrC+g4yfpz0Q=;
        b=a9Xd3cXC4A8un+PwMwB9/632NvYpf5RPS7qi4A7TbRWXkykSvMMmMk4f3IQgPDiHdI
         9eWOtEkxKJo8PX73rrzWC+WoxNCyG1cNeXlc4g2h1SlAWl2A6/0slPpl0f0UNL3iSfSn
         Jg9jD+QQXvO4f/03VhNoNqZwO1YdX46dHj3cB+DGQJkbOMVvEQMED1puG8KwksuddeAv
         VMt1T5eqco1RJcgas9JM8V5GJrEJaMAbr1m54HNUkFcoTKEHtxNZEkzmXV0qyKhprXRm
         lcFLQZtR/8KGmVXo3Up54EDxg3iQQ0p6kPsKzjeUmC/bNM0mj1MavIN0GSIzWhE3+hif
         dyKg==
X-Gm-Message-State: AOJu0YwfrW8CW4EIMMfKJWmUDytFcy+vTvzsyH9caSjn+vNddU2pFAsb
        jZXmVWnyw6uP7wWtOSXBxHhnLz1DQ/8xdw==
X-Google-Smtp-Source: AGHT+IGTboKD9jMb7/hBmso6C/UneNnywnRJgshy+qZSsrD9DLKmDD8KZOGjyTNRaEtp6KbviSZsHw==
X-Received: by 2002:a05:6512:1cf:b0:505:7113:1d0f with SMTP id f15-20020a05651201cf00b0050571131d0fmr1832796lfp.13.1698418521865;
        Fri, 27 Oct 2023 07:55:21 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id f27-20020ac251bb000000b004fce9e8c390sm300568lfk.63.2023.10.27.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:55:21 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 9D4A91C9C; Fri, 27 Oct 2023 16:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418520; bh=XYooW2tHRjOShIGkDb+fj10MVq3/bsytYnpauhlZIqY=;
        h=From:To:Cc:Subject:Date:From;
        b=J1xjYv40kbD+W+ttDfblGQyAdquc0NwFIqEDly6iGANmKuRC0PbRUytvJ+yIFr06J
         aR9uzf3PTvKC2PpY86MTywOHb1qdPmlBQ0LkO/ZQlGkCBNU9QI4AFmMGeOmj6uXZpo
         bQxnsAsXp71lwT83/SOVGy/7NwaApU+klyX/WEaI=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 845F119B2;
        Fri, 27 Oct 2023 16:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418482; bh=XYooW2tHRjOShIGkDb+fj10MVq3/bsytYnpauhlZIqY=;
        h=From:To:Cc:Subject:Date:From;
        b=udVsIis1vxBWe+//VugcXqyHpywZBrG1PIQ4pKYAWuOb/PK7v+gXTvqIrhYA5jeg/
         0v+ik5Wg7d3nJj/Ot1HPEcFTokk2wqCUX4pgVGbVdYzWFWh3kCX1AraDPF/o3qadm1
         R+k0MAx6nYXCVIgvY4rL0+U8C32vQspG/qgcPFH4=
From:   Niklas Cassel <nks@flawful.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/6] rockchip DWC PCIe improvements
Date:   Fri, 27 Oct 2023 16:54:12 +0200
Message-ID: <20231027145422.40265-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Hello,

This series adds the iATU region to all rockchip DWC PCIe compatibles,
such that the driver can properly runtime detect all inbound iATU and
outbound iATUs. (The actual number of inbound/outbound iATUs differ,
but can be up to 16 inbound iATUs and 16 outbound iATUs.)

It also adds the interrupts for the eDMA on rk3588, such that the embedded
DMA controller is properly detected, and can be used to offload data
transfers.

We also remove unused device tree properties num-ib-windows/num-ob-windows
that are unsed by the code. (Instead the driver depends on the iATU region
being specified in the device tree.)


Changes since v2:
-Added patch to drop unused properties num-{ib,ob}-windows.
-Added patch that adds atu reg also for rk3568.
-Make atu reg mandatory (since both rk3568 and rk3588 defines it).
-Include eDMA region in iATU region, as suggested by snps,dw-pcie.yaml.


Kind regards,
Niklas

Niklas Cassel (6):
  dt-bindings: PCI: dwc: rockchip: Add mandatory atu reg
  dt-bindings: PCI: dwc: rockchip: Add optional dma interrupts
  arm64: dts: rockchip: drop unused properties num-{ib,ob}-windows
  arm64: dts: rockchip: add missing mandatory rk3568 PCIe atu reg
  arm64: dts: rockchip: add missing mandatory rk3588 PCIe atu reg
  arm64: dts: rockchip: add missing rk3588 PCIe eDMA interrupts

 .../bindings/pci/rockchip-dw-pcie.yaml        | 29 +++++++++++++++---
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dts   |  2 --
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 18 +++++------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  9 +++---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 30 ++++++++++++-------
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 14 +++++----
 6 files changed, 64 insertions(+), 38 deletions(-)

-- 
2.41.0

