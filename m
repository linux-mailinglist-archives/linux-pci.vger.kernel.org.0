Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F241D728
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349700AbhI3KHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 06:07:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:24980 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349679AbhI3KHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 06:07:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212408503"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="212408503"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="618055875"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2021 03:05:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Sep 2021 13:05:16 +0300
Date:   Thu, 30 Sep 2021 13:05:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device
 properties
Message-ID: <YVWL3PyYRanGTlVG@kuha.fi.intel.com>
References: <20210929170804.GA778424@bhelgaas>
 <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi guys,

On Thu, Sep 30, 2021 at 10:33:27AM +0800, Zhangfei Gao wrote:
> On 2021/9/30 上午1:08, Bjorn Helgaas wrote:
> > [+cc Zhangfei, author of 8304a3a199ee ("PCI: Set dma-can-stall for
> > HiSilicon chips"), which added this]
> > 
> > On Wed, Sep 29, 2021 at 04:37:28PM +0300, Heikki Krogerus wrote:
> > > Using device_create_managed_software_node() to inject the
> > > properties in quirk_huawei_pcie_sva() instead of with the
> > > old device_add_properties() API.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > This is fine with me, but please update the subject line and commit
> > log something like this:
> > 
> >    PCI: Convert to device_create_managed_software_node()
> > 
> >    In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> >    instead of device_add_properties() to set the "dma-can-stall"
> >    property.
> > 
> >    This resolves a software node lifetime issue (see 151f6ff78cdf
> >    ("software node: Provide replacement for device_add_properties()"))
> >    and paves the way for removing device_add_properties() completely.
> > 
> > Actually, 8304a3a199ee was merged during the v5.15 merge window, so if
> > this does in fact fix a lifetime issue, I can merge this before
> > v5.15-final.

It does not fix lifetime issues. This is because device_del() called
device_remove_properties() unconditionally with every device.

There should be no functional impact.

> > I know *this* quirk applies to AMBA devices, and I assume they cannot
> > be removed, so there's no actual lifetime problem in this particular
> > case, but in general it looks like a problem for PCI devices.
> Thanks Bjorn
> This patch also works, though the quirk is for platform devices and not
> removed.

If the device is really never removed, then we could also constify the
node and the properties in it. Then the patch would look like this:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b6b4c803bdc94..3dc7a1c62bf24 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1833,13 +1833,17 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
  * even when a "PCI" device turns out to be a regular old SoC device
  * dressed up as a RCiEP and normal rules don't apply.
  */
+static const struct property_entry huawei_pcie_sva_props[] = {
+       PROPERTY_ENTRY_BOOL("dma-can-stall"),
+       { }
+};
+
+static const struct software_node huawei_pcie_sva_swnode = {
+       .properties = huawei_pcie_sva_props,
+};
+
 static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 {
-       struct property_entry properties[] = {
-               PROPERTY_ENTRY_BOOL("dma-can-stall"),
-               {},
-       };
-
        if (pdev->revision != 0x21 && pdev->revision != 0x30)
                return;
 
@@ -1850,7 +1854,7 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
         * can set it directly.
         */
        if (!pdev->dev.of_node &&
-           device_add_properties(&pdev->dev, properties))
+           device_add_software_node(&pdev->dev, &huawei_pcie_sva_swnode))
                pci_warn(pdev, "could not add stall property");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);


Let me know if you prefer it that way.

thanks,

-- 
heikki
