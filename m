Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA482DE87A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLRRmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:52 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38578 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbgLRRmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8D6B4413D7;
        Fri, 18 Dec 2020 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313293; x=1610127694; bh=aP4ZVo64yVK8Q+GVWLOMVK/0Def8PayQyTT
        YTWOSXpA=; b=bCyhKa2FzY1E39EFp5JVHY0araB1Ws0FvxvGv2dIM7odXgJJpls
        LNGLWR4o0UPzhTUuxojwg/n/eVWrSlRBpXY+JbVSzquG9fHlKa3H0opyusgtisMt
        qmETrMxh2T8ZASwpxdje/BV9cHRQKGt1vQfzTA/68gFrluxZN6U9hoLk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YkP0ST7r1jVl; Fri, 18 Dec 2020 20:41:33 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 70D3A413E2;
        Fri, 18 Dec 2020 20:41:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:11 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 26/26] resource: increase max nesting level for /proc/iomem
Date:   Fri, 18 Dec 2020 20:40:11 +0300
Message-ID: <20201218174011.340514-27-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current value of maximum indentation for /proc/iomem and /proc/ioports is
not enough for comfortable PCI resources debugging when several bridges are
nested, so increase it from 5 to 15:

 % lspci -tv
 +-[0000:80]-+-00.0-[81]--
 |           +-01.0-[82]--
 |           +-03.0-[83-99]----00.0-[84-99]----04.0-[85-99]----00.0-[86-99]--+-00.0-[87]--
 |           |                                                               +-04.0-[88]--
 |           |                                                               +-08.0-[89]--
 |           |                                                               +-09.0-[8a]--
 |           |                                                               +-0c.0-[8b-95]----00.0-[8c-95]--+-00.0-[8d]--
 |           |                                                               |                               +-04.0-[8e]--
 |           |                                                               |                               +-08.0-[8f]--
 |           |                                                               |                               +-09.0-[90]--
 |           |                                                               |                               +-0c.0-[91]--
 |           |                                                               |                               +-10.0-[92]--+-00.0
 |           |                                                               |                               |            \-00.1

 % sudo cat /proc/iomem
 ...
 f9000000000-f907fffffff : PCI Bus 0000:80
   f9000100000-f90010fffff : PCI Bus 0000:83
     f9000100000-f90010fffff : PCI Bus 0000:84
       f9000100000-f90010fffff : PCI Bus 0000:85
         f9000100000-f90010fffff : PCI Bus 0000:86
           f9000100000-f90009fffff : PCI Bus 0000:8b
             f9000100000-f90009fffff : PCI Bus 0000:8c
               f9000100000-f90003fffff : PCI Bus 0000:92
                 f9000100000-f90001fffff : 0000:92:00.0
                   f9000100000-f90001fffff : qla2xx
                 f9000200000-f9002ffffff : 0000:92:00.1
                   f9000200000-f90002fffff : qla2xxx
                 f9000300000-f9000301fff : 0000:92:00.0
                   f9000300000-f9000301fff : qla2xxx
                 f9000302000-f9000303fff : 0000:92:00.1
                   f9000302000-f9000303fff : qla2xxx
                 f9000304000-f9000304fff : 0000:92:00.0
                   f9000304000-f9000304fff : qla2xxx
                 f9000305000-f9000305fff : 0000:92:00.1
                   f9000305000-f9000305fff : qla2xxx

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 833394f9c608..4b3b378fed19 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -83,7 +83,7 @@ static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 
 #ifdef CONFIG_PROC_FS
 
-enum { MAX_IORES_LEVEL = 5 };
+enum { MAX_IORES_LEVEL = 15 };
 
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
-- 
2.24.1

