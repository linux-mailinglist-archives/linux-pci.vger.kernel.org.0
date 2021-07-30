Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B598A3DB726
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbhG3K2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 06:28:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:23712 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238438AbhG3K2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 06:28:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193351620"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="193351620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 03:28:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="499594036"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 03:28:12 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 30 Jul 2021 13:28:10 +0300
Date:   Fri, 30 Jul 2021 13:28:10 +0300
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
Subject: Re: [PATCH v1 2/2] PCI: PM: Enable PME if it can be signaled from
 D3cold
Message-ID: <YQPUOgxldaqpxOxL@lahna>
References: <4668274.31r3eYUQgx@kreacher>
 <1791325.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1791325.tdWV9SEqCh@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 04:49:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> PME signaling is only enabled by __pci_enable_wake() if the target
> device can signal PME from the given target power state (to avoid
> pointless reconfiguration of the device), but if the hierarchy above
> the device goes into D3cold, the device itself will end up in D3cold
> too, so if it can signal PME from D3cold, it should be enabled to
> do so in __pci_enable_wake().
> 
> [Note that if the device does not end up in D3cold and it cannot
>  signal PME from the original target power state, it will not signal
>  PME, so in that case the behavior does not change.]
> 
> Link: https://lore.kernel.org/linux-pm/3149540.aeNJFYEL58@kreacher/
> Fixes: 5bcc2fb4e815 ("PCI PM: Simplify PCI wake-up code")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Also this solves the reported issue so,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
