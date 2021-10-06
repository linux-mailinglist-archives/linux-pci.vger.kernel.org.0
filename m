Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4437F423B7D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhJFKaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 06:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJFKaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 06:30:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7102D61177;
        Wed,  6 Oct 2021 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633516107;
        bh=mshNwlVmerkEFJOsxcZYJpjomSbsSZrnhbhRQ9qdk6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tBfNDrHcwtE2vcgHgxbMGLsQg6lxNoPvbHu+Lka+kDnAlbbIqRxDyvrpGrcFAenxI
         M6NDzELH8rsGOdw8ZrCyEXQzEW1EivejahgNaRlrdn3q1p5li1s3iVB6RbvEAy9k7s
         3LS58m0C83WKPB6yyOhP8b7jKvSzkeWbP5b9Vra5CHK10k4i/1PvuHBNCHbNJYGrkk
         9IMOgP7PIEzvyMtd4gsexu2bFHTC9B36P4n5WHoBG5T5q8q1VzMZxQb/3pwDhMP9CT
         NDgbn8Ma54KIJZH0HQ8Fk1gLJeV8tD2to0cbZDXJp+BLElEjm7PllSM2kR8q5Vy9Sv
         2ObY5c/8Lqj+Q==
Date:   Wed, 6 Oct 2021 12:28:23 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     sashal@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH v2 07/13] PCI: aardvark: Do not unmask unused interrupts
Message-ID: <20211006122823.59467d89@thinkpad>
In-Reply-To: <20211006091337.GA9287@lpieralisi>
References: <20211005180952.6812-1-kabel@kernel.org>
        <20211005180952.6812-8-kabel@kernel.org>
        <20211006091337.GA9287@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Oct 2021 10:13:38 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> [CC Sasha for stable kernel rules]
>=20
> On Tue, Oct 05, 2021 at 08:09:46PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > There are lot of undocumented interrupt bits. Fix all *_ALL_MASK macros=
 to
> > define all interrupt bits, so that driver can properly mask all interru=
pts,
> > including those which are undocumented.
> >=20
> > Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller d=
river")
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Cc: stable@vger.kernel.org =20
>=20
> I don't think this is a fix and I don't think it should be sent
> to stable kernels in _preparation_ for other fixes to come (that
> may never land in mainline).

This patch is a fix because it fixes masking interrupts, which may
prevent spurious interrupts - we don't want interrupts which kernel
didn't request for.

I agree that the commit message should probably mention this, though...
:(

Marek
