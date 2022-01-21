Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A65496064
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380958AbiAUOFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344855AbiAUOFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:05:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B45C061401
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 06:05:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1DF17CE2384
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD21C340E4;
        Fri, 21 Jan 2022 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773906;
        bh=rvMVY9A63H/33e8AFufw38J9LCcyJH1/j9FcSxn2e8I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jfitE6IZqaG3ENrIckdiDghOjcjB0jiDeLSmJ3zMgOATMlz7n8Etjlh6tlVS4D8R8
         M64BhdNp051Chmkulz8ee+MtqCYyBWje88WX3BcT+Nu+IwT+XR1yV99FBzLs/vrwKa
         oA73baAQKf1ky8UTVxx9x+YR+RqMSzfYwfm4Q4d6DylW2BqS0TeRtUNs2vhLsd7Jfy
         ZOhNZ2NnJRd2yiHfdWJ4Uc6hD/YZv2owZs3AfIFMrb6LPLVWOKphUymFqsgHihWau+
         6ku/NXjzT2rr0DxUCvZ7RGrKi2bumYiIqcsZD8RIbiWVQhXErQ72G6VRGwZ+czKtBE
         I80AnvHH4vheA==
Received: by pali.im (Postfix)
        id 350A4B8A; Fri, 21 Jan 2022 15:05:04 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 1/4] libpci: Define new string property PCI_FILL_DRIVER
Date:   Fri, 21 Jan 2022 15:03:48 +0100
Message-Id: <20220121140351.27382-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140351.27382-1-pali@kernel.org>
References: <20220121140351.27382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change extends libpci library and allows providers to fill
PCI_FILL_DRIVER via native system APIs. As it is string property there is
no need to increase ABI version.

Intended usage in application is just:

  const char *driver = pci_get_string_property(d->dev, PCI_FILL_DRIVER);
---
 lib/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/pci.h b/lib/pci.h
index 8c3c11b9ebeb..c13387e2b4b1 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -216,6 +216,7 @@ char *pci_get_string_property(struct pci_dev *d, u32 prop) PCI_ABI;
 #define PCI_FILL_PROGIF		0x00020000
 #define PCI_FILL_REVID		0x00040000
 #define PCI_FILL_SUBSYS		0x00080000
+#define PCI_FILL_DRIVER		0x00100000
 
 void pci_setup_cache(struct pci_dev *, u8 *cache, int len) PCI_ABI;
 
-- 
2.20.1

