Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAFDC51A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfJRMhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 08:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJRMhc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 08:37:32 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A6C20820;
        Fri, 18 Oct 2019 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571402251;
        bh=xAXfOdfdVlKjv6Hm7XeCOYoP/iwV/MFzZqZjWnWH9rA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QghU9SEJ2d3JFosaFYsAs3e5T8CPcu9nmazZS50POe2igL7vvvgOSY+rXzgr9NnVZ
         ifuRlmqaHcIaEM3dqffUDtL1bhirfIFswfRx9+SY6vf36CtiFRphwu7ay428LdvpTS
         KpmEspZ4NYivBH7wK6TTr5twIL74VCktScvytFuM=
Date:   Fri, 18 Oct 2019 07:37:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Message-ID: <20191018123729.GA158700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018084721.GS32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 18, 2019 at 11:47:21AM +0300, andriy.shevchenko@linux.intel.com wrote:
> On Thu, Oct 17, 2019 at 06:09:08PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 08, 2019 at 05:22:34PM +0000, Patel, Mayurkumar wrote:
> > > This patch provides AER config save and restore capabilities. After system
> > > resume AER config registers settings are lost. Not restoring AER root error
> > > command register bits on root port if they were set, disables generation
> > > of an AER interrupt reported by function as described in PCIe spec r4.0,
> > > sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> > > also required to maintain same state prior to system suspend to maintain
> > > AER interrupts behavior.
> 
> > Can you send this as plain text?  The patch seems to be a
> > quoted-printable attachment, and I can't figure out how to decode it
> > in a way "patch" will understand.
> 
> I understand that it changes your workflow and probably you won't like,
> though you can use patchwork (either thru web, or directly thru client(s)
> like git pw): https://patchwork.ozlabs.org/patch/1173439/

I had already tried that and "patch" still thought it was corrupted.
Same thing happens when downloading from lore.kernel.org.  Did you try
it and it worked for you?

07:30:22 ~/linux (master)$ git checkout -b test master
Switched to a new branch 'test'
07:30:31 ~/linux (test)$ wget -O patch https://patchwork.ozlabs.org/patch/1173439/mbox/
--2019-10-18 07:30:47--  https://patchwork.ozlabs.org/patch/1173439/mbox/
Resolving patchwork.ozlabs.org (patchwork.ozlabs.org)... 203.11.71.1, 2401:3900:2:1::2
Connecting to patchwork.ozlabs.org (patchwork.ozlabs.org)|203.11.71.1|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 8919 (8.7K) [text/plain]
Saving to: ‘patch’

patch               100%[===================>]   8.71K  --.-KB/s    in 0.001s

2019-10-18 07:30:48 (9.41 MB/s) - ‘patch’ saved [8919/8919]

07:30:48 ~/linux (test)$ git am patch
Applying: PCI/AER: Save and restore AER config state
error: corrupt patch at line 14
Patch failed at 0001 PCI/AER: Save and restore AER config state
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

07:36:11 ~/linux (test)$ wget -O patch.lore https://lore.kernel.org/linux-pci/92EBB4272BF81E4089A7126EC1E7B28479AE1486@IRSMSX101.ger.corp.intel.com/raw
--2019-10-18 07:36:16--  https://lore.kernel.org/linux-pci/92EBB4272BF81E4089A7126EC1E7B28479AE1486@IRSMSX101.ger.corp.intel.com/raw
Resolving lore.kernel.org (lore.kernel.org)... 54.203.26.224, 52.38.63.62
Connecting to lore.kernel.org (lore.kernel.org)|54.203.26.224|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 9744 (9.5K) [text/plain]
Saving to: ‘patch.lore’

patch.lore          100%[===================>]   9.52K  --.-KB/s    in 0s

2019-10-18 07:36:16 (46.7 MB/s) - ‘patch.lore’ saved [9744/9744]

07:36:16 ~/linux (test)$ git am patch.lore
Applying: PCI/AER: Save and restore AER config state
error: corrupt patch at line 14
Patch failed at 0001 PCI/AER: Save and restore AER config state
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

