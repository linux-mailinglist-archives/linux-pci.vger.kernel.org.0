Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D416A05AE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1PHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 11:07:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54133 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfH1PHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 11:07:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so431206wmp.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0g6/GWz5P/gWnoS2zvVct0hdhKaGG9FVra9wvXgtYro=;
        b=G4yuIL9aACyk+T1kP/v/gjWwqvfosJhV/CrOwvCZWPq9LWrgypos/FB/at6623Os0t
         MOjMC5p8GDAvrCudo/Voigjzi7LGwqvDvmptJA2N/SJb9rzz8l1OWLHyPaqkWWcUGFex
         aFbl21PTj2DpaTmDZxsWCQjknQ/v/A64x+9/I1RBG3ySsddEYNFul/ZMysk6C1zIEDz2
         MBRhkBBi6OTf8+IF1x3Yqfpd1ba9BTNHpuLTo4c6l2c6OM/5/CgsdXZXizmAgTS9lc1G
         OUcRyNcj3Ue1IAA6TzU/T+ka6LERlX/TAPj5w547tGTGFhy+L711EsFj3W5yPt8ZSB+p
         Tmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0g6/GWz5P/gWnoS2zvVct0hdhKaGG9FVra9wvXgtYro=;
        b=KpEzWetHKrUJnt/WOcL9q05R8yMc9swNLw7+JQxLKBroi50xXkgbgZtqIHsPKCEPYE
         sNCg+x2eoFbLkG4dLzoeYBqbatLS3gYwLMP2wAGNTjhm2ch0cei7QmXBZSJrchHIU5ev
         u8P3q/p9DlZo1HiEflFjHeNuGrVUH+EVJHqA+T8Q8zjUPYByJyXkJXuuyjknDssSFuex
         vpa50kjr6gQOnJ5CBAvB/QgTmKDQFJvmopHnXOHyb9e7Qj5diVln+jfsQbJflnSbqE35
         HHSOQeu3qWA/5lBeFQc8ubMjQGG5YYivey0FFk7rNU8ZJXY7ejtyduDmPh/0gZj7I2Mh
         Ph4w==
X-Gm-Message-State: APjAAAW2bVu50imvaGeD4P5JAKyaD0bP4jK/SYFvZG2R28QLg+C9dYs7
        5s1nuz0LM1eIbZf9IJposNs=
X-Google-Smtp-Source: APXvYqzpBqySxGG2yCcwTNpgYDuAfZBmGQmktNF+X+q9cdeGc6c9u/8Edr1Xpqs95F0MjOE+3g8WCA==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr5824675wmg.28.1567004860039;
        Wed, 28 Aug 2019 08:07:40 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id v124sm3115316wmf.23.2019.08.28.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:07:38 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: rockchip: Properly handle optional regulators
Date:   Wed, 28 Aug 2019 17:07:37 +0200
Message-Id: <20190828150737.30285-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

regulator_get_optional() can fail for a number of reasons besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate data structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "regulator not specified in DT".

What we really want is to ignore the optional regulators only if they
have not been specified in DT. regulator_get_optional() returns -ENODEV
in this case, so that's the special case that we need to handle. So we
propagate all errors, except -ENODEV, so that real failures will still
cause the driver to fail probe.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8d20f1793a61..ef8e677ce9d1 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -608,29 +608,29 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
-		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie12v);
 		dev_info(dev, "no vpcie12v regulator found\n");
 	}
 
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
-		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie3v3);
 		dev_info(dev, "no vpcie3v3 regulator found\n");
 	}
 
 	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
 	if (IS_ERR(rockchip->vpcie1v8)) {
-		if (PTR_ERR(rockchip->vpcie1v8) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie1v8) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie1v8);
 		dev_info(dev, "no vpcie1v8 regulator found\n");
 	}
 
 	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
 	if (IS_ERR(rockchip->vpcie0v9)) {
-		if (PTR_ERR(rockchip->vpcie0v9) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie0v9) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie0v9);
 		dev_info(dev, "no vpcie0v9 regulator found\n");
 	}
 
-- 
2.22.0

