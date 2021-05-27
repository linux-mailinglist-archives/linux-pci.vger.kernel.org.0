Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB53936F1
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhE0USa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 16:18:30 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:37517 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhE0USa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 16:18:30 -0400
Received: by mail-ej1-f48.google.com with SMTP id l3so2040297ejc.4
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 13:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWL0BIlaM4sZhNoyZsPmu9hnl0QQ7ijERedHMYAK8Ec=;
        b=YmFizaurleLt/MIktPsixZugskPuXoeHXL76jazjUro/+GmLEVF0NUSaVXe3nJb+41
         6koqB+duLogL1QCi3vTY1+fXOMG+I8zdxKleVErM321fbE8uWkUsOVA4l5bzDAkG6+oi
         IlKBbAfRS6EKT2pwwpCHxfgUZh/iBKt8ApcxnuoYH9RU0hNqCGHgwPbXSfBNN2eHSC3y
         LpI3+5zptmo5DNj0+wP+oF6Guewc5RYJmmRhLM/Tjywx/yVR1y40A8SKHJG0iDEF/hTu
         e85Uo6zZRsZ8/orJqTPplotdZa0lOh+Onf8nrpqz9PSHiEMUjNLU/pQvFGDp/xAshHG3
         gGyw==
X-Gm-Message-State: AOAM531ba5xaFODXbba9cQpf4GJv5k6lhNbLoof6rAKaUJxKbPxwCszH
        xw9yhFAXKhE+EXFXbfu0bfU8Uv0covVeSNn9
X-Google-Smtp-Source: ABdhPJy2zh3teCEwVTK//79q7iMMuOmGrrNk6dfg15wUHLxcJYrui0cuCtGOrWIoJwPT+Dd3zkZYqg==
X-Received: by 2002:a17:906:71a:: with SMTP id y26mr5557721ejb.491.1622146615981;
        Thu, 27 May 2021 13:16:55 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o64sm492739eda.83.2021.05.27.13.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:16:55 -0700 (PDT)
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
Subject: [PATCH v5 4/5] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Thu, 27 May 2021 20:16:49 +0000
Message-Id: <20210527201650.221944-4-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201650.221944-1-kw@linux.com>
References: <20210527201650.221944-1-kw@linux.com>
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
Changes in v5:
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

