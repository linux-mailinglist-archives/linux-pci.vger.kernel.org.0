Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5382C4210F1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhJDOKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJDOKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D35C061745;
        Mon,  4 Oct 2021 07:08:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 133so16664130pgb.1;
        Mon, 04 Oct 2021 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90VZotrStGy8mgssJr/W9iFiKQDvcfNAnl0DsJhkfs0=;
        b=o/QK+MjgwS+aEQuPx4irPsbCaHMW6sfXp8BaqM12h1M93plmbNOTRFIEVh1NBvMkEB
         ZUI/rsaRIpecJgpTBkNdVhjXxkwcmFdasoMV5ExX4poVBKt+rT6b3AXqoH8YrS1V9Cma
         yTLd30q8/soHf0V8eO5srZz85E1ywxMMQjSiHSXBQmm4FwKQnXqmnLibeVWcAbhZsPoG
         g7rBm1DWVZe9gEnb4fnGCjTY7cLC1uB+fjbWcPtPfaxV99JFomRFEybhCoXr3oNyDkpZ
         +zue++onjHrY646/5Vrk8fAzNswt0qpQPvj0GEqZcPrHvgmnxDwplbLQUFeXbAVc1+Wk
         8g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90VZotrStGy8mgssJr/W9iFiKQDvcfNAnl0DsJhkfs0=;
        b=V0CbbIIoy7DHD3t1qapP9Cv+MPDzyzoP9m9AwYSCD+Ny6cc9AoaAXn+mbsRyh0z8Ry
         5U0tEubGXfCAE2Gbp68wPCFnxNPz1OgNisOSl2rbeqJ0XpDocWRFAbzpeyKzwMGBFGAR
         j3Iq7aSm26GOc9i/fcw1o/RTy/00uM/CGBrweVEIbQpzQoChRBlBGSFVJ915lhN7Cx7v
         Gb5P6CFm5Rkhw4N4Nfmsp//LPhQjrkqlExb0S3RwmBWF4uJBnhySDVxeg/8KZo4qY/VG
         IRc1BCwM+1XWWMc3eYjEGKLVMt2IbFh6SNn3bthQhLamXFBnYDjZDPswEvhxuTrHODIA
         wP8A==
X-Gm-Message-State: AOAM531jGsIW0Mcj+EalpIq0s8aXaKs+/LQIsYTYmf1WVnHarCSLean9
        FjiFrDrm1rJ+mUmed6qxUP8=
X-Google-Smtp-Source: ABdhPJxdmeh3wBzsACdJJKEbMJ6nFPRgGudEiYPsvM9XJ9KsMd2LE/efWBCTvow/NjbvzslzV8Q/lg==
X-Received: by 2002:a63:63c5:: with SMTP id x188mr5138080pgb.391.1633356491815;
        Mon, 04 Oct 2021 07:08:11 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:08:11 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/8] Fix long standing AER Error Handling Issues 
Date:   Mon,  4 Oct 2021 19:36:26 +0530
Message-Id: <cover.1633353468.git.naveennaidu479@gmail.com>
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
  - "Patch 3/8" is dependent on "Patch 2/3" in the series

PATCH 5 - 7
  - Deals with converging the various paths and to bring more
    commonality between them
  - "Patch 6/8" depends on "Patch 1/8"

PATCH 8:
  -  Adds extra information in AER error logs.

Thanks,
Naveen Naidu

Changelog
=========

v2:
  Apologies for the mistake, I forgot to cc the linux-pci mailing list.
  Resent the email with cc to linux-pci.

Naveen Naidu (8):
 [PATCH v2 1/8] PCI/AER: Remove ID from aer_agent_string[]
 [PATCH v2 2/8] PCI: Cleanup struct aer_err_info
 [PATCH v2 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
 [PATCH v2 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
 [PATCH v2 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
 [PATCH v2 6/8] PCI/AER: Clear error device AER registers in aer_irq()
 [PATCH v2 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
 [PATCH v2 8/8] PCI/AER: Include DEVCTL in aer_print_error()

 drivers/pci/pci.h      |  23 +++-
 drivers/pci/pcie/aer.c | 265 ++++++++++++++++++++++++++++-------------
 drivers/pci/pcie/dpc.c |   9 +-
 drivers/pci/pcie/err.c |   9 +-
 4 files changed, 207 insertions(+), 99 deletions(-)

-- 
2.25.1

