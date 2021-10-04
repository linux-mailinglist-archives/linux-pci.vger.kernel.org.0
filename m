Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712542068B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJDHXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 03:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDHXk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 03:23:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8492610FB;
        Mon,  4 Oct 2021 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633332112;
        bh=O/RmsJxvdgiRBdOlZx3KYtd+JhYIr9QEpTEww/Ej2J8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t82Ih85bGCuAb9c4u66WUDbc+4h7eqPcp20oMtvfKwc9nu9oYocgLzR7XIskGikjd
         3MI70BsE3oV/pDAo1wojygJBHqUB1k+6YTpnYgiCARr7wJ5pLZ/tVVApe8t1VP1Sml
         dsSLQHO+ACKY8fpse6QGWHeE+I986EWKkTtj8/UJbPGWigvZ1N0LzIDA7ZAvnB5cZb
         fgqhGg81pVfw0S1byctvN6wF5cwtW5KdDQL46hXeooxIOSSe4we4EE8ljedNYzt6Xg
         utXIgOkYiYXnvR4nMxp25sBW6HEpDUc+4cORaSiELzdKoWb6xgZAu1hxBZxpc8EfKP
         puZyD8o2zDIWQ==
Date:   Mon, 4 Oct 2021 09:21:48 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211004092148.6e18f6f5@thinkpad>
In-Reply-To: <20211002163519.GA973164@bhelgaas>
References: <20211001195856.10081-10-kabel@kernel.org>
        <20211002163519.GA973164@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2 Oct 2021 11:35:19 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > handling of CRS response and when CRSSVE flag was not enabled it marked=
 CRS
> > response as failed transaction (due to simplicity).
> >=20
> > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT co=
unt
> > for PIO config response and so we can with a small change implement
> > re-issuing of config requests as described in PCIe base specification.
> >=20
> > This change implements re-issuing of config requests when response is C=
RS.
> > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
> > transaction is marked as failed and an all-ones value is returned as
> > before. =20
>=20
> Does this fix a problem?

Hello Bjorn,

Pali has suspisions that certain Marvell WiFi cards may need this [1]
to work, but we do not have them so we cannot test this.

I guess you think this should be considered a new feature instead of a
fix, so that the Fixes tag should be removed, yes? Pali was of the
opinion that this patch "fixes" the driver to conform more to the PCIe
specification, that is why we added the Fixes tag.

Anyway if you think this should be considered a new feature, this patch
can be skipped. The following patches apply even without it.

Marek

[1]
https://lore.kernel.org/linux-wireless/CAHp75Vd5iCLELx8s+Zvcj8ufd2bN6CK26so=
DMkZyC1CwMO2Qeg@mail.gmail.com/
