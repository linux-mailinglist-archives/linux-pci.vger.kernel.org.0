Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3907B2AFD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 06:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjI2EoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 00:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2EoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 00:44:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECB199
        for <linux-pci@vger.kernel.org>; Thu, 28 Sep 2023 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695962657; x=1727498657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4//K+NNGF4DkVXww/XwFWfynUHOAXh5Omf3XP9MB5o=;
  b=lHMN1Hz78iPXdXeffuZYAM96hA6f4m+I1hocOrrAgwpyv8ZOzVS8iqBQ
   pjF2aYZjR/2eubMRrNSyr3ZsTJL4/9YHltECewUy8ew+k+/1wD38BiYl9
   p3d0WLt/b5pz/Ps8ekUb3eqZcDSLLa0dlW673aXV65NBexw23S/T6Q9qw
   eaYH2Loe2M9M1QaNnIxGyplBEJZrCBp5Ur6nU9wtaS/67c+G+2slU1pjg
   rr99UBctD/P1EIF2ofcmCjBiQVTLGJ2ZCuPZFA2lMnJ1Zk6Yczd6JYX/q
   AHQMW3YuEhYVUXmKa7Q1pXZDFwtT4mdJfmN5q6meBUTt1/S1yc3PW5rRW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367294379"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="367294379"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 21:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="743334884"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="743334884"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 21:44:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8003F12B; Fri, 29 Sep 2023 07:44:13 +0300 (EEST)
Date:   Fri, 29 Sep 2023 07:44:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Message-ID: <20230929044413.GY3208943@black.fi.intel.com>
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230928223630.GA507660@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928223630.GA507660@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 05:36:30PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 18, 2023 at 02:48:01PM +0200, Lukas Wunner wrote:
> > struct pci_dev contains two flags which govern whether the device may
> > suspend to D3cold:
> > 
> > * no_d3cold provides an opt-out for drivers (e.g. if a device is known
> >   to not wake from D3cold)
> > 
> > * d3cold_allowed provides an opt-out for user space (default is true,
> >   user space may set to false)
> > 
> > Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
> > the user space setting overwrites the driver setting.  Essentially user
> > space is trusted to know better than the driver whether D3cold is
> > working.
> > 
> > That feels unsafe and wrong.  Assume that the change was introduced
> > inadvertently and do not overwrite no_d3cold when d3cold_allowed is
> > modified.  Instead, consider d3cold_allowed in addition to no_d3cold
> > when choosing a suspend state for the device.
> > 
> > That way, user space may opt out of D3cold if the driver hasn't, but it
> > may no longer force an opt in if the driver has opted out.
> > 
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v4.8+
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Mika and Mario, you both commented on this, but I *think* you were
> both OK with it as-is for now?  If so, can you give a Reviewed-by?
> I don't want to go ahead if you have any concerns.

No concerns from me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
