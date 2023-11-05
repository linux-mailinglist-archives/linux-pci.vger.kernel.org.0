Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631527E12C5
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjKEJ3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Nov 2023 04:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJ3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Nov 2023 04:29:20 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B53EE
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 01:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=4dwyhc7I5VMK+p
        3joAdQ6muDlyj3lJuFlgGGOnOLLkM=; b=GOqsPTQgSakmrjtRYAs0RNIjZY7DM9
        2mY6o3VlX4huWsGyJs2yTgEpgrICr2KSM3ToL1DPIfKkx6tYWIKMJGdwGypuUCyj
        JGu28X97KaHSoMHnxURUf++gozdPrtWWNzgowUeKcOZkWWx/aLso0S76DxxCpBHE
        OfXURWT2z2s1MC7VzTvkc3eFYpqaNcxREsjR9XEPBh0foJZsf2Y/DbehZkOQrd8c
        U+D+Wd3f43E7LUkKb+QnGrmMPomHYyNTdRLB8ilOy3bjHNxi1OcivmPkNI7u0oQt
        s8AEu4in1EaqkMA8BEgGp+70+Sb6se/le4XSAAc/bws5tChfeVytTy8Q==
Received: (qmail 1670058 invoked from network); 5 Nov 2023 10:29:15 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2023 10:29:15 +0100
X-UD-Smtp-Session: l3s3148p1@um33XmQJZsQgAQnoAFPQANY41GnTzLIh
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 RESEND 0/2] PCI: rcar: support regulators for PCIe
Date:   Sun,  5 Nov 2023 10:29:06 +0100
Message-Id: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here are the patches to make PCIe cards work in slot CN15 on a Renesas
KingFisher board. Please apply.

Changes since v4:
* rebased to 6.6
* added ack from Mani (Thanks!)

Wolfram Sang (2):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators

 .../devicetree/bindings/pci/rcar-pci-host.yaml   | 11 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c          | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.35.1

