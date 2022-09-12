Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1885B5305
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiILEQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILEQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 00:16:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B7248EB;
        Sun, 11 Sep 2022 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662956170; x=1694492170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUQfphPMPf1t9vi0UwNuc3fCvC90lDWqrjl7tHi+aw4=;
  b=fisdCy+Q5OGkAc1goTDlT/cWhRerNm2ZBb8RMnzw3kmzi1VjzZux2uoJ
   oKPwai+FVIGHQpa5DiomAiVTsNn8X7HUe/XoP0FNSUNlCWx7PxBtosKvB
   l5jULdlKfChq6+pnQjgJ+eDp8HwTCOLlbJtVSKXodKaWgl2xO6RIil+qp
   qyGipY6gY66kEbijwfOFC35M2oYJNBtVXHC2kUvMiEP84dGeyKwLuBjma
   Uf74c6+qIuIWZd9N4N+dTlMhg0tnfUtyGd9qZphyejdEfafWvJemajFIP
   GcyKw3WaMt6AzYkc1fZWGuPy281ftWNoHmi3/8RPtnSNpNQWVBKG2WQWI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="284801681"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="284801681"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 21:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="791417311"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2022 21:16:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 08542F7; Mon, 12 Sep 2022 07:16:23 +0300 (EEST)
Date:   Mon, 12 Sep 2022 07:16:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/9] PCI/PM: Always disable PTM for all devices during
 suspend
Message-ID: <Yx6yl9jNu6S8xOJ+@black.fi.intel.com>
References: <20220909202505.314195-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909202505.314195-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 03:24:56PM -0500, Bjorn Helgaas wrote:
> Bjorn Helgaas (9):
>   PCI/PTM: Cache PTM Capability offset
>   PCI/PTM: Add pci_upstream_ptm() helper
>   PCI/PTM: Separate configuration and enable
>   PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
>   PCI/PTM: Move pci_ptm_info() body into its only caller
>   PCI/PTM: Preserve RsvdP bits in PTM Control register
>   PCI/PTM: Reorder functions in logical order
>   PCI/PTM: Consolidate PTM interface declarations
>   PCI/PM: Always disable PTM for all devices during suspend

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
