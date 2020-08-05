Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361CA23D259
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHEUL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 16:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgHEQ1k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:40 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741E523332;
        Wed,  5 Aug 2020 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596641714;
        bh=7Qp+M4eLgYInQZcaCD12cN/aTz0hH0XWrQcpBO8syTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MsqcZkF0oNK6wJD7QJAMXlgTMgZdot3svBFsiVWAoPuhjYSY7dPkE1pqqca7bRedb
         NPva+bys3xeedd/W4idbevCMsPs4r8QreuLtkAa918mUtchrXzDDD5PgAzvC0Fd+L0
         yg2NeL+b6rbu1mmoHZPY5RXQVWEAd6Ge9/DH8fXw=
Date:   Wed, 5 Aug 2020 10:35:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Message-ID: <20200805153513.GA512238@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31275a25f29cad2fbda49f94839e128afc15acee.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 05, 2020 at 03:30:00PM +0000, Derrick, Jonathan wrote:
> On Wed, 2020-08-05 at 15:54 +0800, You-Sheng Yang wrote:
> > On 2020-08-01 01:15, Jon Derrick wrote:
> > > The pci_save_state call in vmd_suspend can be performed by
> > > pci_pm_suspend_irq. This allows the call to pci_prepare_to_sleep into
> > > ASPM flow.
> > > 
> > > The pci_restore_state call in vmd_resume was restoring state after
> > > pci_pm_resume->pci_restore_standard_config had already restored state.
> > > It's also been suspected that the config state should be restored before
> > > re-requesting IRQs.
> > > 
> > > Remove the pci_{save,restore}_state calls in vmd_{suspend,resume} in
> > > order to allow proper flow through PCI core power management ASPM code.
> > 
> > I had a try on this patch but `lspci` still shows ASPM Disabled.
> > Anything prerequisite missing here?
> > 
> 
> Is enabling L0s/L1/etc on a device something that the driver should be
> doing?

No.  ASPM should be completely managed by the PCI core.  There are a
few drivers that *do* muck with ASPM, but they are broken and they
cause problems.

Drivers can use pci_disable_link_state() to completely disable ASPM
states, e.g., if they are known to be broken in hardware.  But they
should not update the Link Control register directly because there are
specific requirements that involve both ends of the link, not just the
endpoint.

Bjorn
