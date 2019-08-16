Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93D8FEFE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfHPJ0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:26:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfHPJ0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:26:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so908492wrt.3;
        Fri, 16 Aug 2019 02:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0XuGCmLUKascNoqMOdQFyww1K30R55i9BTSz45B+Sw=;
        b=qVPreuQBx0l/ekXj0XcveNZDItFcd/WBl020drQucKst9u9TQXRKAUSV2HD5hfUaAp
         rGzFBN5YZDWjIc7zXKQwk0EBVTrS9wX9WSgUVEjKzqVJxu+stwH+o/s9y7znuH2AU6FX
         H+F46SLG2FACM64GIMYWVKQ3iKkHPUgXn9RJWBPTvMkFNhOHjH09zMCD8hMGgbXWUZeO
         KkGnoc9VKk8ldOyMd9dHu49QFQ3GGQytsZwD2ft0/GJEq9URMbQLhBm8QtMnHKv4JuGG
         gR9CxNg54vIyW2EIR3YT8UDqjzcVZfRlUvpe2y6epsvpxeuoUlmrUoYx1DWGtntUEArS
         V4dg==
X-Gm-Message-State: APjAAAXrWqpAAmICwcZeB2Sp3yryh9vNwBOMVZH+Dvj3RoAiGErIlpIZ
        jMf98ghk/CK9TR0Sn6u+KB7pcy1RD00=
X-Google-Smtp-Source: APXvYqytMngYXrbX785/qwPiJcgCv9SjaTwj9S3vfVgnUKaNSbDPpqBNbG5TYhofYDxFEddZ+QZjsA==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr4034791wrv.270.1565947583156;
        Fri, 16 Aug 2019 02:26:23 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm16521138wrc.79.2019.08.16.02.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:26:22 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 09/10] PCI: hv: Use PCI_STD_NUM_BARS
Date:   Fri, 16 Aug 2019 12:24:36 +0300
Message-Id: <20190816092437.31846-10-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the magic constant with define PCI_STD_NUM_BARS.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/controller/pci-hyperv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40b625458afa..1665c23b649f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -307,7 +307,7 @@ struct pci_bus_relations {
 struct pci_q_res_req_response {
 	struct vmpacket_descriptor hdr;
 	s32 status;			/* negative values are failures */
-	u32 probed_bar[6];
+	u32 probed_bar[PCI_STD_NUM_BARS];
 } __packed;
 
 struct pci_set_power {
@@ -503,7 +503,7 @@ struct hv_pci_dev {
 	 * What would be observed if one wrote 0xFFFFFFFF to a BAR and then
 	 * read it back, for each of the BAR offsets within config space.
 	 */
-	u32 probed_bar[6];
+	u32 probed_bar[PCI_STD_NUM_BARS];
 };
 
 struct hv_pci_compl {
@@ -1327,7 +1327,7 @@ static void survey_child_resources(struct hv_pcibus_device *hbus)
 	 * so it's sufficient to just add them up without tracking alignment.
 	 */
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			if (hpdev->probed_bar[i] & PCI_BASE_ADDRESS_SPACE_IO)
 				dev_err(&hbus->hdev->device,
 					"There's an I/O BAR in this list!\n");
@@ -1401,7 +1401,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	/* Pick addresses for the BARs. */
 	do {
 		list_for_each_entry(hpdev, &hbus->children, list_entry) {
-			for (i = 0; i < 6; i++) {
+			for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 				bar_val = hpdev->probed_bar[i];
 				if (bar_val == 0)
 					continue;
@@ -1558,7 +1558,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
 			"query resource requirements failed: %x\n",
 			resp->status);
 	} else {
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			completion->hpdev->probed_bar[i] =
 				q_res_req->probed_bar[i];
 		}
-- 
2.21.0

