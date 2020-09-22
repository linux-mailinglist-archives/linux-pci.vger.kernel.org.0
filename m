Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565A274B6C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIVVpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:45:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58151 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgIVVpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F0C85C01C9;
        Tue, 22 Sep 2020 17:39:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=ERnpPU+gIC6hydkrdvGearFQ2eli18omiMWIHaoJwrQ=; b=cAmeS
        XXSEfcV5mIKhek96Y6PY8VtdNZ/EX0Q+CG+uFXrdakw/F2BPsdpBYetlvyhA2JfR
        TzPzfby4c0B0FdCPLRCD3F3NFW8lLCDoV5Vwk10lhV+wvGCAC188fkueisO3g3Zs
        OR6IoZ6r534X+f5kW5nWdt1COKmDJDPMwz0J9zVn0f53vYhIUjOcKxyKZGNReVjO
        75Y/lvM4kIakcnTeX41o4SNLguTg5pJKQYwsZHT3MGNEX+UA0b5AWgdsnqpYa1lk
        CNbaFAGlcsljsthYFhrnDPVWMW/QsmpXxrAkw4EY7Sf6jPmkPiGJ2jbjUJWoWJbs
        aEADox0zWHULzLd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ERnpPU+gIC6hydkrdvGearFQ2eli18omiMWIHaoJwrQ=; b=g2CQofjz
        G+aVr1kdoteVyLLL14QPVoUkMa9orx4qI5QlyPoSKdP4zMLF9SdKtshUYzYqrTP4
        xUOD+pjAzN95HWWtWdPhT9C0E2a6dy05R6jy5QzBYPhUXRir83meGG8kSdY6SBzJ
        7X5WOi4K84DB6RoVtJbRzutAs4IPZ6xxspkuUu/rBpay2t+N2y7q4zkaKhFnDbuf
        y60+M8rWpPFg3sU7j29R0T0bxtY+ylpZ+pA654B5CH/ZJf/OkiSUaEETTwbgBU0c
        yb7NWraAiT2vbYDbWvig57ZaST3FWDr7IhH1ohg2G24Y8Rfg3fqzyUFqR4u6PHui
        Gds+d7RnuGF9tg==
X-ME-Sender: <xms:EG9qXyuDKWNnAI83yVuFcghMG5fOwriE2nyuU92pk1uuDF9_7c02XA>
    <xme:EG9qX3eXHwId5Tvkh-zQW1gfDL1FsQ36w6GibQaIFwMye2j0GNy9NpdridnJSgUNc
    _7c3spQHwAI_UdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:EG9qX9y_nBRjsKtiIjdxw57-Lyw9mK_5vEF2YJnhBiYgOsnf3xuEAw>
    <xmx:EG9qX9PE0Ib9myGDyKne5FWwFkNMedTbAOTrXBPY4ua9uekfkCMOvg>
    <xmx:EG9qXy8kgaD_KlNDTk8oPg5vJYbC19FBo0pAzpQ62kFhoCpD9cq-zw>
    <xmx:EG9qX3Ptif0-U13I-iB-MWTtfI0HXunv0PSZg67N9zhkGW1ybKt7GA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEC073064682;
        Tue, 22 Sep 2020 17:39:26 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 10/10] PCI/AER: Add RCEC AER error injection support
Date:   Tue, 22 Sep 2020 14:38:59 -0700
Message-Id: <20200922213859.108826-11-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
and also have the AER capability. So add RCEC support to the current AER
error injection driver.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c2cbf425afc5..011a6c54b4e3 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither root port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.28.0

