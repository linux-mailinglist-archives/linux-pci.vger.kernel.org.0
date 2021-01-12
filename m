Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC2F344D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbhALPho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 10:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403925AbhALPhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 10:37:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC2C061795;
        Tue, 12 Jan 2021 07:37:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so2512378wmd.3;
        Tue, 12 Jan 2021 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/OOATpUFIrYLWi85tOvfCt5z8mnzNbC6+9SJ3MASM8=;
        b=mK/S5Kccax6uYRwbf86lem0ZF7HLN0PZADSp30Xs/QxEXIS7nyGoCKZA5BX9eVFhek
         bl0ofRrUWMm22BwMzn8KBCydkBzfgOB/yF1+isCmvo230rpHQBhokGfmXM9Xo5zyBe6O
         APqAOq9HTqlBOWGCy1Q9gaA5OV2P0llLFX1+bsaS1+Kk2i9DniAXYW9TAVZLu9nyylFo
         cbxc6rFw31vSe0rcl9JDwU49k5zFZj6DwiOpLOv5kHy5yfENirO/c8YdgeQDo1VJu1EI
         V/5sDM4bFvTUMjC43yEKVFGf/fPLJ8iSFrtF0YNnPVtcaqmUkbvFNeT2EmwujUqxp6yi
         PQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/OOATpUFIrYLWi85tOvfCt5z8mnzNbC6+9SJ3MASM8=;
        b=FWreFRaNsZhEBqI/WI3EcaIejrcDFvlB4uQC9aJUXHwRjd/6Gv5GUqDhz/r+VTwClk
         qNqGDXQuP0MAph2IWSdjkIqfaKSg3/5e1m8i/7WX9wIK1nf9UVGbPle+edjjRf0qhZOv
         EOqd06VUMwBiAMQGysX+VGBFjhQkfgsVqbyamAbYtEow3ZGjpWfdVu7ucKgfSXEQW0/m
         nWzlvCLqB9qSxGCNeFeWmM3FmeP0+dsYw0bQubP9XIn5XtMkTPT7CsEGqTAoZvlzN8H8
         hiaPHLO1X1vofqpVNYNOOMdE5q1PZZneDmSoocfjeoIIFXdMuS15j7bVYam68bzwNd+i
         8RFw==
X-Gm-Message-State: AOAM531fbfIOQmE2qPtrBOPLNdwklBfIe+de2oezWsVU7MDEaoboChFX
        2RKFP9TF4fCbVDfcxkoXsuY=
X-Google-Smtp-Source: ABdhPJy1I6nOSU2GImbcyyiF1FaJKanh8zP8srtrbtWwJDi8v6SQGSo7gukFX+o872kRB7Z3h5g0/g==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr4273347wmk.14.1610465822148;
        Tue, 12 Jan 2021 07:37:02 -0800 (PST)
Received: from localhost ([168.61.80.221])
        by smtp.gmail.com with ESMTPSA id 17sm4239080wmk.48.2021.01.12.07.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:37:01 -0800 (PST)
From:   =?UTF-8?q?Antti=20J=C3=A4rvinen?= <antti.jarvinen@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Antti=20J=C3=A4rvinen?= <antti.jarvinen@gmail.com>
Subject: [PATCH] PCI: quirk for preventing bus reset on TI C667X
Date:   Tue, 12 Jan 2021 15:36:43 +0000
Message-Id: <20210112153643.17930-1-antti.jarvinen@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TI C667X does not support bus/hot reset.
See https://e2e.ti.com/support/processors/f/791/t/954382

Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
---
 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..c8fcf24c5bd0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3578,6 +3578,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
+/*
+ * Some TI keystone C667X devices do no support bus/hot reset.
+ * https://e2e.ti.com/support/processors/f/791/t/954382
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.17.1

