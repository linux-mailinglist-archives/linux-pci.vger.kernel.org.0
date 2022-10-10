Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612A5FA27E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJJRM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJJRMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 13:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95A6566D
        for <linux-pci@vger.kernel.org>; Mon, 10 Oct 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
        b=cVOG64Hvz2isSJ/OlHmWpgeIU+4c3nwJ/9LIkhPZlMCPLFlSvHnQRY634rC1+qnIKpEO8N
        4rXLy6/HzYbObwr27rqkULPjHJ/Hh1yz5qpNyy24CgB+z/i7NI75p13kgpN5PSq68Ge2gu
        cGvfpMCw79GrPjHMwZnxMFkA4gNY1Jc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-3qK7Ds-ePbWXbblkOhjQzA-1; Mon, 10 Oct 2022 13:12:22 -0400
X-MC-Unique: 3qK7Ds-ePbWXbblkOhjQzA-1
Received: by mail-wm1-f70.google.com with SMTP id 2-20020a05600c268200b003c4290989e1so1733324wmt.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Oct 2022 10:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
        b=KHE/929mYyot/y6T0aw4G0jq50bNbb4nnTZGv6JnivNOWjuk3PBbk63iFWTrJkB9j6
         KqXooL9yUi+K/UwlVieaTbruPrHXghRzrKK6ad78lPHHV/JXW5xD0zmGjErjnDy1m6hh
         vN9x/mHyjApur6g8/s/zJ9t1zBBiDIrt8Hjr+lsgS4MyYu03+iMlZb3mCydUT6xg6Nbs
         8Qecgr/2nJbFzkv8yHuTtO57q0S2QBuEbhzGMwTCOWcDcd9vH0loDWFJxrzKa/7ufRlk
         dgLoCzLpN6WaD8rmXR5x9eaEVDAjttfjNJLRm2M1c17rztbiwSuVIiJdWnn+imXTpBly
         OcRQ==
X-Gm-Message-State: ACrzQf1A44IY6CzTpPTANg2PLUABNjkNyoEZaifiMO65jYQ15n5Wwb5N
        DwNH/i0V2FO9h9jwrs6VyDsiKr16mm9/UelT5ZbwuaCTTUnLqgfH102Qv7O1gmRD4NjhnFSTwo0
        AgZTf11CyvVkOfVYqghVv
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id s5-20020a05600c384500b003b4b1873d09mr20540151wmr.96.1665421940998;
        Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63cjhz7XzZhJCporbzOGCOCeEtLMeJPQcnHObTdg8t2i7mRm/yvHLdG4jtj6Aj67AJhVchlg==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id s5-20020a05600c384500b003b4b1873d09mr20540132wmr.96.1665421940794;
        Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id a13-20020adff7cd000000b0022a403954c3sm9339737wrq.42.2022.10.10.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:12:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

virtio uses the same driver for VFs and PFs.  Accordingly,
pci_device_is_present is used to detect device presence. This function
isn't currently working properly for VFs since it attempts reading
device and vendor ID. Result is device marked broken incorrectly.  As
VFs are present if and only if PF is present, just return the value for
that device.

Reported-by: gongwei <gongwei833x@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Warning - compile tested only. gongwei could you help test and report
please?

 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..ba29b8e2f3c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	if (pdev->is_virtfn)
+		return pci_device_is_present(pdev->physfn);
+
 	if (pci_dev_is_disconnected(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
-- 
MST

