Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8464A3DC1
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiAaGmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 01:42:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:58817 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbiAaGmF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 01:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643611325; x=1675147325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NzR5WVLsAbh7rkG2YhVbwAZdDUygwE0mUXpLIgrwZ/Q=;
  b=d44Qgx/hidnwWkSjbQetiunam+bvaDAz6ZPJMZMMpI711tzHrImyfquC
   l3D2N5kc6+KqA1c+BajmFiNmdHidjZIbfK2z7vV+w4nmNe1zeZT17UU9d
   4bnFAeB2qMHzvtjkLF8yD82DJUnY6hyQhL93IEAl+HbzfsxGKw+jju1cm
   mKzOKGQKzfUKLuDoV462AeVMJQi5GJG/QokMTM1Vy4mu2dpsvm7IOzK4S
   J8hhypjVJUzm8H8th/vgD8EJt+AjgRq+O+V5KeZ5jxNcMd/cYww68D+4v
   yBW22v316oHUKHHnQBsShnYoucMOaUL77ae9UeSYBVjSKdjgJ5zrSRwx2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247362622"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="247362622"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 22:42:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="626278379"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 22:42:00 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 31 Jan 2022 08:41:36 +0200
Date:   Mon, 31 Jan 2022 08:41:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <YfeEoF35RPDVMdzD@lahna>
References: <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna>
 <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna>
 <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
 <YfOf2X7Snm7cvDRV@lahna>
 <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
 <CAJZ5v0iuM_qjhPxvhzgvtKM-4pBB2skf9G=R=Qo6NzKnZ2LN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iuM_qjhPxvhzgvtKM-4pBB2skf9G=R=Qo6NzKnZ2LN=w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Jan 30, 2022 at 03:30:39PM +0100, Rafael J. Wysocki wrote:
> > I'm open to doing so if the others also feel the same way. IMHO
> > though, the semantics of ACPI "DmaProperty" differ from the semantics
> > of the property I'm proposing here.
> >
> > The current (documented) semantics (of "DmaProperty"): *This device
> > (root port) is trusted*, but any devices downstream are not to be
> > trusted.
> >
> > What I need and am proposing (new "UntrustedDevice"): *This device as
> > well as any downstream devices* are untrusted.
> >
> > Note that there may be firmware implementing "DmaProperty" already out
> > there (for windows), and if we decide to use it for my purposes, then
> > there shall be a discrepancy in how Linux uses that property vs
> > Windows. Is that acceptable?
> 
> It may be confusing, so I'd rather not do that.
> 
> The platform firmware will use it with the Windows use case in mind
> and if it has side effects in Linux, problems are likely to appear in
> the field.
> 
> So the question is rather not about it being acceptable, but about
> whether or not this is generally going to work.

I was kind of implying that we could perhaps contact Microsoft and ask
them if the wording could be changed to cover all the devices, not just
PCIe root ports. I think this is something they will also need for
things like internal WI-FI controllers.

If that's not possible then no objections adding "UntrustedDevice". We
just need to deal with the "DmaProperty" anyway and both end up setting
pdev->untrusted in the similar manner.
