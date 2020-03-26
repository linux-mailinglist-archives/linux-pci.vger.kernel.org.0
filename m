Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1019393E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCZHII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 03:08:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40741 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgCZHII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 03:08:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so5765241wmf.5
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2020 00:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPRrwsRUkZnW1BFu5Zfyz0cjxU3qvYq6Y7T8MRQYSdQ=;
        b=efWdxf0xIIzGwlTo3B7F4lTNocP3UhjzgR/Sd9/0GFBKhpHka8s/Y9kODVon2GS7vJ
         pq9EHgDW6S9M0akfRcUHx/NMcDKKRj6juykMcA7D3uVqJmxsJ+efqUgMmf6D0sjPFBmO
         kqALyIdMWtBPhTz/J0uQ2VxJsTEyd22LRi0eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPRrwsRUkZnW1BFu5Zfyz0cjxU3qvYq6Y7T8MRQYSdQ=;
        b=LLX5T2Nx9Ww0W1MyGe/mqbyRUdmP8NpniauAomfPM13yZJvz7yeHA7pk/W6pDErk2o
         Tqy8Di8NQYV9Eu6tQW0IPGBtfGGelIpAtsQuZ85YayXXKIlmUyHlJgND24UrIptRCRB7
         MIskBqQOa8tS7tSvIW2ynIvFdawZwum8fe/CaRQyaWiYfIiwmDtt8bbEXR2EfTFKMDb6
         Pr1j3UfQrhojy6gG05Q2timwd7joVuR1jQTyNs1DgdAQDaJGNY4yQI5ZydfGEUP27DFd
         AJEdmEaSPVuhCEJhMnc6qQZhODBpCFAkkMYf1OqvN5LOYeymtOZEviFTjsDjpv2Fd3Lk
         sABA==
X-Gm-Message-State: ANhLgQ0pVNrB1LqE5Ylb/+uqWbmte/PXkLmn5oeAxhjfAqJ3gBv08vL4
        YKQKEKqt3fSAyGQL+XF0YMLF3Q==
X-Google-Smtp-Source: ADFU+vuUW1y4Zx4fXihxBF7h/Mv+t1RFz2WFLCdyXsWOwZrkM3bG2jv3jmghxHL5EtVY9/HxmunywA==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr1529567wmc.67.1585206487385;
        Thu, 26 Mar 2020 00:08:07 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:08:06 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roman Bacik <roman.bacik@broadcom.com>
Subject: [PATCH 2/3] PCI: iproc: fix invalidating PAXB address mapping
Date:   Thu, 26 Mar 2020 12:37:26 +0530
Message-Id: <1585206447-1363-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Roman Bacik <roman.bacik@broadcom.com>

Second stage bootloader prior to Linux boot may use all inbound windows
including IARR1/IMAP1. We need to ensure all previous configuration of
inbound windows are invalidated during the initialization stage of the
Linux iProc PCIe driver. Add fix to invalidate IARR1/IMAP1 because it was
missed in previous patch.

Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 6972ca4..e7f0d58 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -351,6 +351,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_OMAP3]		= 0xdf8,
 	[IPROC_PCIE_IARR0]		= 0xd00,
 	[IPROC_PCIE_IMAP0]		= 0xc00,
+	[IPROC_PCIE_IARR1]		= 0xd08,
+	[IPROC_PCIE_IMAP1]		= 0xd70,
 	[IPROC_PCIE_IARR2]		= 0xd10,
 	[IPROC_PCIE_IMAP2]		= 0xcc0,
 	[IPROC_PCIE_IARR3]		= 0xe00,
-- 
2.7.4

