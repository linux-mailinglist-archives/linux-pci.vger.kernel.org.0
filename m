Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FEC1BC41E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgD1Pwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 11:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1Pwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 11:52:49 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA351206E2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2020 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089168;
        bh=YR2My0qOb7YvZbhiA6WrBwMgo+fMPRVrkKPzmHbjvYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DH4V8WaRlnFqiBbxd+GeP+JUFXPPHrKTTwZimJvPV8tBLozWBhk+AnoI0zY6/MQHx
         9jpsy99OAQqja4EVCSn7mzSQYlup+h2QtPLRRAN/zGemabS5AtcMRctIk3vPU/Q8SV
         o7zRJzPStQXqQl/Lqxz8wQbvhSk2kn20nYeUBVa4=
Received: by mail-ot1-f46.google.com with SMTP id 72so33450595otu.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2020 08:52:47 -0700 (PDT)
X-Gm-Message-State: AGi0Pua5W2ncZUZt6BhzKXd6noYsyHllhzEOMqQCCWKyaxApXTlsSia5
        oorNqKFQHVXKyqJBzY1IUzBwV4wULDoivylStA==
X-Google-Smtp-Source: APiQypL1fyR7AUXwRqPrjwe3U0JW2oIYulShupATP2u8fzjxFL8xx4s3tsA/4wgZeAkLF5rtuAjmeYr2PEu1/tv03zo=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr23426137oth.192.1588089167060;
 Tue, 28 Apr 2020 08:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153858.29744-1-pali@kernel.org> <20200424153858.29744-4-pali@kernel.org>
 <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com> <20200427090032.yb5d6hhosofua46x@pali>
In-Reply-To: <20200427090032.yb5d6hhosofua46x@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Apr 2020 10:52:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmL+HE7PQYaM-u2SNCNJu00XMLUzgoRtcqLesO-M92yQ@mail.gmail.com>
Message-ID: <CAL_JsqLmL+HE7PQYaM-u2SNCNJu00XMLUzgoRtcqLesO-M92yQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] PCI: of: Return -ENOENT if max-link-speed
 property is not found
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 4:00 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 24 April 2020 11:47:26 Rob Herring wrote:
> > On Fri, Apr 24, 2020 at 10:39 AM Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > >
> > > OF API function of_property_read_u32() returns -EINVAL if property is
> > > not found. Therefore this also happens with of_pci_get_max_link_speed=
(),
> > > which also returns -EINVAL if the 'max-link-speed' property has inval=
id
> > > value.
> > >
> > > Change the behaviour of of_pci_get_max_link_speed() to return -ENOENT
> > > in case when the property does not exist and -EINVAL if it has invali=
d
> > > value.
> > >
> > > Also interpret zero max-link-speed value of this property as invalid,
> > > as the device tree bindings documentation specifies.
> > >
> > > Update pcie-tegra194 code to handle errors from this function like ot=
her
> > > drivers - they do not distinguish between no value and invalid value.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-tegra194.c |  6 +++---
> > >  drivers/pci/of.c                           | 15 +++++++++++----
> > >  2 files changed, 14 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci=
/controller/dwc/pcie-tegra194.c
> > > index ae30a2fd3716..027bb41809f9 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -296,7 +296,7 @@ struct tegra_pcie_dw {
> > >         u8 init_link_width;
> > >         u32 msi_ctrl_int;
> > >         u32 num_lanes;
> > > -       u32 max_speed;
> > > +       int max_speed;
> > >         u32 cid;
> > >         u32 cfg_link_cap_l1sub;
> > >         u32 pcie_cap_base;
> > > @@ -911,7 +911,7 @@ static void tegra_pcie_prepare_host(struct pcie_p=
ort *pp)
> > >         dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAUL=
T, val);
> > >
> > >         /* Configure Max Speed from DT */
> > > -       if (pcie->max_speed && pcie->max_speed !=3D -EINVAL) {
> > > +       if (pcie->max_speed > 0) {
> > >                 val =3D dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
> > >                                         PCI_EXP_LNKCAP);
> > >                 val &=3D ~PCI_EXP_LNKCAP_SLS;
> > > @@ -1830,7 +1830,7 @@ static void pex_ep_event_pex_rst_deassert(struc=
t tegra_pcie_dw *pcie)
> > >         dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
> > >
> > >         /* Configure Max Speed from DT */
> > > -       if (pcie->max_speed && pcie->max_speed !=3D -EINVAL) {
> > > +       if (pcie->max_speed > 0) {
> > >                 val =3D dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
> > >                                         PCI_EXP_LNKCAP);
> > >                 val &=3D ~PCI_EXP_LNKCAP_SLS;
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 81ceeaa6f1d5..19bf652256d8 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -584,15 +584,22 @@ EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_rang=
es);
> > >   *
> > >   * @node: device tree node with the max link speed information
> > >   *
> > > - * Returns the associated max link speed from DT, or a negative valu=
e if the
> > > - * required property is not found or is invalid.
> > > + * Returns the associated max link speed from DT, -ENOENT if the req=
uired
> > > + * property is not found or -EINVAL if the required property is inva=
lid.
> > >   */
> > >  int of_pci_get_max_link_speed(struct device_node *node)
> > >  {
> > >         u32 max_link_speed;
> > > +       int ret;
> > > +
> > > +       /* of_property_read_u32 returns -EINVAL if property does not =
exist */
> > > +       ret =3D of_property_read_u32(node, "max-link-speed", &max_lin=
k_speed);
> > > +       if (ret =3D=3D -EINVAL)
> > > +               return -ENOENT;
> >
> > Generally, it's considered bad to change return values (though I guess
> > this was happening. In hindsight, not present probably should have
> > been -ENOENT. But it shouldn't really matter. The kernel should treat
> > malformed as not present. It's not the kernel's job to validate the DT
> > (the schema should and does now).
>
> Bjorn in review of V1 patch wrote that aardavark driver should at least
> warn on DT error.

Yes, but I disagree. Just treat an error as not present as long as the
driver can make progress. If something critical required is missing,
then yes we should print an error and bail out.

> And because max-link-speed is optional property, it is perfectly valid
> when it is absent.
>
> So without ability to distinguish between "property is not present in
> DT" and "property is malformed" it is not possible to properly detect
> this DT error.

How would you have an error? Your DT has a schema to check it, right?
(Hint: convert your binding)

Think about it this way. If every driver has an error string for every
property, that's a lot of bloat to the kernel. If we really want to
print errors, we should define of_property_.*_optional() variants and
print errors in the core code.

Rob
