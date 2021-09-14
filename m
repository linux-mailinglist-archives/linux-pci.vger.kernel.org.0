Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5C40AFFF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhINN6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 09:58:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46201 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233337AbhINN6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 09:58:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9DF1B5805AB;
        Tue, 14 Sep 2021 09:57:31 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 09:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=/qfI0kR2c2R9EpdH6XC5khZEU1Gd
        sF66gEmUDSo9p/A=; b=p6wHtTjiRf96SdEIECnw2JMg3xosSsAID4XSdD66rNlF
        CRMi3Vv74l8ByIFgm9xTCWSYpeiWi3PwKZVRzPJ5j5NjE3kIUg2lyqv249BDPmDK
        HHoTDWMhEuhxEZjQw7Cfo5arwx9bpJ+ugQ2kdTOxaS9vOAH4rZ+hHYsQtnYa0M3k
        9ECSbfibkn7fDt30DhgHe0rlYk0NnGamf+l0t6wY44OKT0P213GfMXg6UdavNmY1
        UV2Pfni/60nfz6ZZ0SphMClLj2S4SFehFv4PXCL0G/uDhPZqvDwjQ/+KBmVR8XvY
        uAp+hcQefXSa7Y7H2SpV+h2x+eGRHJWKg9x5ev3vtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/qfI0k
        R2c2R9EpdH6XC5khZEU1GdsF66gEmUDSo9p/A=; b=ObmLpvpSpZfGpQpcnl5YxO
        2bkGlWscTyRSRJD/0KgvU3cpLJhoM1bk8gn1/rzSYqBmC40jrsILJTtgaHeFABIo
        L1gbQJ/sV55CRS6bPSXX5URC1Zv9pQ16r8/+smPaeV3ox0laG5ISLGjTEQN3Tpz0
        M+ifqKc/x4Zkw42DIVGQDkV1AdOxM/7oA/ieMm6G2dC2ZnzZPyaLQgvgGyP6BB8t
        cEi1GHm/MtvRkld5M2vcgQ+w+MbQlAT6YF3zuh6jydumvJiYXSgn/SF93TrtxMJ2
        qV3QDweFuQmFr6aevXBlUbYfzaNgWEtOXjFiaMX8m3YdNgibDPi1zhrECNxGL6CQ
        ==
X-ME-Sender: <xms:SqpAYbM2nBhvqYKbyYus6Y-umQZylWC24XU3rl28HPvggniZXlO0Ng>
    <xme:SqpAYV84osLKblh1IdJqrHo8olc86SBQyqV6SqtpLtbACyY63pVlFaf7nuqlbeq_H
    TVHXsfhBLr1j6M_I18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
    geehgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:SqpAYaSyq-4QbdkrA8xh4PHK8AR4dTyM3oN7d5RZJKojRhEA-Ktinw>
    <xmx:SqpAYfvTrQ28Nsg0PzzUkcjAhCTSXWBv4IXw0xecdLJCox0vt_WUdw>
    <xmx:SqpAYTeIHlFSSQymDMHwHrQ52O6jBAxfBot-hmS6EMIQtXQAUFv1CA>
    <xmx:S6pAYb0BQ-05Equam92gWQz89p7akWV8vqNJHjsg_3CQ7QcVpHJ2lA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A09D051C0060; Tue, 14 Sep 2021 09:57:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <06263cbc-70f1-4484-86f3-3735137b3a8f@www.fastmail.com>
In-Reply-To: <87y27zbiu3.wl-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-11-maz@kernel.org>
 <b502383a-fe68-498a-b714-7832d3c8703e@www.fastmail.com>
 <87y27zbiu3.wl-maz@kernel.org>
Date:   Tue, 14 Sep 2021 15:56:55 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Robin Murphy" <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: =?UTF-8?Q?Re:_[PATCH_v3_10/10]_PCI:_apple:_Configure_RID_to_SID_mapper_o?=
 =?UTF-8?Q?n_device_addition?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Tue, Sep 14, 2021, at 11:35, Marc Zyngier wrote:
> On Mon, 13 Sep 2021 21:45:13 +0100,
> "Sven Peter" <sven@svenpeter.dev> wrote:
> > 
> > 
> > 
> > On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> > > The Apple PCIe controller doesn't directly feed the endpoint's
> > > Requester ID to the IOMMU (DART), but instead maps RIDs onto
> > > Stream IDs (SIDs). The DART and the PCIe controller must thus
> > > agree on the SIDs that are used for translation (by using
> > > the 'iommu-map' property).
> > > 
> > > For this purpose, parse the 'iommu-map' property each time a
> > > device gets added, and use the resulting translation to configure
> > > the PCIe RID-to-SID mapper. Similarily, remove the translation
> > > if/when the device gets removed.
> > > 
> > > This is all driven from a bus notifier which gets registered at
> > > probe time. Hopefully this is the only PCI controller driver
> > > in the whole system.
> > > 
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-apple.c | 158 +++++++++++++++++++++++++++-
> > >  1 file changed, 156 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-apple.c 
> > > b/drivers/pci/controller/pcie-apple.c
> > > index 76344223245d..68d71eabe708 100644
> > > --- a/drivers/pci/controller/pcie-apple.c
> > > +++ b/drivers/pci/controller/pcie-apple.c
> > > @@ -23,8 +23,10 @@
> > >  #include <linux/iopoll.h>
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > > +#include <linux/list.h>
> > >  #include <linux/module.h>
> > >  #include <linux/msi.h>
> > > +#include <linux/notifier.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/pci-ecam.h>
> > >  
> > > @@ -116,6 +118,8 @@
> > >  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
> > >  #define PORT_PREFMEM_ENABLE		0x00994
> > >  
> > > +#define MAX_RID2SID			64
> > 
> > Do these actually have 64 slots? I thought that was only for
> > the Thunderbolt controllers and that these only had 16.
> 
> You are indeed right, and I blindly used the limit used in the
> Correlium driver. Using entries from 16 onward result in a non booting
> system. The registers do not fault though, and simply ignore writes. I
> came up with an simple fix for this, see below.

Looks good to me and at least I prefer that to an additional property
in the device tree.

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,


Sven
