Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1CE110083
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCOma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 09:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCOma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 09:42:30 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882D420661;
        Tue,  3 Dec 2019 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575384149;
        bh=X0tSYbxhCgxkGi0QUqni+3iiK1EwhvPfsy2UsM12iAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p4aDQItokXXJj8o5Ey/eviueffDtwz0GdZ4C8KFI0W+7eIuaCtHK+sPIFmzoNOrOD
         aPJMROb4YyE4jcJ31MMo5c091ibWV5urkso0ssUGH7DUq4IFsDKMwBXbOBMNoBi+eo
         dPZ3Lqd258OB2j15NlG11T6xaDfDf23FgS/gYNdg=
Date:   Tue, 3 Dec 2019 08:42:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
Message-ID: <20191203144226.GA255690@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd7Wqw56pPXFgvk+vNnrMCeVow6Op2mXONiqHs4C9NrMfS=VQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 03, 2019 at 02:06:57PM +0000, Wei Liu wrote:
> On Wed, 27 Nov 2019 at 10:59, Wei Liu <wei.liu@kernel.org> wrote:
> >
> > On Tue, 26 Nov 2019 at 23:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> > > > CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> > > > in.  Removing the ifdef will allow us to build the driver as a module.
> > > >
> > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > >
> > > Sorry, I missed this thinking it would be under drivers/pci/controller
> > > and hence handled by Lorenzo.
> > >
> > > So I guess this doesn't fix a build problem, but without this patch,
> > > we just don't run the quirk if the driver is a module, right?
> >
> > Yes, this is correct.
> >
> > Without this patch, the quirk doesn't get to run if the driver is a module.
> 
> Are you satisfied with the patch? What do I need to do to get it merged?

You needn't do anything.  I'll clarify the changelog (the patch
doesn't actually *enable* building the driver as a module; it merely
ensures that we include the quirk in that case).

This is too late for v5.5, so it will get merged for v5.6 unless the
modular driver itself was enabled for v5.5.

Bjorn
