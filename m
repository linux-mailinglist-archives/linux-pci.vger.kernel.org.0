Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945C77DF10
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjHPKn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjHPKnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 06:43:22 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D92726
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=+g5CczUC0LAQ/D
        vPOJcyPdA8qzB+pAOqt2A3QG4u+4I=; b=NvJKnk0bLExDm1/E7mUH3Aan/y+Qc/
        5It39boGsc/1KnBzb/UQAK5cCzBasyxcEupFiJa61uVDzIkl1QP1j/NTj7ZCDBYd
        CR1pDQ9desc2sjaWqAeMQ53xIuqH8uGT5BnpByY+1253zHfF0TYIX3TyB7+QgVGl
        9o3kovnJFunSTfyvERHDR6xGwkFrXNlo40uVW3tumGArLNKVRnB/lAqq5FlXs8ka
        vA+7JTKSb+190sGjCO/7pnAGwgsaahYHVx8rHThtRvD6cTOvaaxDwlXf3+98wxrB
        ckHf5cbKz3m9DBeUbpRqzavi3xu1kVGs3CwAqiIze0Xrmn3oU2nZdYkw==
Received: (qmail 101914 invoked from network); 16 Aug 2023 12:43:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 12:43:09 +0200
X-UD-Smtp-Session: l3s3148p1@u4Yd9gcDQL0gAwDPXy5qAJ1huuy56R1W
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 0/2] PCI: rcar: support regulators for PCIe
Date:   Wed, 16 Aug 2023 12:42:48 +0200
Message-Id: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here are the patches to make PCIe cards work in the slot CN15 on a
KingFisher board. No code changes since v3, only rebased to 6.5-rc6 and
reworded the commit messages. Please apply.

Wolfram Sang (2):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators

 .../devicetree/bindings/pci/rcar-pci-host.yaml   | 11 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c          | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.35.1

