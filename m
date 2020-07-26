Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57C22E2FD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGZWHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jul 2020 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2020 18:07:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B6C0619D2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 15:07:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m15so7276915lfp.7
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3s7COGs2738XhL15BR+y51CvuytNPLz8/7hHed1gsXk=;
        b=Hp82ozdEndNBHnS7uTm5Od9y4oKbE8K476LYhz242fG2FEylZFywybD46nfyTPErAD
         7e9NDv1aTU14AiaGeZUA99ZG1t6YDfCSnoSItxe8PqP7XkwjNQUiTvYRn03KFfEEoj+2
         hUhIpwQnI1ePuTZfWHvO9UBVLp5OEQRhUNN+4NYzE7T+HFjRY4DeB1yh842tM3SSIHHy
         VmmONYoJfrbk3lZn27qjSseUi+eodBmGzCeQNvepseuIq37tP+K0b92mqBAMBSNdiKed
         5SdsYKaYBa4Eb7djgEqV32cc5yXbSZ4jPTR7GdNMKiYC2HUxchMXVWMn76T/Pb8lNoou
         n2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3s7COGs2738XhL15BR+y51CvuytNPLz8/7hHed1gsXk=;
        b=hkFAV5zog0nCgPcfCzBwXIUiU91wUSspQySqP+60gk7bv84qxq7cgR+bDiRrAjEV6n
         pccUu7Licl5YmyxCZe1h4R0zCV5P6Be2A1oYFAhJ68xC+RnCMMP5d5MvX0d6g2UFxEKL
         ug4F0jBFszyASy0tDRHYSYa6B30Z+kd7AhLtJHE9d3yAvvXMqMVdy+sNDXmwnkMaUxGF
         znQaJ5UbM213OHvjr5ywIJDXEbww/tdQ9yUJdDyx0YjFf2XMkU2PZq1M3kGPl31WBMdj
         cRFn54/8wfUkIcMo3V0vbcPWNTPxBvjnEv82BQf7aWTjFaOUnYrL0lkKveegStxXqx3z
         I6eg==
X-Gm-Message-State: AOAM533xSdTfG0IeMMgbSdsouPM0kHJSdQTFNDwshzGT9pvdiEXPzVF9
        hfrnQRrAJXhkFGSLaMWMYmjqP7brB7Y=
X-Google-Smtp-Source: ABdhPJx2PbrC4LUOmUkaiETzTck+zvLjTz14EIn9l+5PF0CzlHHw0K46S/2tKVnYbTyi/JG7BE4WTg==
X-Received: by 2002:a19:c68b:: with SMTP id w133mr10082111lff.189.1595801241776;
        Sun, 26 Jul 2020 15:07:21 -0700 (PDT)
Received: from octa.pomac.com (c-f0d2225c.013-195-6c756e10.bbcust.telenor.se. [92.34.210.240])
        by smtp.gmail.com with ESMTPSA id y136sm2590835lfa.79.2020.07.26.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 15:07:21 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH] Use maximum latency when determining L1 ASPM
Date:   Mon, 27 Jul 2020 00:06:53 +0200
Message-Id: <20200726220653.635852-2-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726220653.635852-1-ian.kumlien@gmail.com>
References: <20200726220653.635852-1-ian.kumlien@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current solution verifies per "hop" but doesn't
check the maximum latency, instead it checks the
current "hops" max latency for upstream and downstrea,

This would work if all "hops" have the same latency, but:

root -> a -> b -> c -> endpoint

If c or b has the higest latency, it might not register

Fix this by maintaining a maximum value for comparison

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
---
 drivers/pci/pcie/aspm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..bd53fba7f382 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * substate latencies (and hence do not do any check).
 		 */
 		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+		l1_max_latency = max_t(u32, latency, l1_max_latency);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
-		    (latency + l1_switch_latency > acceptable->l1))
+		    (l1_max_latency + l1_switch_latency > acceptable->l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
 		l1_switch_latency += 1000;
 
-- 
2.27.0

