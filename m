Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22EB4128DD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhITW37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 18:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232360AbhITW16 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 18:27:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F254861100;
        Mon, 20 Sep 2021 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632176791;
        bh=Dys7Uhx6qStxlBZfiIAU9M6a/gcn3VAB9P/ISjwBM2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BzjHZNspSrj3p430J3DOF7qizpYPwvwFiumiLp2DkLDGJJ18095EeWC6H2jbSq6ok
         Vb0cMUnyh1agZFWAlqMedeB96gyhAORXWUm49/BhCNJcvAAp1IwggRbJVsdLCSyH0i
         Gl++lQIqFohR7I+cZ972tQu8Nq6ijGfKodACk1ciKoqgz7eLRJhhz6rFIPLP5WK3hx
         aCY4Y8rjIStJMnXIFRiG47jwNGx9NyT2F5/9Rc1bw0dig9zYoeMlB5jAdM8V5q9pzM
         BlwDP+SlwD8IWUma/ENEN8WB/ALDg7r778A5RM+b3+dSt2h5zzLzb2x8W3ZFwWlu3q
         fLmWg0GtzrjvQ==
Date:   Mon, 20 Sep 2021 17:26:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: Revert "PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume"
Message-ID: <20210920222629.GA45557@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06838361-0d2c-4a18-da04-6fb586ecd730@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 20, 2021 at 03:11:30PM -0700, Hemant Kumar wrote:
> Hi Bjorn,
> 
> Is there any plan to revisit the fix to allow L1SS CTRL1 and CTRL2 save and
> restore to work with suspend and resume.
> 
> Referring to the lkml discussion https://lore.kernel.org/linux-pci/20201228040513.GA611645@bjorn-Precision-5520/
> 
> A patch was shared, described as :-
> "4257f7e008ea restores PCI_L1SS_CTL1, then PCI_L1SS_CTL2.  I think it
> should do those in the reverse order, since the Enable bits are in
> PCI_L1SS_CTL1.  It also restores L1SS state (potentially enabling
> L1.x) before we restore the PCIe Capability (potentially enabling ASPM
> as a whole).  Those probably should also be in the other order."
> 
> We are planning to enable aspm driver, but without L1SS control register
> save and restore, it gets disabled after resume.

I don't remember the state of that, but if somebody posts a patch to
do the save/restore, and it fixes the problems we saw the first time,
I'm open to merging it.

Bjorn
