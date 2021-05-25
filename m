Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF63900E8
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEYM0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 08:26:10 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35790 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhEYM0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 08:26:09 -0400
Received: by mail-pf1-f177.google.com with SMTP id g18so21811366pfr.2
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 05:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTzsrXViPTWjnX/pI+VkTtQrGiMMsRJfFisasSRful4=;
        b=nXl6Pz0HN3Gl14aK6NTXQ5Nf/m2ncQyOKuA3rqbGooRv5xr3Nx5FMKmN0o8pIcnUHd
         x/016v3vWwCYHki1LWVpdCFWTVeFJJyIan1NJwCErEGiA272TRHHzr5fBq58rBWlvq0/
         AIm2T8wgcxKFEqnMpBJ6YsD2V6ylYvQyb7Eng+gjAhGp9RKZ+X00PkO72N/7H4QEbDPN
         lpiaUaJRMK4Ga8ob0ldiIyr/LlY3ANpZNBkiZ9t4oTZq/uxd8/VI28MzeEzNGRD/HEVx
         PuQtGbrbWb8qdyorL7bkrsKwJG7QcDUaU2Lw9P42l7hn9vLwyx9Yo4UDBsHXI2VpcwvX
         IIxw==
X-Gm-Message-State: AOAM530n0/R4s/kj1I+dPeKakPHNQrqJ5hV3JMF7NASXi1fqhuayDSbF
        73d05CxLxgK6RItAaegNw8w=
X-Google-Smtp-Source: ABdhPJyqYRfJWniGgiedWT5TOYKvtUMhbWdrEkDIspDmSmZzgOenCcrCjWJhXh97Brb4v7cG9hmFLA==
X-Received: by 2002:a63:2307:: with SMTP id j7mr11207277pgj.20.1621945480189;
        Tue, 25 May 2021 05:24:40 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u1sm14220258pfc.63.2021.05.25.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:24:39 -0700 (PDT)
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
Subject: [PATCH v4 4/5] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Tue, 25 May 2021 12:24:00 +0000
Message-Id: <20210525122401.206136-4-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525122401.206136-1-kw@linux.com>
References: <20210525122401.206136-1-kw@linux.com>
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
Changes in v4:
  None.

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

