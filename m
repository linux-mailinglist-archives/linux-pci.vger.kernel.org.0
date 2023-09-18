Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F917A4C86
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjIRPfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjIRPfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:35:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2030E5
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051212; x=1726587212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMb2f6CebwFDinLGs1R2mgjUMNWFAuQZrN/mjiP5498=;
  b=QEA7yrB4oNbQoCCHcxe+/lXpSjaOjgkzbQCyaJ1ogCQrn62VJRI6aBrp
   ECIgV+9SdYJ4HbRi3dAOJbRlosA/kvkS9lvWE3DpcIfFYWuyfdC6aYJYR
   W8vEWYbBVeAwltFjU8w3m/LsS2Z+jwjCs/psRor0s5b3b9iyW+hudZuQO
   OX0pUv0owF6Z+/4dqwCU/63OwbTJ0KS7N4kmlzDjnkqBTQ/Wz5ZJ2n1Ag
   9jSIST5aAUkOda9rNyzVd9p9ln68sb4S+nItG9fZKCl7LbUWMpMHU05P5
   qxdCdLGUSlN7Nt3SI56T0ujNa9N5ZpFIXBd3PS4VGg3D3toeyJvVrcdnz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359900080"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359900080"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="816023440"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="816023440"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2023 06:07:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 51B4D1CA; Mon, 18 Sep 2023 16:07:42 +0300 (EEST)
Date:   Mon, 18 Sep 2023 16:07:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Message-ID: <20230918130742.GU1599918@black.fi.intel.com>
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Mon, Sep 18, 2023 at 02:48:01PM +0200, Lukas Wunner wrote:
> struct pci_dev contains two flags which govern whether the device may
> suspend to D3cold:
> 
> * no_d3cold provides an opt-out for drivers (e.g. if a device is known
>   to not wake from D3cold)
> 
> * d3cold_allowed provides an opt-out for user space (default is true,
>   user space may set to false)
> 
> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
> the user space setting overwrites the driver setting.  Essentially user
> space is trusted to know better than the driver whether D3cold is
> working.
> 
> That feels unsafe and wrong.  Assume that the change was introduced
> inadvertently and do not overwrite no_d3cold when d3cold_allowed is
> modified.  Instead, consider d3cold_allowed in addition to no_d3cold
> when choosing a suspend state for the device.
> 
> That way, user space may opt out of D3cold if the driver hasn't, but it
> may no longer force an opt in if the driver has opted out.

Makes sense. I just wonder should the sysfs write fail from userspace
perspective if the driver has opted out and userspace tries to force it?
Or it does that already?
