Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AAE388DD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFGLUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 07:20:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:36929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfFGLUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jun 2019 07:20:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 04:20:24 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2019 04:20:22 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 07 Jun 2019 14:20:21 +0300
Date:   Fri, 7 Jun 2019 14:20:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: PM: Replace pci_dev_keep_suspended() with two
 functions
Message-ID: <20190607112021.GU2781@lahna.fi.intel.com>
References: <2958812.87Qy2A3tJo@kreacher>
 <3991282.doQj0dWKJp@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3991282.doQj0dWKJp@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 07, 2019 at 12:32:31AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The code in pci_dev_keep_suspended() is relatively hard to follow due
> to the negative checks in it and in its callers and the function has
> a possible side-effect (disabling the PME) which doesn't really match
> its role.
> 
> For this reason, move the PME disablig from pci_dev_keep_suspended()
                                ^^^^^^^^
disabling

> to a separate function and change the semantics (and name) of the
> rest of it, so that 'true' is returned when the device needs to be
> resumed (and not the other way around).  Change the callers of
> pci_dev_keep_suspended() accordingly.
> 
> While at it, make the code flow in pci_pm_poweroff() reflect the
> pci_pm_suspend() more closely to avoid arbitrary differences between
> them.
> 
> This is a cosmetic change with no intention to alter behavior.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
