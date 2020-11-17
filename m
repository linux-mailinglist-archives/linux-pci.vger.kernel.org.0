Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462062B5975
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 06:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKQFo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 00:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQFo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 00:44:56 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF1C0613CF;
        Mon, 16 Nov 2020 21:44:56 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so15354562pgm.9;
        Mon, 16 Nov 2020 21:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLOKhmR08M0B/4atKVerRPzwm0RJuJz/KvTr7deGbiY=;
        b=TdPQIJxsRBlp9yFp8khc/3gjrU3Rs8c9d2Qtnp7wxpbVCVXB75KctfQTgLpTISwXa7
         y6iCySS9lFomqIruA5i1k68TPgFAvmiVGfQy+t1NFZgp8/op8S3pUmmShii8IAKj6Y+m
         EwgWFl0l9+a74b9AExu4CHf3IbeiTj04fOcl/cEl87nm9RGj6RL9+SvKgGNvthDRHOSz
         VrxRpgxc65/2j39GldFzQ748O5B4Qg8glAPi+TD4XdvfOcEv7E0GH6P/e7XNI23QVJto
         wlxvcaUKoHvotGlYpOyOV0ktYu+JP49iU5sH9IsO2BPq/DYBpvPULSaAyE6NrtkmfQLP
         XRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLOKhmR08M0B/4atKVerRPzwm0RJuJz/KvTr7deGbiY=;
        b=bUR9TaC11SzPDk0egfNb2K0qdMcmKAQXXIJ3gjAmAO88uLaQsvl3L0+52ORQ2Ioe8M
         4sx1A19dng/aJtpbxlD5yTvfj8HX9qsXjuB8TYfesfzCMTk2LKKcAOzkEuitqyPKe1DH
         4KXq7stkeIdOcFt2Mad24xMTu0C0xo6lgWRQHX8TqEwJJln6JOQ1SPMJoMYCk08Asrnq
         FqMwobHht8PPfJ3Fd1GdntIXg4RedYZajvpEe9IMGLESXTPr5dyq03gKpHuVoEbNjwcv
         eO+fEf8sDxe90eGraDAqpvbQ209hE8PN1crauJjBRyamxmLV4GHoIJXe4rUWh+1rdIMz
         ImOQ==
X-Gm-Message-State: AOAM53320TAJCkz7qKWRMXqqEI7VqJN6p2mQ44RYkSE2D5MW41MgoGcl
        wdOnIdkzSJeQIzQuNscQL8wyP9Z279A=
X-Google-Smtp-Source: ABdhPJzDvPSQytIfyRltrfuWFBufyW6jCZVITefa5VjDftT4j+qfDPY6Fg6uc26ISp8sldarztuUFQ==
X-Received: by 2002:a63:5262:: with SMTP id s34mr2239785pgl.382.1605591895853;
        Mon, 16 Nov 2020 21:44:55 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id m3sm20392462pfd.217.2020.11.16.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 21:44:55 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, hch@infradead.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v3 2/2] PCI: avoid duplicate IDs in dynamic IDs list
Date:   Tue, 17 Nov 2020 13:44:09 +0800
Message-Id: <20201117054409.3428-3-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
References: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
only static ID table is checked for duplicate and multiple dynamic ID
entries of same kind are allowed to exist in a dynamic IDs list.

This doesn't cause user-visible broken behavior, but not user friendly.
remove_id_store() only remove one of the duplicate IDs, so if we add an
ID several times, we would have to remove it the same number of times
before it's completely gone.

Fix it by calling pci_match_device() which checks both dynamic and static
IDs to avoid inserting duplicate IDs in dynamic IDs list.

After fix, it shows below result which is expected:

echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
-bash: echo: write error: File exists

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e928cfa..c4678d8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -197,7 +197,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
-		if (pci_match_id(pdrv->id_table, pdev))
+		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 
 		kfree(pdev);
-- 
1.8.3.1

