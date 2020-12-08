Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150052D3191
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgLHR5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 12:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbgLHR5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 12:57:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C3C0613D6
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 09:57:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so17174178wrt.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ccc/z6bdj2ybnd6nBD1Mq9vhfwf9ubNK0z5meN8OhvY=;
        b=QxctZS6p3IerUsMTlYEcqbk2zHwH0WC60/Hemh3L5pIxifW6vNsYow2ZoUoFqKfF6z
         wfuF6XyA7FuRcfbnyHDyvx0VE3zj17xHXMf9VADH65psORg21sTSmOTrzRs9Iri3rhhb
         zsb1RqEMrf8Nop4sAX12vkiVRp8plDPf1R2E9X/j5NQCMBYWgmu2w4DqGua2BKbtJVTw
         lcKfLOClh9JcIzYD2A+ZnCDOVcutye3b5smdOIqOJ2ft17OP7zf5vAqEOqgPllU97npI
         PdgAhxDwkIn6R61NemaMi7GVkNdHF10u0wce2YodyTsNQQLf40o3Vq0RvfYTzj/eIYu6
         p1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Ccc/z6bdj2ybnd6nBD1Mq9vhfwf9ubNK0z5meN8OhvY=;
        b=MZ/yF0kCe6aSKSLwttoUms9DhgjGb53OQLI/ffhRjpE0YdAzw7MyqYEEtFHCmIHn6H
         +/b0SbVcEKF3bUQnRKHFMqEeUyBOWpUUeVR43+3x6RbR+slvLHs+nUXA0hxITrxvIRaU
         /eCYL5P00ShTV3v2ui3GeoTDxJP0pq9S+aZ1Zq8HVBIUYf09pqvmk6lhkI4iyd1XRHBb
         gfV8s+KEOG3YRQVxTdsBSB1ni16sIenWh/tAigrS/HKW3Yzvgj7HdAFGNuzE8wjWI2vq
         FMayADdi8GIxqt3hih8qDuDFJEiiKFOoBZZHc+JdgolPk6mLPSSYJffbfHIn6yloO37d
         mv6A==
X-Gm-Message-State: AOAM531Bq/ngrmuc0DuATdVgtnzrTB5gJWT5+ZXwwm+7Z3eTXIyfKb6p
        schTadnxzKNzPcgAO5BolX5cOawBlbU=
X-Google-Smtp-Source: ABdhPJzNj7ZwPqb0vJe7u6B/iTp6AjJHYyOeTyzvKz2u+6oIyl6/Cotp12aTONUy0a9Qzy/nuf4pEg==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr26179843wrt.150.1607450228834;
        Tue, 08 Dec 2020 09:57:08 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id y2sm20738789wrn.31.2020.12.08.09.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:57:08 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Change message to debug level in pci_set_cacheline_size
Message-ID: <be1ed3a2-98b9-ee1d-20b8-477f3d93961d@gmail.com>
Date:   Tue, 8 Dec 2020 18:57:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drivers like ehci_hcd and xhci_hcd use pci_set_mwi() and emit an
annnoying message like the following that results in user questions
whether something is broken.
xhci_hcd 0000:00:15.0: cache line size of 64 is not supported

Root cause of the message is that on several (most?) chips the
cache line size register is hard-wired to 0.

Change this message to debug level, an interested caller can still
inform the user (if deemed helpful) based on the return code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b7f0883d6..9a5500287 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4324,7 +4324,7 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	pci_info(dev, "cache line size of %d is not supported\n",
+	pci_dbg(dev, "cache line size of %d is not supported\n",
 		   pci_cache_line_size << 2);
 
 	return -EINVAL;
-- 
2.29.2

