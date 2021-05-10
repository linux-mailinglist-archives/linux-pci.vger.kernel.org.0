Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD81377AE4
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhEJEPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:34 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43738 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhEJEPd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:33 -0400
Received: by mail-ed1-f50.google.com with SMTP id s6so17045141edu.10
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQ3R2W3kyD0ic+vfu4svsuSqjX5xIeVtIEqsI3c2288=;
        b=fqxKd5lk4SojaFXJ/qFeX656TuHZ4kmXbR1/3/KHiRBDZKOV1UAeGWnLuFQHbvNqKs
         KKI0C6iTcPNMWQerQ1hbSpHDaAKhX5dKibT+w6YHC3oahiVZKByQ0gN6NoJa83rmB2Uc
         t5AC6XUe8R2ljetTGuUutk5jwI/wp/rl5AbbZswSjPCgFkXJkK5QiSx5gGVLNviCxBZt
         VEflqOCtqqsZmUYuPukJeRGymD70gn9AtyY4Maa8MO26/ikHlvM0U+T/RFPgJqQeV6Y4
         AL8GFP6eMQHVN72nsm8FrHupSzbfnf66wNwYlvTYslOitEG7o9kxvVmz8B6KZwAyE5T1
         mcLg==
X-Gm-Message-State: AOAM530vOS3c36ph3iPCn3rXaWRfteYedgRE0Fmf+ry0hZQH5VZrrP9f
        WypfUNL0z80AWJM3nhHcNGE=
X-Google-Smtp-Source: ABdhPJxGPbzkNuqWvwE3N4swgt2IrBy7ztOMGWEg6AahkUY/MTcyDs1wVMEnZE8H2UTysbwnShbl9w==
X-Received: by 2002:a05:6402:1547:: with SMTP id p7mr27230413edx.319.1620620068876;
        Sun, 09 May 2021 21:14:28 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:28 -0700 (PDT)
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
Subject: [PATCH 04/11] PCI/MSI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:17 +0000
Message-Id: <20210510041424.233565-4-kw@linux.com>
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
 drivers/pci/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 217dc9f0231f..dbfec59dfe41 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -465,8 +465,8 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 
 	entry = irq_get_msi_desc(irq);
 	if (entry)
-		return sprintf(buf, "%s\n",
-				entry->msi_attrib.is_msix ? "msix" : "msi");
+		return sysfs_emit(buf, "%s\n",
+				  entry->msi_attrib.is_msix ? "msix" : "msi");
 
 	return -ENODEV;
 }
-- 
2.31.1

