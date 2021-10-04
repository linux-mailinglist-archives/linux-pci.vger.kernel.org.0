Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAF420943
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJDKVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 06:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDKVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 06:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E575613A2;
        Mon,  4 Oct 2021 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342782;
        bh=AxMsJc0OWSGhY/JRXJnGZ7RDrxofSUQSVhY6tCgGoag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqvn1Oph8sNvlKhUwdbBrx4vWhiXNlseR1WTO04xNGNgeFjscwTWdHbCvg4haGt7v
         6zLXuWEfdeDwN9HCKHqdwNU4/DSLYQYNHvMD2ek5uUxpqgMuAaFxTqWlqXpPg++6ul
         xrBG/b4Smr07R/tvhqviTKWXnckOJFJQOMpT9tO+Zj4HM7iFFOvPEyXLxXUNs8GOnq
         wzjzm86ydvGIjvGK0ZIqClVfci4akZS+5GnLaMZI3eMKjjqx6gA3grO9MLn3nq4z+H
         v+JsJRKog6GH43DhWhXhcm+cMhN0rbKS9MJsnN57/YJXfW+BzMyulUydFV0hp34Sdk
         vIEHnEm/GfX3A==
Date:   Mon, 4 Oct 2021 12:19:38 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211004121938.546d8f73@thinkpad>
In-Reply-To: <20211004085335.GC22336@lpieralisi>
References: <20211001195856.10081-10-kabel@kernel.org>
        <20211002163519.GA973164@bhelgaas>
        <20211004092148.6e18f6f5@thinkpad>
        <20211004085335.GC22336@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 Oct 2021 09:53:35 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Mon, Oct 04, 2021 at 09:21:48AM +0200, Marek Beh=C3=BAn wrote:
> > On Sat, 2 Oct 2021 11:35:19 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >  =20
> > > On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Beh=C3=BAn wrote: =20
> > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > >=20
> > > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > > handling of CRS response and when CRSSVE flag was not enabled it ma=
rked CRS
> > > > response as failed transaction (due to simplicity).
> > > >=20
> > > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CN=
T count
> > > > for PIO config response and so we can with a small change implement
> > > > re-issuing of config requests as described in PCIe base specificati=
on.
> > > >=20
> > > > This change implements re-issuing of config requests when response =
is CRS.
> > > > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards =
the
> > > > transaction is marked as failed and an all-ones value is returned as
> > > > before.   =20
> > >=20
> > > Does this fix a problem? =20
> >=20
> > Hello Bjorn,
> >=20
> > Pali has suspisions that certain Marvell WiFi cards may need this [1]
> > to work, but we do not have them so we cannot test this.
> >=20
> > I guess you think this should be considered a new feature instead of a
> > fix, so that the Fixes tag should be removed, yes? Pali was of the
> > opinion that this patch "fixes" the driver to conform more to the PCIe
> > specification, that is why we added the Fixes tag.
> >=20
> > Anyway if you think this should be considered a new feature, this patch
> > can be skipped. The following patches apply even without it. =20
>=20
> I do not think we should apply to the mainline a fix that can't be
> tested sorry, I will skip this patch.

Lorenzo,

my explanation was incorrect.

The functionality added by this patch _is_ tested and correctly does a
retry: it was done by simulating a CRS reply.

We just don't know whether there are real cards used by users that
need this functionality (the mentioned Marvell card may be such a card).

Marek
