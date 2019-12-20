Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3B127584
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 07:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLTGFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 01:05:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:56538 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfLTGFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 01:05:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 22:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,334,1571727600"; 
   d="scan'208";a="222434519"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Dec 2019 22:05:07 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 20 Dec 2019 08:05:07 +0200
Date:   Fri, 20 Dec 2019 08:05:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Marcin =?utf-8?Q?Zaj=C4=85czkowski?= <mszpak@wp.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Nouveau] Tracking down severe regression in 5.3-rc4/5.4 for
 TU116 - assistance needed
Message-ID: <20191220060507.GQ2913417@lahna.fi.intel.com>
References: <c34a6fe1-80dd-a4db-c605-0a13c69e803f@wp.pl>
 <CAKb7UviSYORoeDm1sbDFEzkGd68+DV=StCpzsiaGbA=1VQX3gw@mail.gmail.com>
 <233aafa2-1474-39bf-8ea0-fe1a3ecef167@wp.pl>
 <CAKb7UvgOVrwC91ys19uTAG2p_MRVqcsV_MAHOSL4-m3f+j=dNg@mail.gmail.com>
 <68def665-d236-f3e0-7033-bcb9b9436d1c@wp.pl>
 <CAKb7Uvion7KuwgNaz0G3UD15nnkfM8hfayQgDtgz4d8W6p98bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7Uvion7KuwgNaz0G3UD15nnkfM8hfayQgDtgz4d8W6p98bg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 03:38:10PM -0500, Ilia Mirkin wrote:
> Let's add Mika and Rafael, as they were responsible for that commit.
> Mika/Rafael - any ideas? The commit in question is
> 
> 0617bdede5114a0002298b12cd0ca2b0cfd0395d

This seems to be

  Revert "PCI: Add missing link delays required by the PCIe spec"

Can you try v5.5-rcX without any additional changes? It should include
the same fix done bit differently (trying to avoid breaking systems
which caused us to revert the previous one):

  4827d63891b6 PCI/PM: Add pcie_wait_for_link_delay()
  ad9001f2f411 PCI/PM: Add missing link delays required by the PCIe spec
