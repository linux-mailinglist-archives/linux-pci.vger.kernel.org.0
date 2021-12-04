Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9962468803
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbhLDWGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 17:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLDWGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 17:06:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DBC061751;
        Sat,  4 Dec 2021 14:03:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r26so15456429lfn.8;
        Sat, 04 Dec 2021 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMHe3Mr6LOidgPDoC/df15qM+1WZASow9qgRZygvAe0=;
        b=GJpxZnlAHgun4AwI+BDe9LpvpzMYi5ArV4gYl8b0TGTDbkFfWB/NBR+fz1E/MD3vVR
         Ym14oe7Y6xHO3bjDzPS4P8iZTlxP5yZpXvDT0m7Uh0uHK2wFUdhI8bJm21lr5B+wl80O
         7EsYsMaLUp8lYNQjxE+lbJ6WZT4TFQPZhxSY8onNZgd8EI9eGhJ14e2FRoP/yljh98la
         NEEzD+QY7z1RkwQjek/UubPm1Ed09S+1y3xg2qrCiEthqubzlYVO99HnZtvq9zhtMafm
         sm+1JA64jFBWD8w3GF/mTgXPQ2plmR8cOzaJG99qw8y3KUDtD47okb41CoxkEH/UoT2u
         6S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMHe3Mr6LOidgPDoC/df15qM+1WZASow9qgRZygvAe0=;
        b=UYEc6ekIfznkmf5UFb+bpPMVVEGxBUJBT6wWqVnzsvospOZJucOXnKSZX83hWxgH7C
         mXA+x2lUcqAL2g5HUZIigPObm/6T9IuLRSxgUdKcHY9wN2T1aWfkaaPHaA9W6ljDnsSp
         P+UdB53MduKDZUOFKlgGqj4bwLZu/dQR49wh7iMo5c3zNSaCdn6NJvtKFMB5FxE3thYM
         U1/KiMX9DiDTSEKkPn14ySxOsuht4/WV8m/bQpnsYOdjHLoUZOGf2k/92yP5xSo82IzQ
         gDzvHiv0Le7cMz5Uk2WjCrUmEF+ekmCbYMycbDF7fK1bMgYCzcvfD4g827zpDvGIj8cu
         7CyQ==
X-Gm-Message-State: AOAM531T98Z/b9HOZl2Lpv2uAGLkGiWS6mD8w4HZP5Bd1uWvUuaB6vFa
        6IdTbwgTeYABknLXHR+BUek=
X-Google-Smtp-Source: ABdhPJxL74LhMegN9fxBM+mprGiB+kzE/FjfYopkbFL7RPUSNJQUlackrL9jlGJehL6c65MK0xi9Pg==
X-Received: by 2002:a05:6512:3212:: with SMTP id d18mr25827231lfe.285.1638655401893;
        Sat, 04 Dec 2021 14:03:21 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id t19sm881143lfl.163.2021.12.04.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 14:03:21 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] PCI: qcom-ep: Constify static dw_pcie_ep_ops
Date:   Sat,  4 Dec 2021 23:03:16 +0100
Message-Id: <20211204220316.88655-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only usage of pci_ep_ops is to assign its address to the ops field
in the dw_pcie_ep struct which is a pointer to const struct dw_pcie_ep_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 7b17da2f9b3f..c4c78ba7fba5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -619,7 +619,7 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static struct dw_pcie_ep_ops pci_ep_ops = {
+static const struct dw_pcie_ep_ops pci_ep_ops = {
 	.ep_init = qcom_pcie_ep_init,
 	.raise_irq = qcom_pcie_ep_raise_irq,
 	.get_features = qcom_pcie_epc_get_features,
-- 
2.34.1

