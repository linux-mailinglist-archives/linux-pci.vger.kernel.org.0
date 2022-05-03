Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721825188A7
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiECPiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiECPiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 11:38:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A92CE16;
        Tue,  3 May 2022 08:34:49 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt3nF3c9Mz67PvP;
        Tue,  3 May 2022 23:30:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:34:46 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 16:34:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Date:   Tue, 3 May 2022 16:34:48 +0100
Message-ID: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far, we have been considering Data Object Exchange (DOE) mailboxes only
on EPs (CXL type 3 devices).
CXL CDAT (technically CXL Table Query Protocol but lets just call it CDAT)
  https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com
CMA/SPDM support
  https://lore.kernel.org/linux-cxl/20220303135905.10420-1-Jonathan.Cameron@huawei.com/

However, a number of DOE protocols apply to switch (and root) ports.
DOE instances supporting CDAT occur on switch upstream ports as well as EPs.

DOE instances supporting CMA may occur in root ports, upstream switch ports,
downstream switch ports and EPs (including multiple functions where relevant).

The intent of this RFC is to discuss how to actually implement such support.
The attached patch is a really rough PoC for CDAT on upstream switch ports
done by adding a new pcie_port_service_driver.  This is different from the
proposed auxiliary device used for CXL type 3 devices (for now).

So open questions:

1. Granularity. Should we do a driver per group of protocols that may
   be collocated, or one per DOE instance. For now, we might be looking
   at CDAT as done for this PoC, and CMA/IDE.
2. Use of a pcie_port_service_driver a reasonable way to do this?
3. Service provision. It is likely that all of the protocols defined
   above will be used as part of activities that span multiple devices.
   a) CDAT used to establish latencies and bandwidth between host CPU
      and memory on a CXL type 3 device beyond one or more CXL switches.
   b) CMA.  Might just be used to provide simple device attestation
      and potentially lock out the upstream port above a switch if the
      switch does not pass attestation.  Many many other uses possible...
   c) Secure CMA / IDE. Likely to be used to set up link IDE.  What
      this will look like is a question I've not really started
      thinking about yet.

   So how do we support this?  If nothing else we need to make sure
   the drivers for the port don't go away whilst in use.

The patch is a very early PoC just to show it would 'work'...

Note I am keen to not have the discussion around this support delay
Ira's series.

Jonathan Cameron (1):
  pcie/portdrv: Hack in DOE and CDAT support

 drivers/pci/pcie/Kconfig        |   5 ++
 drivers/pci/pcie/Makefile       |   1 +
 drivers/pci/pcie/cdat.c         | 127 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h      |   9 ++-
 drivers/pci/pcie/portdrv_core.c |  43 ++++++++++-
 drivers/pci/pcie/portdrv_pci.c  |   2 +
 6 files changed, 183 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/cdat.c

-- 
2.32.0

