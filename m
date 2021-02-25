Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A69325731
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhBYT6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 14:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhBYT44 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 14:56:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CE8160235;
        Thu, 25 Feb 2021 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614282970;
        bh=RgoP7HFFzWiItSfV6xRarT0YWR3QPzEVfpXAWeL5lyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HeYUys9H/BTZ+fQsoUKlA0S5puBaS1zCs2G4cxhSoWjxPAzd9o7XlRvVhwRHiXwTg
         fJsq4jvxTRNyNzQ0BfEuPx617r75i8fcs+1Zrf1uVqmG5Z3DRO9/rzEBseFRN/P106
         t58pdo89anZWlmKUwCkD7w3e5CxjqIKImMRcgh2OTet1LRbNrjOEu4VqZXkfVPGZWr
         BUHaM32MAlZuN+9vzaR8sqhLOH6tOIskxZ2sUVnurquZdDHxcLIvBBjSwsMD99OCIy
         HV/H03X2A0DwTAsRXtCJTBFdXaEhlOlozUkWIJCp1lW7y/afKrBJ0wGoqAsK9hXzcV
         NWYu6BhspWn2Q==
Date:   Thu, 25 Feb 2021 13:56:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [EXT] Re: [PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261
Message-ID: <20210225195608.GA25861@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2102251127560.13940@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 25, 2021 at 11:32:28AM -0800, Arun Easi wrote:
> On Thu, 25 Feb 2021, 8:31am, Bjorn Helgaas wrote:
> > On Wed, Feb 24, 2021 at 03:00:18PM -0800, Arun Easi wrote:
> > > On Fri, 18 Dec 2020, 5:04pm, Arun Easi wrote:
> > > 
> > > > The VPD quirk was added by [0] to avoid a system NMI; this issue
> > > > has been long fixed in the HBA firmware. In addition, PCI also has
> > > > the logic to check the VPD size [1], so this quirk can be reverted
> > > > now. More details in the thread:
> > > >     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> > > > 
> > > > [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> > > > [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> > > > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=Bw8qGbVsETqSibSD8JVMAxZh8BCn1cHuskKjbarfuT8&s=IMvYnIBgaHJkzF2-GgIrGymbRguV287NVLG1_KcP_po&e= 
> > > > 
> > > > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > > > CC: stable@vger.kernel.org      # v4.6+
> > > > ---
> > > 
> > > Wondering if there is something needed from my side. I could not find this 
> > > in the v5.12 list.
> > 
> > Sorry, I blew it on this one (and other VPD patches from Heiner).
> > It's too late for v5.12, but I'll try again for v5.13.
> > 
> 
> No worries. As these are mostly one-liners and straight forward changes, 
> posting during RC is not an option for 5.12 inclusion?

Not unless it's critical or it fixes a bug we introduced during the
merge window.  This doesn't seem like either, but please clarify if it
is.

From the commit log, it looks like this is just a cleanup with no
benefit to the user.  If that's the case, there's no reason to
backport to stable either.

Bjorn
