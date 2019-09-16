Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9995EB4230
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbfIPUor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46801 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbfIPUor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so777012wrv.13;
        Mon, 16 Sep 2019 13:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASUn9OH0qpdm5tauYuwAj3Acnc10dNAyecbrZXIKD5k=;
        b=IOX9zDkbrJ+ugKjM6mr+410HW+5acMRt7yr8Hz3qpMJN5/ONBRaahTtzK4x5daSAS8
         jOugofsotbg4JQghPUJWFMoSS2dWNR38/h5OHYaV1dnXU7k3NyCvRQ2XZdJfW3GRl/jr
         2F0Vyb04Mp7Gi9uUISu8XUzpWzvj/Xo+VIm8m4uFpnr4cIcrqDkkLvDoqQchE8swNSk2
         E0iEqwd6ci5q41F1tfFmVj6zalRV3Mx/oHXLFUMJa3UHWh8qL6xR/of+M4feOtzmQ+Ms
         vp2Cw17YvbKmHev+M9RdpC62uQbvroMxTAYvY4RKtYzN74It2DqgC+VzPC53sRjqpsd8
         NGrQ==
X-Gm-Message-State: APjAAAUc5etJPJ9hUj6vwbCyxeK5t0FNZtwezUAizCMRk1VOpycE3sMq
        Ir2hwL45diGjWKWURodmiStEEFo4AVw=
X-Google-Smtp-Source: APXvYqxXKxOmo7vV3YO2KraQNHk6/pPJJCJXdwXVzZXSNDK+4XpNHBrvqCO9fO7iF2NaztvfDbTBIw==
X-Received: by 2002:a5d:4590:: with SMTP id p16mr190844wrq.82.1568666686310;
        Mon, 16 Sep 2019 13:44:46 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: [PATCH v3 10/26] stmmac: pci: Loop using PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:42 +0300
Message-Id: <20190916204158.6889-11-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use idiomatic C style and avoid the fencepost error
of using "i < PCI_STD_RESOURCE_END" when "i <= PCI_STD_RESOURCE_END"
is required, e.g., commit 2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END
usage").

To iterate through all possible BARs, loop conditions changed to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= PCI_STD_RESOURCE_END".

Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 86f9c07a38cf..cfe496cdd78b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -258,7 +258,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Get the base address of device */
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
 		ret = pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
@@ -296,7 +296,7 @@ static void stmmac_pci_remove(struct pci_dev *pdev)
 
 	stmmac_dvr_remove(&pdev->dev);
 
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
 		pcim_iounmap_regions(pdev, BIT(i));
-- 
2.21.0

