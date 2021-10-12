Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E26429B74
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 04:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhJLCXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 22:23:22 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43817 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhJLCXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 22:23:22 -0400
Received: by mail-pl1-f178.google.com with SMTP id y1so12473884plk.10;
        Mon, 11 Oct 2021 19:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIRsn6iNEFHg+PhIYW5Z69IDGiPIeGIeW4ryh/X6f3g=;
        b=zxkAY3ctXWYqBsf15BCGYBX7XlXDTjr2OyTxCwtiVKKUMtqwKbk6Av1TeV5i+e8XYd
         h8S01vhfiCllydN+wtCGnzWBmeIy9xjjYpnl3crI4j7DUMxEQSQ0iMqn/e1ELHzHaO2B
         ojF1BYuhm1VwfRWvBjX9hSOo5RKSbsKx5Fy6ksN4K+H3YtOQd2fCVIE56w70ujX2oIDZ
         snHe01UMr5ALlGPj7df/fTmQuZmDBGvhcaX9Wm6A+JUaCFTyDkC0L7zXHWo3KowfyvjZ
         PTIIMJMyVkkOSCDuGUEZpCZhZXlNvQKtA+eE1PjnpVvEgsG/G8PDJ6p32MWKE2qIbRkQ
         10YA==
X-Gm-Message-State: AOAM531p19Z1KozTx/f4DtnoNSPss27Qh1rLQuVsyEP0/TSkPaCDMjiZ
        +dg53NeV6g7B72/FPf5SGlr+EIqZnxo=
X-Google-Smtp-Source: ABdhPJxjmKu6eGmB8s+e+rTmXv8jWqruT8T9P94l95AHP9z47RZttdTxhdzMORT1Sm8pU4cCBLyJzQ==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr2939574pjr.15.1634005279863;
        Mon, 11 Oct 2021 19:21:19 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c11sm697644pji.38.2021.10.11.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 19:21:19 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] PCI: qcom: Make rst_names array static with const elements
Date:   Tue, 12 Oct 2021 02:21:08 +0000
Message-Id: <20211012022108.2823743-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A static const string array often reduces size of the size of text
section and can lead to an improved runtime performance as the need
to initialize and populate the array every time a given function is
called would be removed, contrary to local variables that live on
the stack and have to be initialized every time the come into scope.

Thus, make the rst_names array a static const array with constant
strings elements (stored in the .rodata section) so that it will be
stored in the data section and accessible for the total lifetime of
the running kernel.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300163e5..6bb616b45388 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -977,9 +977,9 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	int i;
-	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
-				    "axi_m_sticky", "sticky",
-				    "ahb", "sleep", };
+	static const char * const rst_names[] = { "axi_m", "axi_s", "pipe",
+						  "axi_m_sticky", "sticky",
+						  "ahb", "sleep", };
 
 	res->iface = devm_clk_get(dev, "iface");
 	if (IS_ERR(res->iface))
-- 
2.33.0

