Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCF463426
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhK3MZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:25:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56458 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhK3MZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39761B818FE
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F2C53FC7;
        Tue, 30 Nov 2021 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274932;
        bh=bIcR2swGnj8SqKE5jiL6iiFDYqPU9Z55FYaC5GxEUTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MNUBCKNoC2gPIVvNVNsnLe1SD050tMEJ4IYAqNVoc6KWNE39pCGN0Qmi6fbBrbKjt
         mJYkic/UJiP742JvPba73M7tLnNihAhus1FLpftdrOko87AiAiBUNcMmioV6UIprfd
         U5ySkWRmjoQLEMuN3ZIl7w6F32sCaAgRKXgyR8M3xJ0+s/rPaV1HumcyVb8eq8bj6W
         M+3xcNO2OYhyRtLrIzPkqB2dKP/OJ5jGb2WvKelxZNSAzGDfbuPgpu+ZAm20QneNmo
         EAx/p8S8EYeNYFhXaXGRWgi8OM2f8IJpnkoeuxy/GWeMG6J2j3RJzA7Gz4l5jJOVkE
         I4yhSe90MdaFg==
Date:   Tue, 30 Nov 2021 13:22:09 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 7/7] PCI: aardvark: Reset PCIe card and disable PHY at
 driver unbind
Message-ID: <20211130132209.3d3c717e@thinkpad>
In-Reply-To: <20211130103157.GA32648@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
        <20211031181233.9976-8-kabel@kernel.org>
        <20211129164043.GA26244@lpieralisi>
        <20211129181553.41a341bb@thinkpad>
        <20211130103157.GA32648@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 10:31:57 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Mon, Nov 29, 2021 at 06:15:53PM +0100, Marek Beh=C3=BAn wrote:
> > On Mon, 29 Nov 2021 16:40:43 +0000
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >  =20
> > > On Sun, Oct 31, 2021 at 07:12:33PM +0100, Marek Beh=C3=BAn wrote: =20
> > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > >=20
> > > > When unbinding driver, assert PERST# signal which prepares PCIe car=
d for
> > > > power down. Then disable link training and PHY.   =20
> > >=20
> > > This reads as three actions. If we carry them out as a single patch we
> > > have to explain why they are related and what problem they are solving
> > > as a _single_ commit.
> > >=20
> > > Otherwise we have to split this patch into three and explain each of
> > > them as a separate fix.
> > >=20
> > > I understand it is tempting to coalesce missing code in one single
> > > change but every commit must implement a single logical change. =20
> >=20
> > Hi Lorenzo,
> >=20
> > this is a fix for driver remove function. Although each of these things
> > could be introduced in separate commits, IMO it doesn't make sense to
> > split it. It should have been done this way in the first place when the
> > driver removal support was introduced. I guess we could rewrite the
> > commit message to:
> >=20
> >   PCI: aardvark: Disable controller entirely at driver unbind =20
>=20
> "PCI: aardvark: Fix the controller disabling sequence"
>=20
> >   Add the following to driver unbind to disable the controller entirely:
> >   - asserting PERST# signal
> >   - disabling link training
> >   - disable PHY
> >=20
> > Would this be okay? =20
>=20
> Yes, that's what I meant. I would describe the change in its entirety
> not as three fixes - it makes sense to have one single patch as long
> as we describe it properly.

After I went through it again, I think it would be better to split it
into 3 patches. I am going to do that this way.

Marek
