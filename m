Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD803DB71E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhG3K0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 06:26:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:53264 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238274AbhG3K0n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 06:26:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="209959346"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="209959346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 03:26:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="418432773"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 03:26:34 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 30 Jul 2021 13:26:31 +0300
Date:   Fri, 30 Jul 2021 13:26:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH v1.1 1/2] PCI: PM: Avoid forcing PCI_D0 for wakeup
 reasons inconsistently
Message-ID: <YQPT1y2hA+/UPReI@lahna>
References: <4668274.31r3eYUQgx@kreacher>
 <2207145.ElGaqSPkdT@kreacher>
 <2593738.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2593738.mvXUDI8C0e@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 05:54:28PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is inconsistent to return PCI_D0 from pci_target_state() instead
> of the original target state if 'wakeup' is true and the device
> cannot signal PME from D0.
> 
> This only happens when the device cannot signal PME from the original
> target state and any shallower power states (including D0) and that
> case is effectively equivalent to the one in which PME singaling is
> not supported at all.  Since the original target state is returned in
> the latter case, make the function do that in the former one too.
> 
> Link: https://lore.kernel.org/linux-pm/3149540.aeNJFYEL58@kreacher/
> Fixes: 666ff6f83e1d ("PCI/PM: Avoid using device_may_wakeup() for runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
