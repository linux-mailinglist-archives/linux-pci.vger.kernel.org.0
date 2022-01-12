Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900FD48BC79
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 02:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbiALBbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 20:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiALBbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 20:31:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD00C06173F
        for <linux-pci@vger.kernel.org>; Tue, 11 Jan 2022 17:31:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so1711992pls.5
        for <linux-pci@vger.kernel.org>; Tue, 11 Jan 2022 17:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zWgTqK+//r+FI94NQVNRv5s0joBk1kqpwFFvipQzTiE=;
        b=HKYc916JvWL1ESbC8UePMItOyR/nt3IGjEjUqt8gGgnNVFS+fjSgULjSI4985epJdL
         yHocqZKVQSafOSZQV5Z40ZW4tR3zatPreqAnP+1st2UgOVI3XUtI8ACChb7tL432eqi0
         hRH4tfD86XLpzmNO3PM0nOFBFT2bioAjDQW8qn5QuuLb6qVFD1CFJfqDlIiQqmoNie1P
         Aruw72PyWt3RqOQEPI9NUeI0VdmSvSlTXCDiBVtclCqNEoKMXFud61Z2j7+mg+RjBLrQ
         RNYbOINuyzjv08axYMgbizZNjc6Y6pZqAaOZzZfYwe76pAx8bJ5NEnBOXLl8UHOANe4n
         MtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zWgTqK+//r+FI94NQVNRv5s0joBk1kqpwFFvipQzTiE=;
        b=4lDhXqsMnTsv0RngDFqerKZVn2Iy4BTJiCFT38BNe0dqDcowNucYOGkHYpuvHrVG+k
         Q6Y+wGTeZJ+lHRsgzqZT2WqqfM1RT1qVxslOHxlFue3gFOeHyt0Pu9959uWb9K5bl+yp
         ySVy0kPghlYEOirGjp9FTOJPJqbtvr8a3L/IDxlZ83HvDaMm+IQ+Vfrjl/cot00Ip2Ar
         XAAOUAJd4enVS//7mpuPlVAHFpZ1KorMNtdbUSJuYiNJticxI2p+1lqVFuhCYPCgevM/
         +9ThlQSJ54v8B/BhJUCxmkKe1F/oMRim8JtGbzZB0cXW4ugZrDM1drs41C1udxan4m8i
         lnUA==
X-Gm-Message-State: AOAM531dZCWuzAY5yTdc6JFzdCitHpQoQ3LFkpyVijcQ2B/+q6F9jyb0
        ecUTY27JRHiy9XTJVskL/P67bWuCGVI=
X-Google-Smtp-Source: ABdhPJymuYCBByuAJhdRLWur3yxxRVleKYjSAooK82ZyuUcHGiuPO1l5AUsFB/E1dPcp6P5g5FNYSA==
X-Received: by 2002:a63:a84b:: with SMTP id i11mr6277644pgp.486.1641951070586;
        Tue, 11 Jan 2022 17:31:10 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id k8sm12556258pfu.72.2022.01.11.17.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:31:10 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jim2101024@gmail.com, james.quinlan@broadcom.com
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Tue, 11 Jan 2022 20:31:00 -0500
Message-Id: <20220112013100.48029-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8a3321314b74..4134f01acd87 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1392,7 +1392,8 @@ static int brcm_pcie_resume(struct device *dev)
 err_reset:
 	reset_control_rearm(pcie->rescal);
 err_regulator:
-	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
+	if (pcie->sr)
+		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
-- 
2.17.1

