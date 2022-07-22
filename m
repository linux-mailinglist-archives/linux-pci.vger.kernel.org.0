Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42257E3EF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiGVPt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiGVPt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 11:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4902357D8;
        Fri, 22 Jul 2022 08:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B39621B0;
        Fri, 22 Jul 2022 15:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B56C341C6;
        Fri, 22 Jul 2022 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658504966;
        bh=OPPydkGKy7PGmPmQbLUdjXZSvfHWTIwtZkiHUQMfkkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fdy/zff+rV2y2OMqo72PMRVuEI4d3gczRbGvIPiLQDimKHRpu4ayDJ+ONYRI+0U3S
         zm4/D+0Z9gVxWqApDjGDNzni04rtfTBz7MzUJlri4A9e9jC+377iRovng+6G1d3Pv8
         TSpmyMJgrDNTcwgA/48ZKpA3ZA2HMAR41sNeNGtObPD12WwYRfO6EK0925h1axvVLZ
         zlL0Ko4wdSACJQ4f2h/F+jbOD7azg1yAXjBLQVpKxSinQqnJ/e5Uf6H3HS2kXUvx8v
         P/CpTvFs3sB5vfKulh24UUG/P+GnHVNZoS1MZuGZzmeKsOAJLW7nTuT/ZFI/2Mr0wF
         YmbAgh+PFBuHg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: qcom: Drop unnecessary <linux/interrupt.h> include
Date:   Fri, 22 Jul 2022 10:49:18 -0500
Message-Id: <20220722154919.1826027-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722154919.1826027-1-helgaas@kernel.org>
References: <20220722154919.1826027-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie-qcom.c uses nothing from <linux/interrupt.h>, so remove the
unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3a3e667c3408..c27e3494179f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -12,7 +12,6 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-- 
2.25.1

