Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D986420917
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJDKMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 06:12:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhJDKMu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 06:12:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D8F31FB;
        Mon,  4 Oct 2021 03:11:01 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1BB33F766;
        Mon,  4 Oct 2021 03:11:00 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:10:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 10/13] PCI: aardvark: Simplify initialization of rootcap
 on virtual bridge
Message-ID: <20211004101054.GA23838@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
 <20211001195856.10081-11-kabel@kernel.org>
 <20211004094422.GA22827@lpieralisi>
 <20211004115656.32f2630b@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004115656.32f2630b@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 11:56:56AM +0200, Marek Behún wrote:
> On Mon, 4 Oct 2021 10:44:22 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Fri, Oct 01, 2021 at 09:58:53PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > PCIe config space can be initialized also before pci_bridge_emul_init()
> > > call, so move rootcap initialization after PCI config space initialization.
> > > 
> > > This simplifies the function a little since it removes one if (ret < 0)
> > > check.
> > > 
> > > Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")  
> > 
> > Is this a fix ? If not I will remove this tag.
> 
> It is not a fix, but we put the Fixes patch there because another patch
> that is a fix depends on it. But that another patch will come in
> another batch, after this was is applied. So maybe we could drop this
> patch now.
> 
> Or you can remove the Fixes tag, but then we will have to send this by
> hand to stable.

It would help me to focus on a series at a time please, I understand
it has been taking a while to get them reviewed and it is complicated
to handle a big patch stack, let's focus on a self-contained series
at a time please.

I'd keep this patch and remove the Fixes: tag, stable dependencies
can be specified if and when required.

Lorenzo
