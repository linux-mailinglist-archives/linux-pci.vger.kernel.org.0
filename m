Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5813BE87
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgAOLdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 06:33:18 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49561 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAOLdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 06:33:18 -0500
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 06:33:17 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C17B9101E6A30;
        Wed, 15 Jan 2020 12:24:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id ED75040D5F; Wed, 15 Jan 2020 12:24:29 +0100 (CET)
Date:   Wed, 15 Jan 2020 12:24:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org
Subject: Re: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
Message-ID: <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
References: <1579083986.15925.31.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579083986.15925.31.camel@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 11:26:26AM +0100, Oliver Neukum wrote:
> I got a bug report about some systems generating an NMI and
> subsequently crashing bisected down to 80696f991424d.
> Apparently these systems do not react well to __pciehp_enable_slot
> while no card is present. Restoring the check to __pciehp_enable_slot()
> removed in 80696f991424d makes the current kernels work.

That's odd, these systems must be setting the Data Link Layer Link Active
bit in the Link Status Register even though no card is present.


> What is to be done? Do you want a special case for the affected
> systems based on DMI, or should I revert 80696f991424d?

It would be good if we could get a better idea what's going on before
deciding what action to take.  What systems are we talking about exactly?
Can you provide dmesg and lspci -vvvv output including the NMI, e.g. by
attaching it to a new bugzilla?

Thanks,

Lukas
