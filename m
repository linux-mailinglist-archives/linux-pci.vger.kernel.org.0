Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E005B32538D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhBYQc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 11:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhBYQcl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 11:32:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6373B64F19;
        Thu, 25 Feb 2021 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614270719;
        bh=Qz/Xs/XBCsL6aNkel3z9wHufehEW1z7s+f3I1qeFZeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tAd6D2P02k6wqKnk8cA18RzWjnxt1m0DH8p5JdFMuqwQDFxuUqZrfPll+AEc6oXPb
         D0OL0hgQ5QyOsI4dcwlcmX6Y76HTCru8cd/fpISPbF+G9JNKfCpguASwZfJpiccUtx
         5UuV4bHzbqgwlsf/ZoNOJ7Vz3xnWCGdoUNvps1gQQOF89kK+tzma0oKKDpS/8Lr/iP
         DyreQ84ac5oRGbX74sSfFvTE3nv/UESmgmQJm0jQJESAMsDLQtbU4pEtS7A2ToDe2h
         K9GLqnrd1I4Urs39pFdGfUga4dlwk74n5a1Hi8d4zA4rJ2Vs/lknrKZ00bxVW1+l/R
         0NVIDHhj7B6nw==
Date:   Thu, 25 Feb 2021 10:31:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261
Message-ID: <20210225163157.GA5064@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2102241456360.13940@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 03:00:18PM -0800, Arun Easi wrote:
> Hi Bjorn,
> 
> On Fri, 18 Dec 2020, 5:04pm, Arun Easi wrote:
> 
> > The VPD quirk was added by [0] to avoid a system NMI; this issue
> > has been long fixed in the HBA firmware. In addition, PCI also has
> > the logic to check the VPD size [1], so this quirk can be reverted
> > now. More details in the thread:
> >     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> > 
> > [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> > [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=Bw8qGbVsETqSibSD8JVMAxZh8BCn1cHuskKjbarfuT8&s=IMvYnIBgaHJkzF2-GgIrGymbRguV287NVLG1_KcP_po&e= 
> > 
> > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > CC: stable@vger.kernel.org      # v4.6+
> > ---
> 
> Wondering if there is something needed from my side. I could not find this 
> in the v5.12 list.

Sorry, I blew it on this one (and other VPD patches from Heiner).
It's too late for v5.12, but I'll try again for v5.13.

Bjorn
