Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989328FDD2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbgJPFwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbgJPFwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 01:52:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5EEC061755;
        Thu, 15 Oct 2020 22:52:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so838569pff.6;
        Thu, 15 Oct 2020 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI/NTRnsuiqMq/19qfG8dHccdcc45HtUzVtiWVJOA54=;
        b=pD5FJ7dGZbZIGvMFGfGVp6uhM0aQbeJzP5nuTKxe6hekA+xD+Bz7avwlOlqMZVaxda
         4gA9MxiFUWw7PitLTs/C0cLZVbksoy67J1NbwAozTllcMgXBvWl+3zXD3/lcn8p8A58a
         vTlV4BojkNq0clIkEDio75syqxacmUyDRc7NWbCzDglDqM+sE8uj2RH/Yc9/N6LOx6Mf
         NufIzGnE9X2rCdVx85BwGqFt1Aum7/TQAqwuOqcAQQoaQQikuFUdKa6NHLc1ol93+pdA
         w/tEcuxYyRn8DLxilt9izQMErmMZmaquSOJMZv9YNKaVLXk9JbfpDmYduD7/YdMIQBac
         i/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI/NTRnsuiqMq/19qfG8dHccdcc45HtUzVtiWVJOA54=;
        b=JRh/uIrpBVzfkXXBS9TEOOWsmWihIUkrH4Jk99C+PD07qwkZQFX4SlFzFFUA+/Itua
         9/ij5cyTBdODaMw2unNBWfroRpS8oH8QNhfWWbA7xrIfxdjs8jJBCwY7taOwQUx/iuJC
         /Dh1ZBH8OvsqIrbHWFWFOkYfl1Pf6NfEI+ZIlKxVPuo2wlog/cvy0tDIPwEO2H/FkGoP
         53c7F04xKdNpz9Mzb0UsGn0F5S64AYxUPzhtEDDi/Fwi1Q95dyBlcXoaM8cyltBRXD80
         kLih0aQBmAI7tlyfm3bhkxImMoqYaFNlr4W9iMw5Zt5pUCTFf9GGlp0BjIiHHU+n9Mkq
         lwZg==
X-Gm-Message-State: AOAM532puCibg2cm+s6CcLxBGvJP51cUy+mcie0C4W/YjYLLSpytPTaB
        ITwgcASzA/d2vzkrmx+nhI80o375+kg=
X-Google-Smtp-Source: ABdhPJyDewsrfBilzjkXeoqPjtx3xNkDPU5NaeYKQi2avPxnn8ssglwAlSDWYUCi0lSnJKhbiA1axg==
X-Received: by 2002:a63:cf46:: with SMTP id b6mr1794900pgj.49.1602827565724;
        Thu, 15 Oct 2020 22:52:45 -0700 (PDT)
Received: from localhost.localdomain ([49.207.214.53])
        by smtp.gmail.com with ESMTPSA id u14sm1308110pjf.53.2020.10.15.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 22:52:45 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, ast@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Subject: [RFC] PCI: allow sysfs file owner to read the config space with CAP_SYS_RAWIO
Date:   Fri, 16 Oct 2020 11:22:35 +0530
Message-Id: <20201016055235.440159-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

 Access to pci config space is explictly checked with CAP_SYS_ADMIN
in order to read configuration space past the frist 64B.

 Since the path is only for reading, could we use CAP_SYS_RAWIO?
This patch contains a simpler fix, I would love to hear from the
Maintainers on the approach.

 The other approach that I considered was to introduce and API
which would check for multiple capabilities, something similar to
perfmon_capable()/bpf_capable(). But I could not find more users
for the API and hence dropped it.

 The problem I am trying to solve is to avoid handing out
CAP_SYS_ADMIN for extended reads of the PCI config space.

Signed-off-by: Allen Pais <allen.pais@lkml.com>
---
 drivers/pci/pci-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df981d41..6574c0203475 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -666,7 +666,8 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	u8 *data = (u8 *) buf;
 
 	/* Several chips lock up trying to read undefined config space */
-	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
+	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN) ||
+	    file_ns_capable(filp, &init_user_ns, CAP_SYS_RAWIO))
 		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
-- 
2.25.1

