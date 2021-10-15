Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45C42E6B4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 04:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJOCmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 22:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJOCmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 22:42:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45916C061570;
        Thu, 14 Oct 2021 19:40:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so6555580pjq.0;
        Thu, 14 Oct 2021 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkosC3uUeUT0tBHhW+c5eCcNJ2sxj8ufUzVtCYYKofs=;
        b=WoP6JhZLc9fJWGWMjulUGA0u4Xnao+GuoqENMS/IJdKMzty3OsCnpE9jwUCK9p6X9F
         4zI/aPZy59kM6OBka+ljFbCSsdLyb4WCxZ61fkhL0keyi+VNsaq1LB9KE3SoYhbljWPv
         D6TmboUWBuwGeHDunoaM8J9aGEs99+sqCsK8/pZPw4QFnO6kLwMOgvunRzeDaHREhQAG
         LfqNookD9o67GfELq0bhFeDiT2F7K3X6TehjeZc7rI7tIyGC9RePIckSSB+pV40aWgQS
         Rtwz31cHmP27vD1KfAYHyT4SEBjvNla7fekkBLE4zq6xuuJBUvxth+tR3U14h/lt5EEb
         RoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkosC3uUeUT0tBHhW+c5eCcNJ2sxj8ufUzVtCYYKofs=;
        b=bXruzTnDursIaGxyxPrpBXLE02auA9CpF0ZgycKsnrhC3wEGBbSKFMZMQ+0SMBw2kq
         JvCuVDEw/kPEZNwWc6raVLkUF7uKqCAZSy4ulEkChkTxAzRUGhzbXZvhl4EeRq7h5S6d
         mmbOb6pPWCTr+jIuFkvhE+lM+17syYPC0yF99PQkuZ0DnhK8fywH3m/SrdhhSXtEOhMp
         iAMjF2BbPiQutIqDe4whkkKdPP2Eejj29kgvBzr5qe10/+hC3I2Hon5BxbVu8EUDxdSx
         9lmuCASDavhlU/J+1dZbLkK1I1OUd0XsMyXw8iixr3jq1Vp9QoFpYR1EAlvxcoxdE9DT
         qyNQ==
X-Gm-Message-State: AOAM531C9qBVAGivyYq7YOBaICLumN4PLbTtdeoBy1VvX1/F4ZAKfV83
        j5qQ9BEy4JQCYbR6KZI5vL4=
X-Google-Smtp-Source: ABdhPJz3Q0p25ke7XFLk2Ptjf43Qnyuqq9PCARbtgtL0A0dmXjdu3NbY199rqI5obZw72+OT26EHsQ==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr10400922pjb.222.1634265640672;
        Thu, 14 Oct 2021 19:40:40 -0700 (PDT)
Received: from desktop.cluster.local ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id g189sm3988286pfb.75.2021.10.14.19.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 19:40:40 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH v2] pci: call cond_resched() after pci bus config writing
Date:   Fri, 15 Oct 2021 10:40:25 +0800
Message-Id: <20211015024025.2916363-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

While the system is running in KVM, pci config writing for virtio devices
may cost long time (about 1-2ms), as it causes VM-exit. During
__pci_bus_assign_resources(), pci_setup_bridge(), which can write pci
config up to 10 times, can be called many times without any
cond_resched(). So __pci_bus_assign_resources() can cause 25+ms
scheduling latency with !CONFIG_PREEMPT.

To solve this problem, call cond_resched() after pci config writing.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- use cond_resched() instead of _cond_resched()
---
 drivers/pci/access.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..4c52a50f2c46 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -57,6 +57,7 @@ int noinline pci_bus_write_config_##size \
 	pci_lock_config(flags);						\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
 	pci_unlock_config(flags);					\
+	cond_resched();						\
 	return res;							\
 }
 
-- 
2.27.0

