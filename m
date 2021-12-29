Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463834815AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhL2ROR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhL2ROQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 12:14:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C7C061574
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 09:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B657B819B1
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 17:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBA3C36AE7;
        Wed, 29 Dec 2021 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640798053;
        bh=n1xLgvlA1kE5NDMjfx+HCkQvhhrrv977YVRBMZfX48o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BoQZh4ztviNTlSGYbIhGUQz52QEt9t6umDU1LIF3zHEbPWkK/sMRbxsoyC0mWEFw6
         kVAReEguc4gTY1xE3LtVWLDwcJRwnO7LUFIR7Cl2nuxuQGIRTXMjD8ItMwrgofTZz8
         3oluhKZB0HjUR90Yrdy9hdGrcwPT5c0Yt/hSjLWtM/NEZZmUVjirDkoyLCXF0Sqd7D
         LZXDJfxAGW1ticYoTE5z6v2iCqJ5poerzuUljVI2H6BqRrSRKmtBiTl+DasPKWf20m
         KqgjG/7JIG2ra71ozhV5FgEWjXOo8JUf7pJgMWAYVunRZErxOwSg/U48QT7niZAs10
         RJScA7pstwrHQ==
Date:   Wed, 29 Dec 2021 11:14:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     linux-pci@vger.kernel.org, bjorn@helgaas.com
Subject: Re: [PATCH 00/13] Unify device * to platform_device *
Message-ID: <20211229171412.GA1686464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228193801.GA54107@claire-ThinkPad-T470>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 28, 2021 at 08:38:01PM +0100, Fan Fei wrote:
> On Wed, Dec 22, 2021 at 06:43:37PM -0600, Bjorn Helgaas wrote:
> > On Sat, Nov 27, 2021 at 03:11:08PM +0100, Fan Fei wrote:
> > > Some PCI controller structs contain "device *", while others contain
> > > "platform_device *". These patches unify "device *dev" to
> > > "platform_device *pdev" in 13 controller struct, to make the controller
> > > struct more consistent. Consider that PCI controllers interact with
> > > platform_device directly, not device, to enumerate the controlled
> > > device.
> > 
> > I went through all the controller drivers using a command like this:
> > 
> >   git grep -A4 -E "^struct .*_pci.?\> \{$" drivers/pci/controller/
> > 
> > and found that almost all of them hang onto the "struct device *", not
> > the "struct platform_device *".  Many of these are buried inside struct
> > dw_pcie and struct cdns_pcie.
> >
> Do you mean most of these structs contain dw_pcie and cdns_pcie, both of
> which contain "sturct device *"?

Yes.

> > I know I've gone back and forth on this, but I don't think the churn of
> > converting some of them to keep the "struct platform_device *" would be
> > worthwhile.
> > 
> I could convert "platform_device *" back to "device *", e.g. in the
> pcie-altear.c. What do you think?

No, I don't think we should do that.  I don't think there's really any
benefit right now.

Bjorn
