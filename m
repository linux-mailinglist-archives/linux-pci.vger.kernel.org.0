Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6D42599B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhJGRib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 13:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243302AbhJGRiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 13:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A73C610CC;
        Thu,  7 Oct 2021 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633628180;
        bh=QYsjwPvbbfl73CGvowChGsFHixN4dVr1+Zn4DB1gzb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=guPT9gWtPIOoH3EK9KV/Iw+W1fKFs+RDccZs2/5UY0tkYd2cAeo7tk9ZdouQuKkXZ
         i1sHWUbKiVeYW0StyzlaCBeN2LKeSyqz+24KB8uTzBGdIb7gssauzKhTASHun9sWLR
         feZ5EquhWJc0F3Yx6eSTgk7DsiwnAqwudcyarrHaN/p1CPJvr+q/5EUXgiQQhS5J61
         tbzHvGK7p0mL50qexH38fFwn4xycwEMbCB8vgjZ2OUrdXjFyOV+A7w9bWbm3CaBJve
         yHW6JFCnV2kNNdyzv+YCqg4UTVV8B6TtTb7WsidWb5v57sUOnIv6DtFFFa1jrU60wv
         zHM2g9oGHBwmg==
Date:   Thu, 7 Oct 2021 19:36:16 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: aardvark controller fixes
Message-ID: <20211007193616.5adf25f6@thinkpad>
In-Reply-To: <163361366612.462.10245349222624047259.b4-ty@arm.com>
References: <20211005180952.6812-1-kabel@kernel.org>
        <163361366612.462.10245349222624047259.b4-ty@arm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu,  7 Oct 2021 14:38:25 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Tue, 5 Oct 2021 20:09:39 +0200, Marek Beh=C3=BAn wrote:
> > as requested I am sending v2 of this series.
> >=20
> > Changes since v1:
> > - updated commit message in patch 6 as suggested by Mark
> > - updated patch 6 to also drop the early return
> > - changed the LTSSM definitions to enum in patch 12
> > - dropped the Fixes tags for those patches where it was inappropriate
> >=20
> > [...] =20
>=20
> I rewrote some logs, dropped some stable tags. This series raised
> a couple of interesting questions that may be relevant for PCI core
> as well, it'd be great if those won't be lost but I feel it is time
> to merge this series to help Marek/Pali cut the patch delta and
> give this code wider testing.
>=20
> I have applied it to pci/aardvark, please _do_ have a look and
> report back any issue with it.

I checked all the commit messages in pci/aardvark.

I also compiled this branch and tested it on my Mox with ath10k card
and it works correctly, no regressions.

Marek
