Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED3399694
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCADT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:19 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33595 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFCADT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:19 -0400
Received: by mail-wr1-f53.google.com with SMTP id a20so4002255wrc.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDZTRy60jf886VMZcN9phSvrkqPImnoVMsDLpQujQdY=;
        b=U9KNAopeE477jwnfTWwPC3Onq1SfHM8iGuYc+sFRNUM5dT7/HceTTpAWBSy/8jUXtp
         453UR+P+DYKuZw/XACfajnNBCsNaDf2Av2Z9vdKfgTogTQD2lvA/TO1/H9dddZHx2r9V
         KW1kBs7TGV1OslHPLBEDBKOJTgHgVuT6bW65+w+lAfm+Mk5ZD/Oliohe+gnTKeTQFBBa
         wtplaon9ZokMeMdJuN9J8mrB/o9wjt57e8dJmPVdicmi5/jMXlhE+kDQX4OBEGcxt8Tv
         nku90pv/r8feWF1CzrgHA/I5gZFiG9S6Z3Smq83v87SMDnfQNj+BdIXrpDTlBW114zME
         ajNA==
X-Gm-Message-State: AOAM533SWf4mz/PJCxzEXMvDde8EOxOzuyfEObMCj0AiUUtdTYiGyN8K
        4DuUw2+oNhL3n0w+ImUF290=
X-Google-Smtp-Source: ABdhPJzg+FZ2lQ6DRXRLpucS/hd0JoguzbDVgvoE2pwcrlZJh5+doDXK4PMVFvB8vZxSAmsEt1pFSw==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr22103513wrs.246.1622678481489;
        Wed, 02 Jun 2021 17:01:21 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:21 -0700 (PDT)
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
Subject: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Thu,  3 Jun 2021 00:01:11 +0000
Message-Id: <20210603000112.703037-6-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
References: <20210603000112.703037-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only expose the value of the "driver_override" variable through the
corresponding sysfs object when a value is actually set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/pci-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..4e9f582ca10f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t len;
+	ssize_t len = 0;
 
 	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	if (pdev->driver_override)
+		len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
-- 
2.31.1

