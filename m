Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290F128FBEE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbgJPAMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:42 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34129 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389671AbgJPAMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4FFCBB92;
        Thu, 15 Oct 2020 20:12:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=sIt2uYHfTnWOvqnPuSGF1myLLYizqRlQ7JmPCjDR9o4=; b=b29+s
        OBGaeUyjG+sn5ssyma/1x48RGrz1IyHPl7z7lceZTMU3inon9E47B/hgtdQpZPWJ
        2rkErQgZn9i4IakE6beX9ynBIDlJduIm8+6SQx9aQ1H2lKnjjNnpQyz8OWwfxOo1
        pB9hJKs95K+uAM9/Foc8sHuOq6zcnJvx1V/8kqxWm4CjdNAVPGgGyk8uWB8sAPHm
        97OsjQJq6gdG3aTAqUc1OYuXS1oEA5waQdnsXyF0fNytDUmseN0rhaLETO3ZSDsC
        8yaRrB3ruAoyEkqL/NO+UBxolCE5L827FMGmlzksWTOrB1oHquXjAqkA8nHc01cQ
        B5yb2Rr/1YjJOALgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=sIt2uYHfTnWOvqnPuSGF1myLLYizqRlQ7JmPCjDR9o4=; b=E3QcARHX
        eJ+B1VXFV4GaTT25FvmpVb9x7qDDB/9QTF0c0wrObB8FSki3IUYHv89eChuVXZMf
        7nALzUT7joN0PmcOtn7IHU6wJBI6lZD+AoLb8qupxpuN5RLwosuxMP9mynZyZmpC
        HhURe1RDRXicPXaHGKC71pK2Ml32z2klB+12UtQJ3BTPApuAjkJQ3S/9L94PtDON
        HhqFh8xU94gU0RPp8RVcfXWeElm0MO4PKHdRLok3lFt31NGjujAoh8Mp5zGpiizZ
        A3MRmssW8Dc+l7YaURls3sdTBopJWlUH4HLyctAff3kt18eTQOV6oH1wBPVYJtpB
        Unn0S7s61uBVog==
X-ME-Sender: <xms:c-WIXzrZLFLc37bC_qrKE8xhosWL4NnEAB_bYLubD37UAAlY08lhVQ>
    <xme:c-WIX9q1sB27bNGgpYuaWslX7px048h-8p2QM94YAEu-5vgSApWdaVHH7XGxupONj
    AUCK5Zn2Xid1LSH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:c-WIXwOi9w9xFLUbpaxCmUBoM-4rttLa6c9M6reTYeCURVzzy3cqEQ>
    <xmx:c-WIX24ZpoGEeQ93ggIu6BrAXkfuT-tdYC30cfFwsfcyJFlmbtCsPA>
    <xmx:c-WIXy5sPYBU34-74d7JIchkrIw4tOOa8UBXsm-XyZ5VGuKK3L7NFA>
    <xmx:c-WIX5ZqewQtPbGosuVflCJc8QeJWVwadg8bk6GUegNfjoV7vsME_w>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 993D1306467E;
        Thu, 15 Oct 2020 20:12:34 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 14/15] PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
Date:   Thu, 15 Oct 2020 17:11:12 -0700
Message-Id: <20201016001113.2301761-15-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Root Complex Event Collectors (RCEC) appear as peers of Root Ports and also
have the PME capability. As with AER, there is a need to be able to walk
the RCiEPs associated with their RCEC for purposes of acting upon them with
callbacks.

Add RCEC support through the use of pcie_walk_rcec() to the current PME
service driver and attach the PME service driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-14-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c          | 15 +++++++++++----
 drivers/pci/pcie/portdrv_core.c |  9 +++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 6a32970bb731..87799166c96a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
 static void pcie_pme_mark_devices(struct pci_dev *port)
 {
 	pcie_pme_can_wakeup(port, NULL);
-	if (port->subordinate)
+
+	if (pci_pcie_type(port) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
+	else if (port->subordinate)
 		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
 }
 
@@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev *port)
  */
 static int pcie_pme_probe(struct pcie_device *srv)
 {
-	struct pci_dev *port;
+	struct pci_dev *port = srv->port;
 	struct pcie_pme_service_data *data;
 	int ret;
 
+	/* Limit to Root Ports or Root Complex Event Collectors */
+	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
+	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	data->srv = srv;
 	set_service_data(srv, data);
 
-	port = srv->port;
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
 
@@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
 
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_PME,
 
 	.probe		= pcie_pme_probe,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..e1fed6649c41 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -233,12 +233,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 #endif
 
-	/*
-	 * Root ports are capable of generating PME too.  Root Complex
-	 * Event Collectors can also generate PMEs, but we don't handle
-	 * those yet.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	/* Root Ports and Root Complex Event Collectors may generate PMEs */
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    (pcie_ports_native || host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
-- 
2.28.0

