Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB28274B6F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIVVqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38441 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0963E5C0166;
        Tue, 22 Sep 2020 17:39:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=uXHDp0qx6g4os
        n7IwWkNfPwSQjRvYEOs1NTZ2+zhDds=; b=k1Dib3PaFjP/McnPtWpW6rzw/9dqv
        HMJxOYiBPLILCSMew3Ds1LTu+lM1YifwTqc67IJvcczm/AreD5Y2jdAhGlSPizrH
        gJUY4gG4pJDrbc8hG96dRG3zk2l5/BUpxEKjXRy4PkW/qozY+O3oj61weByR7c/z
        Tf8VqB5Msys6cMW3y1fW+E5gU8uuVLpT3M0DeWo0q7fdtIWD1UtpbHI4yKzG0VFm
        jateIuBHAcYsqF56OxPz0QcqnHj3T6unCgnyjf2Pu2U6ww8u9THoVz3qJl0WsDKu
        zR3ePWGfzz2qUjtAtP6Uu5eHFXEy7xZtfopmQi2a6Fa5tJULxd7VAj5gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uXHDp0qx6g4osn7Iw
        WkNfPwSQjRvYEOs1NTZ2+zhDds=; b=Ok39OdfnZBre2HVWf/tfovFoFSeJyFd7E
        +E14YQpBLUqWEa/q2wLJl+BYaFsNG1o0OfnRpt41qbQqoj3ar6duMxQDAfTvqrDJ
        33inQmugop56K6MZPbpgTCcwCTBtvtoU8dYY0/UBqQ57EykNi5XsKmj7h31003zO
        wNAeMZduCDLOoKCu9JuSZDKwnSi8yHun1bCS9r38239dUJaubvGpVrcwChzsTuT0
        9YsBM7yDCWP1RZ8cXgg6BCOdR4fVWypcN9ZnK8RYhNJMl5zSpmg4P3ea89b6OzSV
        BDX2d36vYEtICo6nFp0W1TEnl6HGlipZXbU1l149LSS5t9K5U1JMw==
X-ME-Sender: <xms:-G5qX7NMpY3OS-iXFZn6scuyPAGND-t8P987LWIHPWKk7m3-NB-buQ>
    <xme:-G5qX1-WRAmRgvBfqbAjR1y2G5bDr452HVD0JjiA79I-xLs_xJPSiqYM3pdQW6Jv1
    0c-TF83444TUNgb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggvvhes
    ohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeeuieeijeduve
    etudejkefhuedutdelvdevheffvdeiudevteekffdvieduudeikeenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecukfhppedvgedrvddtrddugeekrdegleenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggvvhes
    ohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:-G5qX6S4QYrP71dTTNo5PJ_6F0Fg610ZXj9eChD6xgxp66LLa2bdCw>
    <xmx:-G5qX_th8p1Exea51dmmwgVDFzgkSMrL100gdyLJi_q346-b6UNPlg>
    <xmx:-G5qXzf-4j1bivMGP1WoykYgLQHiYUFyjTebjlQHpqaYyPPjTmyW7Q>
    <xmx:-m5qX1t2DJlXtPMpI3yU6GXh_Z8IDsK2InU6InuI5h9ZqyElD9d-cQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 838353064610;
        Tue, 22 Sep 2020 17:39:03 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 00/10] Add RCEC handling to PCI/AER
Date:   Tue, 22 Sep 2020 14:38:49 -0700
Message-Id: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Changes since v5 and v4:

- Note that not all of the patches in v4 made it to the lists due
possible errors on the smtp server side. It's being investigated.
- Removed two Reviewed-by tags on the patches for pcie_walk_rcec()
due to significant functionality changes.
- Made walk_rcec() static.
- Bumped to v6, with hope this makes it completely to the lists.

Changes since v3 [1]:

- Merge usage patch and API (pcie_walk_rcec).
(Sathyanarayanan Kuppuswamy)

- Considering the possible ways to call pcie_do_recovery(), make
the flow more understandable through assignments of the incoming
devices in terms of 'bridges'.
- reset_link() may be misnamed. The point is really to reset any devices
below 'dev', which is a bridge. Using reset_subordinate_devices() makes it
more clear that we pass a bridge and reset the devices *below* it.
- In pcie_walk_rcec() an RCEC bus number does not indicate association
in the Assocated Bus Numbers register so skip it (7.9.10.3)
- Potential for a lot of churning to call pci_get_slot() in
pcie_walk_rciep_Devfn(). Attempt to reduce the number of calls by identifying
the associations through bus walks.
- Change pr_dbg of link RCiEP to "PME & error events reported via.."
(Bjorn Helgaas)

- In some cases (AER via APEI) there may not exist an RCEC. In these cases
the bridge is NULL. Account for that in the bridge walk.
(Jonathan Cameron)


[1] https://lore.kernel.org/linux-pci/20200812164659.1118946-1-sean.v.kelley@intel.com/



Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (5):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (4):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
  PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
  PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

 drivers/pci/pci.h               |  26 ++++-
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  36 +++++--
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          | 102 ++++++++++++++----
 drivers/pci/pcie/pme.c          |  15 ++-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/pcie/portdrv_pci.c  |   8 +-
 drivers/pci/pcie/rcec.c         | 185 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   3 +-
 include/linux/pci.h             |   5 +
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 359 insertions(+), 44 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.28.0

