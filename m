Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0300C48C68E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiALOxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 09:53:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39848 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiALOxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 09:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC42B6190C;
        Wed, 12 Jan 2022 14:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9CCC36AE5;
        Wed, 12 Jan 2022 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641999228;
        bh=csDQgpgi1DI4Buo+lSkJPqgNHTQJAMce5FiFJUgwP+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i6qHoZ+7LPZG9mmPLg1u3JvkZ/PTgxjQEc0g3KkwA3GYjLkQWhK60cMo4lfrYd7vA
         YB6+c6isYe2Jqu8PiYY8q+k/Qus+wHKAJYxWkJba9n4H+Li8UbFBScctWbQRpB/KH/
         OS0IBfvcqIdfSdsceHjFsayv96mXrpRpq/eKM7UgU8Cz64r6zuAFceOQRahkxl4xdY
         ACpWoAYESdJ63npsf3gxxDLRLLQOIPwTmnKtwS7aOGeZpobPheInTaZ6XXfPO7bFLM
         T2bSjLArNp5V1PkuNoSyobxu7tQ1unFk1KNxg3XgfQdN3DBYny2608Znzhg1tacKle
         HkWimj4tCTOLQ==
Received: by mail-ed1-f41.google.com with SMTP id m4so10899921edb.10;
        Wed, 12 Jan 2022 06:53:48 -0800 (PST)
X-Gm-Message-State: AOAM532g/RFcY6kjKmqsFDpEaP52/dHh0TGJC5puzXsb8HzG0+L1MaR+
        FW+/zVgIYyUyQdqPOKZxyHh8bGK+CL+aEIfsNg==
X-Google-Smtp-Source: ABdhPJya+dupCkkQzInJpFq2Av5DZozNaipTp2tamo3Pj5KWrPAI4IRLNlFImd8QPs3djVI8YYUY0ZDeoYkTTLnpsj8=
X-Received: by 2002:a17:906:d184:: with SMTP id c4mr112958ejz.20.1641999226716;
 Wed, 12 Jan 2022 06:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20220105150239.9628-1-pali@kernel.org> <20220105150239.9628-9-pali@kernel.org>
 <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com> <20220112014356.h2pm7nc3vzsvjexq@pali>
In-Reply-To: <20220112014356.h2pm7nc3vzsvjexq@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jan 2022 08:53:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLaB=WnZjD3UBSyLHdWC4N3V8rFS47u57NZmmB1o0j1XA@mail.gmail.com>
Message-ID: <CAL_JsqLaB=WnZjD3UBSyLHdWC4N3V8rFS47u57NZmmB1o0j1XA@mail.gmail.com>
Subject: Re: [PATCH 08/11] PCI: mvebu: Use child_ops API
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 7:44 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 05 January 2022 09:41:51 Rob Herring wrote:
> > On Wed, Jan 5, 2022 at 9:03 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > Split struct pci_ops between ops and child_ops. Member ops is used fo=
r
> > > accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops =
for
> > > accessing real PCIe cards.
> > >
> > > There is no need to mix these two struct pci_ops into one as PCI core=
 code
> > > already provides separate callbacks via bridge->ops and bridge->child=
_ops.
> >
> > I had similar patches including mvebu that I never got around to
> > sending out. I pushed the branch out now at least[1].
>
> Are you going to finish your patch series and send it? Because if yes,
> I can drop this my patch in v3 and let all ->child_ops conversion for
> you.

Not any time soon.

Rob
