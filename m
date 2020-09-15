Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA426B7AA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 02:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIPA1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 20:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIOOH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 10:07:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44506C061226
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 06:46:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bh1so1370818plb.12
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MeLJEQ5UzKvpRw+f0TuQfsNut0rOub9KBNZ3XbT5R4w=;
        b=VyzI3l68YaIDGZSJqqVNoBbU0lqcqpmQ6neoGauVB0ydm6bSCbf7jtSUa4s8rToSTJ
         /z8S4X4jJkwIMTgZfJeey5u122Wby9vkT234yCMTUPuB3aURQZmv02RxTc9VzHahY5rZ
         lbx0AeZL11QpO4mI9KEvtNJfUg+F33YmToIwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MeLJEQ5UzKvpRw+f0TuQfsNut0rOub9KBNZ3XbT5R4w=;
        b=pblySAcbOtvjOUSkgBTduTgF4GkE/C4mqDAXkvpTambH9Oj39uRI8V/vipgSiuuhgJ
         6ttLHhuZ6PecXtALuymnwogzBOUfE7hjaE0E4X/NZLpgHIbo/zL52tDxXVMB4iO3+4tJ
         EQeOi6alarrgJoJULyux7MQMZZer7Q+n5XX5tndJNUXqNQB2rIa14UcpAGEcqg6wlu8J
         oOA5ORg490rzzj0Xxg1+GDRBryzLo8q8SSDc8qf140oMf+oHDJJKMm/JzknPbb8DxHSz
         WcxmLS6EhtnYsNjTixOsq8CPQyCicOIT7Ux3Ox7vpd8roZX1NCPO4C1W/JItG3u975sE
         PgVw==
X-Gm-Message-State: AOAM533lBOVpFythsTwrgWtpjjoI0xT/NDVRkGKUOX1wxpHRa1vi0Dq8
        376cjs4DjxbFYvL4Pis6lEsHwg==
X-Google-Smtp-Source: ABdhPJxcNnN5vg5uojXyT3K7ps9jzvHo60XPiUNDKPGLzN1OH9DK612rrF6YmNusesVGKbdSWANS/g==
X-Received: by 2002:a17:90a:c28e:: with SMTP id f14mr4105023pjt.83.1600177572607;
        Tue, 15 Sep 2020 06:46:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz6sm12471478pjb.22.2020.09.15.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:11 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] PCI: iproc: Add fixes to pcie iproc 
Date:   Tue, 15 Sep 2020 19:15:38 +0530
Message-Id: <20200915134541.14711-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains fixes and improvements to pcie iproc driver.

This patch set is based on Linux-5.9.0-rc2.

Changes from v1:
  - Addressed Bjorn's review comments
     - pcie_print_link_status is used to print Link information.
     - Added IARR1/IMAP1 window map definition.

Bharat Gooty (1):
  PCI: iproc: fix out of bound array access

Roman Bacik (1):
  PCI: iproc: fix invalidating PAXB address mapping

Srinath Mannam (1):
  PCI: iproc: Display PCIe Link information

 drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.17.1

