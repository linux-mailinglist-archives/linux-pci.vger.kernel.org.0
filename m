Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6914D429620
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhJKR5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhJKR5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:57:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F30C061570;
        Mon, 11 Oct 2021 10:55:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a73so11572416pge.0;
        Mon, 11 Oct 2021 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoYdRdVPFBgzF0byghvbRioEVo6f6dpKTV5r2hTcAdQ=;
        b=ltW+f0rbN/uPUVAH4o8eij4NeHjfvjxzyTIm0z47FLxfPHnHZBDlexL8LeD4scV0A7
         Aq2Cf7SQJzV66QLG2M5xEOE1AuWu7zvm0vRLyRewSZVc68x3FJTTGzkyJSvE7FGrBppJ
         IRIBOMAG424UU4msfXNq0UmXTmgcQ2wUfXTl1zM859G+xKka3Fm+x+JAYa41FJvHGuc1
         0cs0+YgMHG0Pj5l9w4/pIs8lU3RdS1TZqmF7B9QpYzdQUic2UEE6cXJQymDYfh3fTPt8
         CSBJX+aDzkf614T801J9e3/HaVGMt7V5O/1eEFymgEbfpRI4cE8Dm5tvWXNt5nzFq9cA
         fwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoYdRdVPFBgzF0byghvbRioEVo6f6dpKTV5r2hTcAdQ=;
        b=4hQ30TDfFjfX82/EKvhyMFOpH0+XlIPP1kVq94AmFQnjH0IKJP/2f+iS82YwJvXUdm
         zKXruPKmbqf80bOQtUotAmw2LaH2I7VZQEB5lEz0bpmsbSjOCid+MbmDsbIiekdx2Scw
         LISNnzvJkit+1qosPwwJMxAJ7XFLnLl/WlG/EMXvb1kAdpFKY+MUxtQ5hkiOG3kg8jKq
         ziNxmRmVDd3swneN4qJgUkqTQ+VbQLuiX8W/3M7HQCEeg1gRxulDaK26z3XOll50E0xd
         Irh+zYvCc6V9vxjdKN4YJsfLs3DfZDjzQmnpjfVq31rweBSuFagPp72bLw3X9AaQ4yIM
         W/4g==
X-Gm-Message-State: AOAM531CSEx82LU+zV0ZsDQu1c80+eAHc8F1Dr0JdvMZOdWQ7Pvd9ikI
        rC5Ai+6hgPgHoGZrzm+/peY=
X-Google-Smtp-Source: ABdhPJw+HCqgfQADOdEGCNm+9dT2i5EQY3JxrTsbW69x0A2NZM7eDjDKBtYYiMr6nM+PiesMRs5mZA==
X-Received: by 2002:a62:1d46:0:b0:44d:1a4d:5d03 with SMTP id d67-20020a621d46000000b0044d1a4d5d03mr7882789pfd.55.1633974946582;
        Mon, 11 Oct 2021 10:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id y24sm8384653pfo.69.2021.10.11.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:55:46 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 08/22] PCI: kirin: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:25:25 +0530
Message-Id: <d8e423386aad3d78bca575a7521b138508638e3b.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..a37b59a9e0be 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -331,7 +331,7 @@ static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
 	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

