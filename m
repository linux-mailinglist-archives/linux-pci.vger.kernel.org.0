Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B26421159
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhJDOc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhJDOcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:32:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7CC061745;
        Mon,  4 Oct 2021 07:30:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so211955pjb.1;
        Mon, 04 Oct 2021 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rr106+TYNeK97taV8nJ/RZEy+nuSWL8bqPL/aoVjRQ=;
        b=dCrrsJvny+hB8TpVDzPJqM5XRNvg99gIyL7pccDv7Hg1idhKdsZXpuRzIqSm3k86wK
         6EpxKp5R2n/dSTSd3atPrxHHsbxx+oe4QOD9qiSAZBylCjJ/UaJEVRxwhOYJgvYAEwCg
         0CzNm2RlWEjNdGNgA4/UBYBB3yQNWWFADdfOlPRfJZb4Qwn7xV0cLfa/mnbiDSaE2V+A
         J145kLAi1Edyeub2jRxpLg3PP5yJ3pq/1p63zI+4MvIcFjEoGjPVtz07Vu1hRTxdft0L
         IhSYV9nXW/pt8qQRW7/qijuCW/9s3fZ74iEFxxUI/5U3H+UOjySRtoIH+mIODSuiBZhB
         G++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rr106+TYNeK97taV8nJ/RZEy+nuSWL8bqPL/aoVjRQ=;
        b=w5Je2kRN3toooDz93EP8PXGub2DZX6+zElUZ50og4HtcT3Y0pq0iuElm0OyB7+5N0n
         ypn5n7fND3xicGBEnpVI6FMl3rOIk5OXhrVBzrQmQVgK/CiJbfHAtXBCZiuTmWrBOxd+
         Sr9oJ9qP85qxcPJ/1KUWhmgKpH2ouUFLQlfn8vH+0bJJXwqQy8cT8dc5rAbvuf+jFQtK
         jgLKTTwRg3ihsEFpf1do88RuszpikndUcRRE6D8AVrkAOAAq7ntERU/7CJ9fFaU7y9F9
         TzRRWDVqQz3SIoAnPV5Jow1/r+Pta2WQ9HkZ3QGkR/rQNk2kxl3VHAsv31v0HI74IzXz
         9rSQ==
X-Gm-Message-State: AOAM532o49X1d8MplLbI6sZ48C6KJ8mjnzUf2YdHGzF1LIjrjAT7ezl3
        DEyC7Jm1NM+nk6ZCmq4Cn/4=
X-Google-Smtp-Source: ABdhPJw6PldeGsjV/EL0pdYEviOaQ4rPP1DQowLQR2PYIHQgBZUm1Hnv61uEdepS0yhN1pwijPziZA==
X-Received: by 2002:a17:902:9689:b0:138:d2ac:44f with SMTP id n9-20020a170902968900b00138d2ac044fmr23336055plp.85.1633357836449;
        Mon, 04 Oct 2021 07:30:36 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:30:36 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/8] Fix long standing AER Error Handling Issues
Date:   Mon,  4 Oct 2021 19:59:56 +0530
Message-Id: <cover.1633357368.git.naveennaidu479@gmail.com>
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

v3:
 - Fix up mail formatting and resend the patches again.
   Really sorry for all the spam. I messed up in the first try and
   instead of fixing it well in v2, I messed up again. I have fixed
   everything now. Apologies for the inconvenience caused. I'll make
   sure to not repeat it again.

v2:
  - Apologies for the mistake, I forgot to cc the linux-pci mailing 
    list.Resent the email with cc to linux-pci

Naveen Naidu (8):
 [PATCH v3 1/8] PCI/AER: Remove ID from aer_agent_string[]
 [PATCH v3 2/8] PCI: Cleanup struct aer_err_info
 [PATCH v3 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
 [PATCH v3 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
 [PATCH v3 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
 [PATCH v3 6/8] PCI/AER: Clear error device AER registers in aer_irq()
 [PATCH v3 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
 [PATCH v3 8/8] PCI/AER: Include DEVCTL in aer_print_error()

 drivers/pci/pci.h      |  23 +++-
 drivers/pci/pcie/aer.c | 265 ++++++++++++++++++++++++++++-------------
 drivers/pci/pcie/dpc.c |   9 +-
 drivers/pci/pcie/err.c |   9 +-
 4 files changed, 207 insertions(+), 99 deletions(-)

-- 
2.25.1

