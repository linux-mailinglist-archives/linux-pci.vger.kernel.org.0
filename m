Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00D2280992
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 23:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJAVom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 17:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 17:44:41 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3100D2074B;
        Thu,  1 Oct 2020 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588681;
        bh=jKkLgzCx8HaJ1+6VNlsAcoVGbytrdz9Zie+bKwei/FA=;
        h=From:To:Cc:Subject:Date:From;
        b=a4KWhobngAR1cpYyoK02I9el6sZx2X30paPnXCqaC3y4slAAvHlIyefQW2NKr4tei
         xU9xtNBjA9rfgHkt53izrJt983Jol1TExEYRizQNIWrsyBwKoIBd46bMF9RyAU5cOM
         F9SkfaDP2UIsqXEbr6v5gPvED8x7YC7qzgktO+Yg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 0/2] PCI/ASPM: Add support for LTR _DSM
Date:   Thu,  1 Oct 2020 16:44:34 -0500
Message-Id: <20201001214436.2735412-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a v6 of Puranjay's LTR _DSM support.  It should be functionally
equivalent, but I moved the bulk of the code from pci.c to aspm.c, since
it's only used for ASPM.  I also combined pci_ltr_encode() with the
existing encode_l12_threshold(), since they were doing essentially the same
thing.

I'll reply to the patches with a few more comments.

Bjorn Helgaas (1):
  PCI/ASPM: Rename encode_l12_threshold(), convert arg to ns

Puranjay Mohan (1):
  PCI/ASPM: Add support for LTR _DSM

 drivers/pci/pci-acpi.c   |  35 +++++++++++++
 drivers/pci/pci.h        |   4 ++
 drivers/pci/pcie/aspm.c  | 110 +++++++++++++++++++++++++++++----------
 drivers/pci/probe.c      |   4 ++
 include/linux/pci-acpi.h |   1 +
 include/linux/pci.h      |   2 +
 6 files changed, 129 insertions(+), 27 deletions(-)

-- 
2.25.1

