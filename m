Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA24D168706
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUSyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 13:54:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUSyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2020 13:54:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so3588703edv.9;
        Fri, 21 Feb 2020 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6H7czC/EWWOLG+c9dDSZL0yrJluOEN5LNYAxJRlBPZQ=;
        b=Nj1J0Jd4bERbsqqC2RdvzymFWFfEKiqalI2qOX8Sjgq5gmNzefkKgNuBCDGQMxTqfL
         sxVlAk4X06dQpEngnbk3tRqzaiAZJIZp6bzcOm1ft2qMYaL/Mf+95n3Q+mk6aQBcG2c4
         D/Pn+vstVBh076/KljES7r5GvWzMPS3x2lHc5AY93eaZTg/5W/LfsAUodTTk7DAbHZHy
         gd2nbpjSFHjWvWmVfQPWiYG5lyjGWVVP5VJrFNUMBzr+7ud2hCak1kznKB+WIGmxOjTU
         rjngGRSkpqVXjTSQ21868E17hoWwDrY3/1nSSyNx/uPwNYs/AV8LJjiEw3NcREqL9Q/1
         93vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6H7czC/EWWOLG+c9dDSZL0yrJluOEN5LNYAxJRlBPZQ=;
        b=qEt7e1VSsO6AdMfjpnAGX8p79mBb8PvdolHJ+Z7rpwfstK041RAOLzrVtIWChq02O0
         aILJrRDVJTmUiS3PSVCCe8eGPUU99WwfxQO2H8f+ZrSLp9NXq8XvnVZlhHb+3vfbYfNj
         DId91pk8VtYJppfNBKQhCuKZIk/4s/xcDaPiI2bpb9ki/JLWcznwC1JRImFwAULDmIJS
         xC2Z+Q2SLUul5oxpbSbNIByM6/hFW6KPGdPAU56ltL0Y7Ym/qibrZuH66grU3+oDvspk
         m6D1FBlu8bXh9V57PmIC6B5Z82219EgoO/YHWV69hYd3CdPMHSIHUmICWhjdix+NIrfP
         3NSw==
X-Gm-Message-State: APjAAAVlAMwKg+YNG3ajk4/R/O6jVjhHklc3Pgppz4Vz3Yn6XFV/MQli
        FC1Qs+OwlR9m5Rlv05Qhma2iDez0iIM=
X-Google-Smtp-Source: APXvYqw4D+LbiKAlW0MqDTX69Z2BKZfFCJPr23ydy58+Tn3OdmEKcevzhzN9ulkIeQBfs59EFEdPig==
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr35455979eds.107.1582311251283;
        Fri, 21 Feb 2020 10:54:11 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d0c:d000:34f3:c27:3def:c058])
        by smtp.gmail.com with ESMTPSA id v2sm307158ejj.44.2020.02.21.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 10:54:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry to moving cadence drivers
Date:   Fri, 21 Feb 2020 19:54:02 +0100
Message-Id: <20200221185402.4703-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit de80f95ccb9c ("PCI: cadence: Move all files to per-device cadence
directory") moved files of the pci cadence drivers, but did not adjust
the entry in MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/pci/controller/pcie-cadence*

So, repair the MAINTAINERS entry now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Tom, Andrew, please ack. Lorenzo, please pick this patch.
applies cleanly on current master and next-20200221

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4beb8dc4c7eb..d8f690f0e838 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12740,7 +12740,7 @@ M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cdns,*.txt
-F:	drivers/pci/controller/pcie-cadence*
+F:	drivers/pci/controller/cadence/
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
-- 
2.17.1

