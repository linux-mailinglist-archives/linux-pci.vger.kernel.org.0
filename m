Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6C13D3D2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 06:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPFkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 00:40:36 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:32815 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPFkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 00:40:36 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 00:40:35 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4C91630015070;
        Thu, 16 Jan 2020 06:35:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 158F31213BC; Thu, 16 Jan 2020 06:35:00 +0100 (CET)
Date:   Thu, 16 Jan 2020 06:35:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
Message-ID: <20200116053500.chp4rsbeflg3qrdr@wunner.de>
References: <1579083986.15925.31.camel@suse.com>
 <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Stuart]

On Wed, Jan 15, 2020 at 12:24:29PM +0100, Lukas Wunner wrote:
> On Wed, Jan 15, 2020 at 11:26:26AM +0100, Oliver Neukum wrote:
> > I got a bug report about some systems generating an NMI and
> > subsequently crashing bisected down to 80696f991424d.
> > Apparently these systems do not react well to __pciehp_enable_slot
> > while no card is present. Restoring the check to __pciehp_enable_slot()
> > removed in 80696f991424d makes the current kernels work.
> 
> That's odd, these systems must be setting the Data Link Layer Link Active
> bit in the Link Status Register even though no card is present.

Recent PCIe versions allow turning off in-band presence detect, in which
case the DLLLA bit can be set even though Presence Detect is not set.
You may be dealing with one of those systems but without full dmesg
and lspci output this is just an educated guess.

A series was submitted by Dell last year to support disabling in-band
presence detect, but it hasn't been merged yet by Bjorn:

https://lore.kernel.org/linux-pci/20191025190047.38130-1-stuart.w.hayes@gmail.com/

You may want to try if that series helps.

Thanks,

Lukas


> > What is to be done? Do you want a special case for the affected
> > systems based on DMI, or should I revert 80696f991424d?
> 
> It would be good if we could get a better idea what's going on before
> deciding what action to take.  What systems are we talking about exactly?
> Can you provide dmesg and lspci -vvvv output including the NMI, e.g. by
> attaching it to a new bugzilla?
> 
> Thanks,
> 
> Lukas
