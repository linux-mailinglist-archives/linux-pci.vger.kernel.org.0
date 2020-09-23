Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7E274F47
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 04:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWCwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 22:52:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44847 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIWCw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 22:52:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id d15so20319229lfq.11
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 19:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMt86R1F6FGsFNJfVsdsnE6HPvJxl5HpW03XfgvNdx4=;
        b=X9Z5wPyiApH2sTTOiL5p8THrpzy67AgzZl70YIxFV3zmaUCfTlWjx7VFPEWeTjFtPK
         EvKMCwHV1Vrblay+hYk4ESHDGyVSuan08zGn3xZhDobiDaDKpDCtzsfvSwUaGYKg/1G4
         3hVIMCNHEkDtqr9MRHLxiopJFzbIEH4lo8WoNa8H+Hrr4xlw109AUBkvzwkl638w+9or
         cn4l46euidU0AQjK98K7aG3hYAWdKZm7jsPoCStD2SjOX9+vIIh0jYKNUPRtLNlKEpO6
         B02xHauUpxFCRBTiqaWtS3qRMaCN549atu2vPBi8l2wqV044siSrH3q9OgYRN9zvwhva
         fPaQ==
X-Gm-Message-State: AOAM53305gDE1CxmQZ+fN/9wwx/vin1z0Wc47T4jCLs8rXqCdplAsdbw
        FXSgkmckAk+nz0hPGR4rdog=
X-Google-Smtp-Source: ABdhPJy4i/w0dSUTfIBdbJoiJb1zPZ7YwsygCWuu7wKrx7/LpTG/ZCWt6P55twIPrO/BSr8YqMTj4A==
X-Received: by 2002:ac2:5599:: with SMTP id v25mr2452857lfg.129.1600829547130;
        Tue, 22 Sep 2020 19:52:27 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b134sm4194589lfg.147.2020.09.22.19.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 19:52:26 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: shpchp: Remove unused assignment to variable rc
Date:   Wed, 23 Sep 2020 02:52:25 +0000
Message-Id: <20200923025225.471459-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of the constant POWER_FAILURE assigned to the variable rc
after the power fault check is never used for anything within the body
of the board_added() function and it is also overridden later following
jump to the err_exit label with the return value from the slot_disable()
callback.

Since the value of rc is never used in any meaningful way the assignment
can be removed.

I believe the assignment of constant POWER_FAILURE to the rc variable
was initially taken from the file drivers/pci/hotplug/cpqphp_ctrl.c and
then used in the file pci/hotplug/shpchp_ctrl.c (the code base is very
similar) around the time of the Kernel version 2.6.4-rc1 when the
support for the Standard Hot Plug was first added, sadly the Git history
only goes as far as to commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Related:
  https://elixir.bootlin.com/linux/v2.6.4-rc1/source/drivers/pci/hotplug/shpchp_ctrl.c
  https://elixir.bootlin.com/linux/v2.6.4-rc1/source/drivers/pci/hotplug/cpqphp_ctrl.c

Addresses-Coverity-ID: 1226899 ("Unused value")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/shpchp_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 65502e3f7b4f..6a6705e0cf17 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -299,7 +299,6 @@ static int board_added(struct slot *p_slot)
 	if (p_slot->status == 0xFF) {
 		/* power fault occurred, but it was benign */
 		ctrl_dbg(ctrl, "%s: Power fault\n", __func__);
-		rc = POWER_FAILURE;
 		p_slot->status = 0;
 		goto err_exit;
 	}
-- 
2.28.0

