Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA383523B16
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiEKRD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 13:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbiEKRD0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 13:03:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB489CC7
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652288604; x=1683824604;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ep1NpoWBAu0QrrJGK5qZ85w2uoUEBDEApxOHzjml43A=;
  b=HMVvJBfUYB2L2mjjtjOS81tHef2aMOuRjccDenKYVecICFZjPSEUgPF1
   qhsO0DujRvVNujOjjkP3k8vo+h1mfsnfHhIVCA2u7QyN1jnuZ5aDYlD8t
   ynOxvt5a+zJhlJfHqf9p5Vku0Rso6JAn6GzVwyhpayMVP1YzKbciuZj5Q
   JPDfeUbc7pGgr4A31a3lwaG5E6uTvWt1y1rdHNBffsUjaAz70AX833N6s
   VtJkawKBsru3x0r7x37TwmjfrOr0GGGoHEzZITO+xfO/1Nr08DTtP7zoX
   HG5M9CLNwooA82tRkzGbs9fn+SDfyyVt7Un5TGT7lohNOpXGENOKwNKWu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269693794"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269693794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="542391467"
Received: from azvmdlinux1.ch.intel.com ([10.2.230.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:13 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v2 0/2] PCI: vmd: IRQ domain assignment to sub devices
Date:   Wed, 11 May 2022 02:57:05 -0700
Message-Id: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Host OS fails to boot and DMAR errors were observed when interrupt
remapping is enabled by intel_iommu because of the fact that VMD child
devices are on different IRQ domain than all other PCI devices.
Make sure VMD assigns proper IRQ domain to the child devices during
device enumeration.

Nirmal Patel (2):
  PCI: vmd: Assign VMD IRQ domain before enumeration
  PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X
    remapping if interrupt remapping is enabled by IOMMU.")

 drivers/pci/controller/vmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.26.2

