Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003E6FE45A
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjEJTDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjEJTDC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 15:03:02 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB42D74
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=xsUZISaadJhlH92DFScw3hXVyek
        Q2glsCLYxrO5cYjg=; b=ayCP+xpK6yCEAiSMzXQd+v1J6/1NsSGtt+jhyTOqXZV
        Xal7YhhhnzNboDcWSpgTSOOI88K18S4JY8jmPL7zeHca2zt6XefovqTApfUeUxHa
        MBCYBQcv2UH4iH7krI2FHmzrO2qAUJyp7CongClr/+mosZ+4zJ1QOKoWOL01txEA
        =
Received: (qmail 2541411 invoked from network); 10 May 2023 21:02:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 May 2023 21:02:55 +0200
X-UD-Smtp-Session: l3s3148p1@fGT7hFv70O0ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] KingFisher: support regulators for PCIe
Date:   Wed, 10 May 2023 21:02:50 +0200
Message-Id: <20230510190252.19030-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here are the patches to make PCIe cards work in the slot CN15 on a
KingFisher board. Look at the patches for a changelog, please.

   Wolfram

Wolfram Sang (2):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators

 .../devicetree/bindings/pci/rcar-pci-host.yaml | 11 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c        | 18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.30.2

