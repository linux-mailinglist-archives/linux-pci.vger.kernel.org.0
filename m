Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9E162CFF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBRRck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 12:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgBRRck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Feb 2020 12:32:40 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B5722B48;
        Tue, 18 Feb 2020 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582047159;
        bh=Hs3mtj72oHAhcOKlb/lLWg8W10Q2iAludK8Rt699D0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G95I/cQmNoWVRms0Y9738Q8oz3LoDZYUNq/qzUgKtlrmu5Vm3WTg8ZsgX2BYkSp9l
         NOcXyrcLG2zO9NMErHWJ6iN/ns0DPFTf1cYAr1HH3Ma34GyILSvyqTOdjp1iqROUi0
         tjOXB1tfyMeXfRPmgv5EQASLD+dBnTq8aNAEdNn0=
Date:   Tue, 18 Feb 2020 11:32:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200218173238.GA214360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211143202.2sgryye4m234pymq@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 03:32:02PM +0100, Lukas Wunner wrote:
> On Tue, Feb 11, 2020 at 08:14:44AM -0600, Bjorn Helgaas wrote:
> > Feels like sort of a
> > double-negative situation, too.  Obviously the hardware bit has to be
> > "1 means disabled" to be compatible with previous spec versions, but
> > the code is usually easier to read if we test for something being
> > *enabled*.
> 
> It's a similar situation with the "DisINTx" bit in the Command
> register, which, if disabled, is shown as "DisINTx-" in lspci even
> though the more intuitive notion is that INTx is *enabled*.  I think
> you did the right thing by showing it as "IbPresDis-" because it's
> consistent with how it's done elsewhere for similar bits.

Everything else we decode is *capability* bits and IBPD is another
one.  So by the principle of least surprise, I propose this:

+       ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
+               FLAG(slot_cap2, PCI_EXP_SLTCAP2_IBPD),

That works out to be the same as printing

  inbound_presence_disabled ? '+' : '-'

because we always set inbound_presence_disabled when
PCI_EXP_SLTCAP2_IBPD is supported.
