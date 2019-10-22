Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13247E00D4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 11:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfJVJdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 05:33:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:52568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfJVJdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:33:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="209635240"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 22 Oct 2019 02:33:50 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Oct 2019 12:33:49 +0300
Date:   Tue, 22 Oct 2019 12:33:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191022093349.GC2819@lahna.fi.intel.com>
References: <20191014061355.29072-1-drake@endlessm.com>
 <20191014154322.GA190693@google.com>
 <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
 <20191021113353.GX2819@lahna.fi.intel.com>
 <CAD8Lp47dmOD0jRZC2Y_Q_Gqfy9X5zbPAoXFJ=2Dadq0W89EC=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp47dmOD0jRZC2Y_Q_Gqfy9X5zbPAoXFJ=2Dadq0W89EC=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 10:40:00AM +0800, Daniel Drake wrote:
> On Mon, Oct 21, 2019 at 7:33 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Just to be sure, did you try the patch or just looked at it? Because
> > what the patch does is that it does the delay when the downstream/root
> > port is resumed, not the xHCI itself.
> 
> I tried it, it didn't fix the problem.

:(

It may very well be that this particular xHCI controller needs more than
that 10ms from D3hot -> D0 transition. Again the PCIe spec says the 10ms
is the minimum time system software needs to delay but it does not say
what would be the maximum time the function absolutely must be properly
in D0.
