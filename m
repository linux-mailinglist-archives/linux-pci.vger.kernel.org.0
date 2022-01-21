Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F834960A0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348447AbiAUOX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiAUOX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:23:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF1C06173B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 06:23:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C062EB81FF5
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557F8C340E1;
        Fri, 21 Jan 2022 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775034;
        bh=8mkxBMvIahEsqRSKhj/gDOXFwcW/1WLiaijthGvd5U8=;
        h=From:To:Subject:Date:From;
        b=BdYLtCLMUvPuA8p0jsPW2xg/sTyqQg+A9K4qYhEBh6g1rmLyGxuYg4Vx2iLb7dTuE
         PlfdAE9EQkaY/g36Po2FrCdEpzkw76JtpV25SvUiViF66ECxvN6g2rexqBpxHdrkuB
         zQre0mywX4+8CmZd6VtuX/gyvEwjZkGTh/BVNqYp1CmkVERBoRlWWwBFF4AQ2ib28t
         o2+HGzFwOPB4K4kI9dEXUGaEK4Iy8re9rp4+uUkllt6Xyxge3B+my9su2gOVRFgadH
         7vGNfCTBfvKmEibp/ly7jKmL2X+7fy/MPpPypV6iyi4OUqRI/2HfN0RvIYSOjWtiqm
         2wMRsoxpR7/gw==
Received: by pali.im (Postfix)
        id 03FDB857; Fri, 21 Jan 2022 15:23:51 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 0/4] Support for PCI_FILL_PARENT
Date:   Fri, 21 Jan 2022 15:22:54 +0100
Message-Id: <20220121142258.28170-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Extend libpci API with a new option PCI_FILL_PARENT to fill parent
device for the current enumerated device. This can be useful in
situation when non-complaint PCI-to-PCI bridge-like device with Type 0
header is present in the system and behind this bridge are either
endpoint devices or another non-compliant bridges. This applies e.g.
for notoriously broken Galileo and Marvell PCI and PCIe devices.
lspci can will use PCI_FILL_PARENT information from the system if
config space does not provide enough information to build topology.

Pali Rohár (4):
  libpci: Add new option PCI_FILL_PARENT
  libpci: sysfs: Implement support for PCI_FILL_PARENT
  lspci: Build tree based on PCI_FILL_PARENT information
  lspci: Do not show -[00]- bus in tree output

 lib/pci.h   |  2 ++
 lib/sysfs.c | 31 ++++++++++++++++++++++++
 ls-tree.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++++----
 lspci.c     |  2 +-
 4 files changed, 98 insertions(+), 6 deletions(-)

-- 
2.20.1

