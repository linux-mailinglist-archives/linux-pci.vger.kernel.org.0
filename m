Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17A381606
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhEOF0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:26:01 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:37589 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhEOF0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:26:01 -0400
Received: by mail-ej1-f43.google.com with SMTP id w3so1601436ejc.4
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4j5vWKcpf1/fXayhp3JqEGpiyWg4HsxhuOtNpqA8wo=;
        b=MT3K1uJR8jhomFVAZv1p8aE1ZQB70k7XGENZyF4W+WysX5tXmxZdnEGtVca88Jn7j0
         sHH7OJlDiTMoUOULEZsrN/NUhEvhnuujc6WT8Ij+im/3jR9/rto0YpTLiVJqcny3I/uL
         vd2DlcA68fYFGGoqwvSkaN2xfyLO3ORInEdg/4qxreuSQ6USY26NA1WbfCYV2q1+dYuh
         6eZAdMsA++Mb+ynN4S8EORfgjpf2PSBWamT+bIVg79Du7jZcGPfXNnsxvBhlQp6jwmDh
         JA/2R4pYS/0g7RjPiuiRiy1Wm4Z4azhphIxc6TpGgUfDxPLggvhrLcG4adAn9PcZunS0
         s6EA==
X-Gm-Message-State: AOAM530RS2nsDn0HDMobhbbWSXnoYXuwT89+Az8+rFQNm/ouYj2n193+
        BGS5zSWAVsztG9qtHS6GBlw=
X-Google-Smtp-Source: ABdhPJzLfDPuTOgIrRqYiui9dXEh/ZAVy0flFmqCN22LEo3CBQNC7QrZjxzGfkQ+eGOXwrKfmjn3Vg==
X-Received: by 2002:a17:906:dc4c:: with SMTP id yz12mr2396563ejb.364.1621056286994;
        Fri, 14 May 2021 22:24:46 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:46 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/14] PCI: shpchp: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:31 +0000
Message-Id: <20210515052434.1413236-11-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
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

