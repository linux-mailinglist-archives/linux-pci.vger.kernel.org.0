Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0569340DCBD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhIPOe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 10:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237656AbhIPOeT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 10:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E281761214;
        Thu, 16 Sep 2021 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631802779;
        bh=VAoz05Oj6Ro+NaKLzDh0krZCRZNIAvmgNKrs4VEOQzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vLshLpePQEPOFCXlBz3lca6aEQpEDLhsG4Uy+RNWDy9cnpOMzDKEM2pGRFOdq4aPo
         6LnO90Bky46bjlrPmEfhUGHoguQAr4QOm/Zlxy6BOLWHvQ9pVwJ2Xx1LRSpupRdSie
         WM0H2jZMTIMni+3XxA5Iruu4cjlLRj182qZsmJSaEUXC9PjJ3JBtF+mpu9ddu/PVSF
         KDoH6jvnBdeqPtZQQvBsSy0xBsSAb9NbKGgbMPB7UIQ3hbH086gnj9344kj327PAjY
         KfeRuDPBf3Z/FJihEp0FzS1autpkAdrNbIQUo8FK/S3qs8ZI5QnWIQBh+5vgjiOIUL
         vYZPW2zf30TSQ==
Date:   Thu, 16 Sep 2021 09:32:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210916143257.GA1608462@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915105553.6eaqakvrmag6vxeq@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 15, 2021 at 12:55:53PM +0200, Pali Rohár wrote:
> On Tuesday 14 September 2021 15:55:26 Bjorn Helgaas wrote:

> > It is illegal for a device to return CRS after it has returned a
> > successful completion unless an intervening reset has occurred, so
> > drivers and other code should never see it.
> > 
> > > And issue is there also with write requests. Is somebody checking return
> > > value of pci_bus_write_config function?
> > 
> > Similar case here.  The enumeration and wait-after-reset paths always
> > do *reads* until we get a successful completion, so I don't think we
> > ever issue a write that can get CRS.
> 
> Yes, in normal conditions we should not see it.
> 
> But for testing purposes (that emulated bridge works fine) I'm using
> setpci for changing some configuration.
> 
> And via setpci it is possible to turn off CRSSVE bit in which case then
> Root Complex should re-issue request again.
> 
> I'm not sure how "legal" it is if userspace / setpci changes some of
> these bits. At least on a hardware with a real Root Port device it
> should be fully transparent. As hardware handles this re-issue and
> kernel then would see (reissued) response.

If setpci changes bits like these, all bets are off.  We can't tell
what happened, so we can't rely on any configuration Linux did.  I
think we really should taint the kernel when this happens.

> Test case: Initialize device, then unbind it from sysfs, reset it (hot
> reset or warm reset) and then rescan / reinit it again. Here device is
> permitted to send CRS response.
> 
> We know that more PCIe cards are buggy and sometimes firmware on cards
> crashes or resets card logic. Which may put card into initialization
> state when it is again permitted to send CRS response.

Yep.  That's a buggy device and normally we would work around it with
a quirk.  This particular kind of bug would be hard to work around,
but a host bridge driver doesn't seem like the right place to do it
because we'd have to do it in *every* such driver.

Bjorn
