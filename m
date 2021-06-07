Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1439E112
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFGPpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 11:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhFGPpt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 11:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FCC761029;
        Mon,  7 Jun 2021 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623080637;
        bh=embE+av5DCb18g6eagqQwnFEILspD+IVcIITWOKcWRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Haof8aH+QNGg8uw/Her4PB5ur4jRXFKM9TpwE6Xl64hFzgPmA6sghWyvxcZbifk2T
         utGtL9q0ftz5VLpcOCs9WH/F1KbkvE11Nwjndl+eiBIol8RGauDPqdgw0rC0AdJlAb
         JTYpdfblkZq6rWCuKyMREkkIQzx6iZXBKtOu47o/emzgWNm0SnBMBCDjhqgcirvLne
         msrTxfpzg2zhDTyw3pX6Xz46bfECCVklDy3wIQAQhkpS21Ve+gRAl2Lm6pJbvytVUi
         BWrOk6sX8yicVTUg8CcyPIz+K4FT6tc6dwG4Kcdtqe4AcYUaQOttAfo4ih9koGcvL8
         4ZiL6wAZq0dFw==
Date:   Mon, 7 Jun 2021 10:43:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <20210607154356.GA2492093@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4o1pJyIm74Lwz3@suse.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 07, 2021 at 04:10:30PM +0200, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Thu, Jun 03, 2021 at 03:50:47PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 03, 2021 at 02:48:14PM +0200, Joerg Roedel wrote:
> 
> > If instead you mean that the OS has *not* been granted DPC control,
> > but does _OSC(Query, SUPPORT=x, CONTROL=0), I think that means the OS
> > is telling the platform what it supports but not requesting anything.
> > That sounds legal to me, so if firmware complains about it, I would
> > say it's a firmware problem.
> 
> I think it depends on how you look at it. The machine I was working with
> has a BIOS setting where one can configure that DPC is controlled by the
> OS. When it is configured that way, then the BIOS will issue an error
> when an _OSC query is made with control set to 0. This is because it
> indicates to the BIOS that the OS does not take control over DPC and
> thus that the OS does not support it. The BIOS will issue a warning into
> its log and when the Linux later takes control the warning is already
> there.

I think that BIOS setting is misguided.  _OSC is designed around the
assumption that features in the Control field start out being
controlled by the platform, and they stay that way until the OS
requests control of a feature and the platform grants it.

It makes no sense to me to configure the BIOS in advance to say "the
OS controls DPC."  The BIOS has no control over what the OS will do,
and it can't behave as though the OS controls DPC until the OS
actually requests that.

I also think the warning is overly aggressive.  _OSC is clearly
designed to be evaluated multiple times, and the OS is allowed to
request control of more features each time (ACPI v6.3, sec 6.2.11.1.1,
6.2.11.1.3).

Bjorn
