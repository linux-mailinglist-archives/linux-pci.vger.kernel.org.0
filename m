Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8895B4950C6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376304AbiATPA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 10:00:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43984 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359604AbiATPAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 10:00:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C567B617E8
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 15:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DD1C340E7;
        Thu, 20 Jan 2022 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642690853;
        bh=8wN8PN7kJwhtvBcX3rIqEOVbPtPVPt7xioExFDOMUEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EFeWNhSfRuTwgrOF/NzHVbOsC0oGx0k1Ll+O1wV4Gn0mxY+wVKqUP36dpPXlCFI5l
         sOATnm3bAjj6KgZebMz34qkpdt9cRVKB6XunvL/ANdDh9TNSIIz31jpRzCo+aSTGmd
         NtuTUUpneK+MCy3+eVULyPsExmGs6BC/NGsyT/M/pNQBCMJlGyy8LM6mGBjnC15opj
         arYTR+NIn2P0kwMdEH4eqGoII1KdP+xerR1wutyRINDQ9DQU22TCLetmsNQzkx6Qbu
         2xwa9y6gq1vX0uurKlqLWhlFjk8jzNpjQE7hnfIfHfxwj/ouRfcOX+fPud6dxhiDzZ
         OeJvVTk6SqADw==
Date:   Thu, 20 Jan 2022 09:00:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <20220120150051.GA1015185@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8e57b75-bb60-f092-67f7-174b1b3372c4@leemhuis.info>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 02:19:05PM +0100, Thorsten Leemhuis wrote:
> On 17.12.21 23:49, Krzysztof Wilczyński wrote:
> > Hi Ville,
> > 
> > Thank you for letting us know, and sincere apologies for troubles!
> > 
> > [...]
> >>>> The pci sysfs "rom" file has disappeared for VGA devices.
> >>>> Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
> >>>> Convert "rom" to static attribute").
> >>>>
> >>>> Some kind of ordering issue between the sysfs file creation 
> >>>> vs. pci_fixup_video() perhaps?
> >>>
> >>> Can you attach your complete "lspci -vv" output?  Also, which is the
> >>> default device?  I think there's a "boot_vga" sysfs file that shows
> >>> this.  "find /sys -name boot_vga | xargs grep ."
> >>
> >> All I have is Intel iGPUs so it's always 00:02.0. 
> >>
> >> $ cat /sys/bus/pci/devices/0000\:00\:02.0/boot_vga 
> >> 1
> >> $ cat /sys/bus/pci/devices/0000\:00\:02.0/rom
> >> cat: '/sys/bus/pci/devices/0000:00:02.0/rom': No such file or directory
> >>
> >> I've attached the full lspci from my IVB laptop, but the problem
> >> happens on every machine (with an iGPU at least).
> >>
> >> I presume with a discrete GPU it might not happen since they
> >> actually have a real ROM.
> > 
> > Admittedly, the automated testing I was running before the patch was released
> > didn't catch this.  I primarily focused on trying to catch the race condition
> > related to the ROM attribute creation.
> > 
> > I need to look into how to properly address this problem as if we were to
> > revert the ROM attribute changes, then we would introduce the race condition
> > we've had back.
> > 
> > Again, apologies for troubles this caused!
> 
> What's the status of this regression and getting it fixed? It looks like
> there was no progress for quite a while. Could anyone please provide a
> status update?

What a coincidence.  Krzysztof and I chatted about this yesterday.  No
progress to report yet, but we are working on it.

Bjorn
