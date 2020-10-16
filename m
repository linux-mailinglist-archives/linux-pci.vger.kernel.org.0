Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6418C28FBF0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbgJPAMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:42 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42513 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389795AbgJPAMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A159AC0D;
        Thu, 15 Oct 2020 20:12:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=nyBbTyXDf3mqxE2/pZf0BxJ4TGB40IXyTT523AFOsZI=; b=J1D6k
        GgzWexZu/3n7Jql4gEoh3wTR+SZE1IgYJ6nTyOBCyZbbtaSjQhvdtoTsTKiok7q0
        Swivwxy4O0C7rNU2zed+2d7CQiRF1B9GZvuC5A6r5ss2yX2FO7rL1lQsCJ4vhj4W
        4MeJMF6XYP9rL3XZtnbH5qD6GMapuxBhCFyHo+c4rX/mdFpn0xeTMMdoY2xvqFyk
        1MCQ1YloALFoRskO2cFlnjFwvKZJ6IoWBQKhPN25kO47DlA/h/kKrgTKRc+2T05J
        eNFsJAV4uSdph9s3WJc2HH2WsyM2YnVuNuHKbyPS75Z+wb7KRIo4/j15zXh4n58b
        qt+xMbpj8eJSsHWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nyBbTyXDf3mqxE2/pZf0BxJ4TGB40IXyTT523AFOsZI=; b=JxDvwG8C
        YixRWruYLieByU9vsRo+wbXxvWQnFqsESJyChRUpC+qgxA7bkF3di1rJ/ATy9RLq
        kkKBf9BARn2mm6FyY7GdAQXTJWXQwZ0ghCT6UqC0ENx+5iU8kFCguKI85DqXsAjC
        Yl5EuO9PF2LD0wXP+g0MLiY4OxZssDjciQ2bc78IinTbgSiGfNEmOahTx0xLIIc2
        Kkcw/LmyGt39MhqzcvBS9RHWSQ+belJlq8LFIlG1f3gXii8emLbjoGCLxL5GtkiP
        GTGc/OoVHiOYNwjBPyfUtc0w50/MAB983HO3krqt64GtnU3kkhLLEOIvNrROgVWj
        0hZYcM6X47f6ew==
X-ME-Sender: <xms:deWIX0E0nb7dpcIlWg7A36d45oKIUH-74AkEqLnGz3Qi6YTxRPupzw>
    <xme:deWIX9XBwzdGMlG9NwoNEr9vV3K6kg-PXZgIIfzmEgiROmthD9gQmbrHm0yHzDh8-
    RmhKjMWzJ9vP9_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:deWIX-I9O_yb9LGTDXf3kUQy4XDjPX9hWucahZ053LUN4uqt_S2ITA>
    <xmx:deWIX2HRDezLEZJEBRz9QJ-RX4gCCblcIerReNr0_uq9bXCu6GPfAw>
    <xmx:deWIX6UQr0umghZ9VJ-CeYrnGJXLTMPsFqEJLz1nm07pLp51RZYOrg>
    <xmx:deWIX1FrJVdzCMMm6ip1qr0TkGlkqEiWL8HDxALOU0K64u3H9JB0Wg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id E94FA3064680;
        Thu, 15 Oct 2020 20:12:35 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 15/15] PCI/AER: Add RCEC AER error injection support
Date:   Thu, 15 Oct 2020 17:11:13 -0700
Message-Id: <20201016001113.2301761-16-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Root Complex Event Collectors (RCEC) appear as peers to Root Ports and may
also have the AER capability.

Add RCEC support to the AER error injection driver.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-15-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c2cbf425afc5..767f8859b99b 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root Port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither Root Port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.28.0

