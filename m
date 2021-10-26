Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE043BCA1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhJZVrp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbhJZVrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 17:47:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85BAC061745
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:45:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g141so729543wmg.4
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mccorkell.me.uk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5BANdJasacHOlv1Y3jKJEwW4gL6pMg/y757jVLK2v0=;
        b=Q/oQ3YD0D4yJmJQahFpnnu5HcQg+GkAfeZP3LOTfHXANqxFF0khv6qTyqiM43QaOR5
         Wv67CWwMQKaczvpCFDGQZfWFpFU6aKkI5hR4jHRydKIBcQkFwQYr6KDg2NYINhVYqKJp
         b0cGx03zaUiqeAs+/oY1Dyb6xnjn5cZkrOzez3btYb3Qh+OUfNiIFZlJyBM/7QyHtLDK
         8rFpULYC9DODc09MoAEexv7pYRiyt8JTx9sdEIp6XP18/mEBijohIkk8Ug7pdM1WVIPn
         yQkErmAOcTnDC9ETty+btAwH//qHRIuiNn56Aj3xOTyFXYuG0lgtN+EhW55uUoDgARgE
         IK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5BANdJasacHOlv1Y3jKJEwW4gL6pMg/y757jVLK2v0=;
        b=hdV+ACB8PS1MEwsWrhggL64dSLQu2PSu+g1V07PAqhY6m01ha3QcTQWVnxqUCtfHUa
         9PkuzDicbYNO2CpaP+HU7VCL8AdBvRJGL6+H7hicA9S6mNmklGpBb2mgicdoCYsCwSbW
         SabTVMuApGA8mPsX5t6bdUoBAzJp7L9mkMPSWDhYZy7RH+CR5m9nxMIolTyZelHQI1tN
         1JCKcLuOqAuj11Xc+h2YSQK1xYXgYto+JE0OcmBCvdUPOl+BigTnZ/B//FS9/ZNWG+Qm
         Lm1KKbMRphcz775TY/0Nwek4Wz6v2S0EsNf3+px2b1hL+buS7Ip7BSZ5pS0QmebZwES9
         Xxlg==
X-Gm-Message-State: AOAM533usq85fqYnNOQ8vGC2iYFyBfYdRSobihnshQ6RogKz46FpBnW+
        ObEeHiMzVRVXRLeLuUvX9IT9yLnnakxoWw==
X-Google-Smtp-Source: ABdhPJzywVq0TNx0C2WGaj6ZoOYmABJWAZ4CV+4E25l2q+PvkIdLMx91uLNLYbsD8M7rR5DiYNMz7g==
X-Received: by 2002:a05:600c:3649:: with SMTP id y9mr1418504wmq.170.1635284715058;
        Tue, 26 Oct 2021 14:45:15 -0700 (PDT)
Received: from apollo.. (cpc73842-dals21-2-0-cust781.20-2.cable.virginm.net. [82.4.111.14])
        by smtp.gmail.com with ESMTPSA id y16sm1400677wmc.2.2021.10.26.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:45:14 -0700 (PDT)
From:   Robin McCorkell <robin@mccorkell.me.uk>
To:     linux-pci@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2] PCI: Limit REBAR quirk to just Sapphire RX 5600 XT Pulse
Date:   Tue, 26 Oct 2021 22:44:59 +0100
Message-Id: <20211026214513.25986-1-robin@mccorkell.me.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026212835.GA167500@bhelgaas>
References: <20211026212835.GA167500@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A particular RX 5600 device requires a hack in the rebar logic, but the
current branch is too general and catches other devices too, breaking
them. This patch changes the branch to be more selective on the
particular revision.

This patch fixes intermittent freezes on other RX 5600 devices where the
hack is unnecessary. Credit to all contributors in the linked issue on
the AMD bug tracker.

See also: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Cc: stable@vger.kernel.org    # v5.12+
Signed-off-by: Robin McCorkell <robin@mccorkell.me.uk>
Reported-by: Simon May <@Socob on gitlab.freedesktop.com>
Tested-by: Kain Centeno <@kaincenteno on gitlab.freedesktop.com>
Tested-by: Tobias Jakobi <@tobiasjakobi on gitlab.freedesktop.com>
Suggested-by: lijo lazar <@lijo on gitlab.freedesktop.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..1fe75243019e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3647,7 +3647,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x7000)
+	    pdev->revision == 0xC1 && bar == 0 && cap == 0x7000)
 		cap = 0x3f000;
 
 	return cap >> 4;
-- 
2.31.1

