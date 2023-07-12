Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5399A7504DF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGLKju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGLKjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 06:39:47 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11401BCB
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=hAryLDGRrsOSmX
        ERGiB+C1mBG99Cn/6s0lKFEG1FTPQ=; b=YXoWev0KyTGtvp+bj7nkmCNVCELEw+
        7TTy1JM9WhcgH+DQN9VUFr2SPCn9phdr6tmdNK1tmWbnG4q34QnM5uBw2vXV/vw3
        C+a7gZCtEkSpZwPBCR8aroMGQ8Q2Gb0Eh6ZPVKC9xkNxg3ujXY8e6RJPcT2nNk+c
        brtM9aBbEly14fgbVJB8Cj0ZlZJXePS59UYVMBZm2WPr6jTNqaM+GuhHc6Odgl8I
        nfhxFxhW1CQULqJd1xViLFVU+jT8OZpvYi6NYR09q3Kv4Hpt6o923FMLSmu1Xu5i
        NffGMwECvpLzLwyS0XNrmgcneI1DUcwwwHg6s+OpL7DhtT0W8f619ckg==
Received: (qmail 1580036 invoked from network); 12 Jul 2023 12:39:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 12:39:38 +0200
X-UD-Smtp-Session: l3s3148p1@WKjb1EcA/L0ujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 RESEND 0/2] KingFisher: support regulators for PCIe
Date:   Wed, 12 Jul 2023 12:39:14 +0200
Message-Id: <20230712103916.1631-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here are the patches to make PCIe cards work in the slot CN15 on a
KingFisher board. No code changes since v3, only rebased to 6.5-rc1 and
Geert's tag on patch 2 added. I think all the acks are now in place.
Please apply.

Wolfram Sang (2):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators

 .../devicetree/bindings/pci/rcar-pci-host.yaml   | 11 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c          | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.30.2

