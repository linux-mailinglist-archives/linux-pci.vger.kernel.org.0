Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104C6791A1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjAXHMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjAXHMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:12:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD32DE5A
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so13850163plw.11
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v3vKH0OUQa3EkOREw3bJ+B1AKEzvWHCw7MB+vHd9t4=;
        b=ZJSVtuBM+BhRrNs+A16J+fidiLqSEIJPMS2kMxaVz2bmdHms1q36mXFxsQNLsoleJK
         O6iXXm00waWsaNuJYNPCn/UlhEcrzuT7lzfjNQ3XSjscM1VYmkbYhIcbSViY08bH6uDJ
         EFlEFyFUz6WTD+jM4FV5qsbIP/yeOpKqZbEbis5ukW/K5skZJi2E3eYtpJJ7fwqYgspd
         EGC7a/y2PzCSQygcfX3t3NvD6SjZvShZpko//uPvG/qA7olPKwoG1iDm4r8ZpdIlnbv5
         F+V0B0Sk8poONvMIWht3ogYwciMwpBNi1sGiCJU3k6NuKb1kGyjGef3P2CDomr8k5oTk
         j3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v3vKH0OUQa3EkOREw3bJ+B1AKEzvWHCw7MB+vHd9t4=;
        b=C09xff9a43HfcMXmqCbDbd2whpu4qRI4CSAVOmTkPQOKUaj/u4ZvscuLSrJn+yivnF
         wEN61BECndQ8fchMNTkzevb4NlAXYdaxhqL5Wu39IsXcBfol2VM9kXVx0SCbnDI7/zdU
         fUUNgkfGPBNGb+Y3vkt9d/gSaiS1Ydj+WR9n97EZ7fMNvhLPMiB6kmbipAOm0DqPRHOA
         0v0D2SIiFj93i0c6SEVHwP4hGKQWjjQW1d9A+z2XICpbRDNdSp+QAkYEB9c45yr+2lBC
         MY2o0qhfleUGZ14K5IZNFYep2QBTV62lX2P92PHno1Z4JGq0A65aF2l59j998QrIkeIq
         YUvw==
X-Gm-Message-State: AFqh2koZCoBu1KMW+3e5G9j2zstQU5sN1VHPRhlzEsPgTR35EygHfDpu
        w6MVb4px3k4yOjlHn9XGTneG
X-Google-Smtp-Source: AMrXdXsW7QSNkm4uOigZ/myGZxmMqpOzvzzypL4fJeke5jbE8aqCHXJGUWDZeA4LkX4bcoYOSSQfsg==
X-Received: by 2002:a17:90b:35c9:b0:229:8e0c:68b0 with SMTP id nb9-20020a17090b35c900b002298e0c68b0mr29172185pjb.19.1674544339457;
        Mon, 23 Jan 2023 23:12:19 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Date:   Tue, 24 Jan 2023 12:41:53 +0530
Message-Id: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

Changes in v5:

* Collected review tag from Vidya
* Fixed the issue reported by Kbot regarding missing declaration

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

