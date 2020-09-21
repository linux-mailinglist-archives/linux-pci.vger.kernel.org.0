Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAD2734BD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgIUVTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUVTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 17:19:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513CCC061755;
        Mon, 21 Sep 2020 14:19:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so14428524wrx.7;
        Mon, 21 Sep 2020 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aErC566HEqSRvdJslRlyUb0c8FokyCT59IKrcXAfu4=;
        b=sHKrLTGEGIa6Zucq882TmaXZP67AldKWzzzNFviFkhw8wy9dWnOET5rVVOgP0qogAL
         GhivdlayMQKjNWIJJ3DLRPbYmmZ2/hs9b9bvxElov3PmLJwN+Kw5aBOutZvT/lE6KMNp
         9BDI9UpXL9ND+tQiFcy0QoBvDvNUxBGtfOYSt3efw/yK57yR+ZOrYU2UiCLkJbWQviLw
         msKLopa4Nw4SIF1Q4Hkyd6ljIkubTOvTjKBYYedOWHxI4BuPShjbTOihI4H2keYAjhJH
         iy9IT9IluUfLE//9SHKtAiPJfnQPqOtOpJT6V7+gYq/9gfhQbeJCaao8JAB2+K0i6BPW
         IsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aErC566HEqSRvdJslRlyUb0c8FokyCT59IKrcXAfu4=;
        b=qACApt/Ogs0E0SHiAcWPSRCLg5tUxJ5xTCW6TxXnU11M1c1PHaoT882Kgp7yOJPEAc
         IzHpKUHvhSOXL8P8wki2ZPuqUhhwuxPPVql/SWbyB7i3FvgR11fQXGuwaD78CmLbSoRF
         ocqoiD17qQ7+RcFgm5zuhJ4HEEzzXqmwtP9B7HwSDETxCvqi2OxHK5qXQaZHcHxDEYrG
         gZAT1mG8K4f3bjjo5j/KoDOcYDYffu/FmYb9QpZMQHhTjmWlVlNzw2j4EYwKViZdzZbk
         GZ27NMRLGyzq4vOsSdgXcm+0dYF7i/2ppOexZ4A6cuRYpoZdI1mPsf7LgajLkKeAxbpt
         lDfA==
X-Gm-Message-State: AOAM531Epbpkf1aQX3ar9zh7r+pXuUgkZd6R++RMgsdfW7IR9rsQ2N8+
        V5e5XqkGAS5x1vABKRzZ7Ks=
X-Google-Smtp-Source: ABdhPJwL+qgOM4mOwnX0G6peBtuRhX95dExnYOhp+TnsTuD6nUVtT1V5CBzcuSAhO+w4J3ZJhcDxvw==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr1703697wrn.236.1600723163940;
        Mon, 21 Sep 2020 14:19:23 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id k4sm23325699wrx.51.2020.09.21.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:19:23 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: brcmstb: Add missing if statement and error path
Date:   Mon, 21 Sep 2020 22:16:24 +0100
Message-Id: <20200921211623.33908-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CA+-6iNwJt4zq1fZv5ujsUJqTs_kcvF9iAcLRp6rtQudwm5CfHA@mail.gmail.com>
References: <CA+-6iNwJt4zq1fZv5ujsUJqTs_kcvF9iAcLRp6rtQudwm5CfHA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

brcm_pcie_resume() contains a return statement that was presumably
intended to have an "if (ret)" in front of it, otherwise the function
returns prematurely. Fix this.

Additionally, redisable the clock on the error path.

I don't know if this code was tested or not, but I assume that this bug
means that this driver will not resume properly.

Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
Addresses-Coverity: CID 1497099: Control flow issues (UNREACHABLE)
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
Hi Jim,

Here's a new version of the patch.

I added the missing clk_disable_unprepare() and assumed that it would
also be required in the case that the call to brcm_pcie_setup() fails.

I didn't follow the suggestion of adding extra braces to the
if-statement as the kernel style is not to add unnecessary braces in
this case: https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=style#placing-braces-and-spaces

Best,
Alex

 drivers/pci/controller/pcie-brcmstb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7a3ff4632e7c..8bae3a4f8e49 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1154,7 +1154,8 @@ static int brcm_pcie_resume(struct device *dev)
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
-		return ret;
+	if (ret)
+		goto err;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
 	pcie->bridge_sw_init_set(pcie, 0);
@@ -1169,12 +1170,16 @@ static int brcm_pcie_resume(struct device *dev)
 
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
 	return 0;
+
+err:
+	clk_disable_unprepare(pcie->clk);
+	return ret;
 }
 
 static void __brcm_pcie_remove(struct brcm_pcie *pcie)
-- 
2.28.0

