Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA771D29F5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfJJMrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 08:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733288AbfJJMrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 08:47:55 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE852067B;
        Thu, 10 Oct 2019 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570711675;
        bh=xH5hUmNUB5+dgxk0q2lFYYcSuqGDN9IgEL40mmPPtqs=;
        h=From:To:Cc:Subject:Date:From;
        b=p8FpxpMXf6WpshIuSefbjbBq2Je8uZRrp5b1fsP8Pr3WVWcNX4PMBPGtol4L3yG0j
         vzN5AdlKAi96Fv6ceLNiRMIS27shKnLFPnsJZ18T2IbPvoF99dQDkKhFU85xdRvVx3
         snkhwNUYMk4t1i3o7TEAFHU+nspOkJvgG0+0iOAQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/1] PCI/ASPM: Remove locking
Date:   Thu, 10 Oct 2019 07:47:45 -0500
Message-Id: <20191010124746.2882-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

In reference to this thread:
  https://lore.kernel.org/r/20191007223428.GA72605@google.com

This removes locking from pcie_aspm_enabled() because the reference count
held by the driver should provide all the locking we need.

Bjorn Helgaas (1):
  PCI/ASPM: Remove pcie_aspm_enabled() unnecessary locking

 drivers/pci/pcie/aspm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

