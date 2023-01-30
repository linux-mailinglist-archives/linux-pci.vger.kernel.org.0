Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF081680A7B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3KJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 05:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjA3KJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 05:09:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C416E8D;
        Mon, 30 Jan 2023 02:08:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C600F60F07;
        Mon, 30 Jan 2023 10:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95258C433EF;
        Mon, 30 Jan 2023 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675073337;
        bh=W5gLvow7kIsM2sQNE3lRotYbhEFYYxizyLyVp4ZWVfY=;
        h=From:To:Cc:Subject:Date:From;
        b=GUEbo7pT+01uTkfkxfyCU9PNvqYwwV4EVOSDfXgItyp3mKCPeLLeu4svveajiWevb
         JDWq9gWRgwe3BQjAy0zVCzv7zOBTrlpG9MJMAv85J7IQX20Gr+S9HOsICoO78Kcqwb
         WX4ps6hjz6h93BMAZe2n0dr4K/RXQvg9HqXs513ihsQ6N4d+FzrXxZqUKAvA0ruaKE
         PGmrL4tGGDwiI/R2nCTvWKjdAhWY59qqGtZxwyUfeUPDWSYkxPSJQrmaQqProCP8Oq
         O/Yje3w47K2yelQfXOWuJ3XOAUkghOkn3otWZDJsSk+vzQIPPjp5JBL791kK5JOFHb
         S5a7QqHhvhd3A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH] MAINTAINERS: Promote Krzysztof to PCI controller maintainer
Date:   Mon, 30 Jan 2023 11:08:50 +0100
Message-Id: <20230130100850.24994-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Krzysztof has contributed significantly to the PCI controller
subsystem recently through reviews, tooling and submissions.

Update the MAINTAINERS file to grant him the role he deserves.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kw@linux.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14c0b3e89c63..87e7a5e5a666 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16107,7 +16107,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
 
 PCI ENDPOINT SUBSYSTEM
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
-R:	Krzysztof Wilczyński <kw@linux.com>
+M:	Krzysztof Wilczyński <kw@linux.com>
 R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-pci@vger.kernel.org
@@ -16172,8 +16172,8 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
+M:	Krzysztof Wilczyński <kw@linux.com>
 R:	Rob Herring <robh@kernel.org>
-R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
-- 
2.39.1

