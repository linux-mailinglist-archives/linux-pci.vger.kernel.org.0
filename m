Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE284A55
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfHGLGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 07:06:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:57170 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfHGLGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 07:06:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 04:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="192894810"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Aug 2019 04:05:37 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 07 Aug 2019 14:05:36 +0300
Date:   Wed, 7 Aug 2019 14:05:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] Revert "PCI: Add missing link delays required by the
 PCIe spec"
Message-ID: <20190807110536.GK2716@lahna.fi.intel.com>
References: <20190807105718.77600-1-mika.westerberg@linux.intel.com>
 <2705367.zNMUfgmSmy@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2705367.zNMUfgmSmy@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 01:01:26PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 7, 2019 12:57:18 PM CEST Mika Westerberg wrote:
> > Commit c2bf1fc212f7 ("PCI: Add missing link delays required by the PCIe
> > spec") turned out causing issues with some systems either by making them
> > unresponsive or slowing down runtime and system wide resume of PCIe
> > devices. While root cause for the unresponsiveness is still under
> > investigation given the amount of issues reported better to revert it
> > for now.
> 
> Well, I've applied it, so I guess I should do the revert.
> 
> I'll queue this one up as a fix for -rc4.

Thanks!
