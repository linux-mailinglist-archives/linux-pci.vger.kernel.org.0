Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388FE12696
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfECEAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43532 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfECEAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id j9so2711126oie.10
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuWHqWyJ+JP06RXp87S+GiXSAUWX7Ks5BQw57gh+tGk=;
        b=GZEujWwhMRJwFtd80IdNNMcGZhrNHvNaZZX7gTaAYqA3YN/E9W5VGiG7UdlCXH2b3s
         eIqNC/5wk26Sy41WqEUjReocbGnnF4GkX7sUhB2N953PxtkkrOg1J1YrDWOXtrmk3nYV
         YrlPd3nDA5SarFrVu5rYW0UsB4pMQ1DB0kvTaBX5ntuG/6X5+d1eC6/QplkFX67qzWxj
         1zguJx34e765vbj7p1PK8rzTaLpxAEM3jjaa8Cpt0SzaXWl6gavE6/PDwbCVIsuB8I4g
         TVL0/v6WLpZE3W/FbdjzOjGICqVlNBHOgViO5drxoTtFf0d+n04lE79mpiErWvi88LFZ
         98Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuWHqWyJ+JP06RXp87S+GiXSAUWX7Ks5BQw57gh+tGk=;
        b=ILFYI/+5TVc5RXsiVqENcnpC6vK6tJnXUwRJyMr3pHILghNJHQm/c5Gpxxfqv8GLn1
         Qx3hpz04O3xnzJBwSuSO/gXu2q/6ayRuWjbsySddoL4Qn5SeYle2d2aGvj8TEZmK7Jyx
         WeHk8mztoOYgRrtY65SXwIb8xK+qMfkB1SnkfC+j1k2SJ2xZd6j8ibEAFf79NwGnhy3C
         m25mHlB+ycVAKFISuzPF6Wraht8jmXf5JUze4UFkCrLajXGPXr5ucWVFrwfh8sIWGddr
         HmUx5lWWcQ5+heaGzR8MxZGOVcjNWJBzj14ZEQe4oqfXaLeavf9EBYaGDJFA8s1ra+Im
         R6bg==
X-Gm-Message-State: APjAAAUc1WHkClgtRe7vAET/uJxaXdFe1UN/phNXHOKmj9wgtX5Ih6pC
        mnzFKPGktelGaFwjA0bamPYvOA==
X-Google-Smtp-Source: APXvYqwqTuUqK/SIef1FttxAcfu0BMnkig8NswvTmUvCK3eoCUT0mnuD/C5o1hlRS51mBDBpdWVnNg==
X-Received: by 2002:aca:5203:: with SMTP id g3mr4886547oib.142.1556856019443;
        Thu, 02 May 2019 21:00:19 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id e9sm758897otf.48.2019.05.02.21.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:18 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 3/9] PCI/PME: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:40 -0500
Message-Id: <20190503035946.23608-4-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prefix dmesg logs with PCIe service name.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/pme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..d6698423a6d6 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  */
 
+#define dev_fmt(fmt) "PME: " fmt
+
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-- 
2.17.1

