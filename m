Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8163128FBED
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgJPAMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:38 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50267 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389671AbgJPAM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B0CB920D;
        Thu, 15 Oct 2020 20:12:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=0c/JONLL/FRrSvwQ4PVvmvGdLpt/b1FZX+mwA7CeAjQ=; b=pk3wQ
        DsxLtW0RrZaGwTiZ2D1i2ovvGHHXoPeYINXKb5VbFynmpO8roft/UCTqFkdkT+jO
        GRcJ21X+ArcbWjIQ+gZ8lmmA0R3Ev1dV14zGm1GqBN75NMmheqDJ6I+A1u9dft56
        SDLrPjq7qpiJ7TejG1aRRX8Grx1UvPxNmx8Z91tLt5KZBzpj4GYsaDfICU9LdBbj
        JQyeoWPz0vTdKv/6nzfpewyFBGn8iCkZntOE9PydYmSyQZh9O9p9I+OjlJYlAkWY
        qAw17A9PBXlIUN+ZLEe7Za/3d2rgUtxYDpVO7hxkPV86nIT/MCsbl46AhAl40vL7
        EL5dbq7TJP5EHYLAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0c/JONLL/FRrSvwQ4PVvmvGdLpt/b1FZX+mwA7CeAjQ=; b=rMTZbVGf
        Edd1vrClHq45ysuYvZtD57GrawYGjXV2ynTkyf0X3vfENn8yWInTY8ug4qs42MSP
        W/9Hx1M02GbYzq9OUV9V1ywD9PVfgjBANylYGykv1T6zL3Ji44u1F8XtVKw1ZvGp
        SaMj+o13D6kYz+321eNwz5SQWdPKIRzwrTLq7fdFsKL3K2Cii8YfJpoh14Tai/Zr
        U1KE5ryZaJy/RTHIYlB8nGCxsiNKJ0NBA15/lxgbqeD9BvxcyYv4kiJL61j9HZv9
        Z8/HfrcSsgaBgXdeO7novcCPiVQzQ9hCXeooGrHbuB9g7JuED0ADSoyvJH8L+g+v
        toX7iWCsBEExMw==
X-ME-Sender: <xms:aeWIX8eKSpCW2Y4-5dgCH8VWZtvm4csAV8h8ilXlwQhl0HqYK_zt3g>
    <xme:aeWIX-P81TFecIp8u9Q8jiD2w7UhHVZ0PN0UApyfR1GnRFHKRKUpifFN-wZuhgK2I
    kK6LXy1vmv0Y7DI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:aeWIX9j29Gu_jay3inzpfssdSzxmGBysUEhleY3Ij7ke2qPGWOZkpQ>
    <xmx:aeWIXx-WFjEw8C-YMcgp4epajH87AJxtXtrBkv80FtE6WskidjR3wg>
    <xmx:aeWIX4uJVbR6bHh6eVlTi0Go_ZZ-nfjBZuFzdmxialfQTNAt2D4bpA>
    <xmx:aeWIX9-FlPwQ7oqhHxqQtUTs-5eQpquTh_Wa8MA1hHPKbFpx1ck3yA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F3EE306467E;
        Thu, 15 Oct 2020 20:12:23 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 06/15] PCI/ERR: Simplify by computing pci_pcie_type() once
Date:   Thu, 15 Oct 2020 17:11:04 -0700
Message-Id: <20201016001113.2301761-7-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Instead of calling pci_pcie_type(dev) twice, call it once and save the
result.  No functional change intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 05f61da5ed9d..7a5af873d8bc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -150,6 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
+	int type = pci_pcie_type(dev);
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
 
@@ -157,8 +158,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * Error recovery runs on all subordinates of the first downstream port.
 	 * If the downstream port detected the error, it is cleared at the end.
 	 */
-	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
+	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
+	      type == PCI_EXP_TYPE_DOWNSTREAM))
 		dev = pci_upstream_bridge(dev);
 	bus = dev->subordinate;
 
-- 
2.28.0

