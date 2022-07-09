Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE956C8A5
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGIKHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGIKHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 06:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9E4AD79;
        Sat,  9 Jul 2022 03:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DF4A60E06;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6940AC341D2;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=F2vJvKobmY+7Q0VL60xDXrSdjNT+GlqsUZZb03nj5as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsPE6afodD4q4R2N31XGiYi2EjkRjBpzxK6JYXVMASvvTKIj2xyuJQYxwYupXAuFP
         a4btHij472zaF12ArmMICkBS7dN6ajkhzdfgh5MS7lVf4HQcILi8MpXCDOpbAcwJd1
         b4GCcTyPgPaFMkhR/12ph+PJfNXfzkXVQpYZQ+SnW80eQBtD1SKd92mHtfLsr6yv0L
         oWgs/5eyiYEnac7Kp/E8bTk6CiWe2KOajzin2BpJUB0TVK25SW23ameC+eENwFmuiR
         JP2EnQwDRwaZsbdkjAcelTmlyoB5igyS1rYUpbqOCBhLzQTP6qc55UoVtazlg+9jEl
         DywmsQhxEikrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EHC-MR;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 16/21] docs: PCI: pci-vntb-function.rst: Properly include ascii artwork
Date:   Sat,  9 Jul 2022 11:07:29 +0100
Message-Id: <9a7a1fc4d53fa7dc2e442c647550c27ff44a8e37.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adjust identation and add a "::" in order to properly mark the
ascii artwork as a code block, fixing this warning:

	Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 Documentation/PCI/endpoint/pci-vntb-function.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
index cad8013e8839..7b2ac70e2c57 100644
--- a/Documentation/PCI/endpoint/pci-vntb-function.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
@@ -58,7 +58,7 @@ It is same as PCI NTB Function driver
 Scratchpad Registers:
 ---------------------
 
-  It is appended after Config region.
+It is appended after Config region::
 
   +--------------------------------------------------+ Base
   |                                                  |
-- 
2.36.1

