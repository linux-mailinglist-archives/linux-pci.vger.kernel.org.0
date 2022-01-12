Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2418E48CE05
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiALVuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 16:50:05 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:58313 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiALVuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 16:50:03 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id AD62328018C1D;
        Wed, 12 Jan 2022 22:50:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A0DF3385884; Wed, 12 Jan 2022 22:50:00 +0100 (CET)
Date:   Wed, 12 Jan 2022 22:50:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220112215000.GA4972@wunner.de>
References: <20220112013100.48029-1-jim2101024@gmail.com>
 <20220112175106.GA267550@bhelgaas>
 <20220112180011.GA1319@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112180011.GA1319@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 06:00:11PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 12, 2022 at 11:51:06AM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:
> > What's this connected to?  Is this a fix for a patch that has already
> > been merged?  If so, which one?  If it's a standalone thing, it needs
> > a commit log and a Signed-off-by.  Actually, that would be good in any
> > case.  Maybe a lore link to the relevant patch?
> 
> I was about to reply. It is a fixup for one of the branches I am
> queueing for v5.17 (pci/brcmstb), I can either squash that it myself or
> you can do it, provided that Jim gives us the commit id this is actually
> fixing (or a lore link to the patch posting so that we can infer the
> commit to fix).

If you apply the patch to the pci/host/brcmstb branch with "git am"
as usual, then execute "git rebase --autosquash v5.16-rc1",
git will automatically figure out the commit id this patch is fixing,
fold it into the commit and rebase the remainder of the branch on top
of it.

Thanks,

Lukas
