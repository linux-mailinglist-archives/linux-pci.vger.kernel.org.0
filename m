Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30034513333
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiD1MCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiD1MCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 08:02:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438AB890A1
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w19so8157795lfu.11
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=tyNBcLsVj7imu1qgLFJfdtX1fu9TBOFL9MCFMpaqE4+4/tXj7iAKVTo4TWUWm4KK4U
         AB3AGMwU/cSMXS4tcBhpWbalIcH5tQVeht1P0fNS76YhPnGeKQi424NCGwsike567Wok
         +3p2lKjEKUtDseeQoKtwWwDhe1vGynZz+H6+yls3l28CZfvOpvFh6IogPsdgIBh9s4B7
         1L8cOEtxtAE3YYYqLkhuU8Vo+N5gZ+lKhIz6JdF6NiQweYYzfhTXvgt39sdy/o+XwDwi
         +rXEJ7wXbemSNtzennYkrJIWLC3Pme1jvdEvy8LrQ/++xjq6IUzfFcoCdlSX+kkwtUcN
         5I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=7Rd9ma/jZPZf2FyKu5/DKWe5LgD9Ymp9hd1/XAhMMNHJY6PGOsE1Yk4mXxt4TZ/k+6
         8KPl2UxQwrBClfczl/pu/BUZr1gQ9CX9MrAxYXsr1kDuvyKVLruQ0txW7atewpQCKbW0
         JblggBC/d1UIPFTjvrMhJ/wyduKUq3NTi6Za+mvE1S8DabcrgIzfh82gYa6dS+nCluQY
         lgo2Fmba9p0R0QrwhzbGfpo491xFRIWyF4ZnjxmKwaQIEvf1gBQXi6x129j0ihY9Rbp0
         uoxE/Vbmh9OYVSchJy/3cyqMJLdJu46tZcSAZ0rOQP6+iDILVUUXClFiJzANUeiDW9Rl
         PhpQ==
X-Gm-Message-State: AOAM5310OubnjCB6Uc5Yy1w/44GPNnTCA1WGOSTnONicdn8whfeNzyNG
        fFR7ST5If3bpqx91r/z4wA8hVg==
X-Google-Smtp-Source: ABdhPJybEOPOGBmWZqZCFHZb2nKs8JK0zi2bwiAZMBlIa8fen7WSqkdLhC2229bzNVGdX0OvGlaQfQ==
X-Received: by 2002:ac2:456e:0:b0:472:12c9:42b5 with SMTP id k14-20020ac2456e000000b0047212c942b5mr10443768lfm.211.1651147176533;
        Thu, 28 Apr 2022 04:59:36 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f1-20020a2e1f01000000b0024602522b5dsm2069137ljf.120.2022.04.28.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:59:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/7] PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8 endpoints"
Date:   Thu, 28 Apr 2022 14:59:28 +0300
Message-Id: <20220428115934.3414641-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
References: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. Additional research pointed to
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt.

Without these changes specifying num_verctors can lead to missing MSI
interrupts and thus to devices malfunction.

Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c940e67d831c..375f27ab9403 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1593,7 +1593,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
-	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.35.1

