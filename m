Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2C157FD3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBJQcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 11:32:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:63530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbgBJQcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 11:32:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 08:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="312795470"
Received: from jerjavec-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley) ([10.251.129.77])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2020 08:32:39 -0800
Message-ID: <088c8f9d07fe4a36125b2f0e5aeb09defb5b5e13.camel@linux.intel.com>
Subject: Re: RE: Re: "oneshot" interrupt causes another interrupt to be
 fired erroneously in Haswell system
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
Reply-To: sean.v.kelley@linux.intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kar Hin Ong <kar.hin.ong@ni.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 10 Feb 2020 08:32:39 -0800
In-Reply-To: <8736bjlqkg.fsf@nanos.tec.linutronix.de>
References: <20191031230532.GA170712@google.com>
         <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
         <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
         <87a76oxqv1.fsf@nanos.tec.linutronix.de>
         <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com>
         <87muanwwhb.fsf@nanos.tec.linutronix.de>
         <8f1e5981b519acb5edf53b5392c81ef7cbf6a3eb.camel@linux.intel.com>
         <87muaetj4p.fsf@nanos.tec.linutronix.de>
         <8736bjlqkg.fsf@nanos.tec.linutronix.de>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2020-02-09 at 16:37 +0100, Thomas Gleixner wrote:
> Sean,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Sean V Kelley <sean.v.kelley@linux.intel.com> writes:
> > > So I will ensure we actually create useful information pointing
> > > to this
> > > behavior either in kernel docs or online as in a white paper or
> > > both.
> > 
> > Great.
> > 
> > > > As we have already quirks in drivers/pci/quirks.c which handle
> > > > the
> > > > same issue on older chipsets, we really should add one for
> > > > these kind
> > > > of systems to avoid fiddling with the BIOS (which you can, but
> > > > most
> > > > people cannot).
> > > Agreed, and I will follow-up with Kar Hin Ong to get them added.
> > 
> > Much appreciated.
> 
> Any update on this?

Hi Thomas,

I've been working with Kar Hin in attempting to follow a similar
pattern to the earlier PCI quirks done with ESB / ESB2 chipsets.
However, the optional INTX routing table which was a part of the
original quirk done about 10 years ago changed by the time these
Haswell PCH arrived.  The later PCH aligned with the BIOS switch
becoming available and the deprecation of the bypass routing.  We're
testing a few more things, and I hope to have a conclusion this week.

Thanks,

Sean

> 
> Thanks,
> 
>         tglx

