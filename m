Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD091CD7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfHSGG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 02:06:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 02:06:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so7335737wrn.10;
        Sun, 18 Aug 2019 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoLMhosJKaAGre1eE3iRbK4QzCCIJ9YhOYsd1F7Y0pI=;
        b=PLxoIaTttOAeCtvWfwbYCL94JNOR7VHN5A47KJ7T5Vn+cret/fAQ/+u7T4sJCh7hQD
         5CEnbevR24ETpVU6RKiXBLbmbQCJppSJu3V/Uykd3cwa9nr4dcza+oJHgFuyWpA7yeDL
         8poDnWoPK1C69N/c+DYxrNfPfIor5YCRDLUktjEmH+UfLnaK8Di3RYphgQYASoefFRI1
         vw6r0wpYH/KWyEJtB/68ual93EsPWk0lHWzJNU3VFonaAmeBbH+aRg90/nluuUfwFiWo
         EmCDxdf0ImPeVM1vezx4pBd7IdL0jutI21e7v9G9mz0vn7njy/k45u2bqgYftZlrU1Rh
         SXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HoLMhosJKaAGre1eE3iRbK4QzCCIJ9YhOYsd1F7Y0pI=;
        b=hZhrLgYGWBVuzNUrhmr3iqQhUWb2yxQORyvBRabMjGF1yNBa049i0wWvpYvNQoUvFS
         y+7KyLRfcjbR52R5m2XZTtPEy+WOztFj1mq6K4/4CCbavgiHleL9vUyjgN72ZQKPi1af
         p7557Vw6hCY7WXnPSdHAoqLpPuFHqSgHJOFe5z+5m9Gcsm21i4Zz2C2sHlurRxOv3SoL
         sdW/6RzAggTJz4t5gEA7jkjpPbk9YELG/qo1EJck0muyOnp5ky/GV0OZcPcjki2T1JZd
         UW2qV+a7CmYwt1FRikRlJniTxUhziu/utwu1tfxmrKm2fhUqWZdbsRmcv+f+7bYZg5QC
         7Yjg==
X-Gm-Message-State: APjAAAVeoFb9m8noQNjTdBM3ZJMg198/FAHCtNBg+RLLoaWgrH/rzDdN
        t8C3iAO/X4YHSnydoRKyVDsYrS+VP4GywA==
X-Google-Smtp-Source: APXvYqz4pyPO5sHS746siRIrO5OlF17Swq3OCjJa3HMaZEf7s2zsxw+tRkRWrXgYzuwABebLlfFLNA==
X-Received: by 2002:adf:f705:: with SMTP id r5mr24521071wrp.342.1566194785846;
        Sun, 18 Aug 2019 23:06:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aef41.dynamic.kabel-deutschland.de. [95.90.239.65])
        by smtp.gmail.com with ESMTPSA id j9sm14008976wrx.66.2019.08.18.23.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 23:06:25 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Add missing SPDX license header.
Date:   Mon, 19 Aug 2019 08:06:24 +0200
Message-Id: <20190819060624.17305-1-kw@linux.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing "SPDX-License-Identifier" license header to the
arch/x86/pci/numachip.c.  Use GPL-2.0 identifier derived using
the comment mentioning license from the top of the file.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 arch/x86/pci/numachip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 2e565e65c893..b73157e834e0 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
-- 
2.22.0

