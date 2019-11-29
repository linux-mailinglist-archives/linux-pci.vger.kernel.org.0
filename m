Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3222910D932
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK2R4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:56:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45123 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfK2R4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 12:56:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so14668922pgg.12
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jPr5t/QGIk3dEsOl9u9M5NSjMqP5apTW3OFqc5H9bGg=;
        b=Sx3AvPOr6oH6nNcHg0XUMPQpmiIJP7Q/U/kiGocKGDuWxO4R+IjAXi9N/72XkHjjGE
         Uv5EZUMHijnKJkaoTxfO4oH9jxNVgkWtmtkNN8xKDL+UWCk2WayHJxC3Wbi1pvncWVIa
         zfjxSh6XMAX6ZIRuSj8sXl6i+dOHsbaAfxwr6JTXOM3g5lVe6KCuOgJYt34TQt9tu5JQ
         EoyiFuznkiQOIETC7NKnFkeS+G6U4NKWKqhbBdOS72SPyJ5gvQBlAwR6rge3tFOqKEKj
         g1xNLMLRgHqrTlOjW/9ELQ3oQe8UaNdpxmAvgzgfGCmdG82FHpCxdIYxyioESCqe7uXq
         Hagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jPr5t/QGIk3dEsOl9u9M5NSjMqP5apTW3OFqc5H9bGg=;
        b=Pr/bvInuwFBMXmgDHck9uZGIknN7LLIZtTj/DYgrwzU6rV3GAybTsA7Gv7N8kBCm1J
         HvonH/A7rUXwEX3rwZK3ph/Quev2NzY0tgLI/t/VinCu4rhkLa86sMRiE6j2V3XyZAnp
         zlgMVI1q/AkMyDd0Nyv6szT51gvqnGaFuqKNfOFrCnAeBWDjMoXhGR+J84WuBD2Z8Bsq
         0gONYIPlNBvHPUQGjL7A2f8wDv+2kNkPXwh0cOtC3vc1c8tLcLDrmmhnjPy/NWOY9ZK6
         f/umvGUuhJps3FJC08YAe1glwmUnMFVjV0wA95fG9qR3oDGkDSFed/RtUmmltEQltR2T
         5qKw==
X-Gm-Message-State: APjAAAXVyxSw9XwaCcahp4GFmbOelIN34S4p/CmJ9c+dTxfoOzEpcN4U
        sCzD76OdceAN4FatujgfLOAk+5YnhyjLjQ==
X-Google-Smtp-Source: APXvYqz1sCR0hMaSTGt0Lcx6/V0omL2CwbAr16Ima8v95egYPkJJoY5hGsmY7XgRYbKLbpl/9vtKwQ==
X-Received: by 2002:aa7:90d0:: with SMTP id k16mr59548674pfk.131.1575050183849;
        Fri, 29 Nov 2019 09:56:23 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7sm9962922pfe.22.2019.11.29.09.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:56:23 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v5 1/3] PCI: Fix off by one in dma_alias_mask allocation size
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
Date:   Fri, 29 Nov 2019 17:56:19 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of possible devfns is 256 so the size of the bitmap for
allocations should be U8_MAX+1.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 2 +-
 drivers/pci/search.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..0a4449a30ace 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(U8_MAX+1, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8..b3633af1743b 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	if (unlikely(pdev->dma_alias_mask)) {
 		u8 devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX+1) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
-- 
2.24.0


