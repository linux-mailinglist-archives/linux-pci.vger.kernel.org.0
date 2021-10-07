Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87630425412
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhJGN3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 09:29:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhJGN3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 09:29:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE08E6D;
        Thu,  7 Oct 2021 06:27:53 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E17ED3F66F;
        Thu,  7 Oct 2021 06:27:52 -0700 (PDT)
Date:   Thu, 7 Oct 2021 14:27:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     sashal@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH v2 07/13] PCI: aardvark: Do not unmask unused interrupts
Message-ID: <20211007132748.GA19754@lpieralisi>
References: <20211005180952.6812-1-kabel@kernel.org>
 <20211005180952.6812-8-kabel@kernel.org>
 <20211006091337.GA9287@lpieralisi>
 <20211006122823.59467d89@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006122823.59467d89@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 12:28:23PM +0200, Marek Behún wrote:
> On Wed, 6 Oct 2021 10:13:38 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > [CC Sasha for stable kernel rules]
> > 
> > On Tue, Oct 05, 2021 at 08:09:46PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > There are lot of undocumented interrupt bits. Fix all *_ALL_MASK macros to
> > > define all interrupt bits, so that driver can properly mask all interrupts,
> > > including those which are undocumented.
> > > 
> > > Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > Cc: stable@vger.kernel.org  
> > 
> > I don't think this is a fix and I don't think it should be sent
> > to stable kernels in _preparation_ for other fixes to come (that
> > may never land in mainline).
> 
> This patch is a fix because it fixes masking interrupts, which may
> prevent spurious interrupts - we don't want interrupts which kernel
> didn't request for.
> 
> I agree that the commit message should probably mention this, though...
> :(

Now it does ;-), will notify you when I push the series out so that
you can have a look to check.

Thanks,
Lorenzo

> 
> Marek
