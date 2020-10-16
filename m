Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3B28FBE8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgJPAMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:25 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40049 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733098AbgJPAMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 53D6920D;
        Thu, 15 Oct 2020 20:12:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=XkK+qMthRd2q3piqOztQJ0jErvOUh6+Ez65ELTAOptM=; b=nlKBS
        Rjchh7XxtEpue4jLKteiPj70u+bpig0kiTnZwY1pzLJzF5TC/frpQ/LHPgQMTSv2
        0H5y133xTvj5K99Eqb7FNv43/SlzTZyb+06fewW4E2P8eM5EDcl4WvLQls81Yq24
        jRsbdE6aEYTCBoUTflqGiuiU1zSyOvbsQ4SAF8oC6B3NeUlI3z3NJc81w/g/nKdz
        3zTznakZl/HoJdkuWoQI7t/lWXtjVt0FI17yigaVayrAaBjpx7JtUYs24njphp25
        6r4Fl6boey85DW3s8tegrDl+66qgVCRPK+ioIi95y3gWrPRV8nFnGRI2jZpLSDEw
        E5q6RWo+TgmJxEjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XkK+qMthRd2q3piqOztQJ0jErvOUh6+Ez65ELTAOptM=; b=lP6xA7tR
        5l+1dzFmvKSLuzxCtSNZe8+cIbgn7EOrbKF65raKc00GFZdLfHIzFjOVZtX9UHFM
        hmgq8VUwEL9VOCWokr8mKYHQO2mPZq+15SVM2OCOFQdhNAXPat9vcPHolq5KC9Jg
        6YH9RsTRWlal6mSeh3cjWwFSdLb6t6EimQbWLslg/hGlnwvDhiLhH89QIlPHPwHb
        Q6HJKPecDYBTSF1H6XHcTrcHLP+4U2CKoByL5vC9ANb9JpLMS4bVlIkS+Jns02jW
        95cOQs9VUHsowLi5+brg8TQiAj9slXkibfTmGofdXO5EoPz7+nePbmCKDChDJHrz
        E4mEx16c0Zr9mw==
X-ME-Sender: <xms:YeWIX8xIvsyMEi4VMcw3vYsEhgvns5kMdHL55IoVA8DvajuA5jRHoQ>
    <xme:YeWIXwRjcm515grlAawm-lhgByGKkxIUK3kcdZteX8HY3O9l3eqK0uIzuOykOK1fz
    w-ya73hOdShnczF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:YeWIX-UYuoJGasP_indGItLY-wAt8Kpkqc2f26NHRx977n9LIrj46w>
    <xmx:YeWIX6jDmanhwZArDve-fXqzLJNACBThesizIDYCyCHeCQwtivPprw>
    <xmx:YeWIX-ACZacKWnngXspZ-WrDauwfZl7fZNo6AlMwWgewNZCPUp-kSA>
    <xmx:YeWIX0C2CkDXTXy8DHV3yzu-5ceEA0YZ8PwiqwyLRniT-aKPEbweXg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E9B7306467E;
        Thu, 15 Oct 2020 20:12:15 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 02/15] PCI/RCEC: Bind RCEC devices to the Root Port driver
Date:   Thu, 15 Oct 2020 17:11:00 -0700
Message-Id: <20201016001113.2301761-3-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

If a Root Complex Integrated Endpoint (RCiEP) is implemented, it may signal
errors through a Root Complex Event Collector (RCEC).  Each RCiEP must be
associated with no more than one RCEC.

For an RCEC (which is technically not a Bridge), error messages "received"
from associated RCiEPs must be enabled for "transmission" in order to cause
a System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

Given the commonality with Root Ports and the need to also support AER and
PME services for RCECs, extend the Root Port driver to support RCEC devices
by adding the RCEC Class ID to the driver structure.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-3-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40ae1ab..4d880679b9b1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
 	status = pcie_port_device_register(dev);
@@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
 	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
+	/* handle any Root Complex Event Collector */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
 	{ },
 };
 
-- 
2.28.0

