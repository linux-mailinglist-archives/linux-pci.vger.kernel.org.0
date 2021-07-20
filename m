Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22B43D038E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 23:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhGTUXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 16:23:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:37762 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhGTULH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 16:11:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272440827"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="272440827"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="415371383"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.248.31])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:40 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/2] Issue secondary bus reset and domain window reset
Date:   Tue, 20 Jul 2021 13:50:07 -0700
Message-Id: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During VT-d pass-through, the VMD driver occasionally fails to
enumerate underlying NVMe devices when repetitive reboots are
performed in the guest OS. The issue seems to be resolved by
performing secondary bus resets and reinitializing the root
port's bridge windows.

Nirmal Patel (2):
  PCI: vmd: Trigger secondary bus reset
  PCI: vmd: Issue vmd domain window reset

 drivers/pci/controller/vmd.c | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

-- 
2.27.0

