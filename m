Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52497643C1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGJIob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 04:44:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36416 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfGJIob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 04:44:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so1249720ljj.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2019 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FqMO8RT89OR9fNtMgTSxuVjqmXGyM8SsKk2ZzzmwHBQ=;
        b=B5fmBwnA1EraBB2e8QkhC52KEtVPIM4uiMUWlwN0KgQA59OiKLHLiyO0JihyRnPt3m
         WoUIlpqGpZNLoqvhvcoMiAFaa10A7pbxB2ExWfYQeLfKBYgSjK/gt0bjUW+XyaVjC9KX
         wfJQ4ioZlrPQIS9JNbUEAlEfB0NCvsXJ1mKskDsHsEal1sGQLk/i5gM+tXVScspTjrXE
         q1y47/NQGV2td9sW+dY4hYHzg9bL/nNA6sjjD5N2cHvOLWQLe0aLHcnTQT7me57gJkfI
         Kgf16a+oqQ9r8OV6xuHiqTop7IUGRrhCG1iNDxnGF5c1LJcwXFQWXF9BJwykqnSaGKrg
         zeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FqMO8RT89OR9fNtMgTSxuVjqmXGyM8SsKk2ZzzmwHBQ=;
        b=ODWl1MS7+EdrQUpFa36YcDEysem2FHg57hMtO3SCG9KHaVWGnGNXyi0GdB4A3g396+
         vYFQzw2nPtK8jvZvMaFuzkkLq1bnq5usiluyyLWRWNeNGzZxyHm/cP3GbpZqOjv3lvNV
         EyUkC3yDOduYAkwURDfhR2lNOD4RFtzp8mPkPxISdCu9oyyFvahxlGRZ26qxydWo92JJ
         zrU7UD7j+sHjiVz/salGcs6VBe6gbftgdqIlQu9DyYH4nDD+HWJk9E5bdS+OJQUt7CjL
         1SVWyKagwkisT3TqwsZfZSnQEVY2rpKC2x04Jgr1kdE5ITv/uh8LeG6WZz9bTZFNeOzw
         lvFg==
X-Gm-Message-State: APjAAAWk41MZws/xubxwoGXKmAySOM1x+DyWncQYhMM8fuI87id20pf5
        uatZx44EqoCZYKTxARD8M3glAbT5XCk=
X-Google-Smtp-Source: APXvYqxR3GU78uAGJiY8+/bhheQw4OlgaGGLP44zp1/cyfmIggBOLN633fTFOVHG2zKz9upFNJa/mA==
X-Received: by 2002:a2e:8455:: with SMTP id u21mr13239478ljh.20.1562748269260;
        Wed, 10 Jul 2019 01:44:29 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id y15sm256050lfg.43.2019.07.10.01.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 01:44:28 -0700 (PDT)
Date:   Wed, 10 Jul 2019 11:44:27 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning
 error if size == 0
Message-ID: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
addr == 0. But error in xlate_pos checking condition prevents this.
Fix the condition to make ntb_mw_clear_trans working.

Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 1e2f627d3bac..19d46af19650 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
 		return -EINVAL;
 
-	if (xlate_pos < 12)
+	if (size != 0 && xlate_pos < 12)
 		return -EINVAL;
 
 	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
-- 
2.17.1
