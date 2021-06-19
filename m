Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA43AD82D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhFSGmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhFSGmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 02:42:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43438C061574;
        Fri, 18 Jun 2021 23:40:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so9700865pgm.3;
        Fri, 18 Jun 2021 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BqdgBHlkY5WITeFSr4aT0Yb2yF3TJEhWLYU++k4kDc=;
        b=OyJR0Nfb8+QGn3KzeftqpXXNYZ0z6y3vw7+jeGicalCGyi3T9Q8LWumQqgoCXEPvMw
         6XAifQxgt9eFldC7SIU4rY10qlaiVWmXAW3Xr8YzP6ilEfvKPXWeaDTYDyExHtcp92QS
         MtZC6OYe4leOWMObtezIaKH7diNPzu5Y/1PVVKcbWbOe5KB+yyPCbNIp7/EOn+mxwlAq
         HSV2nCvbDPH+MKISoDlABO4wraYUqQVkVW2ulFqAEWSpxeHxACOCnspvNE46/FcU2Sj1
         bMQ/2i3fDJ1R57h6lwEskSF0F0jmVKXeSNk00LzJJ4+KccUuL3uFt5fK2lAxLN4K2D0+
         kozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BqdgBHlkY5WITeFSr4aT0Yb2yF3TJEhWLYU++k4kDc=;
        b=YeVsckhk87/wHdi9+ZF7rNLS/q3nRbp9H17y3rLlYPlXL/u9ELdPzIkH+mxMYxLJX7
         pf+YiDIM4qncwzOdq+QOA/m6rjGC2wzA/DiFVbvpoUW3vcQ9JiEreuvA3TfG24qwVAUk
         iZgPRpluCtqA77Bqn0T/g9N1EtBd66fQwCz2BXq++p6GEj/TkM9txCiozT0pkLEc6bcv
         CDpEKBBVT6q/F3FwAUdJfApZIWJzK9jT5cmhkdrXLXyzxJN4gSdKEFhbZymUKGjUSMga
         BZKdSMrFq5MUnQnRkNokXJdix8XXED3KAOwx/Tqo/t8BuWupXYgOEGQh4V7Z9ngWo/ia
         72nA==
X-Gm-Message-State: AOAM531rBEXKAxxvH9gRDE9HPpAunr0nHdgLj6FeGv9X26TEel8pp7So
        Q1jcGztV2YWST0lbN0PGLX8=
X-Google-Smtp-Source: ABdhPJx6qUHdAKvNLGs9CTuBE4CgynbGRylM+XJL0CFH/7p4Eml/rzSVbtxAj2oJWYngPavAiszjFg==
X-Received: by 2002:a62:1942:0:b029:2e9:debd:d8b1 with SMTP id 63-20020a6219420000b02902e9debdd8b1mr8852127pfz.9.1624084807935;
        Fri, 18 Jun 2021 23:40:07 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id r19sm9440274pfh.152.2021.06.18.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:40:07 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
Date:   Sat, 19 Jun 2021 14:39:48 +0800
Message-Id: <20210619063952.2008746-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace dublicated MRRS limit quirks by mrrs_limit_quirk from core
* drivers/pci/controller/dwc/pci-keystone.c
* drivers/pci/controller/pci-loongson.c

Both ks_pcie_quirk loongson_mrrs_quirk was rewritten without any
functionality changes by one mrrs_limit_quirk

Added DesignWare PCI controller which need same quirk for
* drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3)

This quirk can solve some issue for Khadas VIM3/VIM3L(Amlogic)
with HDMI scrambled picture and nvme devices at intensive writing...

come from:
* https://lore.kernel.org/linux-pci/20210618063821.1383357-1-art@khadas.com/

Artem Lapkin (4):
 PCI: move Keystone and Loongson device IDs to pci_ids
 PCI: core: quirks: add mrrs_limit_quirk
 PCI: keystone move mrrs quirk to core
 PCI: loongson move mrrs quirk to core

-- 
2.25.1

