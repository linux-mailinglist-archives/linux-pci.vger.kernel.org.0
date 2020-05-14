Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD01D2FC8
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENMbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 08:31:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:7855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgENMbJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 08:31:09 -0400
IronPort-SDR: X+ScXvep4P57IPZ99oWv52IzlNdJKJkvHjYtWvRzqjWd9N+TBjtfxLf/B5eOoZxVLc/wy6jVQ2
 FZcFp3eaoxRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 05:31:08 -0700
IronPort-SDR: PAZcE3uYF2y3wFTVpJUJm/MFdW0fA7g3rPU0DUrd38KiuY1jTQrhG4oSHNsuGLjxCXp57a7B25
 viCX3JpPReTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="372254747"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 14 May 2020 05:31:06 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 14 May 2020 15:31:05 +0300
Date:   Thu, 14 May 2020 15:31:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200514123105.GW2571@lahna.fi.intel.com>
References: <20200511101606.GD487496@lahna.fi.intel.com>
 <20200512170906.GA268853@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512170906.GA268853@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 12, 2020 at 12:09:06PM -0500, Bjorn Helgaas wrote:
> I think that code would be more readable as something like:
> 
>   if (dev->link_active_reporting)
>     wait_for_link_active(dev);
>   msleep(delay);
> 
> Obviously we still want the printks and error/timeout checking, but
> fundamentally we want to wait for the link to be active (if possible),
> then wait the 100ms.  That structure isn't as clear as it could be
> when the delay is buried inside pcie_wait_for_link_delay().
> 
> It's not completely trivial to restructure it like that because of
> pcie_wait_for_link() and its callers.  But I think it's worth pushing
> on it a little bit to see if it could be done reasonably.

OK, I see what I can do to make it clearer.

> This does expose the fact that per spec, a hot-plug capable port that
> supports only 5 GT/s must support link_active_reporting, but sec 6.6.1
> says we *don't* need to wait for link training to complete before
> waiting 100ms.  So maybe we end up waiting slightly more than
> necessary.  Probably not worth worrying about?

I would say so. Better wait a bit too much than the opposite IMHO.
