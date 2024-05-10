Return-Path: <linux-pci+bounces-7320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9D8C1DB3
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 07:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81902B22DBE
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 05:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD31509B9;
	Fri, 10 May 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu1ZJlji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E171635B2;
	Fri, 10 May 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318782; cv=none; b=ZpYjIArkE1O/ng6YrLYbWGPtamI4lsIJIAuRA5RHyTM22cwbuez+8fyIa7RIXd846hZ6I7WgNQE6LaUsvWbZwfGzM6dJCGNMW0+fE6JdJpuIPAUz79t1md5ET5rx1M3uSLKK6eOBHfrmbbfNBwWoSTgu5JHTPrgjcbX2Zq7eWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318782; c=relaxed/simple;
	bh=s7GnuaM+DAGfO01oPdNcCFYZ9nnThKfN0BTirWMJ1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYtoqnBhOACTlmwxf6xnVxT2ixop/7D2gtu8gWXpCo5pajY/QVJgo2B/I51AbvUtrgmBTljH2qBehYMWlHmtDK3Le/5wwYCrv1CXUvxaeChwmzHTIxVwA3Tontoyk8waAhL98kDJIxj7F5xn//XkeTcnu4KGTJhBtE1KthUyrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu1ZJlji; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715318781; x=1746854781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s7GnuaM+DAGfO01oPdNcCFYZ9nnThKfN0BTirWMJ1j4=;
  b=Mu1ZJljiScVPDsYoHFP840lmy+h6ekAg3LB7mPyZw33EpvRAdEVKTMj0
   t1516NwSK2GDfvVNx/HXvNHamPZzdu6VLVAg/+GBKvpcLdM4iJD+0BU1Z
   PiRk0iJKP1RQEjaw9t7lUnbTVRqVdXhxzHp273fK1zwIdLavwxsqADjpI
   ULQjolVhk/2KPBZpMDkayzX6zUuG0SZxkBMFXtZO+QsV1PBJkP9vJX586
   /yXdwd5XTUU95dZnopTOMYHujVmCQBFiH2CltbiBuRkMOG6GeKf4P7Mrg
   fIM0+8fH3ZgDaa/aN4kdZe8k11EAC/MlnCdegYoEdWkh7NLy+n6fDBfc2
   w==;
X-CSE-ConnectionGUID: P4H7eUIvT5qU6/MOk4u57A==
X-CSE-MsgGUID: CUN1EvIST1OQ63cv0hluUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21953105"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21953105"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 22:26:20 -0700
X-CSE-ConnectionGUID: bPJN/TMWR7yicxs40X0qEg==
X-CSE-MsgGUID: RSR06L2iTJu69BRESjHIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="66942671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 09 May 2024 22:26:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8ED5F15C; Fri, 10 May 2024 08:26:16 +0300 (EEST)
Date: Fri, 10 May 2024 08:26:16 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240510052616.GC4162345@black.fi.intel.com>
References: <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjsKPSgV39SF0gdX@wunner.de>

Hi,

On Wed, May 08, 2024 at 07:14:37AM +0200, Lukas Wunner wrote:
> On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > That is correct, when the user-visible issue occurs, no driver is
> > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > attach to the external-facing root port because of the security
> > policy, so the NHI and XHCI are not seen by the computer.
> 
> Could you rework your patch to only rectify the NHI's and XHCI's
> device properties and leave the bridges untouched?

As an alternative, I also spent some time to figure out whether there is
a way to detect the integrated Thunderbolt PCIe Root Ports and turns out
it is not "impossible" at least :) Basically it is a list of Ice Lake
and Tiger Lake Thunderbolt PCIe Root Ports. Everything after this is
using the "usb4-host-interface" device property.

I went a head and did a patch that, instead of relabeling, sets the
"untrusted" and "removable" flags based on this and some heuristics (to
figure out the discrete controller) directly on the source. I did some
testing over the hardware I have here and it sets the flags like this:

  - Everything below integrated Thunderbolt/USB4 PCIe root ports are
    marked as "untrusted" and "removable", this includes the Ice Lake
    and Tiger Lake ones. Whereas the NHI and xHCI here are untouched.

  - Everything below discrete Thunderbolt/USB4 host controller PCIe
    downstream ports that are behind a PCIe Root Port with
    "external_facing" set are marked as "untrusted" and "removable"
    whereas endpoints are still "trusted" and "fixed".

I'm sharing the code below. @Esther, you may use it as you like, parts
of it or just ignore the whole thing completely.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..38bc80c931d6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1612,6 +1612,127 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static bool pcie_switch_directly_under(struct pci_dev *bridge,
+				       struct pci_dev *parent,
+				       struct pci_dev *pdev)
+{
+	u64 serial, upstream_serial;
+
+	/*
+	 * Check the type of the device to make sure it is part of a PCIe
+	 * switch and if it is try to match the serial numbers too with
+	 * the assumption that they all share the same serial number.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_UPSTREAM:
+		if (parent == bridge)
+			return pci_get_dsn(pdev) != 0;
+		break;
+
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+			upstream_serial = pci_get_dsn(parent);
+			if (!upstream_serial)
+				return false;
+			serial = pci_get_dsn(pdev);
+			if (!serial)
+				return false;
+			if (serial != upstream_serial)
+				return false;
+			parent = pci_upstream_bridge(parent);
+			if (parent == bridge)
+				return true;
+		}
+		break;
+
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
+			serial = pci_get_dsn(parent);
+			if (!serial)
+				return false;
+			parent = pci_upstream_bridge(parent);
+			if (parent && pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+				upstream_serial = pci_get_dsn(parent);
+				if (!upstream_serial)
+					return false;
+				if (serial != upstream_serial)
+					return false;
+				parent = pci_upstream_bridge(parent);
+				if (parent == bridge)
+					return true;
+			}
+		}
+		break;
+	}
+
+	return false;
+}
+
+static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
+{
+	struct fwnode_handle *fwnode;
+
+	/*
+	 * For USB4 the tunneled PCIe root or downstream ports are marked with
+	 * the "usb4-host-interface" property so we look for that first. This
+	 * should cover the most cases.
+	 */
+	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
+				       "usb4-host-interface", 0);
+	if (!IS_ERR(fwnode)) {
+		fwnode_handle_put(fwnode);
+		return true;
+	}
+
+	/*
+	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
+	 * before Alder Lake do not have the above device property so we
+	 * use their PCI IDs instead. All these are tunneled. This list
+	 * is not expected to grow.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch (pdev->device) {
+		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
+		case 0x8a1d:
+		case 0x8a1f:
+		case 0x8a21:
+		case 0x8a23:
+		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
+		case 0x9a23:
+		case 0x9a25:
+		case 0x9a27:
+		case 0x9a29:
+		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
+		case 0x9a2b:
+		case 0x9a2d:
+		case 0x9a2f:
+		case 0x9a31:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/* root->external_facing is true, parent != NULL */
+static bool pcie_is_tunneled(struct pci_dev *root, struct pci_dev *parent,
+			     struct pci_dev *pdev)
+{
+	/* Anything directly behind a "usb4-host-interface" is tunneled */
+	if (pcie_has_usb4_host_interface(parent))
+		return true;
+
+	/*
+	 * Check if this is a discrete Thunderbolt/USB4 controller that is
+	 * directly behind a PCIe Root Port marked as "ExternalFacingPort".
+	 * These are not behind a PCIe tunnel.
+	 */
+	if (pcie_switch_directly_under(root, parent, pdev))
+		return false;
+
+	return true;
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
@@ -1621,8 +1742,32 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent) {
+		struct pci_dev *root;
+
+		/* If parent is untrusted so are we */
+		if (parent->untrusted) {
+			pci_dbg(dev, "marking as untrusted\n");
+			dev->untrusted = true;
+			return;
+		}
+
+		root = pcie_find_root_port(dev);
+		if (root && root->external_facing) {
+			/*
+			 * Only PCIe root ports can be marked as
+			 * "ExternalFacingPort", However, in case of a
+			 * discrete Thunderbolt/USB4 controller only its
+			 * downstream facing ports are actually
+			 * something that are exposed to the wild so we
+			 * only mark devices behind those as untrusted.
+			 */
+			if (pcie_is_tunneled(root, parent, dev)) {
+				pci_dbg(dev, "marking as untrusted\n");
+				dev->untrusted = true;
+			}
+		}
+	}
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1639,10 +1784,15 @@ static void pci_set_removable(struct pci_dev *dev)
 	 * the port is marked with external_facing, such devices are less
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
+	 *
+	 * These are the same devices marked as untrusted by the above
+	 * function. The ports and endpoints part of the discrete
+	 * Thunderbolt/USB4 controller are not marked as removable.
 	 */
-	if (parent &&
-	    (parent->external_facing || dev_is_removable(&parent->dev)))
+	if (dev->untrusted || (parent && dev_is_removable(&parent->dev))) {
+		pci_dbg(dev, "marking as removable\n");
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+	}
 }
 
 /**

