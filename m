Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D1747B0D0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhLTQC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 11:02:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44444 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhLTQC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 11:02:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0555B80EEA
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 16:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA2C36AE7;
        Mon, 20 Dec 2021 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016144;
        bh=moxR4H5LroCD4Y/ELWw28W1oRGFu68ApFXCw0fKLws4=;
        h=From:To:Subject:Date:From;
        b=FEfaLf1vz2kITcwZuuOediDOSWcmXslrW3elh0mNkDY5BNgr4FiVu8/hNCdA07S7i
         qNyV8nXnvQtIF3ltOxC0rfN9TSkpDaU3KKGu05UAtZXXzNP6N21iMWExgu3JKuHKKz
         IkzJJhpSid/OivGywNCMWa51dNAu7BQnxfj/+qXHigebeDj3r1Q8pltjL3K0HIHWT+
         Txj7l/0ESZvlhisJLtFoZTT+fIMFFsUmFn+CaloVi7CceCyuLtIimbE5FU341htfQB
         7Ynjh320QsmDYMmsYV3J70bnG62/4nmLkyzyy2CAjExL7gNgjayAxeJi6KXiPZvho8
         Z0/+0dNm3hOug==
Received: by pali.im (Postfix)
        id 4833687B; Mon, 20 Dec 2021 17:02:22 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils] dump: Allow more leading zeros in dump line number
Date:   Mon, 20 Dec 2021 16:56:59 +0100
Message-Id: <20211220155659.1343-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U-Boot's "pci display.b" command prints pci config space dump with 8 digits
in line number. So allow up to the 8 digits in line number to easily parse
U-Boot's pci config space dumps.
---
 lib/dump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/dump.c b/lib/dump.c
index 879c62449b27..c0f929133973 100644
--- a/lib/dump.c
+++ b/lib/dump.c
@@ -90,7 +90,9 @@ dump_init(struct pci_access *a)
       else if (!len)
 	dev = NULL;
       else if (dev &&
-	       (dump_validate(buf, "##: ") || dump_validate(buf, "###: ")) &&
+	       (dump_validate(buf, "##: ") || dump_validate(buf, "###: ") || dump_validate(buf, "####: ") ||
+		dump_validate(buf, "#####: ") || dump_validate(buf, "######: ") ||
+		dump_validate(buf, "#######: ") || dump_validate(buf, "########: ")) &&
 	       sscanf(buf, "%x: ", &i) == 1)
 	{
 	  struct dump_data *dd = dev->aux;
-- 
2.20.1

