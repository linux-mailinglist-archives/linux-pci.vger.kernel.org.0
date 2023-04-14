Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23B6E2383
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNMjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNMjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 08:39:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9426A1
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 05:39:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6so1314510pjx.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681475962; x=1684067962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
        b=b7ywarHDTXn9DuzxgGH5T9X8yXaaRlqT+o0+z+U6K56Sv8klVOP0I5Sja/eBAUBiQA
         auAsHdsRzbKjwT2F5ktIGoYPu30zgnbAFR483hcB5Pz9pWW77rBoy5YnVGG/MANXW3AC
         wYUuWfXmJ/yjqrUl3NuDTFn/Q9EloGImclGA+aHoB+5UEG+EUe5WDswjqS4gpxUBRcgj
         YI8GZCrPcs360w5VTYi/qWwCXraGrUBWFsZU2h5AiBLHRG298zVOWR4yLTcVT4/7FbGy
         /cFujgoQrZINwbfcMBOcQgucZ7bZYfGx+d6aUQEgzZ2UEPxO0PfP3fw0UiRqW/R7wSe1
         T+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475962; x=1684067962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
        b=IamedXEQVNGZSBcg9APUsAps06x/ZsGgQIJoiJkZbz9URGas2jiY8m+CiOGsvUPOPS
         /eI0Pyq1BEJMnJNxyc3OEWxBXwwTbov02cNtQIkLyu0x5mnSGAV8e+gTBtxXyjfoMMOM
         5Pf8l2cqh+dhhNNzo7ZQNPwqFEdFnIie4mIg3a/NisCuIaDq0zbCiX50RgMe/jxQU9Vq
         9YHEYPY23O/JLM7VYDmK25jwIZm2+0qIo1W8XEsYF0tbJ9H8W4IjdiW8q23Y93OE5rGw
         Ead+VcIJRpxljl/AxnB4EJAIz0Ykd4oMPgLN0t2m54z5DWfLoBlwTRSvDNE8MQNk+IoU
         XnwQ==
X-Gm-Message-State: AAQBX9duhb/nP1HQZyUgaupwnreMFnlaSlSlK5w9dSGEvwOSaFqo5OY9
        j4Ksr0kAiowQ0cg16Hy1WHR+EQ==
X-Google-Smtp-Source: AKy350bbTAYGABfXjfsLqUTU/WrsVCelzkOFGUGytTzIM5zBcMTZxDzCBF1sB9aPe7WOcn+g/Ntnkw==
X-Received: by 2002:a17:902:7892:b0:1a1:97b5:c63e with SMTP id q18-20020a170902789200b001a197b5c63emr2479303pll.38.1681475961919;
        Fri, 14 Apr 2023 05:39:21 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709028d9500b001a527761c31sm3015366plo.79.2023.04.14.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:39:21 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/3] virtio_pci: add a definition of queue flag in ISR
Date:   Fri, 14 Apr 2023 21:39:02 +0900
Message-Id: <20230414123903.896914-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414123903.896914-1-mie@igel.co.jp>
References: <20230414123903.896914-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Already it has beed defined a config changed flag of ISR, but not the queue
flag. Add a macro for it.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/uapi/linux/virtio_pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..d405bea27240 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,9 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Bits for ISR status field:only when if MSI-X is disabled */
+/* The bit of the ISR which indicates a queue entry update. */
+#define VIRTIO_PCI_ISR_QUEUE		0x1
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 /* Vector value used to disable MSI for queue */
-- 
2.25.1

