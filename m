Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD524F21E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 07:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHXFUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 01:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHXFUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 01:20:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E78C061573;
        Sun, 23 Aug 2020 22:20:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so3997093pgl.10;
        Sun, 23 Aug 2020 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9FIkUYppAnd6RkZ+nRY1Ky5mZ+w/qdsOn9YUv8jqCk=;
        b=vcT2u1USQjCJsI84bF5cjPilghWnbfilgNMMkMOXcDM3+2zDyX7Lns15utnFh2rqfP
         VHaAlDe8TsZVVa++LzJtyzBwXew92XmzyNlNcqbsUnWPhANqxhbh2HpdPKLi/upCu8+5
         ifADSYRQKXBCs03uXsBnmUjYdjh66TUE/EiEQgFHN7Knt9yygNqd3Jh9RxMzarGzDzrd
         iumBOYL4vGbiTAcz687oPEHbBouDdyUtKvjzcsaE+c7z4bePcfF1S4oLf1m45Q9bPIRv
         4HRbS6jv6S50y3knrjSpKpsG+mqRPOn42sLY+ijVnMGByOfiAWQ2JdCnV7zL8Y06pmPw
         B9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9FIkUYppAnd6RkZ+nRY1Ky5mZ+w/qdsOn9YUv8jqCk=;
        b=uWAh+dMtKrMpuDgTcFTA1M0CaxQs7leQypG6tZcxMkEa5VYH3/bWjsG9NcHkDGL08+
         OzGp7FT6EhuxfGlr8BSLm8JgYDhq9JbXugblPe5Bib2JarLo306YzTsCjIgIY1sHMady
         hNfH3ga9GesoUsYSVXsMt2PG6Xz2MuFl9hNQ6mS4cXtUcVN1cdkoAeoXKboVjKCSTu9x
         9fnvs7mgtL6mzsvfUAhooZ8Y1HhJtpEqF48rR4PyOm0mscU9vH0t24hKJPWyYtnL+aQV
         iECc9yYISjilFURizExnCzA1knODMKSd7D+/pe5IYe8A5BhPqNs5X4hsoG/6tG7/TEsB
         P04w==
X-Gm-Message-State: AOAM533YbpLLJdzIxhhj8+2S909qfZjpbe5F6CPRP/EElA8chbPIPpsC
        EeUvyC718jt1v3Yqkq5WmMU=
X-Google-Smtp-Source: ABdhPJwrhBJIL1QKHKD5mrhI0EjX1niAo/OIICj66vRZDhcyJOkkIdWNaYT3wCsw7VuN9syQevZA4A==
X-Received: by 2002:aa7:9e4e:: with SMTP id z14mr3017901pfq.60.1598246441144;
        Sun, 23 Aug 2020 22:20:41 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.9])
        by smtp.gmail.com with ESMTPSA id r134sm9964167pfc.1.2020.08.23.22.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 22:20:40 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: [PATCH] driver/pci: reduce the single block time in pci_read_config
Date:   Mon, 24 Aug 2020 13:20:25 +0800
Message-Id: <20200824052025.48362-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

pci_read_config() could block several ms in kernel space, mainly
caused by the while loop to call pci_user_read_config_dword().
Singel pci_user_read_config_dword() loop could consume 130us+,
              |    pci_user_read_config_dword() {
              |      _raw_spin_lock_irq() {
! 136.698 us  |        native_queued_spin_lock_slowpath();
! 137.582 us  |      }
              |      pci_read() {
              |        raw_pci_read() {
              |          pci_conf1_read() {
  0.230 us    |            _raw_spin_lock_irqsave();
  0.035 us    |            _raw_spin_unlock_irqrestore();
  8.476 us    |          }
  8.790 us    |        }
  9.091 us    |      }
! 147.263 us  |    }
and dozens of the loop could consume ms+.

If we execute some lspci commands concurrently, ms+ scheduling
latency could be detected.

Add scheduling chance in the loop to improve the latency.

Reported-by: Bin Lai <robinlai@tencent.com>
Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 drivers/pci/pci-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df9..3b9f63d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -708,6 +708,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 		data[off - init_off + 3] = (val >> 24) & 0xff;
 		off += 4;
 		size -= 4;
+		cond_resched();
 	}
 
 	if (size >= 2) {
-- 
1.8.3.1

