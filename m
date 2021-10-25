Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778A743930A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJYJy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 05:54:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:46352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhJYJy7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 05:54:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="216781076"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="216781076"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 02:52:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="493666091"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 02:52:32 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Oct 2021 12:50:19 +0300
Date:   Mon, 25 Oct 2021 12:50:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/PCI: Fix compile errors when CONFIG_PCI is disabled
Message-ID: <YXZ92/QxiGq2mM/R@lahna>
References: <20211020102102.86577-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020102102.86577-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 20, 2021 at 12:21:02PM +0200, Hans de Goede wrote:
> arch/x86/include/asm/pci_x86.h uses a number of data -types and defines
> without including the headers which define these.
> 
> Instead so far it has been relying on files including it including the
> necessary headers first.
> 
> Recently a include <asm/pci_x86.h> was added to arch/x86/kernel/resource.c
> which does not include the necessary headers first.
> 
> Add the missing includes to arch/x86/include/asm/pci_x86.h to fix the
> compile errors (with certain .config-s) when it is included from
> arch/x86/kernel/resource.c.
> 
> Fixes: f10507a66e36 ("x86/PCI: Ignore E820 reservations for bridge windows on newer systems")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
