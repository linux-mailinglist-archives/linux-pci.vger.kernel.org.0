Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212860CF8C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiJYOvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJYOvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:51:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4071998BC
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ez6so11107322pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGn0PbiFymHKMcNjUGWXoioOm7PfQt5MHEJvVchVE4s=;
        b=UBypWPLGznT/DbD9AMQEGECW2iMMvloV/G2ZoYyVyVeeSOTvnpiF7h8kWMo3HCzfP4
         864MlB+6jkvI6b4CtPov+9fqWzC+GtZhjIdb9PZQ/0bgbkk8fYE/fAfVe4CdE4a2jpWz
         Qcqf+YBwwNwwLIlTGN+Q/A/y2y9os7ZsT+/ZV+eU/d+EGTiT6bdNEwo9tbnHgMRrlKUI
         Upa/9ZPTicsx/N/SnhIg3P3mwfuUwQ+8te9mhGM+MJeNCHa0N+tFLVXg4xhUKnRgltTZ
         B6t0gd4X3FA2TMEK3DKbQMM/AP+X/v5vMsDXyheolsMIaJC3Y6fPo+HKBQd8RqTl+V0r
         exrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGn0PbiFymHKMcNjUGWXoioOm7PfQt5MHEJvVchVE4s=;
        b=KnoW8HwsMyhBDMvTUb9Y9lz6449t6n0r+X89C3dD/kTGaY3bKfT9A8J2cNoNXUQlZQ
         3fhSBqTN/D8Kz/5XWLAfjO2aujLkKx4uD9JBqV6IQ8w1oguHsiLdzJnSfhrNgvc9PvhW
         ke4pyzkjM5fT/UF61EqKCnfg81boZtONFs5vqCA5LJUXQXSpaa8g0LZI1juurR/c+VAh
         /uurb7+7lFat0Eg7fKQvwSYgn5S0fR+D9dyyTRnZEJ+DKMDTPrYrNjeOwqFDFVj/RTQl
         mvpnRmqhiIjZJMGUWORIfhrCeoUycPPNG0nIQ7KG2rp8BbpxaDrV1+rYYSLSjn9TD9tu
         6Z2Q==
X-Gm-Message-State: ACrzQf3SArc7XgL7VrM12plnO98r6NIuzH4qVaqD+iz/YFDaL4o2p7gj
        GLZMjUrFUyznKzBz0JBNzmLr
X-Google-Smtp-Source: AMsMyM4QmJ9hENMOITCzYCmLDpzoUM/Vm/0Ns4a2Kda0pfGS+9s+6NymvzcHhs8Liv3/+kTJpgIA9A==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr38935135plz.108.1666709473534;
        Tue, 25 Oct 2022 07:51:13 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm1318765plh.130.2022.10.25.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:51:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Date:   Tue, 25 Oct 2022 20:20:56 +0530
Message-Id: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
on the real platforms is greatly appreciated.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
[2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org

Changes in v4:

* Added check for the presence of event_ops before involing the callbacks (Kishon)
* Added return with IRQ_WAKE_THREAD when link_up event is found in the hard irq
  handler of tegra194 driver (Vidya)
* Collected review tags

Changes in v3:

* As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
  call the LINK_UP callback in threaded IRQ handler.

Changes in v2:

* Introduced a new "list_lock" for protecting the epc->pci_epf list and
  used it in the callback mechanism.

Manivannan Sadhasivam (5):
  PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
  PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
  PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
  PCI: endpoint: Use callback mechanism for passing events from EPC to
    EPF
  PCI: endpoint: Use link_up() callback in place of LINK_UP notifier

 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
 include/linux/pci-epc.h                       | 10 +----
 include/linux/pci-epf.h                       | 19 ++++++----
 6 files changed, 59 insertions(+), 51 deletions(-)

-- 
2.25.1

