Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4991E399692
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCADS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:18 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46680 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFCADP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:15 -0400
Received: by mail-wr1-f47.google.com with SMTP id a11so2071713wrt.13
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqyAstqoy6rUmJYtGMjATa9/Rre3tPEOJwev6J8FReI=;
        b=e5j4f8JWXmWv0tQ0kTX/dx7nRhXWB8SBLfOGAjysUgv30jLKolT4gZ3t1TE5qT+dWb
         m2IatbT5XjGpZ1vyB5CbHZsan9IlT4ExRyTfZl0rwkW/YnJWlIxTOLWsHmwlN2MyYygH
         yN6RS/NAE4Toc3vw20pQunRBqlYblNmot0lq8OclsV112uvXA5xZQ+myLaZk5eobBe22
         85tOpA0N0Xt04v43NcVaur/vHvGmLkbeJaa7t6qq9e46AkESvTyYK3XGIe/a2wZpii52
         VaRSNGiLAjDYpJ/0L9qVskAdvtZeyr1Hy5/m7zbjq4it7gK9Av9CvtoQwHUrbxnizFtN
         RPBg==
X-Gm-Message-State: AOAM531/ufQJEuNwlqDjdZ0ym2xG2W2tVcVwOs2Rcii5OVtcdhnOXn2A
        NoCAxBOs7m+FtHB4PnWGXm4=
X-Google-Smtp-Source: ABdhPJz5HhvJ2eRfHuOn69Ej6wr0OiGJCcKBPn6NcriZh2rq+04n7WHdIJjpdbvdWh2Ddm3EcFF+rg==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr10873389wrr.26.1622678480285;
        Wed, 02 Jun 2021 17:01:20 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:19 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 4/6] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Thu,  3 Jun 2021 00:01:10 +0000
Message-Id: <20210603000112.703037-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
References: <20210603000112.703037-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, when the value of the "devspec" sysfs object is read from
the user space there will be no newline present, and the utilities such
as the "cat" command won't display the result of the read correctly in
a shell, as the trailing newline is currently missing.

To fix this, append a newline character in the show() function.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4fafe..5d63df7c1820 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -537,7 +537,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	if (np == NULL)
 		return 0;
-	return sysfs_emit(buf, "%pOF", np);
+	return sysfs_emit(buf, "%pOF\n", np);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
-- 
2.31.1

