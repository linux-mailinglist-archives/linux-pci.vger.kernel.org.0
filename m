Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6A417CDA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbhIXVN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbhIXVNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:13:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB992C061760;
        Fri, 24 Sep 2021 14:11:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d21so31081110wra.12;
        Fri, 24 Sep 2021 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEHoU21DH841tx0qtRTz5FbDxLZko2mQ4Z33po9e6hg=;
        b=ajfY7Ymmr+7cnGhJOtrjT2wVcAV/rxDc7B6NaEreAvLHCKzEacArwdGGhIes3F+dnH
         754KCqC0DrJT4Guxwjfq02g08n5JTWpJhxggEebDGVe4iAJEWjBOKlTrwOnDoES05n1s
         gi1tikCyks6F3pFbBEIqjzccnHxiruwRzYma9kwvIup0ywxIdtp2quLZwk+LOC4umEOm
         SymSBx4WkYfbtbEfxyFHPvXb6wbWLlExxXEmIoZcwc8rZqUGz468JTdlL9hBX0JTlrQc
         4ppqYtW2JKAPOpazd9Zhkcdy946u4ZpSArcYgW/WA42qqI1K3O/QFTayYuSRleMmNGOK
         reUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEHoU21DH841tx0qtRTz5FbDxLZko2mQ4Z33po9e6hg=;
        b=wyQ2pw6A2ymruPQNM82snjBLoItxMBoAT2tuPIuo1WA6Hks6k8QzQqHUsVt+pp1os7
         fKV7eLousH9wHqTzJi618VpcL6YVSLzgBpESNQm1Be6As9L3BcTptrrzVcSlv3P4Buyd
         T7J08Y+COswCRrzgJ7mp9fkt5SYp9oWGjrb6OVs61gl125ErfvGZlzAvLaskMpF9kGnx
         vrJlD6fNJ6Z8Wc5HKce8YcMiTz444xqeDq4TP8p5MwyVuiIsqteE5XHpCqt3hg02SQDa
         bBgpGa1XmE3BGDbFblXecmNTrkMyXAgewTLCxdVkpcw26xFJsHl1aCywAf/+lU6KUT4X
         PWgg==
X-Gm-Message-State: AOAM530yMPocuLyX9/kyKA/dYsMuFbC/TcPQtWAAeeCsDMpQm5CUGmB/
        b1PeLlf0BHKVU9tsa/luajI=
X-Google-Smtp-Source: ABdhPJxlUEJPYCJsNzawytHIOiH/45imW9bnZmTk3fyUFhDaECmpAeFTIfch/BNrkh6Bn7sAykByHg==
X-Received: by 2002:adf:a549:: with SMTP id j9mr2799424wrb.353.1632517908646;
        Fri, 24 Sep 2021 14:11:48 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y64sm10344297wmc.38.2021.09.24.14.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:11:48 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: mt7621-pci: properly adjust base address for the IO window
Date:   Fri, 24 Sep 2021 23:11:39 +0200
Message-Id: <20210924211139.3477-7-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value to adjust in the bridge register RALINK_PCI_IOBASE must take into
account the raw value from DT, not only the translated linux port number.
As long as io_offset is zero, the two are the same, but if you were to use
multiple host bridge in the system, or pick a different bus address in DT,
you can have a nonzero io_offset. At this means to take into account the
bus address which is used to calculate this offset, substracting it from
the IO resource start address.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 6acfc94a16e7..503cb1fca2e0 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -482,7 +482,7 @@ static int mt7621_pcie_enable_ports(struct pci_host_bridge *host)
 
 	/* Setup MEMWIN and IOWIN */
 	pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
-	pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);
+	pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);
 
 	list_for_each_entry(port, &pcie->ports, list) {
 		if (port->enabled) {
-- 
2.25.1

