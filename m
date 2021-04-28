Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3690C36DED7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbhD1SM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 14:12:57 -0400
Received: from 8bytes.org ([81.169.241.247]:36574 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240210AbhD1SM5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 14:12:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 32FF9366; Wed, 28 Apr 2021 20:12:11 +0200 (CEST)
Date:   Wed, 28 Apr 2021 20:12:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [RFC PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <YImld9VyBOGvPdiA@8bytes.org>
References: <20210428081857.10322-1-joro@8bytes.org>
 <d24893db-2c9e-dbb1-75d2-53b96760c80e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24893db-2c9e-dbb1-75d2-53b96760c80e@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 10:21:12AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 4/28/21 1:18 AM, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The acpi_pci_osc_support() does an _OSC query with _OSC supported set
> > to what the OS supports but a zero _OSC control value. This is
> > problematic on some platforms where the firmware allows to configure
> > whether DPC is under OS or Firmware control.
> 
> Do we run acpi_pci_osc_support() only to check whether _OSC is
> supported ? Or does it serve any other purpose.

I am not 100% sure, but to me it looks like the pure purpose of the
acpi_pci_osc_support() call was indeed to check whether the firmware is
willing to grant the OS control over some PCIe features.

> > When DPC is configured to be under OS control these platforms will
> > issue a warning in the firmware log that the OS does not support DPC.
> 
> Also, is there any other benefit from this patch other than fixing
> a warning message in firmware?

Not much other benefit, besides some removed code. But those messages
can confuse the system owner and are worth getting rid of imho.

Regards,

	Joerg

