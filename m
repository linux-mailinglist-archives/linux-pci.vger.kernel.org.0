Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887C7327A9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242161AbjFPGdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 02:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjFPGdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 02:33:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592419B5;
        Thu, 15 Jun 2023 23:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686897187; x=1718433187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iQSD2cJl7vIHfqPC9Yd/x0EEMRaLDOH9lEeCeAfrnx0=;
  b=XomZJ7MjX8b5KRGBidqsjGro1wqIT2CFtoHBFx1A4q9l7ure5YW4C17v
   C3roQcPFI9z6M+L9guQkL83tdDyb7rN2CcfJtFoLIf4LOox3ji7U8Q3Sh
   Dd/TX9ZUGsr83Ofvq1GR5mMuXW9xu8j3Ay/iD+rAhrxNde3vb5+UWyMxh
   LTw3U5+kHPkOkNrW9X5jfH3xeg9k3XeHB8jX4DqZFUQtIXM0lZqUS+MBD
   ZDkbgGs7xx/QmF1+hr9v1MxqijqOnLmIBuD+DOlO7Ek/b6TxzbuvAufHc
   oH2tc4+d7c3cQYPVbinDYRkHtxjYQw+uhUCeam51VSASKmAckgPw2qoZF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445520549"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445520549"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="663071055"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="663071055"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 23:33:04 -0700
From:   sharath.kumar.d.m@intel.com
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH 0/1] pci: agilex_rp: add pci root port support for agilex platform
Date:   Fri, 16 Jun 2023 12:03:12 +0530
Message-Id: <20230616063313.862996-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

added new callback for
1) read,write to root port configuration registers
2) read,write to endpoint configuration registers
3) root port interrupt handler

agilex and newer platforms need to implemant the callback
and generic root port driver should work ( without much changes )
, legacy platforms (arria and startix) implement configuration read,write
directly in wrapper api _altera_pcie_cfg_read/_altera_pcie_cfg_write


D M Sharath Kumar (1):
  pci: agilex_pci: add pcie rootport support for agilex

 drivers/pci/controller/pcie-altera.c | 278 ++++++++++++++++++++++++++-
 1 file changed, 268 insertions(+), 10 deletions(-)

-- 
2.34.1

