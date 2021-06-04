Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74D39B9EB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFDNen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:43 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:43828 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFDNek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:40 -0400
Received: by mail-qk1-f178.google.com with SMTP id r17so9254525qkp.10
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqyAstqoy6rUmJYtGMjATa9/Rre3tPEOJwev6J8FReI=;
        b=ltZsJP9fzZOMbLpoGwChyBJZPL4TkvhAeXCr27NA+c708etBFO+2/s8dSsPHEq4Dgs
         y2gFPQMVa1JTo2Giv2r+fKOP+ZLp9mQMzslqbmLvygixOMMkaznUwXtAzf11IZo8GyhI
         tuUZ+QOfYHyU8jMNdqafq+5EVV4HZfY8YJ+JkYV74PsysJ2sm1wOHC23z2hkI4MHMoWD
         2S7EibMB4d2jgHkYIifLmKzYKGXfSw6zbqUk5hZoQYf28nNmIq6CgpVnub9PqBObrxmV
         MHkaDWDdkyrLHfZRVsNKBVnfMaAYXR1dGZNTMHDO8JBCqC8gWLfouEHP+ZKRP3qbc/Z+
         vQ2w==
X-Gm-Message-State: AOAM530fFqnNmyy8CKTNenUlFZ4aiXZS7ZqpVKf7/bh8ut9nX0IsNG6b
        x7z9LjN3Y+Ew/5NtnFwrs+o=
X-Google-Smtp-Source: ABdhPJw+OOSIR1EgfwusB18XoFtCDyqGjInkiiQl0uXt1aSlT9nkFAiVvH4mWjxjP19ui2OthgE/5A==
X-Received: by 2002:a37:63d6:: with SMTP id x205mr4237055qkb.501.1622813564299;
        Fri, 04 Jun 2021 06:32:44 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:43 -0700 (PDT)
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
Subject: [PATCH v7 4/6] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Fri,  4 Jun 2021 13:32:28 +0000
Message-Id: <20210604133230.983956-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604133230.983956-1-kw@linux.com>
References: <20210604133230.983956-1-kw@linux.com>
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

