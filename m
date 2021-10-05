Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F042338B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhJEWfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhJEWfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:35:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FD0361154;
        Tue,  5 Oct 2021 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633473210;
        bh=FROCZ7Fdrh+ucPcqLlLW5sqxSSGfDZM+n5bgaDUm3WU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1CO0KRVMoRpUe264hgxwgXAtvJUYDN1kiUbsI/TtXI2nWi6HbElV+S3/zPVaMAPz
         yW6MmANKU4+8Rn5oOr9/+b8kalfD9NekzTjECTaS+71UEXF5/kk8r95AmQRjTHaRf5
         FYRHm0/fPXQUXXluPZuipj2QULwMd2RynmW8s6iWVMvbEkp4aigSmvZerFwvBgU7BN
         3zxTuG0VfSOgk5/HILJCW2pkt9jiUZiaay+f9RtIWrJ8iWY+lMB/HClyrJgznSeDSl
         WU2XhBWIAgQo3c+0rBEMTMlKlQkx9eEYhiXDD9qTvc54bc24CvFPf9DcD3Zs0inpqF
         CREoaVXfyGBAA==
Date:   Wed, 6 Oct 2021 00:33:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 03/11] PCI: kirin: Add support for a PHY layer
Message-ID: <20211006003325.6106cfab@coco.lan>
In-Reply-To: <20211005203148.gn2f34pfvm62w6ca@pali>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
        <8a6d353145c0ec169d212094f5d534f93e2597f8.1632814194.git.mchehab+huawei@kernel.org>
        <20211005203148.gn2f34pfvm62w6ca@pali>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

Em Tue, 5 Oct 2021 22:31:48 +0200
Pali Roh=C3=A1r <pali@kernel.org> escreveu:

> Hello!
>=20
> On Tuesday 28 September 2021 09:34:13 Mauro Carvalho Chehab wrote:
> > The pcie-kirin driver contains both PHY and generic PCI driver
> > on it.
> >=20
> > The best would be, instead, to support a PCI PHY driver, making
> > the driver more generic.
> >=20
> > However, it is too late to remove the Kirin 960 PHY, as a change
> > like that would make the DT schema incompatible with past versions. =20
>=20
> I have not looked deeply at it. But is not it really possible to declare
> PHY node in DTS file with backward compatible manner? Or cannot Rob help
> with it (maybe there was similar issue in past with other driver)?

It would be possible to split the Kirin 960 PHY into drivers/phy. It is
also possible to hack the phy driver to search for the PHY-specific data
inside the PCI compatible string (I did wrote some patches doing that
and sent as a RFC several months ago), but the problem is that the
PHY driver won't be probed without adding a new compatible inside the
DT schema. By doing that, the schema will be incompatible.

In any case, the patches on this series split all PHY-specific code
inside the driver on a separate part of the source code. Moving it
to a new driver would be easy once someone comes with a solution
to add some new method at the PHY layer that would allow to load a
new module without having a compatible for it.

> I was fixing something similar, address space defined in DTS was used by
> two HW blocks: clock and UART. And I was able to make both DTS file and
> driver backward compatible.

Thanks,
Mauro
