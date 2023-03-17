Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989266BE81E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCQLdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCQLc5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 07:32:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACB90B76
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 04:32:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ix20so4987253plb.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V+IWdBYw8MK5GfswCmGJSJSTT+akxzrw5rFlMbMC5w=;
        b=bTcKJztfGLfF3k9V/x7Kf+eP+33U7Lt8fKhkDY/tDXyqM0TKfAiuG6wZ+1Z9fcCMfV
         21ZZchq+pkv5liRAR6nUWh0EmPeYqWykedKEgNBTKT/IaM/hqy1zewPwJQKZU9WTOhzn
         R3bcw82HmGvgtogR41uCE35FhpJs6vHAzNR0rnaCrDsntjDQidDNhiSwWEUQn3wIWE5G
         4EIIxOJuw9LA5j++Y0ZojyoKDTPv/8Nqr/4uF0QTWV1LP49rxGG9nBLBNtzKe9YCFTGu
         KWV5fBjZbVinApKxbDQSfuCWkjCMaecnx9dm8G4Sw/4kfS+LrLaYKXKs+VrCDoIl8jsW
         6FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8V+IWdBYw8MK5GfswCmGJSJSTT+akxzrw5rFlMbMC5w=;
        b=R3f1p6Va44a9/rCtUg76jC77yTTQHwgu5HvDIc+ojVpcSD62O9bCkD6QugSjuGbSbg
         vwPMMHn2UbemRfXOcIk2KLJhoQqIchm6a3Crox9QF6nyEKpYbg6vWvcisE6KlHVzBVmJ
         DqxNv5ZTNKT2qeFSwouRX58yfWkP8tikzmGSbjG2lDC7/1AKGyVmuxDr5UMpku1yhPPS
         44szbS0wuk71igY2wMBDr0SbupjFFbyQTRhQWdRZPMaYnKuLtHD5nm1bjnedE2OUmPzU
         S4FhgKdA0aojNTrH0W/Q8dAAh6DQTl0H77KOIqi5AMaLA+rDZ7ZJcOo9VnxL/iiDMzBJ
         c97Q==
X-Gm-Message-State: AO0yUKU07MNXQHY22ch76BMnRgqi3kWwZ1vBFWLin616aPDNuV/4LszO
        QDmFAM7fuC2SnIB1x2gUTGI7yg==
X-Google-Smtp-Source: AK7set/RsZ3jc36gVmZD1kXoGolfdpW64pTkClw1HV091sT81ILy2HuyUrQUXlWMsLw6vkCmt8xlMA==
X-Received: by 2002:a17:90a:1d1:b0:23d:3878:781e with SMTP id 17-20020a17090a01d100b0023d3878781emr2634120pjd.21.1679052772372;
        Fri, 17 Mar 2023 04:32:52 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:32:52 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 02/11] misc: pci_endpoint_test: Remove an unused variable
Date:   Fri, 17 Mar 2023 20:32:29 +0900
Message-Id: <20230317113238.142970-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The use_dma variables are used only once. Remove those.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 22e0cc0b75d3..55733dee95ad 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -363,7 +363,6 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	void *src_addr;
 	void *dst_addr;
 	u32 flags = 0;
-	bool use_dma;
 	size_t size;
 	dma_addr_t src_phys_addr;
 	dma_addr_t dst_phys_addr;
@@ -392,8 +391,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	size = param.size;
 
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
 	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
@@ -496,7 +494,6 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
 	u32 flags = 0;
-	bool use_dma;
 	u32 reg;
 	void *addr;
 	dma_addr_t phys_addr;
@@ -523,8 +520,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 
 	size = param.size;
 
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
@@ -592,7 +588,6 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
 	u32 flags = 0;
-	bool use_dma;
 	size_t size;
 	void *addr;
 	dma_addr_t phys_addr;
@@ -618,8 +613,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 
 	size = param.size;
 
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-- 
2.25.1

