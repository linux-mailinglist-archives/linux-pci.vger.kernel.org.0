Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02018A4B5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfHLReV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 13:34:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:26428 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfHLReV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 13:34:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 10:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="376025887"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 10:33:35 -0700
Message-ID: <1565632489.7042.17.camel@intel.com>
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X
 vectors by group
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com
Date:   Mon, 12 Aug 2019 10:54:49 -0700
In-Reply-To: <alpine.DEB.2.21.1908110919310.7324@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
         <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
         <1565118316.2401.112.camel@intel.com>
         <alpine.DEB.2.21.1908071525390.24014@nanos.tec.linutronix.de>
         <48a44ffc-4b5b-5eef-73de-020f1710c41e@arm.com>
         <alpine.DEB.2.21.1908110919310.7324@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-08-11 at 09:20 +0200, Thomas Gleixner wrote:
> On Wed, 7 Aug 2019, Marc Zyngier wrote:
> > 
> > On 07/08/2019 14:56, Thomas Gleixner wrote:
> > > 
> > > On Tue, 6 Aug 2019, Megha Dey wrote:
> > > > 
> > > > On Sat, 2019-06-29 at 09:59 +0200, Thomas Gleixner wrote:
> > > > > 
> > > > > On Fri, 21 Jun 2019, Megha Dey wrote:
> > > > Totally agreed. The request to add a dynamic MSI-X
> > > > infrastructure came
> > > > from some driver teams internally and currently they do not
> > > > have
> > > > bandwidth to come up with relevant test cases. <sigh>
> > > Hahahaha.
> > > 
> > > > 
> > > > But we hope that this patch set could serve as a precursor to
> > > > the
> > > > interrupt message store (IMS) patch set, and we can use this
> > > > patch set
> > > > as the baseline for the IMS patches.
> > > If IMS needs the same functionality, then we need to think about
> > > it
> > > slightly differently because IMS is not necessarily tied to PCI.
> > >  
> > > IMS has some similarity to the ARM GIC ITS stuff IIRC, which
> > > already
> > > provides these things outside of PCI. Marc?
> > Indeed. We have MSI-like functionality almost everywhere, and make
> > heavy
> > use of the generic MSI framework. Platform-MSI is probably the most
> > generic example we have (it's the Far West transposed to MSIs).
> > 
> > > 
> > > We probably need some generic infrastructure for this so PCI and
> > > everything
> > > else can use it.
> > Indeed. Overall, I'd like the concept of MSI on whatever bus to
> > have one
> > single behaviour across the board, as long as it makes sense for
> > that
> > bus (nobody needs another PCI MultiMSI, for example).
> Right.
> 
> @Intel: Is there documentation and perhaps early code for that IMS
> muck to
> 	look at?

Hi Thomas,

We have some early documentation on IMS which can be found here (part
of the Scalable I/O Virtualization spec):

https://software.intel.com/sites/default/files/managed/cc/0e/intel-scal
able-io-virtualization-technical-specification.pdf
(Section 3.4.1)

Also, I do have some initial IMS patches that we use internally for
testing. I will clean it up and send it as an RFC patchset shortly.
 
> 
> Thanks,
> 
> 	tglx
