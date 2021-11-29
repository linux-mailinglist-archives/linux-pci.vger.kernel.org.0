Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA43346224F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 21:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhK2UnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 15:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhK2UlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 15:41:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06318C09677B
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 09:16:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2F3BB8120F
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 17:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5801C53FAD;
        Mon, 29 Nov 2021 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638206157;
        bh=JP6Bblx4Vh3MrNtB3GUhSi7CyJJS9rWRtyMrbQenCAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hg6EVArRLKF7E7C9HpuFrK3sx0YhUWcw5eMpwULioa+gn3FESKRhQJXw+KOFgadIf
         WDWyJk5X/ZTIvRmoU5koPLSNupzhYHdV67J8faBPLJiDvNIEEbz5xTuHPEPnDHsni3
         MneQEr4BAkyiTmREJsDsrxnEmZb6o+/p2H8KMAbRELAZVsy8q3PC1M0eD1vVh9lV9v
         nMT/dts7Bt7CN+Zgpbk6Cbdyu7uoXsMNNQjcXfoM7oU2cslP5eES8K1ZGeexi/8wPw
         KsesK9yVPr0q7fzoNkbtfrpoSW+I4Nb9ILW/n13eSiqQyx9JLDumketjdnPJZFFfy/
         oyhGMapgniHdQ==
Date:   Mon, 29 Nov 2021 18:15:53 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 7/7] PCI: aardvark: Reset PCIe card and disable PHY at
 driver unbind
Message-ID: <20211129181553.41a341bb@thinkpad>
In-Reply-To: <20211129164043.GA26244@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
        <20211031181233.9976-8-kabel@kernel.org>
        <20211129164043.GA26244@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 29 Nov 2021 16:40:43 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Sun, Oct 31, 2021 at 07:12:33PM +0100, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > When unbinding driver, assert PERST# signal which prepares PCIe card for
> > power down. Then disable link training and PHY. =20
>=20
> This reads as three actions. If we carry them out as a single patch we
> have to explain why they are related and what problem they are solving
> as a _single_ commit.
>=20
> Otherwise we have to split this patch into three and explain each of
> them as a separate fix.
>=20
> I understand it is tempting to coalesce missing code in one single
> change but every commit must implement a single logical change.

Hi Lorenzo,

this is a fix for driver remove function. Although each of these things
could be introduced in separate commits, IMO it doesn't make sense to
split it. It should have been done this way in the first place when the
driver removal support was introduced. I guess we could rewrite the
commit message to:

  PCI: aardvark: Disable controller entirely at driver unbind

  Add the following to driver unbind to disable the controller entirely:
  - asserting PERST# signal
  - disabling link training
  - disable PHY

Would this be okay?

Marek
