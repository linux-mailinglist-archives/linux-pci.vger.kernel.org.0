Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B354960A1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350792AbiAUOX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiAUOX6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:23:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC3DC06173B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 06:23:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6886F61348
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B304BC340EA;
        Fri, 21 Jan 2022 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775036;
        bh=uYhY1xO6bt5KgpSsQlYQZMVvnFbEIGRLfU6nay64No8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YmI9p9YHP1dqG9RPOZ5akTceWujJGlzz9lyoFzsLClOB6hF1Ie8pVoCfY5vPBvo4U
         pIfJV8TD4pa+LFQSpbXSBxoqOo4vofWy+543wRl5k8086AXjBddA8CfcIpD43yoXwS
         lyNruK4/KGnBjRAxzz0R1PBGn9KrRJ3q3wbuXfx3tL7audBD9Ddl8cWx3wwmWPvgq5
         xJUr2N+eGze4NFILjdo/JO273cOnUfosHKXJf5DTPGsPvvat8E5UdBrFRei8Tza08T
         E1N/1lMOBbJRXQgGFzU6YEvzXp4hN9ifmiHq/22Ca494yPwwjdfds3NWzRllI55xhV
         zcXyMgrsl07UQ==
Received: by pali.im (Postfix)
        id 6C0BD857; Fri, 21 Jan 2022 15:23:56 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 4/4] lspci: Do not show -[00]- bus in tree output
Date:   Fri, 21 Jan 2022 15:22:58 +0100
Message-Id: <20220121142258.28170-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121142258.28170-1-pali@kernel.org>
References: <20220121142258.28170-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Secondary or subordinate bus cannot be zero. Zero value could indicate
either invalid secondary bus value or the fact that secondary bus value was
not filled or indicates non-compliant PCI-to-PCI bridge. This change makes
tree output better readable when bus numbers are not known or not provided.
---
 ls-tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ls-tree.c b/ls-tree.c
index fede581156e4..f8154a2b034a 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -258,7 +258,9 @@ show_tree_dev(struct device *d, char *line, char *p)
   for (b=&host_bridge; b; b=b->chain)
     if (b->br_dev == d)
       {
-	if (b->secondary == b->subordinate)
+	if (b->secondary == 0)
+	  p = tree_printf(line, p, "-");
+	else if (b->secondary == b->subordinate)
 	  p = tree_printf(line, p, "-[%02x]-", b->secondary);
 	else
 	  p = tree_printf(line, p, "-[%02x-%02x]-", b->secondary, b->subordinate);
-- 
2.20.1

