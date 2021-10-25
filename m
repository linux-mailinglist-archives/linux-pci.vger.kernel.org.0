Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDD74393E1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJYKmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 06:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhJYKmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 06:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C60BC61073;
        Mon, 25 Oct 2021 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635158417;
        bh=eZ2XNmT09rFhiWmQ0zWif0Szi6EwrOdHI9MgNtiUYRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FvFXk30bqNLc2fltvKxUQTap0ZgcAtmufunOMTF8sGK1uRHz+skCTq3a4d0OzEmv0
         pKUO53f1tOuE/adu4kWUgLiHYlAtAtjSR+kYbUv8aR+Xey2Qroqqf476Gu83zbUB2X
         9pXWRBCQ7qGlJHVXmhpDSRkXMqareDcbVcjKvSk0Z4nKf0uN9oh16iZ3dl5t4rAxxC
         opVbh5jZCKjhofz3mZqbTD/oKnJl/pJBnZkux6Iw2Jf2TfFm4Z50PINmjVRVIZpthA
         UeYboNird/Wj6JvgbrKytOww+mopJQcIo6+SeQuwLr4977e+87ZvLdnd2qMX07ZKrT
         RBDxj+4lvLskA==
Date:   Mon, 25 Oct 2021 11:40:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset
 to finish
Message-ID: <20211025114011.0eca7ccc@sal.lan>
In-Reply-To: <20211025102511.GA10529@lpieralisi>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
        <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
        <20211022151624.mgsgobjsjgyevnyt@pali>
        <20211023103059.6add00e6@sal.lan>
        <20211025102511.GA10529@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 25 Oct 2021 11:25:11 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:

> On Sat, Oct 23, 2021 at 10:30:59AM +0100, Mauro Carvalho Chehab wrote:
> > Hi Pali,
> >=20
> > Em Fri, 22 Oct 2021 17:16:24 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> escreveu:
> >  =20
> > > On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote: =20
> > > > Before code refactor, the PERST# signals were sent at the
> > > > end of the power_on logic. Then, the PCI core would probe for
> > > > the buses and add them.
> > > >=20
> > > > The new logic changed it to send PERST# signals during
> > > > add_bus operation. That altered the timings.
> > > >=20
> > > > Also, HiKey 970 require a little more waiting time for
> > > > the PCI bridge - which is outside the SoC - to finish
> > > > the PERST# reset, and then initialize the eye diagram.   =20
> > >=20
> > > Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
> > > PCIe Root Port? Or upstream port on some external PCIe switch connect=
ed
> > > via PCIe bus to the PCIe Root Port? Because all of these (virtual) PC=
Ie
> > > devices are presented as PCI bridge devices, so it is not clear to wh=
ich
> > > device it refers. =20
> >=20
> > HiKey 970 uses an external PCI bridge chipset (a Broadcom PEX 8606[1]),
> > with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
> > a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# s=
ignal,
> > as there are 4 independent PERST# signals there:
> >=20
> > 	- one for PEX 8606 (the PCIe root port);
> > 	- one for Ethernet;
> > 	- one for M.2;
> > 	- one for mini-PCIe.
> >=20
> > After sending the PCIe PERST# signals, the device has to wait for 21 ms
> > before adjusting the eye diagram.
> >=20
> > [1] https://docs.broadcom.com/docs/PEX_8606_AIC_RDK_HRM_v1.3_06Aug10.pdf
> >  =20
> > > Normally PERST# signal is used to reset endpoint card, other end of P=
CIe
> > > link and so PERST# signal should not affect PCIe Root Port at all. =20
> >=20
> > That's not the case, as PEX 8606 needs to complete its reset sequence
> > for the rest of the devices to be visible. If the wait time is reduced
> > or removed, the devices behind it won't be detected. =20
>=20
> These pieces of information should go into the commit log (or I can add
> a Link: tag to this discussion) - it is fundamental to understand these
> changes.
>=20
> I believe we can merge this series but we have to document this
> discussion appropriately.

IMO, the best is to add a Link: to the discussion:

Link: https://lore.kernel.org/all/9a365cffe5af9ec5a1f79638968c3a2efa979b65.=
1634622716.git.mchehab+huawei@kernel.org/

But if you prefer otherwise and want me to re-submit the series, please
let me know.

Regards,
Mauro
