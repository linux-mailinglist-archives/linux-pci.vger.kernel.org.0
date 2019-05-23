Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73428AAA
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbfEWTo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 15:44:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42974 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbfEWTo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 15:44:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so5252094lfh.9
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNbZY0p8pWRuPRjABJaml8O4mccH5Jx1g9npXI6IBLo=;
        b=lWagWGQI4Lk+H2G8F7bjOZ0o+YRhs+9v+XfusVkgWu4zTtUjhBc1vNWh5T0FAtYrO2
         uaEYQ5mnbQZ8zW7REAeDHPogCZ1a33uuMLzR+KDcsjQEjc7IWxpxY+VU9/xsSVgle4KF
         7lozdqZ9Efsf4gnjQRqO1xDunMv+kE6aFhXPFgfdmKom6kzyX34WrnDymjoAoRwn2syG
         KLRrZTb9ul+4/tJwT5dzxtuAcvZKZf6ZSK7tIJf7Y2rd0JEXgLNF+LZAfjfoLeF7i8lp
         C7VStLjaVa4GGMW9n+p3z8dVHq1JQXWZm3BZLQnzPfv6QfyV0CvTggJiRsCO5b6kJ5yK
         ABaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNbZY0p8pWRuPRjABJaml8O4mccH5Jx1g9npXI6IBLo=;
        b=IjRCx9dxE9BT4JAYfP5dglfv5pGeny2LaMvBbBlI/ao6syTWFSGTdX1unA9lFMgU7q
         zArCpVeKuUqb99pDY5jBHt51cOAsiCtmDCILTpCW9r1nXP73OBHKF3P5FXL4MxsCkB2y
         /L9BVUcD0jf6WuUWnQm7RtpUP9Aa2/fh7Mu/tN9vU73ec6JgNsc9BqL9OhWVLgHICUQZ
         mRDQoh9Usf5v1VDvA3q0y44clX24Umf7CS9Y8+O0sdHHK/938Kc5y0gyPl+EBnND6pIv
         J5D9J+Z+RyBTMiWVv3W8uihpPRTI/ScAhv6hpEQwvPnTPX/TKmEjXBqvaxndY8wh+7at
         4Gsg==
X-Gm-Message-State: APjAAAVYrhkcHOKr/sD1yQ6JEu1/ACqsm2wGFz7hZUl+Vrci48Cpd6lj
        QRCVpZvak4/LVNTiJqEK/+x6ew==
X-Google-Smtp-Source: APXvYqzk0w49E9NkmPZd5eBxe9i8B0TNIyJ3SlFH6jTItFZLFpU3+Y1yJwUPMdJ1GZC2qN8eKqKLtQ==
X-Received: by 2002:a19:ca02:: with SMTP id a2mr4451705lfg.88.1558640665908;
        Thu, 23 May 2019 12:44:25 -0700 (PDT)
Received: from localhost.localdomain (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id c8sm86990ljk.77.2019.05.23.12.44.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 12:44:25 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least 100 ms
Date:   Thu, 23 May 2019 21:44:08 +0200
Message-Id: <20190523194409.17718-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, there is only a 1 ms sleep after asserting PERST.

Reading the datasheets for different endpoints, some require PERST to be
asserted for 10 ms in order for the endpoint to perform a reset, others
require it to be asserted for 50 ms.

Several SoCs using this driver uses PCIe Mini Card, where we don't know
what endpoint will be plugged in.

The PCI Express Card Electromechanical Specification specifies:
"On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
the power rails achieving specified operating limits."

Add a sleep of 100 ms before deasserting PERST, in order to ensure that
we are compliant with the spec.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0ed235d560e3..cae24376237c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(100);
 	qcom_ep_reset_deassert(pcie);
 
 	ret = qcom_pcie_establish_link(pcie);
-- 
2.21.0

