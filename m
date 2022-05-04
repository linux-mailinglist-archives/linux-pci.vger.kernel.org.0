Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073451A133
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbiEDNsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbiEDNsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 09:48:07 -0400
X-Greylist: delayed 79480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 06:44:30 PDT
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160BF27156;
        Wed,  4 May 2022 06:44:29 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 836C924000C;
        Wed,  4 May 2022 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651671868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rk72OOOdZSUj/t0ck9GUkQrJCm6OvviM5pEqmXGfJr4=;
        b=GAjLy704dfosoxU9eAdGTyyj8HAuQP8NWeOEuRGQ8M0aC3aXtC4Z/+0wzc3MpPCNpazLqs
        sqlSOuSZ6E7OfjEh41ItNsnvAA5BxHa65iDBnypdHxt0BXP1A3CRsej8eMwM2b4fFkFuYm
        eqTfzkGfgZHCKC2EK18B8yQalmXLzMRS1WCKPc68XwGexWOYo+13s9ra5xfpAfeRdggkuW
        Qub8s2GnqY2eWh1s/GD7d4ckd9MGOF29XRakpcsqC74GCJBSbd/9vNgAN1oXHmChv6Pbmc
        g4QS/5UYg5Fm56SNbfpJkQ/Tv6k70XROwA7nHj0ThHUcgAPCMn6XmDh2rwu3gQ==
Date:   Wed, 4 May 2022 15:43:03 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Message-ID: <20220504154303.5cdf8cc2@fixe.home>
In-Reply-To: <20220503225353.GA415393@bhelgaas>
References: <20220427094502.456111-3-clement.leger@bootlin.com>
        <20220503225353.GA415393@bhelgaas>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Tue, 3 May 2022 17:53:53 -0500,
Bjorn Helgaas <helgaas@kernel.org> a =C3=A9crit :

> In subject:
>=20
>   PCI: of: Create DT nodes ... if they do not exist
>=20
> The subject could be read as saying that you're going to create DT
> nodes before the PCI devices exist, but I think you mean that when we
> enumerate a PCI devices, we're *always* going to create a DT node for
> it, even if the DT didn't mention it.

Hi Bjorn,

Indeed ! I'll modify that.

>=20
> Maybe something like:
>=20
>   PCI: of: Create DT node for every PCI device
>=20
> although I see Rob thinks this should be done on demand instead of
> doing it for every device, which sounds sensible to me.

Agreed, I'll rework this series.

Thanks,

>=20
> On Wed, Apr 27, 2022 at 11:45:01AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > In order to apply overlays to PCI device nodes, the nodes must first
> > exist. This commit add support to populate a skeleton tree for PCI bus
> > and devices. These nodes can then be used by drivers to apply overlays.=
 =20
>=20
> s/This commit add support/Add support/
>=20
> Bjorn



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
