Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8607843598A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 05:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJUDy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 23:54:27 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50618
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhJUDy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 23:54:27 -0400
Received: from HP-EliteBook-840-G7.. (36-229-235-18.dynamic-ip.hinet.net [36.229.235.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8777040058;
        Thu, 21 Oct 2021 03:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634788328;
        bh=InDIv3Q6A8MQrkQTwPbinadEyAszSDQkpvBUhb3w5nU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cgjRlXeY0FooDUtLrevwr9NcIcpOeJyBnc/oRtzeH88jVS6m76VWZPuYfTza9gZKC
         t9gYXbrhSEtCVgHyHIodqQaTAUmVNJJzBrFeK0vi0Law8LEy2Z6FCjLTlyGIkyBm7A
         reYc4LBoEcYjVyJhLFRgBMe8PJvicPb/8RVyILapYqI45pOa+5XDuORhXdmRrDGBiJ
         AfOc3oeBFUzkDP+xwSt7APsDkyQadrG/L1Gm6IJFk3jlynKFuqQjgjRGMI7rwGJ8Db
         MH/kNoOgftQdPRmzURp3jQeNPJwcbhBXD46TIMEceViKuQN9YJ3nyYgm6e1A3TKUUI
         n2g9n5mbHCG2g==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, anthony.wong@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 0/3] Let user enable ASPM and LTR via sysfs
Date:   Thu, 21 Oct 2021 11:51:56 +0800
Message-Id: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



v1:
https://lore.kernel.org/linux-pci/20201208082534.2460215-1-kai.heng.feng@canonical.com/

Older approach:
https://lore.kernel.org/linux-pci/20200930082455.25613-1-kai.heng.feng@canonical.com/

Kai-Heng Feng (3):
  PCI/ASPM: Store disabled ASPM states
  PCI/ASPM: Use capability to override ASPM via sysfs
  PCI/ASPM: Add LTR sysfs attributes

 drivers/pci/pcie/aspm.c | 74 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

-- 
2.32.0

