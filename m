Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC62DC7FC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634266AbfJRPBE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Oct 2019 11:01:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4242 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392463AbfJRPBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 11:01:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 08:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="397960152"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2019 08:01:01 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.76]) by
 IRSMSX102.ger.corp.intel.com ([169.254.2.40]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 16:01:01 +0100
From:   "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: RE: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Thread-Topic: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Thread-Index: AdV9/NREHFXBsULnSk+tvCdJHtrp6gHOqrcAABQxqYAACAmOgAACNOcAAATPNFA=
Date:   Fri, 18 Oct 2019 15:01:00 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28492C3AF96@IRSMSX101.ger.corp.intel.com>
References: <20191018084721.GS32742@smile.fi.intel.com>
 <20191018123729.GA158700@google.com>
 <20191018134040.GG32742@smile.fi.intel.com>
In-Reply-To: <20191018134040.GG32742@smile.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWRhNmI1MTQtNDhjMS00ZTEwLTg1YTEtZWQzNDJkNTFkZTFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRk82SE13aWk5cnFDdGNVcmRUUGZmRXFEMjRGakxyQ1NvTk4zaTgrMnNlUjdqcVhxSXBNMmxUTmFmUXZzbW1raCJ9
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 
> On Fri, Oct 18, 2019 at 07:37:29AM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 18, 2019 at 11:47:21AM +0300, andriy.shevchenko@linux.intel.com wrote:
> > > On Thu, Oct 17, 2019 at 06:09:08PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Oct 08, 2019 at 05:22:34PM +0000, Patel, Mayurkumar wrote:
> > > > > This patch provides AER config save and restore capabilities. After system
> > > > > resume AER config registers settings are lost. Not restoring AER root error
> > > > > command register bits on root port if they were set, disables generation
> > > > > of an AER interrupt reported by function as described in PCIe spec r4.0,
> > > > > sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> > > > > also required to maintain same state prior to system suspend to maintain
> > > > > AER interrupts behavior.
> > >
> > > > Can you send this as plain text?  The patch seems to be a
> > > > quoted-printable attachment, and I can't figure out how to decode it
> > > > in a way "patch" will understand.
> > >
> > > I understand that it changes your workflow and probably you won't like,
> > > though you can use patchwork (either thru web, or directly thru client(s)
> > > like git pw): https://patchwork.ozlabs.org/patch/1173439/
> >
> > I had already tried that and "patch" still thought it was corrupted.
> > Same thing happens when downloading from lore.kernel.org.  Did you try
> > it and it worked for you?
> 
> Hmm... indeed. patch work recognizes the patch, but fails to validate it...
> 
> Original mbox is broken :(
> https://marc.info/?l=linux-pci&m=157055537210812&w=2&q=mbox
> 
> So, here is for sure the problem on the sender's side.
> Sorry for the noise from me.
> 

Sorry my mistake. My mail client seems to have re-formatted this patch and removed spaces from
the front of untouch lines. I ll fix my mail client settigns and resend it in plain text again.

> --
> With Best Regards,
> Andy Shevchenko
> 

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

