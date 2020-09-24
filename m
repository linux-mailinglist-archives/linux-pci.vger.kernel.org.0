Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20E927752D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgIXPYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB0C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gx22so5058134ejb.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AbhCv3A2jDP6tq0dh3IocpTVBUh9NwbFtE/5jAmuP3A=;
        b=AFSgLdBNJDZ31gJZMUlfyQYn0KKU+Gm/darRkaWGn0cyA6bA5creQKj6c7S5TZ68XI
         TXyqWnT3nEZFiVCHTIQGwDRgpPgeHjsHr48wYWrdvsUGM4qGS+iRGPIJqoHcW8z8zl/y
         9K5Ea5aCQDuAgqQN7dCpPQu7cxjtkSg3JPKU+PdiQ8QPjP3FXwpj2ZVdtlurdnx+ujH8
         zUOYrZR9q3/Viz0DePHK2+mTvHT7OqtynVNmuIKhTyhUCKf+Ye4SgNlETPA9iLfYcVJH
         d5FM1XAdexSxkEsfalEvahbjTnfslwEKRs5CSpcsXoBSDVz/kLMoqsmG0JsEpN0vyE4K
         Xtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AbhCv3A2jDP6tq0dh3IocpTVBUh9NwbFtE/5jAmuP3A=;
        b=B1hqqiV/5zdZVObQslps4UYV189VXzCA/CTy7XnKLMTp4wilcTIOaoh2xcrY5n6wdC
         Luf8RB7FrdY3FBqgd0ma49GJYD5Jjzmmi1qQ5WWNLzULm/cPeVK/Wudj1BiVLtgSX7Qo
         tgxYfCVnz8ZjEqteTG5UOjE+BVf7ZbrzqetN9UVafti7EaQOJluemMtMbTpcPaAgimOR
         tiplkOgCkXUN/mCir4m5OCT3tmW4A4r7c0mCT8ZKi/2IWfuqcBZfKzcR8g6w1xaiHGRO
         FGVkXzOWV0eTybpn7ahP0gphIrhbg2Jip+WMDx0dxqMcuPBqrmqQi88BhJ9LN4bXqmLS
         syeQ==
X-Gm-Message-State: AOAM530dOsQgj1SQ2LH/SgPuAUCTl0tWjWIG84oBzi143ShHhAIrxJdJ
        4N/Uv4i6i0Mz7PFqUUZpU3A=
X-Google-Smtp-Source: ABdhPJx3o4pTHyeshy/VlVFm3F9DKCraWuPIBcBYF6JKkiWTLeYMWad3DVx4WX0LIhYUH7TLRCDlqA==
X-Received: by 2002:a17:906:3aca:: with SMTP id z10mr381956ejd.419.1600961051956;
        Thu, 24 Sep 2020 08:24:11 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:10 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/7] PCI/ASPM: Move some ASPM info to struct pci_dev
Date:   Thu, 24 Sep 2020 16:24:36 +0200
Message-Id: <20200924142443.260861-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series migrates some ASPM information into struct pci_dev.
struct pcie_link_state.l1ss and struct aspm_register_info were
removed.

Changes since version 1:
 - Rework patches to remove redundant variables in the same patch.

Saheed O. Bolarinwa (7):
  PCI/ASPM: Cache device's ASPM link capability in struct pci_dev
  PCI/ASPM: Rework calc_l*_latency() to take a struct pci_dev
  PCI/ASPM: Compute the value of aspm_register_info.support directly
  PCI/ASPM: Replace aspm_register_info.l1ss_cap* with pci_dev.l1ss_cap*
  PCI/ASPM: Remove aspm_register_info.l1ss_ctl*
  PCI/ASPM: Remove struct aspm_register_info and pcie_get_aspm_reg()
  PCI/ASPM: Remove struct pcie_link_state.l1ss

 drivers/pci/pcie/aspm.c | 203 +++++++++++++++-------------------------
 drivers/pci/probe.c     |   7 ++
 include/linux/pci.h     |   3 +
 3 files changed, 84 insertions(+), 129 deletions(-)

-- 
2.18.4

