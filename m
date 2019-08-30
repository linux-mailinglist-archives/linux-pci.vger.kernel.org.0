Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE97DA40E6
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfH3XSi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 19:18:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfH3XSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 19:18:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so3086088pfw.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2019 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7Fsc+37SdglEjx6/P+VaXoRvmLqI7xYMe39+8FKKog=;
        b=SRkoLbFdjxOOLUsGorlvwCDB8Y7h+4UZCxPAUooe5JUYDpPZoOm+hC88wSCIUVQUJi
         FedLK4Mry/31IytlGZFBo09jNfGHCQpy+KeCRFEAjd/CHA9NXZ0xgmevw0j+ww4PVOri
         NVgKz5E4oVN1UEDexyn1rDN7wNhQVIao8Kavw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7Fsc+37SdglEjx6/P+VaXoRvmLqI7xYMe39+8FKKog=;
        b=TSP/1MNCUfNzugn1DE/6Lg2UUaOqNgptYcJYNwFD4K94zaDtf2nlYJFQFWxGwKa2Ke
         5yvisxwV8HOILpRSSB9W9QE/HAZcnXPh5+jAbaEcG/v9dMuiX7/JaiKCT0i+yf3IB2y4
         8ARCGcZO4fAhBbHx4yqFzGU6mRMsLe5p/wHMeVOolNIQant4h1zLif63b+JuKYqLE3zB
         /e7WaYbyLMEXhSEQsRrhQ9G+roIoIo0CDqM4CfCvdqjB13zd7j8bJRZG4BnoVdOZEkne
         oUTMl2qek86bUpQmrhXN8ifjD3SX56UEvq8ggdLCxQEYI4wp2hhUcAyZinRmK8S5+BpD
         Ey1w==
X-Gm-Message-State: APjAAAV7C26ET9N5zS0HbRMeKYjxIpQ2+c+BxkhFKXfwtUc2EONR3NZC
        c9FFngKy4kiIv5MbUGV6uRqAUg==
X-Google-Smtp-Source: APXvYqzsgIbQD1SS2U2BV8UWGEyzmoL50WWwQMMc6aPYggCkWNncKrpdEs1Qv0qQtklc19SPrZyVdA==
X-Received: by 2002:a17:90a:3748:: with SMTP id u66mr1008427pjb.4.1567207116764;
        Fri, 30 Aug 2019 16:18:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t23sm8479395pfl.154.2019.08.30.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:18:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/2] ipc/sem: Convert to use built-in RCU list checking
Date:   Fri, 30 Aug 2019 19:18:17 -0400
Message-Id: <20190830231817.76862-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830231817.76862-1-joel@joelfernandes.org>
References: <20190830231817.76862-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CONFIG_PROVE_RCU_LIST requires list_for_each_entry_rcu() to pass a
lockdep expression if using srcu or locking for protection. It can only
check regular RCU protection, all other protection needs to be passed as
lockdep expression.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ipc/sem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 7da4504bcc7c..ec97a7072413 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1852,7 +1852,8 @@ static struct sem_undo *__lookup_undo(struct sem_undo_list *ulp, int semid)
 {
 	struct sem_undo *un;
 
-	list_for_each_entry_rcu(un, &ulp->list_proc, list_proc) {
+	list_for_each_entry_rcu(un, &ulp->list_proc, list_proc,
+				spin_is_locked(&ulp->lock)) {
 		if (un->semid == semid)
 			return un;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

