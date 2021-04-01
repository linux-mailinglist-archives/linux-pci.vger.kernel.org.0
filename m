Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49535176C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhDARmO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDARh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 13:37:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BBC02FEBE
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 09:35:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p19so1352738wmq.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Pv6jKxkc1D3IQH8AU5ppAe0sEFoEe1ZBtjtF7SjWL70=;
        b=bHCZ/+2rHYb/CNMwDAXkfGdJ09EMWy9etPE0vVFYfae9erQmqS0yE9yHxgdZY0IDqi
         dMzqSDwuOnuZaUKwBXzvNHZNf61KFZp/pXnWGZhRqoI2wZCTivnp4FOj3icjo9Z2bown
         KUitGqYifC+1U7i0ts/xc+xavqUEhip4WPl08XWVcJ/5nOsfIaD/r3d6TnG6+TRY10dY
         BdEBulvNa2XHgJ+0cZOHIU+q7PLghHZm6W6k+UgfKZK2G/jfkfXk6emvWfEGmkV/NRaV
         y9Z1zEPRFxPrdmpg+aOHwQdIMDtC2jd7Kt+KmA+RGcHNiHDWsfTMOPddnM/0/DEKEv39
         4byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Pv6jKxkc1D3IQH8AU5ppAe0sEFoEe1ZBtjtF7SjWL70=;
        b=Sdf4x3/xFPTmd8c/f211MeOSFAG8AHeYnyMWWHTqetSqFF2n5qIBVLnxcG8Vrvw8sT
         uwesAMuO4R3ZI6a+2G+5ljwYz0hgATp8erxl42ElOZXeLQseZMYCFXjtxxUFzQwx+/OV
         UE9po5S0BPVxPoy1VtQA9kX5t92Z6eLcwYwNB8AIX95E+QXOuMtrI1w82XAu2hbSezk9
         bMVaMRbK1+wwnDhqVHFw/AqFsRohwBwfYte7gIBzYMtojDjtAO7pdo9h/cyO2zWdvGNL
         ge/qTDH6S6EWONODqUvcwGdxv9MnHwWjp+bFu3/qGhtq6hqX5GLYnBUEyj3B0N6CugsI
         H/eg==
X-Gm-Message-State: AOAM532AN9PJKnS2L1jr1SS5kA57F6Ix/JvUwOlm+FhPqALhEkXJ9h0F
        Gu2QU6J0m5CjA1WIffe0Cvx0N1A+KDR9qQ==
X-Google-Smtp-Source: ABdhPJxQV6BWdl9GB9T4jKeP7oxpQGf1AUFP1VQd2qlVsi0hoAiAoR4Y0qyr9yjPrA9OT8/ViC/FdA==
X-Received: by 2002:a1c:f614:: with SMTP id w20mr8770710wmc.70.1617294930075;
        Thu, 01 Apr 2021 09:35:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id a13sm10115740wrp.31.2021.04.01.09.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:35:29 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] PCI/VPD: Some improvements
Message-ID: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Date:   Thu, 1 Apr 2021 18:35:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes some improvements. No functional change intended.

Heiner Kallweit (3):
  PCI/VPD: Change pci_vpd_init return type to void
  PCI/VPD: Remove argument off from pci_vpd_find_tag
  PCI/VPD: Improve and simplify pci_vpd_find_tag

 drivers/net/ethernet/broadcom/bnx2.c          |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 drivers/net/ethernet/broadcom/tg3.c           |  4 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |  2 +-
 drivers/net/ethernet/sfc/efx.c                |  2 +-
 drivers/net/ethernet/sfc/falcon/efx.c         |  2 +-
 drivers/pci/pci.h                             |  2 +-
 drivers/pci/vpd.c                             | 40 +++++--------------
 drivers/scsi/cxlflash/main.c                  |  3 +-
 include/linux/pci.h                           |  3 +-
 11 files changed, 21 insertions(+), 44 deletions(-)

-- 
2.31.1

