Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA57878A6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbjHXThi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjHXTh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7A1B0;
        Thu, 24 Aug 2023 12:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB3164D1A;
        Thu, 24 Aug 2023 19:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8BAC433C8;
        Thu, 24 Aug 2023 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905844;
        bh=uwnOv8ykMOOeD+ibS/fZChJMfKd7KuQkACNqTUSfvyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4myrX6gGHeNR8hZWhahtDggeTynf1j/bDmva4MFKEe0J04/E/9KtMPxSJVKWi9CI
         QqBHNrEw1M0DvXVvTlDPpTbwA0IdZ+R55U3OfUXhW7k9KxREzID/r0ODOQQNNLJjvf
         2Ctnd7Cd4D9aJHkA0BXwu28Bo6vRXxeh3Hyi/AafO/J92YnOmPqK0LRNgnFIcJNVmv
         K+yiGMHWr92SGPCs70gHrd2xswfmAvGzElx4b8foMC/ZZ7rt1/cMiphDhpHh3M9/t+
         9HpWhVRHpa/pKjzBVZ3A21DXVQG4hyu0tmspUPSX9UuUg6KxiXglMd/z5MB4GL0ULE
         0yQeqZO4fMHzA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 01/12] PCI: mvebu: Remove unused struct mvebu_pcie.busn
Date:   Thu, 24 Aug 2023 14:37:01 -0500
Message-Id: <20230824193712.542167-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The busn member of struct mvebu_pcie is unused, so drop it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c931b1b07b1d..60810a1fbfb7 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -87,7 +87,6 @@ struct mvebu_pcie {
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
-	struct resource busn;
 	int nports;
 };
 
-- 
2.34.1

