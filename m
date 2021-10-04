Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6742085E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJDJhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 05:37:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhJDJhZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 05:37:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94570101E;
        Mon,  4 Oct 2021 02:35:36 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C92E63F766;
        Mon,  4 Oct 2021 02:35:35 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:35:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20211004093530.GA22695@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
 <20211001195856.10081-2-kabel@kernel.org>
 <20211004084350.GB22336@lpieralisi>
 <20211004113251.053a02c6@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004113251.053a02c6@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 11:32:51AM +0200, Marek Behún wrote:
> On Mon, 4 Oct 2021 09:43:50 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Fri, Oct 01, 2021 at 09:58:44PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
> > > Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)  
> > 
> > This requires Bjorn's ACK.
> 
> Lorenzo, Bjorn already sent his Reviewed-by for this patch. Did you not
> receive it?

Apologies - missed it, nothing to do then.

Lorenzo
