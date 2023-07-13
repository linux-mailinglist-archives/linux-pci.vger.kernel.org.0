Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42575219B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 14:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjGMMr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjGMMrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 08:47:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50362710;
        Thu, 13 Jul 2023 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252412; x=1720788412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WP9jbrwJlCzDhGsE/E1k9YoxHP6CB4ER/l8Uze8ZUhU=;
  b=aALYlDWc4583zGyteM5LYH2S3TGYDsFzhoie+tOVU3WyeEGIQy/ZI9st
   8ruLr21fguAQ5KfPFn1oyyUQzbzvXnFEYRaTs7rE1ZODledMV0liQgXGY
   1YRlgrK+80DYdkbv6oYr8v0/6VuIcUU2Ohk5xl25RoOdMVnOPUghQiJVJ
   p34kaMMbWRpLd+OJvaeNuP2Yz6GXyzmiTFdW846+H/U3w6lda/Oa5hICh
   H6O8DGPdU4/V2OT42LYE7ODvnM0bsS9sWwPU50CINKsnz39Uv8fc2yt9S
   E/zIi2njwA8ndlgBctDEQM1csHgYjV4ehDEHJY0d5SvLlO8L1Y66Y6g8J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367797061"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367797061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757144524"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757144524"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 11/11] PCI: Document the Capability accessor RMW improvements
Date:   Thu, 13 Jul 2023 15:45:05 +0300
Message-Id: <20230713124505.94866-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Documentation claims port service drivers should play nice wrt. PCIe
Capability changes but the concurrency control is now provided in the
Capability accessors as long as the correct ones are used.

Update the documention to match the RMW accessor behavior.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/PCI/pciebus-howto.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index f882ff62c51f..a0027e8fb0d0 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -213,8 +213,12 @@ PCI Config Registers
 --------------------
 
 Each service driver runs its PCI config operations on its own
-capability structure except the PCI Express capability structure, in
-which Root Control register and Device Control register are shared
-between PME and AER. This patch assumes that all service drivers
-will be well behaved and not overwrite other service driver's
-configuration settings.
+capability structure except the PCI Express capability structure,
+that is shared between many drivers including the service drivers.
+RMW Capability accessors (pcie_capability_clear_and_set_word(),
+pcie_capability_set_word(), and pcie_capability_clear_word()) protect
+a selected set of PCI Express Capability Registers (Link Control
+Register and Root Control Register). Any change to those registers
+should be performed using RMW accessors to avoid problems due to
+concurrent updates. For the up-to-date list of protected registers,
+see pcie_capability_clear_and_set_word().
-- 
2.30.2

