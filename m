Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7342B0FE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 02:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhJMAdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 20:33:51 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43564 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhJMAdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 20:33:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id r7so2394755wrc.10
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 17:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwDQdl4mJJugF0SeCDT0lzru/oRcVPVlEEZvO8eSgPw=;
        b=Lblk0Z7S64UHXTP8bxDBs3MaARd41qpiWehRVZD+aXXu03DbaAakEOuH5t8V2BDyzI
         2WZ9tDHiMrjcgYm5cqIISgPPwW+UuBhEGVnTBuR9wbrXnujzmFD4Xl44/QM6f50fvxG7
         je3SVwstXCiPNRFOLcTx/ufi4XTcC9IOCqhNpHfYqDpznhPKXJQaTtICAIww/oLkaqdk
         6K/fwh2vCLhqG7xEeXEPvNfm9jVHR43721Gm8VW5UdEMCAXbeLSRFmFFHI22vPsEtefU
         rCwJSEp6nCb626HOIGjUkiyulqCtG311hFbJ5WYH5JpcSiWjM+ev71zsQF3DGLaoGLz+
         gVPA==
X-Gm-Message-State: AOAM5308kb6Ua71nlEurHXEPsJ0ejxK0wjH8H5li5wn4vm/12ntY+Wlb
        QjeEMb10+m7rYLuzvZsy/+g=
X-Google-Smtp-Source: ABdhPJyzdJ8GkMZPKu5K8p1ubuLkWmxrZ1905H96sfK+TsW00n76tEzGlQ4QElYaudeshZ0v8RKdiQ==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr9181115wmj.39.1634085108018;
        Tue, 12 Oct 2021 17:31:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a2sm12147516wru.82.2021.10.12.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:31:47 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: hotplug: Use preferred header file linux/io.h
Date:   Wed, 13 Oct 2021 00:31:45 +0000
Message-Id: <20211013003145.1107148-2-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013003145.1107148-1-kw@linux.com>
References: <20211013003145.1107148-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the preferred generic header file linux/io.h that already includes
the corresponding asm/io.h file.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/cpqphp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
index 77e4e0142fbc..2f7b49ea96e2 100644
--- a/drivers/pci/hotplug/cpqphp.h
+++ b/drivers/pci/hotplug/cpqphp.h
@@ -15,7 +15,7 @@
 #define _CPQPHP_H
 
 #include <linux/interrupt.h>
-#include <asm/io.h>		/* for read? and write? functions */
+#include <linux/io.h>		/* for read? and write? functions */
 #include <linux/delay.h>	/* for delays */
 #include <linux/mutex.h>
 #include <linux/sched/signal.h>	/* for signal_pending() */
-- 
2.33.0

