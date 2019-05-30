Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10A30512
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE3W5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 18:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfE3W5q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 18:57:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65663262C9;
        Thu, 30 May 2019 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559257064;
        bh=V0XLEc2xP0TrbWy2zxLkQxN1clojTiiTt9RBYrTlz7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr4r5h3kXgIUZJYhLWguLX0IG6EkRSr3UhjqFUSFsmOFFHN8CpyQHiGKql1FumBIL
         g7Rn20ru2sg/s2K/UH01fT+XUh7/qe2mBPe5XtyHEUVHO88dw+G9G7WW8P2tOyBPcb
         DeQyArQAqb64/7tXUiMPJ64338nk9LDEIJ7NzB9U=
Date:   Thu, 30 May 2019 17:57:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [pci:pci/docs 2/12] htmldocs: include/linux/pci.h:831: warning:
 Function parameter or member 'node' not described in 'pci_driver'
Message-ID: <20190530225738.GN28250@google.com>
References: <201905310045.I2hsmQif%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905310045.I2hsmQif%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 31, 2019 at 12:17:54AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/docs
> head:   5b76337ac1d54eb1c82414f17e29883290ce87de
> commit: fe6cdee86aeb83ee6ed2dc98928fb9fefc138612 [2/12] Documentation: PCI: convert pci.txt to reST
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>    include/linux/pci.h:158: warning: cannot understand function prototype: 'typedef unsigned int __bitwise pci_channel_state_t; '
> >> include/linux/pci.h:831: warning: Function parameter or member 'node' not described in 'pci_driver'
> >> include/linux/pci.h:831: warning: Function parameter or member 'name' not described in 'pci_driver'
> >> include/linux/pci.h:831: warning: Function parameter or member 'sriov_configure' not described in 'pci_driver'
> >> include/linux/pci.h:831: warning: Function parameter or member 'groups' not described in 'pci_driver'
> >> include/linux/pci.h:831: warning: Function parameter or member 'driver' not described in 'pci_driver'
> >> include/linux/pci.h:831: warning: Function parameter or member 'dynids' not described in 'pci_driver'
>    include/linux/pci.h:2251: warning: Excess function parameter 'lrdt' description in 'pci_vpd_info_field_size'

I fixed these by folding the patch below into fe6cdee86aeb
("Documentation: PCI: convert pci.txt to reST").  A couple of these
fixes are for pre-existing warnings unrelated to fe6cdee86aeb.

diff --git a/include/linux/pci.h b/include/linux/pci.h
index df22373c9164..b74b2a4e6df2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -151,6 +151,8 @@ static inline const char *pci_power_name(pci_power_t state)
 #define PCI_PM_BUS_WAIT		50
 
 /**
+ * typedef pci_channel_state_t
+ *
  * The pci_channel state describes connectivity between the CPU and
  * the PCI device.  If some PCI bus between here and the PCI device
  * has crashed or locked up, this info is reflected here.
@@ -778,6 +780,8 @@ struct module;
 
 /**
  * struct pci_driver - PCI driver structure
+ * @node:	List of driver structures.
+ * @name:	Driver name.
  * @id_table:	Pointer to table of device IDs the driver is
  *		interested in.  Most drivers should export this
  *		table using MODULE_DEVICE_TABLE(pci,...).
@@ -786,7 +790,7 @@ struct module;
  *		devices or later if a new device gets inserted) for
  *		all PCI devices which match the ID table and are not
  *		"owned" by the other drivers yet. This function gets
- *		passed a "struct pci_dev *" for each device whose
+ *		passed a "struct pci_dev \*" for each device whose
  *		entry in the ID table matches the device. The probe
  *		function returns zero when the driver chooses to
  *		take "ownership" of the device or an error code
@@ -810,7 +814,12 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @sriov_configure: Optional driver callback to allow configuration of
+ *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ * @groups:	Sysfs attribute groups.
+ * @driver:	Driver model structure.
+ * @dynids:	List of dynamically added device IDs.
  */
 struct pci_driver {
 	struct list_head	node;
@@ -2243,7 +2252,7 @@ static inline u8 pci_vpd_srdt_tag(const u8 *srdt)
 
 /**
  * pci_vpd_info_field_size - Extracts the information field length
- * @lrdt: Pointer to the beginning of an information field header
+ * @info_field: Pointer to the beginning of an information field header
  *
  * Returns the extracted information field length.
  */
