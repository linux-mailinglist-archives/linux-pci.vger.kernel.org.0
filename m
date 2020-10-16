Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7960E28FC00
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgJPANU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:13:20 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47461 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389741AbgJPAM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5E16FB5D;
        Thu, 15 Oct 2020 20:12:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=TzHjClAGwcBI+xdlIeWuQRRnt4We3py93TxvMi99f24=; b=Eb8Sz
        G86GlciFhm1UNB/JCSF08G7eMVjK7YGE/dh42i/MjTmBJMd9Go+D0Ul0K/N5MDaW
        49NdIxQqJ2YYo+hmGqiCankDTxVprwQ8t3ooXQO9FEqYxB6RrOITgMqsRyGgjmsa
        E/arp1D4Oo//OG+ACSEyhmTy8OyD7ZS2SGI+eLjOWnuJ9MMd4+U5WDpQnDTSygCo
        CtKBH/aLpDSd6C2FV6xgCiBChjUTgFGgiGio6eiu/tOHK+16ateVNsvIbuKDOH6e
        YwvhF01AmvFKyZUZEMTz/qiDkAUp6rBRnsyFlgn5EKzideQWlDLp+w0aFOk0TU1V
        IW/Psp7F3OVV/VfJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=TzHjClAGwcBI+xdlIeWuQRRnt4We3py93TxvMi99f24=; b=CpQMaTql
        kjv8THWmJLv6YmlpLeLai/z/Laqu7zwhD5Hhf7yxAKE/Y0oh7RuKza+fURXNksb6
        36XdyZhk5C69Ynwkwu8Kh3HFgcrOF2s679kz+CN0omkfZtTUeD8XhXXrww+U9A8s
        SlY5oHOh9Z/gGQM+ypFbrvKD+SIeFWYFvRwilmMYq0SLMg7sfncr4+oHqC9P/q7m
        ppgdO9lbMcLbzxMpfPla2+5wGBaHnmeLu4KOsGZWnBGhxg6H3qWcS8Vn1DRNRN+P
        oy9LrMyWK8ASOrv4VbsUz4ipllVKTNs3xvhQwVP6TAK5Wo5oAvd9sSG1TbeM4xU7
        +HwnYFDVpG6NmA==
X-ME-Sender: <xms:a-WIXyflVc61XwBVb0twzhGIl1zHh67uOdCLq2zqhWzhlRNe2rAP3Q>
    <xme:a-WIX8O3XWBA-aGTkDvmye9hSxDgFRdWPfb0oECV05EscTM1et0f4eBtLWjDc0aGz
    QIWwn1RLSR74VoH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:a-WIXzjIJLQh0O7D8Fh6oIXJ3sZxxgrtN2jwaSllRkBu2pxG-mRKXA>
    <xmx:a-WIX__7DijQn_eRvi5e4UUyjvY1uqeMkwxd6HxK1VIA5-pQsNsAog>
    <xmx:a-WIX-spIDIYyjYzK2f79A_OOgsFE4oWvoKeuZ-oCIxAUaLnNx0inQ>
    <xmx:bOWIX7-4AIozwanM7bBQRK0C8cZFHy3K3VlkBMu7qkkfxboIu-uW0A>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id A583D306467E;
        Thu, 15 Oct 2020 20:12:26 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 08/15] PCI/ERR: Avoid negated conditional for clarity
Date:   Thu, 15 Oct 2020 17:11:06 -0700
Message-Id: <20201016001113.2301761-9-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Reverse the sense of the Root Port/Downstream Port conditional for clarity.
No functional change intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 46a5b84f8842..931e75f2549d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -159,11 +159,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * Error recovery runs on all subordinates of the bridge.  If the
 	 * bridge detected the error, it is cleared at the end.
 	 */
-	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
-	      type == PCI_EXP_TYPE_DOWNSTREAM))
-		bridge = pci_upstream_bridge(dev);
-	else
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM)
 		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
 
 	bus = bridge->subordinate;
 	pci_dbg(bridge, "broadcast error_detected message\n");
-- 
2.28.0

