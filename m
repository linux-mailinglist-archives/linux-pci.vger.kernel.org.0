Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BBD377AE1
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhEJEPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:31 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:46023 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhEJEPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:30 -0400
Received: by mail-ej1-f42.google.com with SMTP id u3so22359114eja.12
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yG00XpORYp9fWIwYNYumtIx0DbQmOEgAaM8O8RiTCBg=;
        b=CTeo8yihqPBKptTIS4VrnFCam1mQrl36s83kUffXVhXgjXX4d2+4oZswdBq6ZZb2Jk
         6yCz2w1Nfu4ZfpSMuA/uuuqL3ZxPRbYQqpyTaA37iRr1ICsom13m91T586eRhASd8PXB
         cxQ/4tkScLyTtd3hQQ43NUChTGLS8PptNPI4t3+oqEQOxPn3CszLqccETnvqy10Bpsnf
         x2EutTwbQnSg/m3wLvka3pdbUac+rCongE7OAouWGiAvN96LAcqYYlIMfYOXtjmO9nMh
         WE7Y0wIh8ES142Sl594fbGPkDfgDrU8lw0fjpnVgyAdAuuAQz87sVQI/iqKZoPmjHS0t
         gw3Q==
X-Gm-Message-State: AOAM5338sy4wMibbrZhV4yuhcOlG7YQytpjbocOTG8D0100vKgkoZLKo
        +fFZG1B5fhMD6OwZxvHM0/M=
X-Google-Smtp-Source: ABdhPJyJeQPSRJV9jJWYAjEQGkNIBh1uh1Jil7dgPsc1o2RkXPUJpNn61pvdKGmYpGTBlGGSR+C90w==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr23759582ejc.185.1620620065913;
        Sun, 09 May 2021 21:14:25 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:25 -0700 (PDT)
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
Subject: [PATCH 01/11] PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:14 +0000
Message-Id: <20210510041424.233565-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..5ed316ea5831 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,7 +6439,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
+		count = sysfs_emit(buf, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
 	/*
-- 
2.31.1

