Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D943E610
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJ1Q1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 12:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJ1Q1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 12:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C77C610CF;
        Thu, 28 Oct 2021 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635438318;
        bh=dupVla8iZp30AwsennkwWsCSF5gR4nW+zyjMX4oLj74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ncnQX4EoWvtSuaq1xXCzK3Jr6+2qgTcx2PvG101kLi4UrDcNi6Po03IqJ+60NCd43
         vnlak5QpqvFb+AcRhRvBsYt5GlEYFObGJKAIXumXisyXXyo74HUvtkf48VNGU9wJLS
         ie256PJgDMSmiYzLKj+wptGItzGV9ti96Qeiw5Vc9jRlMSw4hZ1je9o8b+iXSTNVpN
         5pOb5COs5RXqjDd9+zvmGM5RP5rr4mN+OFW1DkDNUQbsR2i8yJbR7zFlWyhJ/gQzKG
         3w2jySLk1wohFA+PbAswa793r46JHymuFBidjyDywUFULnYDizi/QGQNG9ao8QwIcs
         vGz9t9efN39sA==
Date:   Thu, 28 Oct 2021 18:25:14 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028182514.65a94c8e@thinkpad>
In-Reply-To: <20211028175150.7faa6481@thinkpad>
References: <20211012164145.14126-1-kabel@kernel.org>
        <20211012164145.14126-11-kabel@kernel.org>
        <20211027141246.GA27543@lpieralisi>
        <20211027142307.lrrix5yfvroxl747@pali>
        <20211028110835.GA1846@lpieralisi>
        <20211028111302.gfd73ifoyudttpee@pali>
        <20211028113030.GA2026@lpieralisi>
        <20211028113724.gm6zhqt7qcyxtgkq@pali>
        <87r1c59nqf.wl-maz@kernel.org>
        <20211028175150.7faa6481@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Oct 2021 17:51:50 +0200
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> Marc, we have ~70 patches ready for the aardvark controller driver.
>=20
> It is patch 53 [1] that converts the old irq_find_mapping() +
> generic_handle_irq() API to the new API, so it isn't that Pali did
> not address your comments, it is that, due to convenience, he addressed
> them in a later patch.
>=20
> The last time Pali sent a larger number of paches (in a previous
> version, which was 42 patches [1]), it was requested that we split the
> series into smaller sets, so that it is easier to merge.
>=20
> Since then some more changes accumulated, resulting in the current ~70
> patches, which I have been sending in smaller batches.
>=20
> I could rebase the entire thing so that the patch changing the usage of
> the old irq_find_mapping() + generic_handle_irq() API is first. But
> that would require rebasing and testing all the patches one by one,
> since the patches in-between touch everything almost everything else.
>=20
> If it is really that problematic to review the changes while they use
> the old API, please let me know and I will rebase it. But if you could
> find it in yourself to review the patches with old API usage, it would
> really save a lot of time and the result will be the same, to your
> satisfaction.

Lorenzo, Marc, Bjorn,

I have one more question.

Pali prepared the ~70 patches so that fixes come first, and
new features / changes to new API later.

He did it in this way so that the patches could be then conventiently
backported to stable versions - were we to first change the API usage
to the new API, and then fix the ~20 IRQ related things, we would
afterwards have to backport the fixes by rewriting them one by one.

Is this really how we should do this? Should we ignore stable while
developing for master, regardless of how much other work would need to
be spent by backporting to master, even if it could be much simpler by
applying the patches in master in another order?

Marek
