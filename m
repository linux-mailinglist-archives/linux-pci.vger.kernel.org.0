Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A73422EFA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhJERUw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhJERUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:20:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7745C061749;
        Tue,  5 Oct 2021 10:19:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s75so2369126pgs.5;
        Tue, 05 Oct 2021 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQT+mDvkkQCJQfW4l8MXueOtWGmReSv26PNLqJ69eIE=;
        b=SAKUQo0n36vAvd2dP1867PQKEdhRlgvmbuzGuIjn6ExEt33l2DZ+FZeddFfsxZhPoN
         pE1xkI3/fiwkKoL3lO3xSRKeT39B5otGFTRCa9aZtDn1KSLn8LY32Q3jEUGqnrGQhrRf
         FEtTYTJWYMEm+plrrqi7vMw6tb1+3M+HUHAEaCbcIwP/maFCEilzUAFRDi4o/D4gskpb
         dHH2tz7jl/EJDxM1lPpu8WUPW8FJtFq2xv+1kXuWmLX4IEXmoFtix8X8sQDIXBkTXUg6
         X/01cjlj1ILLP2ZCI0eSAjTkX/SUAk97sQ0ISZoae2hjQQVoyJioUA2bq18o/TxQ8bFD
         viIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQT+mDvkkQCJQfW4l8MXueOtWGmReSv26PNLqJ69eIE=;
        b=q53FjND+vqd+IsLbmVrMROuyL2ESxOhAqyr8htxf0Vdcl7H7YzVb8wbSlxM5FWpfb4
         HlCV7QH1YfHPPihkaHnSIC03dxr6687qNhgV47zo6Xav99KI4cb0G289/I9zhVa7utX5
         vJAwvHd0L0VubNVTLyXdm6wVlByUaOWeAn1t4XUl3IWnLOBlInqBPeupKrYR5rfrhfno
         TT4C0Kmv2srD9YUeZHYeQEnP6E5k90B/HoroqfIh1lBmwUpRMx1SG+VHt6ga8sYRiJE9
         4JYH97VSMG5FThIaxT19JxbqgmybUVgvrWdBuM4GXjB4K5rNy79YjP08Z16UxiJJ/VJw
         V/7Q==
X-Gm-Message-State: AOAM531CunmcfL08+gb26pb2yRLK2w5uVfEgRsloQfzYfnFEZ8uUAT7O
        9uxqRI8TGVlXKVQ1WCfCSno=
X-Google-Smtp-Source: ABdhPJzEWfjabqzm399k9sgiMDMfZMs8fGUj9h1G1NasJnjVQm0jliPuqYwmVa/JBUHJf7aVDXzsGQ==
X-Received: by 2002:a63:5717:: with SMTP id l23mr1322508pgb.87.1633454340207;
        Tue, 05 Oct 2021 10:19:00 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:18:59 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/8] Fix long standing AER Error Handling Issues 
Date:   Tue,  5 Oct 2021 22:48:06 +0530
Message-Id: <cover.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series aims at fixing some of the AER error handling issues
we have.

Currently we have the following issues:
 - Confusing message in aer_print_error()
 - aer_err_info not being initialized completely in DPC path before
   we print the AER logs
 - A bug [1] in clearing of AER registers in the native AER path

[1] https://lore.kernel.org/linux-pci/20151229155822.GA17321@localhost/

The primary aim of this patch series is to converge the APEI path and the
native AER error handling paths. In our current code, we find that we
have two different behaviours (especially when it comes to clearing of
the AER registers) for the same functionality.

This patch series, tries to bring the same semantics and hence more
commonanlity between the APEI part of code and the native OS
handling of AER errors.

PATCH 1:
  - Fixes the first issue

PATCH 2 - 4:
  - Fixes the second issue
  - "Patch 3/8" is dependent on "Patch 2/8" in the series

PATCH 5 - 7
  - Deals with converging the various paths and brings more
    commonality between them
  - "Patch 6/8" depends on "Patch 1/8"

PATCH 8:
  -  Adds extra information in AER error logs.

Thanks,
Naveen Naidu

Changelog
=========

v4:
  - Implement review comments
  - Make "Patch 1/8" commit message more meaningful
  - Fix the code comment error detected by kernel test robot 
    in "Patch 6/8"

v2 and v3:
  - Fix up mail formatting and include the appropriate receipients for
    the patch.

Naveen Naidu (8):
 [PATCH v4 1/8] PCI/AER: Remove ID from aer_agent_string[]
 [PATCH v4 2/8] PCI: Cleanup struct aer_err_info
 [PATCH v4 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
 [PATCH v4 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
 [PATCH v4 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
 [PATCH v4 6/8] PCI/AER: Clear error device AER registers in aer_irq()
 [PATCH v4 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
 [PATCH v4 8/8] PCI/AER: Include DEVCTL in aer_print_error()

 drivers/pci/pci.h      |  23 +++-
 drivers/pci/pcie/aer.c | 269 ++++++++++++++++++++++++++++-------------
 drivers/pci/pcie/dpc.c |   9 +-
 drivers/pci/pcie/err.c |   9 +-
 4 files changed, 209 insertions(+), 101 deletions(-)

-- 
2.25.1

