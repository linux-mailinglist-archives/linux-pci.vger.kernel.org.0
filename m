Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD05FE1D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiJMSpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiJMSn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3B09583
        for <linux-pci@vger.kernel.org>; Thu, 13 Oct 2022 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665686458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VBqJ4dzJjbnYynK7jkYTYjysfbRi2UUuxGT40j6Ev4=;
        b=CnccWy+fW16LtiD7AgKRvw0cqNN69yI64kv72Ml/ejNYEjbH60tuQCFQ5uJWklJKhKKs0f
        Pnk83WpsFMBd0eUlELTe/nVxc7L2NffHPgy4hMaHKvWvZea5IS64KSIogMqoocvFIOgQUP
        s0de0kIl6aj+j78l8jLqTtdNWWeCi8U=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-aAhGSLHOOKWZc3K3ImEwrQ-1; Thu, 13 Oct 2022 14:40:56 -0400
X-MC-Unique: aAhGSLHOOKWZc3K3ImEwrQ-1
Received: by mail-oi1-f197.google.com with SMTP id e7-20020aca1307000000b003550b8aaac2so810208oii.5
        for <linux-pci@vger.kernel.org>; Thu, 13 Oct 2022 11:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VBqJ4dzJjbnYynK7jkYTYjysfbRi2UUuxGT40j6Ev4=;
        b=xPFGDn3ifGVGDgIFy7zQ+N//8vdjk5d1wZgoeqOGZUbGNM9pC/we/UH65HES8VXHcd
         kf+/Wf44abnvjN3LLaNAP0IG2ni2xyojB6HpNtZb9cGroFQwy1hn20NoNTuRISKY1gXA
         9JylNI3Rf1dt0fKNfuvw7HjOi4GTXmY/IlyskS9snSfoZdQXMJiAp+sQnNtQ6VKzvdd5
         JnhVt4YqoiIIQm91jR5Y0tsQSXohbS1k4YUgyNGngofTZSL8F3cWy4Pmp94K5qOcqEYl
         We6vateUAzy4DN88fzLbfgVIYIzS1+FlSNV2Bom+9wvVmVNSe/nv1WnoRmHlqDjAKD+q
         OVdA==
X-Gm-Message-State: ACrzQf1wFi4uLZH2A+YvBsGtGyWUxoY6IeQLO/LbLyZHZqTkpE7bQGxr
        GK/Mgfyz/oplh2N6Vu4xEyd3t4Ot3MtqPZa12kBx2+pDjG7nXQAssm+OR25UtQJFasluO8TJsg1
        GZdYxJOgYS7akl+tRlkAh
X-Received: by 2002:a05:6830:3152:b0:661:ceb9:9272 with SMTP id c18-20020a056830315200b00661ceb99272mr667822ots.149.1665686455879;
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nJIAmq9Hq+46Kh8sn9us3gulZMoSvouw/Iy6ORtvgE9Z/MyjjjsC/KzgV7OOt2CYFqnSHDA==
X-Received: by 2002:a05:6830:3152:b0:661:ceb9:9272 with SMTP id c18-20020a056830315200b00661ceb99272mr667806ots.149.1665686455653;
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683024ad00b006618ad77a63sm244521ots.74.2022.10.13.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/4] sched/isolation: Fix style issues reported by checkpatch
Date:   Thu, 13 Oct 2022 15:40:26 -0300
Message-Id: <20221013184028.129486-2-leobras@redhat.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013184028.129486-1-leobras@redhat.com>
References: <20221013184028.129486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

scripts/checkpatch.pl warns about:
- extern prototypes should be avoided in .h files
- Missing or malformed SPDX-License-Identifier tag in line 1

Fix those issues to avoid extra noise.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/sched/isolation.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed9..762701f295d1c 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_SCHED_ISOLATION_H
 #define _LINUX_SCHED_ISOLATION_H
 
@@ -20,12 +21,12 @@ enum hk_type {
 
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
-extern int housekeeping_any_cpu(enum hk_type type);
-extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
-extern bool housekeeping_enabled(enum hk_type type);
-extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
-extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
-extern void __init housekeeping_init(void);
+int housekeeping_any_cpu(enum hk_type type);
+const struct cpumask *housekeeping_cpumask(enum hk_type type);
+bool housekeeping_enabled(enum hk_type type);
+void housekeeping_affine(struct task_struct *t, enum hk_type type);
+bool housekeeping_test_cpu(int cpu, enum hk_type type);
+void __init housekeeping_init(void);
 
 #else
 
-- 
2.38.0

