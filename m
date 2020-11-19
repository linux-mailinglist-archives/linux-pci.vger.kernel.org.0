Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8FC2B9DA9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 23:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKSW1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 17:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSW1o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 17:27:44 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1450B208FE;
        Thu, 19 Nov 2020 22:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605824863;
        bh=yNi3coEAq9lkPw1fyD83ieN+fg9nmfHvLa713q90lXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D7y519SwSUYj4kBqlo/hHDLK0XMzsD3Ll8iEGZVA2o+iPBUCocWIPeBs7DFiXqF8m
         oz+CT1tHHAVNwYxi6hej90wsELCc5lxZ5JkrOGLUnJWTDr72CPVV0PZsdlLzlEpC5Y
         7cMfxsIevZj827CyEFQkL4FaROYJouDn94+Z6wWA=
Date:   Thu, 19 Nov 2020 16:27:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201119222741.GA206150@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119220807.GB102444@otc-nc-03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ashok,

When you update this patch, can you run "git log --oneline
drivers/pci/hotplug/pciehp*" and make yours match?  It is a severe
character defect of mine, but seeing subject lines that are obviously
different than the convention is a disincentive to look at the patch.

On Thu, Nov 19, 2020 at 02:08:07PM -0800, Raj, Ashok wrote:
> On Thu, Nov 19, 2020 at 08:51:20AM +0100, Lukas Wunner wrote:
> > Hi Ashok,
> > 
> > my sincere apologies for the delay.
> 
> No worries.. 
> 
> > 
> > On Fri, Sep 25, 2020 at 04:01:38PM -0700, Ashok Raj wrote:
> > > When Mechanical Retention Lock (MRL) is present, Linux doesn't process
> > > those change events.
> > > 
> > > The following changes need to be enabled when MRL is present.
> > > 
> > > 1. Subscribe to MRL change events in SlotControl.
> > > 2. When MRL is closed,
> > >    - If there is no ATTN button, then POWER on the slot.
> > >    - If there is ATTN button, and an MRL event pending, ignore
> > >      Presence Detect. Since we want ATTN button to drive the
> > >      hotplug event.
