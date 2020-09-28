Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1D27A515
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1BLp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1BLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1793C0613CE;
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so6844033pgl.9;
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jnJHULZko1WMf982dRYBhdTPK/IAC09MFg39qDolqYw=;
        b=Dh46LfDcCNj7eSPkEt1pEhl2fpxYl6gW+mG8Cc6YUjWmIQXmWoHkY/LVXUzBgwWCxj
         q8Ewmz4pkksibq9f7Qx9u3Tuv1JZKhXVIEtY+Fg4hmKfilUrmVi7UF/hntkNrcXK7tJ0
         OXWVJyeL0HiS347UWqqHtEayxjKn/asuIqUUptL0wm4V6mhQQ4aFlB1bnX0Mrr9CEGuQ
         aayUI1pVYDF3QlSGpRQ9rrJD2XxWy5ypxGiSi1zYXkWjQpDvQtYmFTwTr+Oofkc13tCL
         xHBm2PWFu51YhYpMmlTFPYfuwpcVqYhAIaYuOvwpFuIeT6Ck7oTpggTpVTqMgSxKgDDJ
         F7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jnJHULZko1WMf982dRYBhdTPK/IAC09MFg39qDolqYw=;
        b=J4nDaZSR1f/owhMpGjzHmWV1G1dYjpdFHG7faMEmyEJi80YbNSCRumfE/npSnO3aY+
         EFafDoHq8g7mRiCR4OxJstpzFQcby+QY6DdDMR9VMzhEXHpAFBBWRYf5dQLTK+xZsT3n
         Y9qucJ1BVmpOVIIpsSjbWvK1BRvgct89cBu2KBwDc5+biRC28hj8L/6kBvIPCHxQSGJY
         UBhmfTJY5bu1ueWzkfD1brCWUpUxQuTnRtKD5YSF9sRebPlagO/NPRftknux24yZyZqj
         jr+pv7PFscucjn6iaLq+UI8JsgRy8rEIg2vZR4vFBBBmKwVyjerzc3XYThS0hnP1sMSv
         mFIw==
X-Gm-Message-State: AOAM533Q8Kokq2ijvaiTealP8GlSWzk3G7pw3f22BHPSZtE6ynV5Ux/n
        4zArNnfr4lOKeq1PLvUyClYh/WSH2apmzw==
X-Google-Smtp-Source: ABdhPJw4taYR14MYgwiiKKT/fgmtOU30T1hHvwb2nKN0oITv0s5yWS/tAaNazsLkKIqNfmgUT/HuQw==
X-Received: by 2002:a63:34c5:: with SMTP id b188mr3185824pga.219.1601255504642;
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 1/5] PCI: Conditionally initialize host bridge native_* members
Date:   Sun, 27 Sep 2020 18:11:32 -0700
Message-Id: <a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
struct pci_host_bridge PCIe specific native_* members to "1" is
incorrect. So protect the PCIe specific member initialization
with CONFIG_PCIEPORTBUS.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..0da0fc034413 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
+#ifdef CONFIG_PCIEPORTBUS
 	bridge->native_aer = 1;
 	bridge->native_pcie_hotplug = 1;
-	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
-	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+#endif
+	bridge->native_ltr = 1;
+	bridge->native_shpc_hotplug = 1;
 
 	device_initialize(&bridge->dev);
 }
-- 
2.17.1

