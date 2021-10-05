Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDFD422F08
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhJERWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbhJERWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:22:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170AC061755;
        Tue,  5 Oct 2021 10:20:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c29so137216pfp.2;
        Tue, 05 Oct 2021 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=GlH/iBtQPycG2+vBjfYb9YFZT0YC56AKQ1tVIynYkTBrvjpWGLWo08OltcrmtvYqIB
         0jMRr3FkNUcmMQxd2pt/9uCc0CqGkPvYMwM0XNwKaTsh9ExY6AmpD7hjpNw6QuKFq5cS
         zwT6QC2ioPW/E4YzbKYad5iLMiCdSaCTyvyZqrFOz46tnl2GRqON1GXP/f3PnTd4TO7c
         1fj1xkFehbw0B1+H3i4vdBlg6AuCcyBAjoVxIo2XgxE7U5Yz867IPV3RNkAMknj9Hmyd
         ltNU6p9WNhu0nxcT7+cZlG/vUiVw2am4cK9x7rGAryS1t+2vkwdoy73GxJXeLNjNsBfo
         E1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=YZYGnnigql2E08tKaENCPRAzeUnmLrHPEHLa77Ohpa1cTdPjvzwZtmrEWyDoDpvGtg
         wqWQkqiO74K1dzr+d7qN5yVQTbB+3oVnpVEiQYsBeVQ8W0Q3loL68MvCXKBs8IUN2YYX
         RnOa0OQx2Fd0sxXGgshoAm7dZCyXPj64lL0SFPpc/CGrK4mdnmrLp0Lv9Ob5CdYTAdpf
         xhB4v08I4aXOr31HXEdbOOIN9dC0wzH7glfpNE5HkmHmRbotjpLZ5djFHx4d1K2T83Ql
         GhohRMPJAZ9fi3Fx72cEn/zAcDwOcPqjhb2qWJejkV5iG0EkLNI2Swf7wT84ib73TuSH
         NVNg==
X-Gm-Message-State: AOAM530PaweOB5yg83w3ikwmnZxSn6/rkkBEgAKBkHAhYfcC4UGP+XX5
        yoAqskp2ajFo8ZYUDaRS0nM=
X-Google-Smtp-Source: ABdhPJxWGXtU11U8vgjFgtp/AwHRz21P2apHXPFWNX+czZ73dNSiwz+WnMvQIpDfwIBfgeFjid5dvA==
X-Received: by 2002:a62:3802:0:b0:44c:776b:f555 with SMTP id f2-20020a623802000000b0044c776bf555mr6250036pfa.82.1633454424124;
        Tue, 05 Oct 2021 10:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:20:23 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
Date:   Tue,  5 Oct 2021 22:48:12 +0530
Message-Id: <0a443323ab64ba8c0fc6caa03ca56ecd4d038ea3.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the EDR path, AER registers are cleared *after* DPC error event is
processed. The process stack in EDR is:

  edr_handle_event()
    dpc_process_error()
    pci_aer_raw_clear_status()
    pcie_do_recovery()

But in DPC path, AER status registers are cleared *while* processing
the error. The process stack in DPC is:

  dpc_handler()
    dpc_process_error()
      pci_aer_clear_status()
    pcie_do_recovery()

In EDR path, AER status registers are cleared irrespective of whether
the error was an RP PIO or unmasked uncorrectable error. But in DPC, the
AER status registers are cleared only when it's an unmasked uncorrectable
error.

This leads to two different behaviours for the same task (handling of
DPC errors) in FFS systems and when native OS has control.

Bring the same semantics for clearing the AER status register in EDR
path and DPC path.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index faf4a1e77fab..68899a3db126 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,7 +288,6 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_status(pdev);
 	}
 }
 
@@ -297,6 +296,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	struct pci_dev *pdev = context;
 
 	dpc_process_error(pdev);
+	pci_aer_clear_status(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
-- 
2.25.1

