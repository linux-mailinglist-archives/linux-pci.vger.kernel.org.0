Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162C6A1724
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfH2Kxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfH2Kxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id h8so3559692edv.7
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gFcxUWdUh7JrthZ4h94QDUZDfQAvubHMLo7e+zp41g=;
        b=ZFNbt0bG4blmJJTdRvenuOxs/OnyNemmfV+FBnGOwI1azx7QTB9zzJtxSjRKZjDfEg
         YMKXS3NbtsySuD4ZWNJKhmLoP5h/dRDjiZ9xP4KYQc29eP3DzHq7IXtQRhwar/ILxaQl
         QOZecA2D/HgeTt9nThVz1oxiIJgD2p9smwpJ7RMdeAo0ZVzjMaSNvKV25F+3i4CI6AR/
         gQKV41t9badED1VfuYpYWshXXcT5Up4LbzKfW/v8dA6K3YFQ7zGonv98XBQ3D4h1J24W
         PC7L0/Juysx2CL3yZHkegpFj73WFpEBVb42EENIey33DO58Gxvd1cqrBcWjeBFpBn4w1
         1Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gFcxUWdUh7JrthZ4h94QDUZDfQAvubHMLo7e+zp41g=;
        b=NkMtbdFcvZrZwLZD161wK2E1pJXcqrdB+2Iwxlsa/YBJP5gXJYb+f9WK57E5cLurPf
         uQ/xo4MZzySv59QE+6dEkGn5kA+KXEGwnc/GHGSn/f2FtInnoSIPr5AwABLZdHfm441U
         S5X5Z2JwI4neHEd+18fBqHdsYQbgBRINz9PM9nkLfDL4j2MsQqvFkh0HV2mnRlf+7Auv
         64Vdc6cuxjV4dX+2Y83BWeqdQuJfFfGj5yISoTHfexjhIUXDf2zSJsxYzjKUv5R+0IXt
         GTPD//3TAXgUfDwcsqcWE82QAd9EOFzvWFdQxosvrT3xJYe7QcbyvjqBGL/W/Hs+qNHp
         qglQ==
X-Gm-Message-State: APjAAAVNkDTS9+UgYZf2lKDkvZBEGp3rdGKW3gPA4IJDeW3uN6+RhMyy
        B4pV3K5WIpnb0R5xcmIMLpw=
X-Google-Smtp-Source: APXvYqxhLrL6/mKGjOAYXE5acZwalwbf90ih41WMGYVDr63l9ZCg1AOwIGvAZQryLm6nAKNxbUGrng==
X-Received: by 2002:a50:b825:: with SMTP id j34mr9249098ede.58.1567076008523;
        Thu, 29 Aug 2019 03:53:28 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id h9sm374654edv.75.2019.08.29.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:27 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/6] PCI: armada8x: Propagate errors for optional PHYs
Date:   Thu, 29 Aug 2019 12:53:17 +0200
Message-Id: <20190829105319.14836-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829105319.14836-1-thierry.reding@gmail.com>
References: <20190829105319.14836-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

devm_of_phy_get_by_index() can fail for a number of reasons besides
probe deferral. It can for example return -ENOMEM if it runs out of
memory as it tries to allocate devres structures. Propagating only
-EPROBE_DEFER is problematic because it results in these legitimately
fatal errors being treated as "PHY not specified in DT".

What we really want is to ignore the optional PHYs only if they have not
been specified in DT. devm_of_phy_get_by_index() returns -ENODEV in this
case, so that's the special case that we need to handle. So we propagate
all errors, except -ENODEV, so that real failures will still cause the
driver to fail probe.

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 3d55dc78d999..49596547e8c2 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -118,11 +118,10 @@ static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
 
 	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
 		pcie->phy[i] = devm_of_phy_get_by_index(dev, node, i);
-		if (IS_ERR(pcie->phy[i]) &&
-		    (PTR_ERR(pcie->phy[i]) == -EPROBE_DEFER))
-			return PTR_ERR(pcie->phy[i]);
-
 		if (IS_ERR(pcie->phy[i])) {
+			if (PTR_ERR(pcie->phy[i]) != -ENODEV)
+				return PTR_ERR(pcie->phy[i]);
+
 			pcie->phy[i] = NULL;
 			continue;
 		}
-- 
2.22.0

