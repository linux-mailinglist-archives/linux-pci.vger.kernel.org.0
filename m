Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6019C0DF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbgDBMMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33995 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbgDBMMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id o1so3841884edv.1;
        Thu, 02 Apr 2020 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsFq7yQU1rlzNMJrGzP0f6VuMClLu/ToR/AF+zEb8qI=;
        b=DbAA1ASmX06fN4fhcKuLmpG395IJaD5OzO2OkAiIl3DUn6qMG8A4hu6nPEdiRCy7qS
         LUAx5RFECtsHPfmAvq/jS+h69W4IoCvCC39zMgpLoonFBTN9bkgKuV046V8nKC5a3pp1
         GbpFsy/t/M/WH9bVudqmABrVTR3ubeyKcGUC81SUv9egWRY4uAe9km7lOzqbw9M9FkeB
         tv0Ejc/l0+FeXM5Tf1OaLrcBIUNWxN2+GTojdYe+/yfD+uWbkr/370kF9IgxgbIw+Dob
         gofwLkhJV9J8fxs72AqfRyaHTut5OimKD6Gumrr+d+on8LtR1JrT5I65/iuHfxKu1NTm
         I19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsFq7yQU1rlzNMJrGzP0f6VuMClLu/ToR/AF+zEb8qI=;
        b=aHPB3/uWoLz31tJTNgiXAowuPspiS1FmkwnG3b4rhGlMsdrPvmq852k4wXPu5iNYE3
         eMT/UBOhqB1Di4ndm5mSvd8fLYXYsfZ5I3UtI4qEIfZCaJu0KDPkej7p1BgBewmNr3IB
         Ngl01m4a5bnGiKPiDyLDxm7sowu6mwJ7KOhGqZ5+yD1CmVIVisIL6fiEs6lqaFUuGmha
         mmPrGZDREyFzIv4xbWUOdepRVXbR8Wmc0nlxnu9JNYFg/sFhL/PuzcJ6qedUjGO6PJ53
         SgR7E2RfP9N3UpRIU8eb/J5RFsowKxhe4rCN/LlUrsjKUDT0IjKeSNXIROAGkkzcfZJx
         mR0g==
X-Gm-Message-State: AGi0PuaI7GGoMY3eaLt1weaJDuARSTUYoOGItkFZIwkv2DW/AkGWgumq
        +DSo5BpzQh9Ss7/xabGn4j2EeSgMZxUyCTz7
X-Google-Smtp-Source: APiQypIvBMbr8/OcVfmbOg/N7gt60xcGNaW9v5EquvvNuFHwtAY2cx8E5B83GtZqK9UIvLjtxRP+eA==
X-Received: by 2002:aa7:d91a:: with SMTP id a26mr2622190edr.236.1585829522548;
        Thu, 02 Apr 2020 05:12:02 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] PCIe: qcom: change duplicate PCI reset to phy reset
Date:   Thu,  2 Apr 2020 14:11:40 +0200
Message-Id: <20200402121148.1767-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Abhishek Sahu <absahu@codeaurora.org>

The deinit issues reset_control_assert for pci twice and does not contain
phy reset.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f958c535de6e..1fcc7fed8443 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -284,7 +284,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
-	reset_control_assert(res->pci_reset);
+	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
-- 
2.25.1

