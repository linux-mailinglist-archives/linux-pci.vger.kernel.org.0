Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512F5B4555
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIJJF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIJJFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 05:05:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ABC50199
        for <linux-pci@vger.kernel.org>; Sat, 10 Sep 2022 02:05:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bj14so6921083wrb.12
        for <linux-pci@vger.kernel.org>; Sat, 10 Sep 2022 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=d7tf1XXa5Vq2bwwcy5Xu9d/XyLL0CmmAqRyXN8c8+6s=;
        b=kjdjvGclYosJ2Fg0C2oNGk0EREncpuv3smn6RsSvGk5qEhtu85We9oXBcZ3qs1OBkp
         xcM8NRRcJItR193Njxjvq+Fq9piSn2gQ6wC6cPp3uWKN3TccmrG4jfwm5CzpzCrEsVXJ
         GYjkYthxnI9DFLtOvtpZkcAJUrb6TiVTSqUMsj/MZyJRnCO1HrMvgjsMCC9jDt2h/uSm
         638xX/a3W9+IQPA/nCbhLFB/D2vWaPAYNJmp7LLGlDigN0jvDUKh1ZoOVQ5EFSC4Vct4
         MG1+qV8+m7qevi4/x4ujjj1YkUncLZIYB9QzqoPMEfoWL2mnF8bkaiZpYVnIPKMhCIls
         QIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d7tf1XXa5Vq2bwwcy5Xu9d/XyLL0CmmAqRyXN8c8+6s=;
        b=1Hb8Up4z//49PPRy74YUCI/ftj+fg1GA8AKbYMP56dC3VIaw8nIrfAIbybgnXcbNfJ
         Xb7011/HNrPdT5w27bLN15Sq4VcpAdUhQ/wJrFB+C/l54dQ5AW/HIJwjwD16wc1POQZh
         lcon/5wi0qfwVq66SQMP29DxTf6K33eJayRDI4t/g6Ypco6IdBhqKtmq6xmGQ/N7PDLF
         vVnjev5BEROY2hjLxN/QcVHiGU9x++f968uWvJM7rRh3Z+Pi1FRpe5J8PywQW48QCZd7
         5SxF405IdzX8pia22pDY1fKt62ff+zkPRh4az+n7+5hJs+bAwKKHu7HR26fCaeW1EmSP
         YQUA==
X-Gm-Message-State: ACgBeo1IJdgAckx3qV6XYCU73s8oyDK0W1e9Vq/u8RSVvE2PPNN5dGgZ
        qGY3haYy2lA0uZuKEFibSlso
X-Google-Smtp-Source: AA6agR7SsTf7M8hsFc/yPjOJHI21NvhxFFByoNsoORxWcutU4P+Um7UlyQGAhJgBRCd24SFWKuh1pw==
X-Received: by 2002:a5d:6d0b:0:b0:222:955a:8774 with SMTP id e11-20020a5d6d0b000000b00222955a8774mr9550870wrq.129.1662800721898;
        Sat, 10 Sep 2022 02:05:21 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id i81-20020a1c3b54000000b003a8418ee646sm3081677wma.12.2022.09.10.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:05:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] PCI: endpoint: Rework the EPC to EPF notification
Date:   Sat, 10 Sep 2022 14:35:05 +0530
Message-Id: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes in v2:

* Introduced a new "list_lock" for protecting the epc->pci_epf list and
  used it in the callback mechanism.

Manivannan Sadhasivam (3):
  PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
  PCI: endpoint: Use callback mechanism for passing events from EPC to
    EPF
  PCI: endpoint: Use link_up() callback in place of LINK_UP notifier

 drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
 include/linux/pci-epc.h                       | 10 +----
 include/linux/pci-epf.h                       | 19 ++++++----
 4 files changed, 51 insertions(+), 48 deletions(-)

-- 
2.25.1

