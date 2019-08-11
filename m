Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9343489019
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 09:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfHKHUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 03:20:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKHUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 03:20:37 -0400
Received: from p200300ddd71876477e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7647:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwi9a-0005mZ-Hi; Sun, 11 Aug 2019 09:20:34 +0200
Date:   Sun, 11 Aug 2019 09:20:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Megha Dey <megha.dey@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X vectors
 by group
In-Reply-To: <48a44ffc-4b5b-5eef-73de-020f1710c41e@arm.com>
Message-ID: <alpine.DEB.2.21.1908110919310.7324@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com> <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com> <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de> <1565118316.2401.112.camel@intel.com>
 <alpine.DEB.2.21.1908071525390.24014@nanos.tec.linutronix.de> <48a44ffc-4b5b-5eef-73de-020f1710c41e@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 7 Aug 2019, Marc Zyngier wrote:
> On 07/08/2019 14:56, Thomas Gleixner wrote:
> > On Tue, 6 Aug 2019, Megha Dey wrote:
> >> On Sat, 2019-06-29 at 09:59 +0200, Thomas Gleixner wrote:
> >>> On Fri, 21 Jun 2019, Megha Dey wrote:
> >>
> >> Totally agreed. The request to add a dynamic MSI-X infrastructure came
> >> from some driver teams internally and currently they do not have
> >> bandwidth to come up with relevant test cases. <sigh>
> > 
> > Hahahaha.
> > 
> >> But we hope that this patch set could serve as a precursor to the
> >> interrupt message store (IMS) patch set, and we can use this patch set
> >> as the baseline for the IMS patches.
> > 
> > If IMS needs the same functionality, then we need to think about it
> > slightly differently because IMS is not necessarily tied to PCI.
> >  
> > IMS has some similarity to the ARM GIC ITS stuff IIRC, which already
> > provides these things outside of PCI. Marc?
> 
> Indeed. We have MSI-like functionality almost everywhere, and make heavy
> use of the generic MSI framework. Platform-MSI is probably the most
> generic example we have (it's the Far West transposed to MSIs).
> 
> > We probably need some generic infrastructure for this so PCI and everything
> > else can use it.
> 
> Indeed. Overall, I'd like the concept of MSI on whatever bus to have one
> single behaviour across the board, as long as it makes sense for that
> bus (nobody needs another PCI MultiMSI, for example).

Right.

@Intel: Is there documentation and perhaps early code for that IMS muck to
	look at?

Thanks,

	tglx
