Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F9523B18
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiEKRDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 13:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiEKRDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 13:03:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54471C5DA1
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652288622; x=1683824622;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ixyYFVoIHjXjdTXaRRDloaSNaYplZU34cwPaeZ3lhq0=;
  b=bxDcnJ0CLBU1cXZ6xOlL2F2Tj4CpsQZMeicWU7FLBc1wpUUtq2fPEBsN
   bNVb2RGXoRME5rMGs6fQxBvWk+ac1WmQtx6Eq49j8rEQ9t+LBeqJSy9Wv
   uIwymoqAf7Sy5jj6G5/BFXb1+Ux6yqaxK2qAu3zJKKuoxYE2ro9hnRUGB
   vbfTnc6OPHWcOOC0ZwFvcfDsv6Ld0hwAj++G5kL7BHL1IMdSlpF6cNErU
   xEPqfKMWOjQJWs4aEFMIfE58zD6alPb6p1zGQc7RYblMs2SQXtpfPMwkw
   49v4md8UxtpKzN4tTQfY6s/oCxiQArVsOETnry0QRLpwObsUYFXoupT3r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257304483"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="257304483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="542391567"
Received: from azvmdlinux1.ch.intel.com ([10.2.230.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:27 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Date:   Wed, 11 May 2022 02:57:06 -0700
Message-Id: <20220511095707.25403-2-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
References: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During the boot process all the PCI devices are assigned default PCI-MSI
IRQ domain including VMD endpoint devices. If interrupt-remapping is
enabled by IOMMU, the PCI devices except VMD get new INTEL-IR-MSI IRQ
domain. And VMD is supposed to create and assign a separate VMD-MSI IRQ
domain for its child devices in order to support MSI-X remapping
capabilities.

Now when MSI-X remapping in VMD is disabled in order to improve
performance, VMD skips VMD-MSI IRQ domain assignment process to its
child devices. Thus the devices behind VMD get default PCI-MSI IRQ
domain instead of INTEL-IR-MSI IRQ domain when VMD creates root bus and
configures child devices.

As a result host OS fails to boot and DMAR errors were observed when
interrupt remapping was enabled on Intel Icelake CPUs. For instance:

  DMAR: DRHD: handling fault status reg 2
  DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

To fix this issue, dev_msi_info struct in dev struct maintains correct
value of IRQ domain. VMD will use this information to assign proper IRQ
domain to its child devices when it doesn't create a separate IRQ domain.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v1->v2: Adding more information to commit log.
---
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index eb05cceab964..5015adc04d19 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -853,6 +853,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
 
 	vmd_acpi_begin();
 
-- 
2.26.2

