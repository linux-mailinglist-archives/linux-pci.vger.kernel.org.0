Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857794208D8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhJDJ6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 05:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhJDJ6t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 05:58:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7E31611C5;
        Mon,  4 Oct 2021 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633341420;
        bh=CPc28IvnmO1bQRX6vtcAQQMGQgBeWS7qVl3KVif+OFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BirVGDoqKe/jZ4DpGO8lVXZ7gFgYpfjpIccywk1nY5A6taE7ibh4PUl1NdnFFOqKh
         nJjiJpmwAytzFNteQiWSE27a5RVMj/NkPmYIgyB1IfzdAb2ORuFmbUdjVsCilH/2q7
         QT8+R3nrB4J8+/S24pcBNw7OI9bJrgPLN5lxF0K7T+eob9z6O0MuOMuDPJU2TQKcaJ
         Tmn5k9rq9en4hHFd59y0PdhAiOov3398cmNG/atqXc9YvobVm7qTj9VZJ2+eCeJBIU
         jVAyq34ySEfWR6QsX4WOF3JS1CndngoOncbaqY8w49rpDrThaeZCdUcLKNFCEnAOZB
         w8LetcXpGpUjA==
Date:   Mon, 4 Oct 2021 11:56:56 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 10/13] PCI: aardvark: Simplify initialization of rootcap
 on virtual bridge
Message-ID: <20211004115656.32f2630b@thinkpad>
In-Reply-To: <20211004094422.GA22827@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
        <20211001195856.10081-11-kabel@kernel.org>
        <20211004094422.GA22827@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 Oct 2021 10:44:22 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Oct 01, 2021 at 09:58:53PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > PCIe config space can be initialized also before pci_bridge_emul_init()
> > call, so move rootcap initialization after PCI config space initializat=
ion.
> >=20
> > This simplifies the function a little since it removes one if (ret < 0)
> > check.
> >=20
> > Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") =20
>=20
> Is this a fix ? If not I will remove this tag.

It is not a fix, but we put the Fixes patch there because another patch
that is a fix depends on it. But that another patch will come in
another batch, after this was is applied. So maybe we could drop this
patch now.

Or you can remove the Fixes tag, but then we will have to send this by
hand to stable.

Marek
