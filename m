Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E07B6981
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjJCMxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJCMxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:53:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C6A6;
        Tue,  3 Oct 2023 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696337625; x=1727873625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PaTpYoAT1uZlfzdLbZxjO14jzGyLuKJKiccXqKEpHDw=;
  b=jv9G6UOZRsdLTDfso+durVv16ewOKuidjMsA0q2cE15XW6h2hlsK6yo1
   YWEixkRTGl1gOLZA76sibzRdUn91BcQN6Prg/Hi0u/RssKbRWKY89n8JU
   iXzLpxvJ6CHOQCvgqlvMAKwp7M3ds+Esa8jD+1g4T0kOdSkXH60m+jj+2
   GqBR4RXVEOhW7DokjBwSyQxopj0zNuFPPi0FlPfGsVg77/eeF17wOp+Ub
   Clq9pNFwunWK0daXY9L0ZWzgvMLvFRH1pEuTz4b9V7UBbZ/sx702SI1//
   6jvlJhfD6ypOCPEof/nDKqsWLPVCWAT+gIYFlGxwXIFPt2CShoSRI6U/w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4432417"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="4432417"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816665798"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="816665798"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.222.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI: Add PCI_HEADER_TYPE_MFD pci_regs.h
Date:   Tue,  3 Oct 2023 15:52:59 +0300
Message-Id: <20231003125300.5541-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
References: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI_HEADER_TYPE_MFD into pci_regs.h to be able to replace
literals in the code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..06df65f11c39 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -80,6 +80,7 @@
 #define  PCI_HEADER_TYPE_NORMAL		0
 #define  PCI_HEADER_TYPE_BRIDGE		1
 #define  PCI_HEADER_TYPE_CARDBUS	2
+#define  PCI_HEADER_TYPE_MFD		0x80	/* Multi-Function Device (possible) */
 
 #define PCI_BIST		0x0f	/* 8 bits */
 #define  PCI_BIST_CODE_MASK	0x0f	/* Return result */
-- 
2.30.2

