Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61701DDA5D
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgEUWkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 18:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbgEUWkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 18:40:40 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C5B2070A;
        Thu, 21 May 2020 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590100840;
        bh=5qFvSbHr+qunb3sONhQNv2UmKxgAzGDVr+Vt6tJ8GIo=;
        h=From:To:Cc:Subject:Date:From;
        b=PJSyDSCJR5GKnDHcqllpOgcd2xN9NBkbYYJzWbrNN+SQv7Vwm9/CG/H1Nh7jAwzw/
         5QM96Ih8GzZIKKdBFA5jN1RU89JPwLljAXfVITdbqi877U/0OZQBWlid4BIUHc4meC
         IPCSvQ9PthL1DKSsX8HZXyrpfLYgjfzTaacNYbE8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] lspci: Decode PCIe Link Capabilities 2
Date:   Thu, 21 May 2020 17:40:28 -0500
Message-Id: <20200521224030.1193617-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Decode Link Capabilities 2, including the Supported Link Speeds Vector,
and expand the decoding of Link Status 2.

Bjorn Helgaas (2):
  lspci: Decode PCIe Link Capabilities 2, expand Link Status 2
  lspci: Use commas more consistently

 lib/header.h          |   10 +
 ls-caps.c             |  115 +++-
 ls-ecaps.c            |    2 +-
 tests/cap-exp-lnkcap2 | 1317 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1430 insertions(+), 14 deletions(-)
 create mode 100644 tests/cap-exp-lnkcap2


base-commit: 203854ccd133f40b8c121feee681cb9182b90566
-- 
2.25.1

