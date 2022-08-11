Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11558FA33
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiHKJnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHKJnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 05:43:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71D93522
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so16034133pfg.8
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=FuszqdVKRODgXPDBIPGNJTPfC+UbIBNSrE2E5rqs79c=;
        b=fJ23Pfw7q7XjCwE8rrFEaFhqcq3UTo1BwAgiHzeRPDaIh6S6lj5BygfYshbiz4CCLw
         ncxfeTUMuafgb49qrpho/dSZj6MOHZ9JA5+xznJDCekUItONEm8cAjlXWDB6GWQD+UqZ
         OW6YsLTfgd7OsPFlaPrZXL4vL2gpySxJa9amTNv+d8syW08sH/KVTeAieVUI7umC9Ucu
         4QJe6aSZJcXbbpx7iSz5Q8fUxa69BOsGa5ueRbySyWImpwcAKNigawKhoFddK3hMlvqp
         4LERGlDGA7s5BcZQQPAm4sJegv61G4QY2lL/+iJuCqgBwCqmJ9hC+R9zzKv4jUCCwHFY
         iKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FuszqdVKRODgXPDBIPGNJTPfC+UbIBNSrE2E5rqs79c=;
        b=2wAm24njeCJQ0AdOWj0aHciYjFiJkf8UgjfOKq0+1ud022o8Ag0i+ZoDw8QnU0/pDY
         WLX+v+LtcHelpSo2+X9tiBNPS4RIefaCp7BBDrqQ9jXgXjwQa1GhurzrO5WTkQyh5OLW
         xJiVznGExHoQi1EVTGhQENozXWWwhHwVikqZc3aU3yknm+ORb4rsJoa3rGsHsMsEH3i4
         IyoIfLJsEo9aF+LhDWwXyUKV95kgO0HjZA8u1drsufKWhxXf6mjKJYXSKLta7zeqoS9N
         vtYr0fteVUGh7SKAYbAjukdNwkeUEYUy/XGleLeAn/XB42NinfQdEtlQj9TU6e7EDFz5
         zKMQ==
X-Gm-Message-State: ACgBeo2bbzDOZ1P35ssJPCODSp/R7l9CT4cLhAMjiC68xhNjqBFOeS2j
        NPjE13N0qa0wl4gQJx+mPrHj
X-Google-Smtp-Source: AA6agR6xiEFTBP/qAlhkDSvvx4xirmbjWieT5tFAl0ao96Lx8X4mb+ZZ6FagKnkqP2ix0s4EN4HjZA==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr25512326pgw.466.1660210984659;
        Thu, 11 Aug 2022 02:43:04 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b0052e6d5ee183sm3553931pfb.129.2022.08.11.02.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:43:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: endpoint: Rework the EPC to EPF notification
Date:   Thu, 11 Aug 2022 15:12:35 +0530
Message-Id: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

During the review of the patch that fixes DBI access in PCI EP, Rob
suggested [1] using a fixed interface for passing the events from EPC to
EPF instead of the in-kernel notifiers.

This series introduces a simple callback based mechanism for passing the
events from EPC to EPF. This interface is chosen for satisfying the below
requirements:

1. The notification has to reach the EPF drivers without any additional
latency.
2. The context of the caller (EPC) needs to be preserved while passing the
notifications.

With the existing notifier mechanism, the 1st case can be satisfied since
notifiers aren't adding any huge overhead. But the 2nd case is clearly not
satisfied, because the current atomic notifiers forces the EPF
notification context to be atomic even though the caller (EPC) may not be
in atomic context. In the notification function, the EPF drivers are
required to call several EPC APIs that might sleep and this triggers a
sleeping in atomic bug during runtime.

The above issue could be fixed by using a blocking notifier instead of
atomic, but that proposal was not accepted either [2].

So instead of working around the issues within the notifiers, let's get rid
of it and use the callback mechanism.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d 
[2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org

Manivannan Sadhasivam (2):
  PCI: endpoint: Use callback mechanism for passing events from EPC to
    EPF
  PCI: endpoint: Use link_up() callback in place of LINK_UP notifier

 drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 15 ++++++--
 include/linux/pci-epc.h                       |  8 ----
 include/linux/pci-epf.h                       | 19 ++++++----
 4 files changed, 36 insertions(+), 44 deletions(-)

-- 
2.25.1

