Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25B97200A9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjFBLtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjFBLst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:48:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E63E49
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:48:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so2753155a12.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706506; x=1688298506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZzlHz0HjDIVYRBaIDbbDRIPAZMGT2jNZydQ3880wqo=;
        b=RSl1RhdQjDhcuoHbfJOFSu1v4UsLQbqbYR6fkQzgveTfVMFqyJIvEESXWjyQiQKous
         ljRDVaAE0ibwe/S/6vlbINCYPya6Jprm5NlYJJVzCYseBfaGR1FO7h/dcPrv/2cp1JyM
         YdJS12cwWcyLITajmfFC+TW1GJc0L+TjgWF/NXAR/BaO2zRa3KH/zSzugzg0vjg64ieP
         bBufghgnW2u9YN8WI/27SC7bMFwpWK1VG0atI6KnGasYuOesmU1QOEN/YOi1seJY+Iad
         s+Y1N2jWaEcafuU4gZNez2WqNTntVVfnLZ6X1OFS1r7kQv9VX9LLgy9fRB26DrAjNngp
         mt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706506; x=1688298506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZzlHz0HjDIVYRBaIDbbDRIPAZMGT2jNZydQ3880wqo=;
        b=g59Mo0Tax5vks7Knw4vV/ldLkta391tZwR0DyWrD1uwAmEmAYYG7Zk6mTNE0Idf7vP
         f/0w913yg08wpnBs06IhgatjPevf8+ae9kOUsAvniAlrxo0O5W08cuLsx/FcSgV63ZAb
         GpvAdTPNBnjyK0NTQ4UxLYLnRIz6Dgt9vxAaolW4m9buabRDDxYc4tZbc1rfOj+VQUxg
         ssmgJykHEk8DI4qV+owaCrGd/nO8UXQZ3dqXJ/eLwz7S8P3fd8gnWLUTBNU1v19J0LQ0
         aJrkJhhmJPLz52GQ2sOG4DgAVAhyJkGwx68xSTaE7WAmyHdz0ycHJxH0cbaJWj2Yu76k
         XF7Q==
X-Gm-Message-State: AC+VfDw31hlE4alL2Opxp0H4ZWiTGii/D45z8Q4lSQG8qTBoCY4KiE+k
        006DBXpO2X91cX9PA9KwKdw/
X-Google-Smtp-Source: ACHHUZ7pvmxtYN/zam3Dez9Klnh0TqVs/VqPnMqRQBA5+8cf7He7JCfxNNSnhe6KRNcTvnQsVD4x1g==
X-Received: by 2002:a17:907:7f09:b0:96f:b58e:7e21 with SMTP id qf9-20020a1709077f0900b0096fb58e7e21mr11645865ejc.52.1685706506371;
        Fri, 02 Jun 2023 04:48:26 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/9] PCI: endpoint: Return error if EPC is started/stopped multiple times
Date:   Fri,  2 Jun 2023 17:17:50 +0530
Message-Id: <20230602114756.36586-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the EPC is started or stopped multiple times from configfs, just
return -EALREADY. There is no need to call the EPC start/stop functions
in those cases.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4b8ac0ac84d5..7e0e430e4ceb 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &start) < 0)
 		return -EINVAL;
 
+	if (start == epc_group->start)
+		return -EALREADY;
+
 	if (!start) {
 		pci_epc_stop(epc);
 		epc_group->start = 0;
-- 
2.25.1

