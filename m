Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA8668E6D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 07:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjAMGzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 01:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbjAMGyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 01:54:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A726A0C2;
        Thu, 12 Jan 2023 22:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=36aG/7kZ1C9JaZkQzVGJwQdSc9mIi2Y4ZSbtcZoy2ZY=; b=A5XT35Y8Z3foFbYDNMdpcz+thJ
        VQL1qblA4dcmJ53VhsomGXP5C0z6ZYQFXvY8Nfkl2Y1c+V1uh3VltLFGej1tytG8bA8y9qP1QownD
        FJkhtXYL807cGFA1Rvn2XoRE4WYGaUuGa3mu6hS99htIf+4Dp4Gv/kSwtV0/7lB6j0M9T447agLuf
        fP/T58E3vJbnxu7lRMK9TTAbGwhmhGkWRhUzZVmgKl0UT4KubCwiq8HTL6T94FTV3mix0amN6KIOL
        GZS1A0teOa5Wx2K99+fgwuYay4r7MoPb7+veBe16S/zTqW4V3DLkVFIAKU7KhqIELK61U99jpw6ua
        q40uBuqg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDj0-000qVL-AV; Fri, 13 Jan 2023 06:39:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: pci_endpoint_test: drop initial kernel-doc marker
Date:   Thu, 12 Jan 2023 22:39:37 -0800
Message-Id: <20230113063937.20912-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This beginning comment is not kernel-doc, so change the "/**" to a
normal "/*" comment to prevent a kernel-doc warning:

drivers/misc/pci_endpoint_test.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Host side test driver to test endpoint functionality

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/pci_endpoint_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Host side test driver to test endpoint functionality
  *
  * Copyright (C) 2017 Texas Instruments
