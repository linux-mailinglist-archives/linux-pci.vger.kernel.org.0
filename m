Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68261BAC7B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgD0SY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:26 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53212 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbgD0SY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 56B374C865;
        Mon, 27 Apr 2020 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011862; x=1589826263; bh=/htqB/0rYGM6bOltjMUumNTM/7sIZv8Pvtx
        4XF2+xgg=; b=k8X5HK3K1Xw5iaqGLxkhjvOUjbx1imyUS+KB4cuB85rYea/TWQN
        VD4HVbiy7C/IBJ9h4NizV/HyZbKMYXtjdoQVD+iPxfcB53nm1ZFTCdZxL3Fj8JU2
        eQVzIDN+Rxg8u6B2XllXSkz+x9stIxPYqCgoG8EZpTEpnMN9SIwSibkM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 08VrbMObn6bB; Mon, 27 Apr 2020 21:24:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 345414C848;
        Mon, 27 Apr 2020 21:24:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:13 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v8 16/24] x86/PCI/ACPI: Fix up PCIBIOS_MIN_MEM if value computed from e820 is invalid
Date:   Mon, 27 Apr 2020 21:23:50 +0300
Message-ID: <20200427182358.2067702-17-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of PCIBIOS_MIN_MEM reported by BIOS 1.3 on Supermicro H11SSL-i
via e820__setup_pci_gap():

  [mem 0xebff1000-0xfe9fffff] available for PCI devices

is only suitable for a single root complex out of four (0000:00):

  pci_bus 0000:00: root bus resource [mem 0xec000000-0xefffffff window]
  pci_bus 0000:20: root bus resource [mem 0xeb800000-0xebefffff window]
  pci_bus 0000:40: root bus resource [mem 0xeb200000-0xeb5fffff window]
  pci_bus 0000:60: root bus resource [mem 0xe8b00000-0xeaffffff window]

That makes the AMD EPYC 7251 unable to assign BARs of devices hot-added in
those three unlucky RCs (0000:20, 0000:40 and 0000:60).

If there are apertures that end below the current PCIBIOS_MIN_MEM (which is
a variable pci_mem_start on x86), adjust it to the aperture's start.

CC: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/x86/pci/acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069cdd..9eccb26d0bf3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -299,6 +299,21 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	int status;
 
 	status = acpi_pci_probe_root_resources(ci);
+
+	resource_list_for_each_entry(entry, &ci->resources) {
+		struct resource *res = entry->res;
+
+		if (!(res->flags & IORESOURCE_MEM) ||
+		    res->end > pci_mem_start ||
+		    res->start == 0xa0000)
+			continue;
+
+		dev_warn(&ci->root->device->dev, "Fix up PCI start address: %lx -> %llx\n",
+			 pci_mem_start, res->start);
+
+		pci_mem_start = res->start;
+	}
+
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
 			if (resource_is_pcicfg_ioport(entry->res))
-- 
2.24.1

