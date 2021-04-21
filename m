Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF423672CF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhDUSsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbhDUSsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 14:48:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76390C06174A;
        Wed, 21 Apr 2021 11:47:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z16so30755867pga.1;
        Wed, 21 Apr 2021 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWlEjhkosbdFJdYkdgHRxg+yCz/Y2VdtjDbfu98fJME=;
        b=RTudUTdt4NdhTTPWpDKzroN4k3kseztpxFb12/BidKZoGQLOHFhwaS1nFkiptN3jHM
         suhL5SGE8/1h2fENqyWk0Wfj5jsRzxlnnLF7WeEDL7nou4Vu36ewAcOpOqERGZsjOkqn
         WmfYTL2ORIfPyNy8J1m7jXEs49lG+uu9l2HYAcxgHHnr2Gx3qM93nnwjU9+tI8/DdMKB
         6s8zY+cewFB9T5/H1mXn7htez4ZqS1EsNKzN+Z8PquS1a7VbOGt448oQgac9c+rhGO3q
         OyQXWHWih7YNQP/a0XGSeyqctR8R4yzdBdJOpIDNBV4CkbAPOR+b0u+JxJHfYc6iDfdw
         AnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWlEjhkosbdFJdYkdgHRxg+yCz/Y2VdtjDbfu98fJME=;
        b=dsU+I5htOc2coc3t86Bg1eAr6hxH58dm98pOBCNqufa/HUM7QV1fCgZRASU2BzyR/W
         SQILLeZTFWM0rwfX0gnBtZS5uiUDi4gwyxDtiGnjtG8WAnlBLiLpMgIXHNRqjEFYpHmn
         wee46G5TlvjthSEASe+jvOQFTZD+C51IaxCPBTLkgqX90PHI+/jcrSJEON9PVJcEA9Wn
         TAyiJ6sfUcB0q/y4iMPy5NS9X78/YbEMSpgrDx2qcj2r+1Mkx6aA36Clkfs0txUMvWea
         AXT2quclwMRs/Irrbg8xvoQzymkZzG/rBmw6jsGqmk/PIU4wwnnwCt2t4N5Vc9JLSAY7
         SwfA==
X-Gm-Message-State: AOAM5336S7HaCQgiX28uMOAuWtfZW+eTZDHwSxK3apga7SOLqC+KyB3N
        wkgp7UqnXK6JWZm8YNY+/ew=
X-Google-Smtp-Source: ABdhPJw5vA7JuDNxmfeHwrsHzCzvymLS1RLRp08ylnm9bGF6jx2hE7UC2TSO2qCYFuT3QToT/ioqng==
X-Received: by 2002:a65:590a:: with SMTP id f10mr23139755pgu.358.1619030874900;
        Wed, 21 Apr 2021 11:47:54 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id x22sm142542pgx.19.2021.04.21.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:47:54 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH] PCI: Check value of resource alignment before using __ffs
Date:   Thu, 22 Apr 2021 00:17:47 +0530
Message-Id: <20210421184747.62391-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return value of __ffs is undefined if no set bit exists in
its argument. This indicates that the associated BAR has
invalid alignment.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/setup-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2ce636937c6e..44e8449418ae 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1044,6 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 * resources.
 			 */
 			align = pci_resource_alignment(dev, r);
+			if (!align) {
+				pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
+					 i, r);
+				continue;
+			}
 			order = __ffs(align) - 20;
 			if (order < 0)
 				order = 0;
--
2.31.1
