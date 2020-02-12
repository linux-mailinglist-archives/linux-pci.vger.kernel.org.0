Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4115A147
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 07:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgBLGaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 01:30:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:49691 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgBLGaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 01:30:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 22:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347456594"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 22:30:23 -0800
Date:   Wed, 12 Feb 2020 14:29:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chen Yu <yu.chen.surf@gmail.com>, linux-pci@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC][pci/pm] pci config space save restore issues during
 suspend/resume
Message-ID: <20200212062942.GA15014@chenyu-office.sh.intel.com>
References: <CADjb_WR1tBHAuP9wZFnx1bJu3ZKAK8BDPMzDwc1-8nX_WVHLvA@mail.gmail.com>
 <20200211135043.GA202987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211135043.GA202987@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
On Tue, Feb 11, 2020 at 07:50:43AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2020 at 01:57:06PM +0800, Chen Yu wrote:
> > Hi,
> > We found two issues in the code during suspend:
> > 
> > 1. Andy Shevchenko found that, the save restore of pci config space
> >     might cause potential issue. Current code uses
> >     pci_read_config_dword() to read pci config header. However
> >     hardware is not obliged to react correctly when trying to read
> >     two/three 'adjacent' pci config registers with one dword read.
> > 
> >     Q1: Should we save/restore the pci config space header according
> >     to the PCI spec strictly(pci_read_config_dword() for 32bit,
> >     while pci_read_config_word() for 16bits, etc)?
> 
> I'm sure you know my first question will be for a spec reference for
> this requirement that we read registers with the correct size :)  If
> there is such a requirement, then of course we should follow it.
> 
There seems to be no explicit request in the spec that the config space
header should be read according to each register's size. And after recheck
the PCI Express Base Specification, Rev. 4.0 Version 1.0 pg703, it mentions:
"An implemented 64-bit Base Address register consumes two consecutive
DWORD locations." It looks like content within a DWORD io space
should be adjacent. So pci_read_config_dword() should be applicable.
But this is just my understanding, since we have not encountered issues caused
by dword reading yet, we might let it be for now.
> > 2. The pci config space of some problematic devices(or due to firmware
> >     bug) might become inaccessible after resumed from S3(suspend to
> >     mem) on VM.
> > 
> >     Q2: Should we do sanity check on pci config space before saving
> >     them?  Say, invoke pci_dev_is_present() before suspend, if the
> >     pci config space is not sane, bypass the config space saving
> >     process, because there's no need to save invalid pci config
> >     space.
> 
> I'm not in favor of a sanity check, at least not yet.  This sounds
> like a problem that has not been debugged yet.  If the device is
> broken in some way, maybe a quirk would be appropriate.  Otherwise,
> maybe there's some Linux issue in the resume from S3 path that we
> should fix.
Got it.

Thanks,
Chenyu
> 
> Bjorn
