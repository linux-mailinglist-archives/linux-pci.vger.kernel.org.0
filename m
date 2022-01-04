Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBD484801
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiADSli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 13:41:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44500 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADSlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 13:41:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61E84CE1A18
        for <linux-pci@vger.kernel.org>; Tue,  4 Jan 2022 18:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B706C36AE9;
        Tue,  4 Jan 2022 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641321694;
        bh=mBJjCCLMP/RBsFM0GazrJ+5hCnneoeEwt8+inK9FcpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LvNRWNm4yL0Gp8PsC0v/wA90ydyrxkNCjG0GJClRnqbW6RSBx4lCNtE6tz1OkH40W
         tJ7ViFyDKI59cICgE76zLRE6Tsqqp0+1q7Gmlshb6Pbd9E4VXcY8gs8ZRnYP2MRPp6
         ZflZJ30Ul40bJTxTMO1mFgSnU8t9ChFrpTfxy11pKd+zU+99tiLH57b7yJlZNhbFCf
         +s0JAIXQJ+WXMSYBNJhlEuCD1NTQGH+438tZHKK0UX8TxDVML04vuePWmhP22Xm7bb
         wV3ME0ZqoxpjLqXhhetp5C2UT4ahMheD2768753CgzEr8rp63dWPRN04j7EphhDDI4
         IvRNrtcu8FNfg==
Date:   Tue, 4 Jan 2022 19:41:29 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 00/17] PCI: aardvark controller fixes BATCH 4
Message-ID: <20220104194129.482a23c6@thinkpad>
In-Reply-To: <e5c1f563f8b4eed36a2bf68bead00f83@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
        <20211208072205.47134b27@thinkpad>
        <e5c1f563f8b4eed36a2bf68bead00f83@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Dec 2021 07:55:48 +0000
Marc Zyngier <maz@kernel.org> wrote:

> On 2021-12-08 06:22, Marek Beh=C3=BAn wrote:
> > Hello Marc,
> >=20
> > sorry about this, I wanted to send this series also to you, but
> > I accidentally sent it to your @arm.com e-mail address.
> > Does that address still work? Should I resend to your @kernel.org
> > address? =20
>=20
> My @arm.com address stopped working over two years ago. I guess
> my ex-manager is busy reviewing your patches!
>=20
> No need to resend, I'll fetch the series from lore.
>=20
> Thanks,
>=20
>          M.

Hello Marc,

did you manage to find some time to look at this series?

Thanks.

Marek
