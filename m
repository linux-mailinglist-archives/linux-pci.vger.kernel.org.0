Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9137377AEB
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEJEPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:44 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:38765 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhEJEPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:40 -0400
Received: by mail-ej1-f47.google.com with SMTP id b25so22386038eju.5
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4j5vWKcpf1/fXayhp3JqEGpiyWg4HsxhuOtNpqA8wo=;
        b=VwfduM3ICyqbh7cqby3Qhz5Vbb5IgYURRqBigMrtch8I/UUepIKTi0m8BqEHgtXVHz
         a/ZsXo7lep5lTk6o20zVAEZfeFtlFTPSG9Yeo9RoVUhlPYIE/xofN6rFJk5As77mjn0J
         I8MlSUIb5HvBeA481wIUViiI5S6IiPAk/6Beatj6yK+S7vigf2B3phpdi4aqD6SwfBQN
         +ZUZWevI/texOp4Fa4BVF5c0a66hNyvY2wq2+UaTl/FkKagEdajJnD3H5IyXaCOx5Dvn
         TJk8FaIXt/8pl767lLih9RuX8bjl3OaeD9TS4B3e7q2o6DpDp/kDPtJ262AuNJiZjjyw
         lHlg==
X-Gm-Message-State: AOAM533vkVb5DYPzrtoRQF8YpYtcCD3/3o+1MzueaylmAd5Syb81gJ+c
        MM4VdFStITlqskQQBFtjg68=
X-Google-Smtp-Source: ABdhPJxAMYMmdFA8LcrGyx+Esmofgetxmn7HIC4ymO123FV0i4E2XHOiD2QzhPJk97n5J1FaLHqY5A==
X-Received: by 2002:a17:907:100e:: with SMTP id ox14mr24169542ejb.484.1620620075998;
        Sun, 09 May 2021 21:14:35 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:35 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/11] PCI: shpchp: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:24 +0000
Message-Id: <20210510041424.233565-11-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/shpchp_sysfs.c | 38 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index 45658bb5c554..64beed7a26be 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -24,50 +24,54 @@
 static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
-	char *out = buf;
 	int index, busnr;
 	struct resource *res;
 	struct pci_bus *bus;
+	size_t len = 0;
 
 	pdev = to_pci_dev(dev);
 	bus = pdev->subordinate;
 
-	out += sprintf(buf, "Free resources: memory\n");
+	len += sysfs_emit_at(buf, len, "Free resources: memory\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 				!(res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: prefetchable memory\n");
+	len += sysfs_emit_at(buf, len, "Free resources: prefetchable memory\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 			       (res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: IO\n");
+	len += sysfs_emit_at(buf, len, "Free resources: IO\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_IO)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: bus numbers\n");
+	len += sysfs_emit_at(buf, len, "Free resources: bus numbers\n");
 	for (busnr = bus->busn_res.start; busnr <= bus->busn_res.end; busnr++) {
 		if (!pci_find_bus(pci_domain_nr(bus), busnr))
 			break;
 	}
 	if (busnr < bus->busn_res.end)
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n",
-				busnr, (int)(bus->busn_res.end - busnr));
+		len += sysfs_emit_at(buf, len,
+				     "start = %8.8x, length = %8.8x\n",
+				     busnr, (int)(bus->busn_res.end - busnr));
 
-	return out - buf;
+	return len;
 }
 static DEVICE_ATTR(ctrl, S_IRUGO, show_ctrl, NULL);
 
-- 
2.31.1

