Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6768A43C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHLR0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 13:26:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:24983 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfHLR0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 13:26:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 10:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="259864026"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 10:26:50 -0700
Message-ID: <1565632084.7042.13.camel@intel.com>
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X
 vectors by group
From:   Megha Dey <megha.dey@intel.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com
Date:   Mon, 12 Aug 2019 10:48:04 -0700
In-Reply-To: <48a44ffc-4b5b-5eef-73de-020f1710c41e@arm.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
         <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
         <1565118316.2401.112.camel@intel.com>
         <alpine.DEB.2.21.1908071525390.24014@nanos.tec.linutronix.de>
         <48a44ffc-4b5b-5eef-73de-020f1710c41e@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-08-07 at 15:18 +0100, Marc Zyngier wrote:
> On 07/08/2019 14:56, Thomas Gleixner wrote:
> > 
> > Megha,
> > 
> > On Tue, 6 Aug 2019, Megha Dey wrote:
> > > 
> > > On Sat, 2019-06-29 at 09:59 +0200, Thomas Gleixner wrote:
> > > > 
> > > > On Fri, 21 Jun 2019, Megha Dey wrote:
> > > Totally agreed. The request to add a dynamic MSI-X infrastructure
> > > came
> > > from some driver teams internally and currently they do not have
> > > bandwidth to come up with relevant test cases. <sigh>
> > Hahahaha.
> > 
> > > 
> > > But we hope that this patch set could serve as a precursor to the
> > > interrupt message store (IMS) patch set, and we can use this
> > > patch set
> > > as the baseline for the IMS patches.
> > If IMS needs the same functionality, then we need to think about it
> > slightly differently because IMS is not necessarily tied to PCI.
> >  
> > IMS has some similarity to the ARM GIC ITS stuff IIRC, which
> > already
> > provides these things outside of PCI. Marc?
> Indeed. We have MSI-like functionality almost everywhere, and make
> heavy
> use of the generic MSI framework. Platform-MSI is probably the most
> generic example we have (it's the Far West transposed to MSIs).
> 
Ok I will have a look at the platform-msi code.
> > 
> > We probably need some generic infrastructure for this so PCI and
> > everything
> > else can use it.
> Indeed. Overall, I'd like the concept of MSI on whatever bus to have
> one
> single behaviour across the board, as long as it makes sense for that
> bus (nobody needs another PCI MultiMSI, for example).

Yeah, agreed.
> 
> Thanks,
> 
> 	M.
