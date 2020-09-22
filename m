Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7F274D64
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgIVXdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 19:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 19:33:35 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4C922206;
        Tue, 22 Sep 2020 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600817615;
        bh=jwF9DOzeIZ5gGIZT8xl2A5S/glutG512fwYCGqAjLAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dX4p+3KSf39qcG29Ew5bgrb0FLVmXwGaUPhTipxz7INAEOdIUTvJEXVGsxPRyfBo3
         ymW7sh8mrhapZHjGzoHvyJEUmrKICTqSGFentiRtvUkWNTcXH9NUcYpkVw1iLdwrQt
         VW4ys9et354HHvptLSQHmaRegGTb01GqyzL9ex4k=
Date:   Tue, 22 Sep 2020 18:33:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
Message-ID: <20200922233333.GA2239404@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cad1a07-509b-ef51-f635-71def2ff8293@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 02:44:51PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/22/20 11:52 AM, Bjorn Helgaas wrote:
> > On Fri, Jul 24, 2020 at 12:07:55PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > Current pcie_do_recovery() implementation has following two issues:
> > > 
> > 
> > I'm having trouble parsing this out, probably just lack of my
> > understanding...
> > 
> > > 1. Fatal (DPC) error recovery is currently broken for non-hotplug
> > > capable devices. Current fatal error recovery implementation relies
> > > on PCIe hotplug (pciehp) handler for detaching and re-enumerating
> > > the affected devices/drivers. pciehp handler listens for DLLSC state
> > > changes and handles device/driver detachment on DLLSC_LINK_DOWN event
> > > and re-enumeration on DLLSC_LINK_UP event. So when dealing with
> > > non-hotplug capable devices, recovery code does not restore the state
> > > of the affected devices correctly.
> > 
> > Apparently in the hotplug case, something *does* restore the state of
> > affected devices?
>
> Yes, in hotplug case, DLLSC state change handler takes over detachment
> /cleanup and re-attachment of affected devices/drivers.

Where does the restore happen here?  I.e., what function does this?
