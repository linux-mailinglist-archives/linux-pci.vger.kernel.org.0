Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05683DCAE8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394294AbfJRQVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 12:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJRQVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 12:21:52 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3041B20854;
        Fri, 18 Oct 2019 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571415711;
        bh=fGFpTIOtX6NCF8ObQdYlIKlx2dgS3VZpDTOzh3Prn88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eGADS4bqpXVBEaH8M039pnAw80NRD+qT0gz4LnJt8ggbTsYagfz/L+rJqlJNXlzM2
         ONJm+UJWVMk3YuhmE2cTP3JHBWKUhGfn7TSujfQjXI0ZsjH2wTe8F2q8sIkDQcnlZ4
         di3FtRsvmJIFTG0W+Zvs5m6fvsQuHzpENsDoUI/I=
Date:   Fri, 18 Oct 2019 11:21:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Message-ID: <20191018162150.GA180608@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28492C3AF96@IRSMSX101.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 18, 2019 at 03:01:00PM +0000, Patel, Mayurkumar wrote:
> > On Fri, Oct 18, 2019 at 07:37:29AM -0500, Bjorn Helgaas wrote:
> > > On Fri, Oct 18, 2019 at 11:47:21AM +0300, andriy.shevchenko@linux.intel.com wrote:
> > > > On Thu, Oct 17, 2019 at 06:09:08PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Oct 08, 2019 at 05:22:34PM +0000, Patel, Mayurkumar wrote:
> > > > > > This patch provides AER config save and restore capabilities. After system
> > > > > > resume AER config registers settings are lost. Not restoring AER root error
> > > > > > command register bits on root port if they were set, disables generation
> > > > > > of an AER interrupt reported by function as described in PCIe spec r4.0,
> > > > > > sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> > > > > > also required to maintain same state prior to system suspend to maintain
> > > > > > AER interrupts behavior.
> > > >
> > > > > Can you send this as plain text?  The patch seems to be a
> > > > > quoted-printable attachment, and I can't figure out how to decode it
> > > > > in a way "patch" will understand.
> > > >
> > > > I understand that it changes your workflow and probably you won't like,
> > > > though you can use patchwork (either thru web, or directly thru client(s)
> > > > like git pw): https://patchwork.ozlabs.org/patch/1173439/
> > >
> > > I had already tried that and "patch" still thought it was corrupted.
> > > Same thing happens when downloading from lore.kernel.org.  Did you try
> > > it and it worked for you?
> > 
> > Hmm... indeed. patch work recognizes the patch, but fails to validate it...
> > 
> > Original mbox is broken :(
> > https://marc.info/?l=linux-pci&m=157055537210812&w=2&q=mbox
> > 
> > So, here is for sure the problem on the sender's side.
> > Sorry for the noise from me.
> > 
> 
> Sorry my mistake. My mail client seems to have re-formatted this
> patch and removed spaces from the front of untouch lines. I ll fix
> my mail client settigns and resend it in plain text again.

You can always test it by sending the email to yourself to make sure
"git am" can apply it.

Bjorn
