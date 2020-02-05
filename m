Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB0153073
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEMPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 07:15:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:47212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgBEMPb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 07:15:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81B68ACC6;
        Wed,  5 Feb 2020 12:15:29 +0000 (UTC)
Message-ID: <1580904900.9756.9.camel@suse.com>
Subject: Re: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
From:   Oliver Neukum <oneukum@suse.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Wed, 05 Feb 2020 13:15:00 +0100
In-Reply-To: <20200116053500.chp4rsbeflg3qrdr@wunner.de>
References: <1579083986.15925.31.camel@suse.com>
         <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
         <20200116053500.chp4rsbeflg3qrdr@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 16.01.2020, 06:35 +0100 schrieb Lukas Wunner:
> [cc += Stuart]
> 
> On Wed, Jan 15, 2020 at 12:24:29PM +0100, Lukas Wunner wrote:
> > On Wed, Jan 15, 2020 at 11:26:26AM +0100, Oliver Neukum wrote:
> > > I got a bug report about some systems generating an NMI and
> > > subsequently crashing bisected down to 80696f991424d.
> > > Apparently these systems do not react well to __pciehp_enable_slot
> > > while no card is present. Restoring the check to __pciehp_enable_slot()
> > > removed in 80696f991424d makes the current kernels work.
> > 
> > That's odd, these systems must be setting the Data Link Layer Link Active
> > bit in the Link Status Register even though no card is present.
> 
> Recent PCIe versions allow turning off in-band presence detect, in which
> case the DLLLA bit can be set even though Presence Detect is not set.
> You may be dealing with one of those systems but without full dmesg
> and lspci output this is just an educated guess.
> 
> A series was submitted by Dell last year to support disabling in-band
> presence detect, but it hasn't been merged yet by Bjorn:
> 
> https://lore.kernel.org/linux-pci/20191025190047.38130-1-stuart.w.hayes@gmail.com/
> 
> You may want to try if that series helps.

Hi,

it has been tested and it does the job. May I ask whether you could
ack it or propose necessary changes, so that we can proceed?

	Regards
		Oliver

