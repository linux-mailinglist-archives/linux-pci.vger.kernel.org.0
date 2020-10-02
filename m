Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CE281B40
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbgJBS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59433 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388317AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A46895C0164;
        Fri,  2 Oct 2020 14:48:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=FYJAyl/MCQ7ZZ3uczTR1M/sIuCBUsCHpedex+XRt07c=; b=TRHXa
        DSXC+yyGTGixVjy1uTe9VoOe2iqjmLZSG3ILCvh+3uoDVSuj6DqynWicC3GRtoIK
        LpIea3QQXwAHRGv0ZlMxewQrOh0YCICgE5pVf3P62CqDCwLoDx4Cx+W38Q2l12fC
        5vcAD8L/nx/fiUI5U710tEkgE1FNLbDLgwaXIjbdmJe0ttst5Lt0EYMu7nahsuq2
        RXQ4wotB/kQckRIbY6GbOaeWPYX0Nu1gFkZPuLGtIPQn0VQ3Hz1cW+jgx/jLqYDu
        v4J3+1o6ZgaWwGPnfyX8Aq1kxIfP7/YRlwFd1vGCaZ/cLrwldtWmnUmxwPhZElXg
        xhbpt6/+LPePI4VBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FYJAyl/MCQ7ZZ3uczTR1M/sIuCBUsCHpedex+XRt07c=; b=LPcxwMiZ
        dBZT8zELBc7/LiScvuKSHpa1iNmnkm7ap9jH3ts0PzYxrEQYy9Cey6gEbWRtzE11
        fvDIbmJ6Rgof7hpBfg/2DuZpK8oikPNFZWY0K5VTN6dzNKXtnyfk9/l9bhu3oig3
        5bS7I0/vGhxS00ZauY27c9mMXq5rpG82sKgGlQpF0lbVeEYZVudVw6CeOS9ZJ0Qf
        1uqPQlcQ1IbSNUp4zGPyJRdL6DtNanuarCL63HTnV9ykgoQ/QbmHoJtc5E4qPzl/
        167WIShR9DXcEcXXquauhXX6y/MN7GQPns0fnydA4Iz6bXYpo0KugTcc3P4UH2tw
        3mcNqrR/qXeeOw==
X-ME-Sender: <xms:9XV3X8tbEe7YP3lQK6aFIOU17yjQenHblhxPwRE2NM4bM7iymqYGlg>
    <xme:9XV3X5eT9uabIJcCxZyNtO76WwzKO096_1NlySi7cvLe7cnYs1kGU14hwYpzEb3hO
    qhju6Y9xIYiqs-Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepuddunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:9XV3X3zZKtizykha2ogDmCQk793KN1b0CeuPUmTf4m5W5gS1Imco7g>
    <xmx:9XV3X_Nt19T_XZe489dWeDqgXx81vtfRGA10WrKo_j8pIjmNZwQ4qA>
    <xmx:9XV3X8_myX707CV3INNWAXvyiyQ3t0cXc2FC1cj9ZErVwlsHFF5QMw>
    <xmx:9XV3X5MxmARTZfh3J7E3KwwQJm12LKTSEicOmMFfiHy72e8aIGcBqA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id F3352306468A;
        Fri,  2 Oct 2020 14:48:18 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 14/14] PCI/AER: Add RCEC AER error injection support
Date:   Fri,  2 Oct 2020 11:47:35 -0700
Message-Id: <20201002184735.1229220-15-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Root Complex Event Collectors (RCEC) appear as peers to Root Ports
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

