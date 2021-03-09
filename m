Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C227A331D40
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 04:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCIDBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 22:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhCIDBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 22:01:00 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE6C06175F
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 19:01:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 16so1357738pgo.13
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 19:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QS+W2evi8k5aHYAfWwTIFQNUplOvcunWdrdhU6E7/AA=;
        b=kKuYcz7AdrgLmLkWgfpAYgI5827ld1D7r0uARL6409oh58xjPf0s95Mt9rsUKb/c4V
         TiU2UWZLf55hky2fN2jnn6OWekuSybPn/XV5pTZIpXmzvJNIdyqn8Xkvynr32Mq6cojH
         13i0+4VM1KX5Ny2E0EIbTBxmEq9w08cgbdeTg5+K9/ybwksUWAhDT4/nKINFLN6j7cIl
         Bq2aaXjN292EkLs1wn4Rpp1D3OwbtTlwmrfxtbaI0oBJFIiHYbArn+X1K4gkVHNVY133
         f5ms5mDtZg9XuhygfMhFrePFRv+Y18MEzCzLNVXwSmZYqLFDcoNdy9OM4sNXDxQY/JiT
         G2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QS+W2evi8k5aHYAfWwTIFQNUplOvcunWdrdhU6E7/AA=;
        b=n9VrKgp1YfA06qqaazdwNhWCcVc+MxlPv/WiPjX3kCuJFv0Pjj2Fh/BJf+eAbg5P9b
         Q4Y2ph5mu/4UT9ENm9clmHdEilCm3BV3enDn+83P394WKHdPsmB/88aIKKL91GLukwMb
         PR01TiYx8IJchQM3AH1TagFX2c1JAtZG4dbRdq6kca0oGb+sJnKelMUNuy21F+dwifPN
         dpn4c/GbeGllC/CxpzOUxtqX/wH+czJVhsM6nWCfhm/P5P0p4igOQYwDb3U4fLdU3PJl
         tFJNVNjjOb1i5QILUYVg7NlGGDAbdFynYCPoMebsKtSnz3e7UqiWpUdqYOx2QvL75xtn
         prFg==
X-Gm-Message-State: AOAM531aV4bZtRbj4d9ujD5RuysYm/Q1TtBYwj+6V1GPM4A+LDjCKuyY
        ym6OaNnDK9S08n8zk4J/4y61OA==
X-Google-Smtp-Source: ABdhPJwT+ra5WOUg4Um3PiQsfJlLbl29zPQtKJWW422EPe2I7c0CRd9gwTFXtMd/pYdYo87tKtEURQ==
X-Received: by 2002:a63:1266:: with SMTP id 38mr9543939pgs.266.1615258859820;
        Mon, 08 Mar 2021 19:00:59 -0800 (PST)
Received: from localhost.localdomain ([240e:362:435:6a00:e593:6e0:bfb4:a65f])
        by smtp.gmail.com with ESMTPSA id y24sm3162782pfn.213.2021.03.08.19.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 19:00:59 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
Date:   Tue,  9 Mar 2021 11:00:34 +0800
Message-Id: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices have PASID capability
though not supporting TLP.

Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.

v3:
Rebase to Linux 5.12-rc1
Change commit msg adding:
Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

By the way the patchset can directly applied on 5.12-rc1 and build successfully though
without the dependent patchset.

v2:
Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
"Apparently these devices have a PASID capability.  I think you should
add a new pci_dev bit that is specific to this idea of "PASID works
without TLP prefixes" and then change pci_enable_pasid() to look at
that bit as well as eetlp_prefix_path."
https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/

Zhangfei Gao (3):
  PCI: PASID can be enabled without TLP prefix
  PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
  PCI: Set dma-can-stall for HiSilicon chips

 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.9.5

