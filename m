Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC57754EE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHIITN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHIITN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:19:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8371703
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 01:19:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b91c2744so4785478b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691569152; x=1692173952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/olz3+pT5vGvwMXGNPW6pUJny4Ruwz46zxkrZbI5uIk=;
        b=jrHUjZszg5aGthu3ZzuRR0j78xTaWrwJpMn+vkNQr9IJXSakR4x5Ei6YuIp+pJBl0x
         UNOiXLU3ceDbWiBviK/yfh8Qdz3vxlgYE1JF6+mzFKzKN5k1FvVI/qYfKcm7TFj1h5WV
         P7/Da4xm8nmh69i7JnsA+wrU++NQOaD4uf2GXGc6IFVrnkBLCRextjiGgMDIeEJC5jO1
         sStB4HpxqjEaTSac41m8tNH9PImtWQm7T1InfKdnLT+LbzQcOaPZowLZ1w05kBlTEwZ4
         PmwNpC99+17i7mfnGxf53IFmzIf1SB+Ic/cCjYLeXeZ1OVeipjxpu9cHtwgoNPVbaFxt
         8Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569152; x=1692173952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/olz3+pT5vGvwMXGNPW6pUJny4Ruwz46zxkrZbI5uIk=;
        b=LdaFIhVUQE2C0s45FhfDYHzlXRip4BQE7ybAGTQy5dUl+kDAVZx+35tXMckgubqSSC
         gDtQsI2mboXeLQqq8VOH9M9mZVLETkWbWSbFfkdKqN/dodVHqL3MmwzojP2o/Hv+KhCp
         7YVkVV18Ks2GsrdslhgakQ8XoDWUEqR/SXgbKpK3DQL21aYqYgWhfBwVIpcqqV90R41v
         KEwY77gYBVPkGKUTVLZAGQojcrRHEiJIH/DE5cxQ1YZtDQrW/5hXtsGYT4mdbuiYanIZ
         aT9lllEenXP1awXiouQ/oDIJkjDyIw9zpvDPzxDb2OE8l+ulxe2EAIrkfmHw18ZsVRuG
         ocuw==
X-Gm-Message-State: AOJu0Ywje+TQay6V+6StgLAIHHpfVp/v7TrN8y9WjbjEo3Ee/jjxPKGI
        8/bRMVHH8GJ3H4PBVHlO1M0D
X-Google-Smtp-Source: AGHT+IGb/j2HSoijwa29RVJtTy6775ilCzzT+Qk8BKibKLGP8453uYMb168de6FT/MJQOAVUiKpziA==
X-Received: by 2002:a05:6a20:cea2:b0:13b:9a09:674b with SMTP id if34-20020a056a20cea200b0013b9a09674bmr1594955pzb.36.1691569152270;
        Wed, 09 Aug 2023 01:19:12 -0700 (PDT)
Received: from localhost.localdomain ([117.207.25.122])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b00686ee7ba3easm9331881pfm.216.2023.08.09.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:19:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: dwc: Add host_post_init() callback
Date:   Wed,  9 Aug 2023 13:48:39 +0530
Message-Id: <20230809081840.16034-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
References: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This callback can be used by the platform drivers to do configuration once
all the devices are scanned. Like changing LNKCTL of all downstream devices
to enable ASPM etc...

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..5ad42cdc2325 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -505,6 +505,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_stop_link;
 
+	if (pp->ops->host_post_init)
+		pp->ops->host_post_init(pp);
+
 	return 0;
 
 err_stop_link:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 615660640801..e595ae9456da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -291,6 +291,7 @@ enum dw_pcie_core_rst {
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
+	void (*host_post_init)(struct dw_pcie_rp *pp);
 	int (*msi_host_init)(struct dw_pcie_rp *pp);
 };
 
-- 
2.25.1

