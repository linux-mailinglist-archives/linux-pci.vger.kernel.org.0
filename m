Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8261022FB6A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG0Vax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Vax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 17:30:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FDC061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 14:30:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q6so18859149ljp.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgXgy4xCcEajnk+JpNDq/g/hOQmzIcVt8/kZ2R1fwks=;
        b=SFUoUatl2mpnBcEO0Efrq2j11lm8Qf/NJBJPyhCcnukRCaJ3JgSPV26MURHAE5Ja8X
         XwTtW+qCHGktzwJYoWd7X/3+kNXBKgEG1sFfV86cI2PAj9fhZO8tFfftKapVRrzd9WuZ
         HhFTQSYsfNnez1sNQrmOmJebdwQrah9AidBfjuJ5OLKVl7iRXBgyEyVYRWFqO0A82yoP
         IOhBz16RHKOn7EQQS4ygHFekxRV93BNL5c2XDXY+kSc7I4KovXYNNvjdYN2MT7E6hYMd
         CskCjJU+OpKICo10eOwRAndEkBfnQuaoubGoIcyfrGPkC8Zsmb3v1J+cvsXGCnW0A11n
         wpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgXgy4xCcEajnk+JpNDq/g/hOQmzIcVt8/kZ2R1fwks=;
        b=DjOPoNbGc4iNkkGaqnA3yrRwPFz5dDvrJHtUXcfqwtYzuJYRWDFi/BGpBKd+gr0oHH
         6O2ENLC/SqpmZi++NrNg5iSEA9jrZFgVaeCAR+oFyUMZjQfu0sWiU3dIJn4pOPyGzdhs
         3kHC569v/4I0akuEtDTBug49tknIY3B7h8do6jxLMGiw/hSB76vQWDl4JrGHHcpGiDow
         APxRtRwoY1tgz3LEYUnr5lhv9CF/AUaOZJHjtF9cI0E6+ItboK4ZfwzsKzNQPBuCyEQw
         SVH6cJbiADYRLKeMB2qKcefIlSSWGT8GNuUHZXx2piViTG3fX28gub+47T1xtitTakjT
         Kurw==
X-Gm-Message-State: AOAM531uliKVO7/hWL4trvpW3mnOhRSToPPlzVOhDU5tR+Rw3VEBJo/N
        /PRQ8rYJx0scWvoAQczRekYrSyQaqxY=
X-Google-Smtp-Source: ABdhPJzmW0j0Km3yWcE7bU6IIoXobIbVELcSGPpf7xDLCZs40QBKjvOehPQTanqOOhDrmqGaWQ41lA==
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr10053511ljj.53.1595885450950;
        Mon, 27 Jul 2020 14:30:50 -0700 (PDT)
Received: from octa.pomac.com (c-f0d2225c.013-195-6c756e10.bbcust.telenor.se. [92.34.210.240])
        by smtp.gmail.com with ESMTPSA id 202sm3298052lfg.24.2020.07.27.14.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:30:50 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH] Use maximum latency when determining L1 ASPM
Date:   Mon, 27 Jul 2020 23:30:45 +0200
Message-Id: <20200727213045.2117855-1-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently we check the maximum latency of upstream and downstream
per link, not the maximum for the path

This would work if all links have the same latency, but:
endpoint -> c -> b -> a -> root  (in the order we walk the path)

If c or b has the higest latency, it will not register

Fix this by maintaining the maximum latency value for the path

This change fixes a regression introduced by:
66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)

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

