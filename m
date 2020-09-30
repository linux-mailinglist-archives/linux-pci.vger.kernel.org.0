Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC927F4A6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgI3V6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56721 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731239AbgI3V6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 19054C6B;
        Wed, 30 Sep 2020 17:58:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=ssHeaqMnPt5Gs846wLr7DIjg7Vyu5Ulfjnxp9FjFInU=; b=H7SPI
        Srtcxj9BaKzoFy8w4aoCx/ItdTTgYUoZyU4+CFcl+09Te7veQXuZoSL3puiN/Q94
        tcXhR6u3zWjZ7I8i4DXyBx5MwhcXZdEIr2iu/nIvQ/CklUX8QhUFkgJwIEw5HipI
        RS+vJzCweiQ+/jrcGG97tFLJcmZMmH90XKdNTag8A1hl57SLnIToKABkb4Bkeorj
        ItKCEC4FK3KSORCsqjiDayTqNhQZI28S+MNXA4xO2VqGke5JW0u513j9UfHb11J+
        z3oiYyZIikhZjVmfZSCF+ypu3daO2jRfG4R0Xb8aeDL34dH/MmMPvYluWguCXkPu
        /dtKLAXyYnkMpLV5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ssHeaqMnPt5Gs846wLr7DIjg7Vyu5Ulfjnxp9FjFInU=; b=MNbTCeEb
        5XAmgdTx5ohcQr2UxlOJsGaooYE/3UOgUJKm9x8q1vyMRUX5QSpE/exTgmr18aCt
        KI6Yex3n9nTBc0jvZU8l1xhfrg3GMTN1/81W6GHjwV8zQCz/S93eYsv3kPZVudHd
        s8vGospo093o3cUoEgXfJXQur0PDOn+LetF5ycqN1SrHTnyCmpuvyFR/OrIcEaS4
        88jKzL4nGrqtPzLXioc5phtiOoH7YjvnUCdRJPODVv/UzYzTKcFN/RFDZ98FJYxh
        JPG6HcoCi5QcPKepaKNpIHDd2kLm6alJLDYT8+bsf0yDIAWHy8ows+WRLFxprAJv
        PkolQ5gyaXvw+A==
X-ME-Sender: <xms:j_90X4QpsridiFILHjoo6YXNPfu6ayKajVT14AIRYwUbY7UnZebGmA>
    <xme:j_90X1xhzrpcaB4I2b2DMDvAoNgVXbEwERIIUeRLeqbYVVd-bEZrCvMQviR5_EBHR
    whDhWUhX0aX21l1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:j_90X110iHWyxYdHOgyGz2NhfAkEltt5-q2VbGjTYhdFIuWgJJ2aTg>
    <xmx:j_90X8CFRNSVfJD4l3m5sWtaCFawTNiAVsD28IiNp_c-FI9sC0XmhQ>
    <xmx:j_90Xxg3m_rDoraYt15j1Yh6Fm3301hxAw_jFmqPsVPvzgABI6O2-Q>
    <xmx:j_90X5j6QpuBMyThFwSizXKgU1mCYaIDZFAcEZXeoRTWnrKqJIrELw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40E083280064;
        Wed, 30 Sep 2020 17:58:38 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 06/13] PCI/ERR: Limit AER resets in pcie_do_recovery()
Date:   Wed, 30 Sep 2020 14:58:13 -0700
Message-Id: <20200930215820.1113353-7-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

In some cases a bridge may not exist as the hardware
controlling may be handled only by firmware and so is
not visible to the OS. This scenario is also possible
in future use cases involving non-native use of RCECs
by firmware. So explicitly apply conditional logic
around these resets by limiting them to root ports and
downstream ports.

Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/err.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c6922c099c76..9e552330155b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -203,9 +203,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-	if (pcie_aer_is_native(dev))
-		pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+		if (pcie_aer_is_native(bridge))
+			pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
-- 
2.28.0

