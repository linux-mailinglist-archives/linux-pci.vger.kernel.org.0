Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E99388CB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfFGLRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 07:17:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:36806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfFGLRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jun 2019 07:17:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 04:17:42 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2019 04:17:39 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 07 Jun 2019 14:17:39 +0300
Date:   Fri, 7 Jun 2019 14:17:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: PM: Avoid resuming devices in D3hot during
 system suspend
Message-ID: <20190607111739.GT2781@lahna.fi.intel.com>
References: <2958812.87Qy2A3tJo@kreacher>
 <3078848.tiz3m2NLmW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3078848.tiz3m2NLmW@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 07, 2019 at 12:30:58AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code resumes devices in D3hot during system suspend if
> the target power state for them is D3cold, but that is not necessary
> in general.  It only is necessary to do that if the platform firmware
> requires the device to be resumed, but that should be covered by
> the platform_pci_need_resume() check anyway, so rework
> pci_dev_keep_suspended() to avoid returning 'false' for devices
> in D3hot which need not be resumed due to platform firmware
> requirements.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
