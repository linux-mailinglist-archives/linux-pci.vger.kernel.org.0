Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1977338704E
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbhERDmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:42 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39838 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbhERDmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:42 -0400
Received: by mail-lf1-f52.google.com with SMTP id q7so10604720lfr.6
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ce2Mqrx6CrD0pUNAC8XjuNA5uU1leumU5uK08mhq7I=;
        b=QojvIaEMOFK+fFLlQjtdNGCE/goOimkw4CLwFJH3RJa7h3Azfk8GGn8xO7DwWVBXWH
         B5zv5uOKwPdhRbJLsd2Ge3RVjPP8XHoAZljKpAKykTt/u8J2zBXbqnf00yk/78rSvv5H
         R6YGhry5tff1rgYhQfAa+PM0Wc+DOplkOIy3YNBtt7IwPB9H0hQQEXo1UnJYO99bvkuo
         1mBriCY3Jy8ha88YIn8yQ7YNBi0wniwCSKCD7MJenc7Al9WlM5kJcKiGmneSsZxFHl9p
         Bbw7/wGjOU9Civs+iPq6chIObPYydWHXMb9Dulbf21oHC7V4Kqeyig2UOEGPc1nepFmc
         VDKg==
X-Gm-Message-State: AOAM533CASSq8U+qFUNFAswyn37zrHdgjUBapucsYjbBXZpoakwL6PtQ
        39RlgwRmL3JH1IdMBF0RXW4=
X-Google-Smtp-Source: ABdhPJy/QYjL/LDei5Kj5TxUOO80kC/GTJbf8Q8FI2H1694n1M0YMXpyAk+rvacTyzlvf2uA/6MoZw==
X-Received: by 2002:a05:6512:388f:: with SMTP id n15mr2744448lft.280.1621309283739;
        Mon, 17 May 2021 20:41:23 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:23 -0700 (PDT)
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
Subject: [PATCH v3 13/14] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Tue, 18 May 2021 03:41:08 +0000
Message-Id: <20210518034109.158450-13-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
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
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

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

