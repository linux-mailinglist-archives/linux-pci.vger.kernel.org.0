Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B568F439CFB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhJYRKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhJYRIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 13:08:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7DC0432DB;
        Mon, 25 Oct 2021 10:01:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t11so8349282plq.11;
        Mon, 25 Oct 2021 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HZsp9BvdntOEBLsd033W6ZW3RXr9hJrrgi/DSIEiZc=;
        b=B/oKHfT/wUi2uwyEuNgWcKyEN7bNb1zznXch9q1rURws+JRljbJEIPz0+rgscXU0+Y
         SCs5Z+HviUmO/AG6Z/ANiKZe4sA5pzDCa+CIEjE3N5dq9PnkcFuiSkw3lDaQaV/ep//u
         ML0AA4vKJiuK7hluPphy+3uxXyhhohyLOWd/UXwTy3rPg2TO7smbF3Fwk9xJQHUp31bm
         LBfNWATE8ZnQ0WXPUVZXg8XJ+cEYa++C35DWFIZz9KbWcTReIP/lY78+rYfYbXko3beJ
         y/jCN5CcI/o3LdBpkqsUiU46xGnE0j44QUDcKmtzvDotdBtawKt/3XJNuzWrpRHLrlmY
         C2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HZsp9BvdntOEBLsd033W6ZW3RXr9hJrrgi/DSIEiZc=;
        b=LzVIrOiQz7aP54qQ9wP8e29Vd1NsBcrcdIUQIBOO9+bRetqRULVYkAiSWk7ZJ6/m7j
         QwIFlgjOuDLPXwKn1TzpVEBGGdnJ/vVKHl4+Ao2qyfVIMWdCjp1juuprRBtb+Sikxotn
         A/iUqPKwdCP+Qyn1UtbUpipmnOhuYACXJpYcejNqriODD8dZvQ5XU6aufqclEmXvfl1J
         YsddjLYWHmSHJ5XKNCcbueJwMamu1Qjd2cu/aLiRFyZoWTpMtLgnP/llcOHBRlrd72MR
         HmO+z4TdegwYghOOH0MihZUM/IeuYIrM5hKoWWfTOrNSyypbd6F2nHtpiaiu1RRvFcAG
         vxkQ==
X-Gm-Message-State: AOAM532i+I/SpVnpfryuYgvBjU9S7vLOsLcAahDe8iEUTJPj5RcARA5x
        z8mARF1zG776UgGGA5O62bw=
X-Google-Smtp-Source: ABdhPJwUXQUjwnugVGLJbHKCyPdLUZ/UBQqXh8Cy82r1VP1k13Hq1CAUhdRWR7+Izqw0iqyEfe89ug==
X-Received: by 2002:a17:90a:2c9:: with SMTP id d9mr22098933pjd.73.1635181283642;
        Mon, 25 Oct 2021 10:01:23 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:df8b:7255:8580:2394:764c])
        by smtp.gmail.com with ESMTPSA id g18sm5100858pfj.67.2021.10.25.10.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:01:23 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Keith Busch <kbusch@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 0/5] Fix long standing AER Error Handling Issues
Date:   Mon, 25 Oct 2021 22:30:59 +0530
Message-Id: <cover.1635179600.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series aims at fixing some of the AER error handling issues
we have.

Currently we have the following issues: 
  
  1. Confusing message in aer_print_error()
  2. aer_err_info not being initialized completely in DPC path before 
     we print the AER logs
  3. A bug [1] in clearing of AER registers in the native AER path

[1] https://lore.kernel.org/linux-pci/20151229155822.GA17321@localhost/

The patch series fixes the above things.

PATCH 1: 
  - Fixes the first issue
  - This patch is independent of other patches and can be applied
    seperately

PATCH 2 - 3:
  - Fixes the second issue
  - Patch 3 is depended on Patch 2 in the series

PATCH 4
  - Fixes the bug in clearing of AER registers which leades to
    AER message spew [1]

PATCH 5:
  - Adds extra information (devctl register) in AER error logs.
  - Patch 5 depends on Patch 4 of the series

Thanks,
Naveen Naidu

Changelog
=========
v5:
    - Edit the commit message of Patch 1 and Patch 5 to include how to
      test the AER messages using aer-inject.
    - Edit Patch 3 to initialize info.id depending on the trigger
      reason.
    - Drop few patches (v4 4/8, 5/8 7/8) since they were wrong.

v4:
    - Fix logical error in 6/8, in the previous version of the patch set
      there was a bug, in how I added the devices to the queue.

v3:
    - Edit the commit messages to be in imperative style and split the
      commits to be more atomic.

v2:
    - Add [PATCH 7] which includes the device control register 
      information in AER error logs.

Naveen Naidu (5):
  [PATCH v5 1/5] PCI/AER: Remove ID from aer_agent_string[]
  [PATCH v5 2/5] PCI: Cleanup struct aer_err_info
  [PATCH v5 3/5] PCI/DPC: Initialize info.id in dpc_process_error()
  [PATCH v5 4/5] PCI/AER: Clear error device AER registers in aer_irq()
  [PATCH v5 5/5] PCI/AER: Include DEVCTL in aer_print_error()

 drivers/pci/pci.h      |  23 +++-
 drivers/pci/pcie/aer.c | 269 ++++++++++++++++++++++++++++-------------
 drivers/pci/pcie/dpc.c |  16 ++-
 3 files changed, 214 insertions(+), 94 deletions(-)

-- 
2.25.1

