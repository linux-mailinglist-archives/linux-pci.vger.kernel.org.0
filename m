Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2467C8446
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJMLUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJMLUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 07:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0CB7;
        Fri, 13 Oct 2023 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196016; x=1728732016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v35k94BNYjpR/g40oHphqcfXoVx02xvQQJ6kG01eG9k=;
  b=a4PTrsrt8qn5KwHhqE/NikvJZMJU8y6t86fegZq13wNiG+/HeyWF5g5m
   crmXkini5e7GDqpcxGw4k7+GcWAtX7JNWSPKdE+d30LlVhUgZAQx+2wr+
   J5KBpVWWKd50k6YkRaKvnIrmSOl9gzbQnkpRJj6HI+nsUXKQBcjAr32Zq
   2MS4/Zb+lBhLDoDktLqT01eHG31cv8uSmgXKhOgjvaRWaqNWYSz/O2cIj
   afPF0JgJKGtV/gcPxaYN7mL1WVgo7LqsQr9E0RJpCQN3HKvCj9nH9Qxa8
   B7/OHvs6AaZ7PHEZ7XWHSYUlD3h1X2tPw8eCfhu3Yfl4Kx626s25R6ttl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416213486"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="416213486"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754672560"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754672560"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI/DPC: Improve register field accessing
Date:   Fri, 13 Oct 2023 14:20:02 +0300
Message-Id: <20231013112004.4239-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This an alternative approach to the patch in:
  https://lore.kernel.org/linux-pci/20231010204436.1000644-7-helgaas@kernel.org/

It adds names to all the reason literals too (which makes it incompatible
with FIELD_GET() for the reason and ext_reason). When the reasons are
named instead of literals, it's very easy to understand the code just by
reading it (no need to lookup the meaning of those numbers from spec or
otherwise).

Also 0xfff4 the other patch missed is converted here.

Just let me know if I should, for example, base the additional changes
on top of that other change.

Ilpo Järvinen (2):
  PCI: Add PCI_EXP_DPC_* field details
  PCI/DPC: Use defines with register fields

 drivers/pci/pcie/dpc.c        | 39 +++++++++++++++++++++--------------
 include/uapi/linux/pci_regs.h |  7 +++++++
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.30.2

