Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F104426855
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhJHK5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 06:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhJHK5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 06:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F29960560;
        Fri,  8 Oct 2021 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633690526;
        bh=Bdl7YH/KFPL6PVC4dXb+EQOjJpjCme92vUaAQ9eoE6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H6SnhBxWmPyVTrr2MNJJepghs+hF+PJfawe9Xn09TbC+0X8DCyUL9QGxrsXzdurcG
         zC3ZTeAHLAVLE75W1WdeMnXgJAWKUQ6fLIfQjllXBWBnpoY+Z5ovGPMf0MWnT5+RXp
         CoL04fk0RYolhfv3erAES2D3Z8tJm1SC3akyultyd0ilCbFTMRoJFeo45T1VtfZLow
         qC3AyVJ3/0BRMHe6rXw9BdlXVNPyGqK3dmCENn5AJdB9eI2aN9qbtjYXvKB8SzcIBO
         fmp+mLQeEDQKd72uQxex1U05lPFAqOFcStterQNN57n8ZMvjTG5at5AXaCPlvKf9zP
         UNAabiGdRXB3w==
Date:   Fri, 8 Oct 2021 12:55:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211008125521.0aa31beb@coco.lan>
In-Reply-To: <20211007144103.GA23778@lpieralisi>
References: <20211005112448.2c40dc10@coco.lan>
        <20211005182321.GA1106986@bhelgaas>
        <20211007144103.GA23778@lpieralisi>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Em Thu, 7 Oct 2021 15:41:03 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:

> On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> >=20
> > On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote: =
=20
> > > Hi Bjorn,
> > >=20
> > > Em Tue, 28 Sep 2021 09:34:10 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu: =20
> >  =20
> > > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > > >   PCI: kirin: Add support for a PHY layer
> > > >   PCI: kirin: Use regmap for APB registers
> > > >   PCI: kirin: Add support for bridge slot DT schema
> > > >   PCI: kirin: Add Kirin 970 compatible
> > > >   PCI: kirin: Add MODULE_* macros
> > > >   PCI: kirin: Allow building it as a module
> > > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > > >   PCI: kirin: fix poweroff sequence
> > > >   PCI: kirin: Allow removing the driver =20
> > >=20
> > > I guess everything is already satisfying the review feedbacks.
> > > If so, could you please merge the PCI ones? =20
> >=20
> > Lorenzo takes care of the native host bridge drivers, so I'm sure this
> > is on his list.  I added him to cc: in case not. =20
>=20
> Ideally I'd like to see these patches ACKed/Review-ed by the kirin
> maintainers - that's what I was waiting for and that's what they
> are there for.
>=20
> Having said that, I will keep an eye on this series so that we
> can hopefully queue it for v5.16.

Not sure if you received the e-mail from Xiaowei with his ack.

At least here, I only received on my internal e-mail (perhaps because
the original e-mail was base64-encoded with gb2312 charset).=20

So, let me forward his answer to you, c/c the mailing lists.

Thanks,
Mauro

-------- Forwarded Message --------
From: Songxiaowei (Kirin_DRV) <songxiaowei@hisilicon.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <helgaas@k=
ernel.org>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Bjorn Helgaas <bhelg=
aas@google.com>, Linuxarm <linuxarm@huawei.com>, Mauro Carvalho Chehab <mau=
ro.chehab@huawei.com>, Krzysztof Wilczy=C5=84ski <kw@linux.com>, Wangbinghu=
i (Biggio, Kirin_DRV) <wangbinghui@hisilicon.com>, Rob Herring <robh@kernel=
.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-p=
ci@vger.kernel.org <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.o=
rg <linux-phy@lists.infradead.org>, Kongfei <kongfei@hisilicon.com>
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Date: Fri, 8 Oct 2021 11:45:06 +0100
Message-ID: <e718dc06633e4f87a6b6e1626e8c098e@hisilicon.com>

Hi Bjorn,

ACKed, it seems ok to me and Binghui.

Thanks a lot.

B. R.

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@ar=
m.com]
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B410=E6=9C=887=E6=97=A5 22=
:41
=E6=94=B6=E4=BB=B6=E4=BA=BA: Bjorn Helgaas <helgaas@kernel.org>
=E6=8A=84=E9=80=81: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>; Bjor=
n Helgaas <bhelgaas@google.com>; Linuxarm <linuxarm@huawei.com>; Mauro Carv=
alho Chehab <mauro.chehab@huawei.com>; Krzysztof Wilczy=C5=84ski <kw@linux.=
com>; Wangbinghui (Biggio, Kirin_DRV) <wangbinghui@hisilicon.com>; Rob Herr=
ing <robh@kernel.org>; Songxiaowei (Kirin_DRV) <songxiaowei@hisilicon.com>;=
 linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; linux-phy@lists.i=
nfradead.org
=E4=B8=BB=E9=A2=98: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe

On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> [+cc Lorenzo]
>=20
> On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote: =20
> > Hi Bjorn,
> >=20
> > Em Tue, 28 Sep 2021 09:34:10 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu: =20
>  =20
> > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > >   PCI: kirin: Add support for a PHY layer
> > >   PCI: kirin: Use regmap for APB registers
> > >   PCI: kirin: Add support for bridge slot DT schema
> > >   PCI: kirin: Add Kirin 970 compatible
> > >   PCI: kirin: Add MODULE_* macros
> > >   PCI: kirin: Allow building it as a module
> > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > >   PCI: kirin: fix poweroff sequence
> > >   PCI: kirin: Allow removing the driver =20
> >=20
> > I guess everything is already satisfying the review feedbacks.
> > If so, could you please merge the PCI ones? =20
>=20
> Lorenzo takes care of the native host bridge drivers, so I'm sure this=20
> is on his list.  I added him to cc: in case not. =20

Ideally I'd like to see these patches ACKed/Review-ed by the kirin maintain=
ers - that's what I was waiting for and that's what they are there for.

Having said that, I will keep an eye on this series so that we can hopefull=
y queue it for v5.16.

Lorenzo


