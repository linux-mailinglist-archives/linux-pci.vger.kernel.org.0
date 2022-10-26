Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A160DAFD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiJZGLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 02:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiJZGLf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 02:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D39187D
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666764693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tgxjTxvjPTIXV3SFnxEgSVVrpV7F4tmAX7ZyULG30rc=;
        b=SdSUi0O4MA9/tas3PnzYpICORP81feS8oq5/E74DcZ8CrGr3Y6i/C0oW/JGfYVYw90ZZwZ
        fq6L7d+mQ6js0ngFzzJduukBM5/sSfGYGS4izq9bbXzvFb0KN63OQnjjj5V7dMMmubyZ9Y
        TGEFW2iZbECtPuiNAgX2IpNH6P5cZK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-i6hdlVpOPD2RDIS9CDNhKQ-1; Wed, 26 Oct 2022 02:11:26 -0400
X-MC-Unique: i6hdlVpOPD2RDIS9CDNhKQ-1
Received: by mail-wm1-f72.google.com with SMTP id az11-20020a05600c600b00b003c6e3d4d5b1so5742257wmb.7
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 23:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgxjTxvjPTIXV3SFnxEgSVVrpV7F4tmAX7ZyULG30rc=;
        b=BpbIr66w0BLDHGPIJr7RPqr48tnqOHJGfbUoTdn/18bj2D7+ghIc7zxKnK6H+KOOiz
         7hpyGpDCrQ0deLiu6EeKJY2UEzdKgXIPoEcoo/y5AICtP8W2q+H4yGiJPNKKUYF70WYb
         1PihChbKzQxvvT8eA5+19HbagrK755R/RZ6zBzZ1o9Ul6z4K6Tsckm1cNn1cr4hGqRPd
         cUGNrwf33L9+0/a0onoTbwWehWUwCeqzUSRArSa0sl0cd2F08o8D453VezALjcMelzZ4
         Zj7b+SRS22Nhqr4SWe618YQZDnla5BOQepKIez0edRIu94J1Nl4mhf6+bBTJztcTkBii
         pNDg==
X-Gm-Message-State: ACrzQf2ofrcqqFQWh0+zoZz4fkUuE4dJveFenWvhVETas2CPD58HxLCK
        XrCi5Maiz6PSHDXovwt6BGqkGCu/QKq30Sf0P/h7LSh8VRj0ZEYAT6vT/FwGM16Sb1rzhfWnn0O
        b8s5AWCjLYb/WbhAxnfUL
X-Received: by 2002:a7b:c4c2:0:b0:3b4:fdc4:6df9 with SMTP id g2-20020a7bc4c2000000b003b4fdc46df9mr1144874wmk.123.1666764685202;
        Tue, 25 Oct 2022 23:11:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tKOgv6LG6yDzRB4SfCpvOtNOSzGhpZ+gmNtnfJO420cl+gvCgYi3AQLSQoYEKN8lRFg/eEg==
X-Received: by 2002:a7b:c4c2:0:b0:3b4:fdc4:6df9 with SMTP id g2-20020a7bc4c2000000b003b4fdc46df9mr1144857wmk.123.1666764684970;
        Tue, 25 Oct 2022 23:11:24 -0700 (PDT)
Received: from redhat.com ([2.55.3.42])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c2e8800b003c64c186206sm915339wmn.16.2022.10.25.23.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:11:24 -0700 (PDT)
Date:   Wed, 26 Oct 2022 02:11:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221026060912.173250-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

virtio uses the same driver for VFs and PFs.  Accordingly,
pci_device_is_present is used to detect device presence. This function
isn't currently working properly for VFs since it attempts reading
device and vendor ID. As VFs are present if and only if PF is present,
just return the value for that device.

Reported-by: Wei Gong <gongwei833x@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Wei Gong, thanks for your testing of the RFC!
As I made a small change, would appreciate re-testing.

Thanks!

changes from RFC:
	use pci_physfn() wrapper to make the code build without PCI_IOV


 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2127aba3550b..899b3f52e84e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6445,8 +6445,13 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 
 bool pci_device_is_present(struct pci_dev *pdev)
 {
+	struct pci_dev *physfn = pci_physfn(pdev);
 	u32 v;
 
+	/* Not a PF? Switch to the PF. */
+	if (physfn != pdev)
+		return pci_device_is_present(physfn);
+
 	if (pci_dev_is_disconnected(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
-- 
MST

