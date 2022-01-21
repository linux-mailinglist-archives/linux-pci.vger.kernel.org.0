Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1838495DFA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 11:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiAUKz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 05:55:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:39816 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbiAUKz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jan 2022 05:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642762527; x=1674298527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViBhVceOnQKi7VwCMCXAn8pJ2YGdIqiCIh6tChqDFnE=;
  b=hRGLzh5ZL1JufDhCPbGe/JmYRqF7+Y50O2bep+23eJm3VQgA/hNUo29k
   fZF8mqI3fACpinpZqcAPg0K0RmDgVIDTi6lWnllxw3e5WX2fZOOwFKeVJ
   92xwH9pBQcCQSv3XeZzz0ec8vWmdlxSqPTm4LYARqMmTGfYTIOtk5jdqg
   EbwyC7CNzg32tHRzL9JozbuSTVapxgBrfgOr4JoJIGeRg3bNVM+IlnLys
   VtGyEqPoKUYdo42gASmdM1sq0FdQDDmenmK+H3Rw7Kt8S/S2x3GRFF60L
   /GTwirvZ0RUMcXb/SeIuRGOwNlxk6R41j5KflwX4GYidp94krpR49/oDH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="331981067"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="331981067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 02:55:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="579574058"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 02:55:23 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 21 Jan 2022 12:55:21 +0200
Date:   Fri, 21 Jan 2022 12:55:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
Message-ID: <YeqRGQoPKy389ct5@lahna>
References: <20220105060643.822111-1-kai.heng.feng@canonical.com>
 <20220105201226.GA218998@bhelgaas>
 <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kai-Heng,

On Fri, Jan 07, 2022 at 12:09:57PM +0800, Kai-Heng Feng wrote:
> Only from root ports of thunderbolt devices.
> 
> The error occurs as soon as the root port is runtime suspended to D3cold.
> 
> Runtime suspend the AER service can resolve the issue. I wonder if
> it's the right thing to do here?

I think you are right here. It seems that AER "service driver" is
completely missing PM hooks. Probably because it is more used in server
type of systems where power management is not priority.

> D3cold should also mean the PCI link is gone, disabling AER seems to
> be a reasonable approach.

Indeed - I think AER might trigger here because the link does "down" /
low power state if left enabled while the root port enters D3. Something
like below hack should disable it over low power transitions:

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..64138cf82db8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1432,6 +1432,22 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
 	.port_type	= PCIE_ANY_PORT,
@@ -1439,6 +1455,10 @@ static struct pcie_port_service_driver aerdriver = {
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
+	.runtime_suspend = aer_suspend,
+	.runtime_resume	= aer_resume,
 };
 
 /**
