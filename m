Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A186328FBFC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgJPAMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:25 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38887 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733125AbgJPAMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 88738B81;
        Thu, 15 Oct 2020 20:12:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=rYsoGqpbGrYNUiZzaVhW/OUq7d3pxR23cqJ5TDYlAfs=; b=Ee48z
        mZ1Qtmpzg7AQbi+VPMEPPButq/903FgNQN/sh/9BIgXWqt8pBd3SBbPvQBrOGhhG
        29DYIq4TTtNLq8iJW6NeS4T88uF7gBfx5WNaUSGNuLWuUjd52uiMcAETXRrT+8Tw
        whqjnx/u0+UtEzmHFPtKcVegnYtA0JEGlaA//RKH5yMJvLf6qvW0qV54+EJwEDfA
        7QzX7l/Z4FAQD7Lz44QKJM5wUZii5qtjweF1cBfyPqwnYH8GEd4mvUpgTOYyLle3
        uOGlKPTTAHNijI3or7lyxJXI8H5NBohk6frjbcS692Td4vaxi2R92kuPVmOnQaVp
        4HLLPbBEKAvLO6G+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rYsoGqpbGrYNUiZzaVhW/OUq7d3pxR23cqJ5TDYlAfs=; b=TT304In4
        Heg3chvzst8+0GFH+3vLqw5nSVXSfIIcwIzWVSCWyYnc8ELKGyBbJSUWaLPOUg4q
        w8+oV/Gm0iQx2RVj9HanVnJhh7so9Ri/Ye12fWI2LWIE2vPplnbUyWLMUb9L5HJl
        WOQvLpskJD6vCl6mGlNXjXPZkrGBeIiUFYV3YfXzQQvyNelRVVmODacNOxVOCb+9
        w+Yu+RP2tSIGghtelu4Kp0IEslKng5dzXIpM3NTUkZnfxIbLVoj9KSZFEuB4NsAD
        nrfOAEhpLI3MWtV0rx2liC7GV4azACkCOF3OythJq/DU8Ca1LbKt6Q7cFZGKWqtt
        ozawl+Dlqxz6Ng==
X-ME-Sender: <xms:Z-WIXw_xdDWCuysCMLcz1xZ-YLtxNZ2KW1hNx-u3yGvXUZxVsKkkvQ>
    <xme:Z-WIX4s5KFcDg90pw2NKjdafOzZGSbEc4KkS7LfTUdmeAnMhPUXakXznBq5_dho4-
    OMjcyuVr1IhRj8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:Z-WIX2C6V83ySAQp7Ml-QQDxRH7zyRyNx5pbztAhiRp_c4FMFko0dg>
    <xmx:Z-WIXwcHMJXtEQq7R9-qpabMynE3UpVuLf8DbQeDvkCI4e-h8kQcCg>
    <xmx:Z-WIX1MMe3RS-Inkk7NfyL6F6TpQeUMlI1ohrx-xeumrBTo5GsOqfA>
    <xmx:Z-WIX4c8D5fti1RA7RIjLQB36NhM6G3XjOj1l1mp_MWgY3XsPZbKFg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A97A3064682;
        Thu, 15 Oct 2020 20:12:20 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 05/15] PCI/ERR: Simplify by using pci_upstream_bridge()
Date:   Thu, 15 Oct 2020 17:11:03 -0700
Message-Id: <20201016001113.2301761-6-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Use pci_upstream_bridge() in place of dev->bus->self.  No functional change
intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index db149c6ce4fb..05f61da5ed9d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -159,7 +159,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = dev->bus->self;
+		dev = pci_upstream_bridge(dev);
 	bus = dev->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
-- 
2.28.0

