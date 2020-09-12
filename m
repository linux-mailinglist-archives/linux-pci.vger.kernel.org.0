Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE08267B55
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgILQMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Sep 2020 12:12:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgILQMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Sep 2020 12:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599927135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=OnLO4ADFj7Z7o5P1yfw7tWD6Tiz1740E30zuroEwIIM=;
        b=WPR2hSzbCn2pHF5qRtNI3munksa9bPEm7sGs6Pg8dtfRDC/QHENE4OFP1G6dun8KgWQmk0
        iAYOmfsebiM3choAShrM5M0EZtr7PGMy20oulcDQ6kM52TD8UxMAe0iWHoHC0+jxFRIGcy
        ssJaQeeeK0M8xjuYWgoEqQG75wFNJjA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-YN5izzMuPxu1P417g8_Yww-1; Sat, 12 Sep 2020 12:12:13 -0400
X-MC-Unique: YN5izzMuPxu1P417g8_Yww-1
Received: by mail-qv1-f69.google.com with SMTP id z12so7174867qvp.11
        for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2020 09:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OnLO4ADFj7Z7o5P1yfw7tWD6Tiz1740E30zuroEwIIM=;
        b=LLPObo7vr64ZFOSI9XZfF0arTFCoCn3o7zT6Fa0apzIENqdzXSWHHphbRr0EqnImwH
         glitxzywTpSiiqvQCErC0r2EEeygcEh4Ay0QjyBWZUevqVj4GQRgWQfcsLYWr95aEGhY
         9lnJ1U9kS7dRE1eQrLP8Xz/U0IM225sIOTdX9wIfmYOtjK/+8NcF7Fyk8QKJjZOY7sFr
         YizLilHUa4Yb3LFt5d5guXmsLar4v6RlVARm3p+cfs2+NhlbA+6jOHpra1NOsMQv8cu0
         e+MqNcoOXQePdY5FvPv9Mf07ZrCgQZOMbe+gfzk6ZBBXmetRZtdJ5rEYHqbYO67CmaMF
         Yalw==
X-Gm-Message-State: AOAM530cCYtgra1LmHzJAXuqbLgaHkRWu/W5KvMEvMAmgctIoc9MyKVH
        Kvl0tNBxRLEzg8bKLY9FQR7XLrcOmoT/XN82EXGuMQPAeQ/90svOCEv1yLmwjHpFd1WFRWdds6Q
        0NTaAFSTbY9Uia0pEm6qo
X-Received: by 2002:a37:a495:: with SMTP id n143mr6285703qke.394.1599927133318;
        Sat, 12 Sep 2020 09:12:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP+4lH+ouC+KfulEQPisuyxi+7vR480dD2LFSfHaIQiCkElD7umePVZ+w6VEUe/W6iJgbyBQ==
X-Received: by 2002:a37:a495:: with SMTP id n143mr6285675qke.394.1599927133032;
        Sat, 12 Sep 2020 09:12:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m138sm7642421qke.99.2020.09.12.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 09:12:12 -0700 (PDT)
From:   trix@redhat.com
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PCI: dwc: do not export a static symbol
Date:   Sat, 12 Sep 2020 09:12:06 -0700
Message-Id: <20200912161206.15848-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building produces this warning
WARNING: modpost: "dw_pcie_link_set_max_speed"
  [vmlinux] is a static EXPORT_SYMBOL_GPL

dw_pcie_link_set_max_speed() has a static storage-class
specifier so it should not be exported.

Fixes: 3af45d34d30c ("PCI: dwc: Centralize link gen setting")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d105efb5722..3c3a4d1dbc0b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -508,7 +508,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
 
 }
-EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
 
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
-- 
2.18.1

