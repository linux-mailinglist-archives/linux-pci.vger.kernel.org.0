Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DA1B9F3D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgD0JAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 05:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgD0JAf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 05:00:35 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F0E2075E;
        Mon, 27 Apr 2020 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587978035;
        bh=zyM4zGvb5RSvRUhEhbKBMlMEr4R2rrAtwq4DgwN4jpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XONsZ/+gKweBcneBVJdlzlDtlZ8CURC1FTGKrDaR7w0uZ/0GImwm4IZDEWldLfaij
         BP/dxyk6F9iN0ugYcCkHIKX8TkUcVIfFgIRbKI1T6rARoRZa5v5NcTun7OKtIOaAYm
         C+i2kGg+hL9dssFcHH3Kp3GPsoISIRP1n+R6bPGg=
Received: by pali.im (Postfix)
        id BEEB18A8; Mon, 27 Apr 2020 11:00:32 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:00:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 03/12] PCI: of: Return -ENOENT if max-link-speed
 property is not found
Message-ID: <20200427090032.yb5d6hhosofua46x@pali>
References: <20200424153858.29744-1-pali@kernel.org>
 <20200424153858.29744-4-pali@kernel.org>
 <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 24 April 2020 11:47:26 Rob Herring wrote:
> On Fri, Apr 24, 2020 at 10:39 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > OF API function of_property_read_u32() returns -EINVAL if property is
> > not found. Therefore this also happens with of_pci_get_max_link_speed(),
> > which also returns -EINVAL if the 'max-link-speed' property has invalid
> > value.
> >
> > Change the behaviour of of_pci_get_max_link_speed() to return -ENOENT
> > in case when the property does not exist and -EINVAL if it has invalid
> > value.
> >
> > Also interpret zero max-link-speed value of this property as invalid,
> > as the device tree bindings documentation specifies.
> >
> > Update pcie-tegra194 code to handle errors from this function like other
> > drivers - they do not distinguish between no value and invalid value.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c |  6 +++---
> >  drivers/pci/of.c                           | 15 +++++++++++----
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index ae30a2fd3716..027bb41809f9 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -296,7 +296,7 @@ struct tegra_pcie_dw {
> >         u8 init_link_width;
> >         u32 msi_ctrl_int;
> >         u32 num_lanes;
> > -       u32 max_speed;
> > +       int max_speed;
> >         u32 cid;
> >         u32 cfg_link_cap_l1sub;
> >         u32 pcie_cap_base;
> > @@ -911,7 +911,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
> >         dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
> >
> >         /* Configure Max Speed from DT */
> > -       if (pcie->max_speed && pcie->max_speed != -EINVAL) {
> > +       if (pcie->max_speed > 0) {
> >                 val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
> >                                         PCI_EXP_LNKCAP);
> >                 val &= ~PCI_EXP_LNKCAP_SLS;
> > @@ -1830,7 +1830,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> >         dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
> >
> >         /* Configure Max Speed from DT */
> > -       if (pcie->max_speed && pcie->max_speed != -EINVAL) {
> > +       if (pcie->max_speed > 0) {
> >                 val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
> >                                         PCI_EXP_LNKCAP);
> >                 val &= ~PCI_EXP_LNKCAP_SLS;
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 81ceeaa6f1d5..19bf652256d8 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -584,15 +584,22 @@ EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
> >   *
> >   * @node: device tree node with the max link speed information
> >   *
> > - * Returns the associated max link speed from DT, or a negative value if the
> > - * required property is not found or is invalid.
> > + * Returns the associated max link speed from DT, -ENOENT if the required
> > + * property is not found or -EINVAL if the required property is invalid.
> >   */
> >  int of_pci_get_max_link_speed(struct device_node *node)
> >  {
> >         u32 max_link_speed;
> > +       int ret;
> > +
> > +       /* of_property_read_u32 returns -EINVAL if property does not exist */
> > +       ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
> > +       if (ret == -EINVAL)
> > +               return -ENOENT;
> 
> Generally, it's considered bad to change return values (though I guess
> this was happening. In hindsight, not present probably should have
> been -ENOENT. But it shouldn't really matter. The kernel should treat
> malformed as not present. It's not the kernel's job to validate the DT
> (the schema should and does now).

Bjorn in review of V1 patch wrote that aardavark driver should at least
warn on DT error.

And because max-link-speed is optional property, it is perfectly valid
when it is absent.

So without ability to distinguish between "property is not present in
DT" and "property is malformed" it is not possible to properly detect
this DT error.

> Plus you are adding capability to distinguish not present and out of
> bounds, but I don't see you using that?

It should have been used in next aardvark patch, but I forgot to include
needed code. My mistake.

> If there's any error with max-link-speed, then just use the max speed
> for the block which should be implied by the compatible string if
> there's more than one.
> 
> Rob
