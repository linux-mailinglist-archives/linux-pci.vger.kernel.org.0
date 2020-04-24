Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE51B7C1C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgDXQrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 12:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbgDXQrl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:41 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8AF20774
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587746860;
        bh=F7xpWJUS7/PWBwjpZDGhCnknOg2K2k7Up6A0+CV/QLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EL6fA14GUZcVszmLXjNm0tn+s2qXax0GmyyBHVe6IlNfSbD8twRi3LmzCX3zfYSgu
         r5xts2piU7xJ2ePxhyerXyQw+5+CtOZyCILSII7811Rg7+qfmPRaNmPx1qkqLe0/Io
         HMnTo42hPlfgW+v127DUUyswfZ+qHhUbua9SoVKo=
Received: by mail-yb1-f177.google.com with SMTP id a9so5360575ybc.8
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 09:47:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuYH+e6MiaUX54pMIJGGsAjcKJpqILg/oE6DgneJLri65a29spZ/
        onWL8XoPgiRTKXjAFmt3dMaTkX7otFtB7Ju4Kw==
X-Google-Smtp-Source: APiQypKE6+AI1rbdJpGbIqnqive1g/JtypI+skvGkMQCBzTCNpauNK27u5yjV88gyOraA+dg5qdlD4rDPPhjfBTOejs=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr17755054ybm.472.1587746859265;
 Fri, 24 Apr 2020 09:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153858.29744-1-pali@kernel.org> <20200424153858.29744-4-pali@kernel.org>
In-Reply-To: <20200424153858.29744-4-pali@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Apr 2020 11:47:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com>
Message-ID: <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com>
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

On Fri, Apr 24, 2020 at 10:39 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> OF API function of_property_read_u32() returns -EINVAL if property is
> not found. Therefore this also happens with of_pci_get_max_link_speed(),
> which also returns -EINVAL if the 'max-link-speed' property has invalid
> value.
>
> Change the behaviour of of_pci_get_max_link_speed() to return -ENOENT
> in case when the property does not exist and -EINVAL if it has invalid
> value.
>
> Also interpret zero max-link-speed value of this property as invalid,
> as the device tree bindings documentation specifies.
>
> Update pcie-tegra194 code to handle errors from this function like other
> drivers - they do not distinguish between no value and invalid value.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c |  6 +++---
>  drivers/pci/of.c                           | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index ae30a2fd3716..027bb41809f9 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -296,7 +296,7 @@ struct tegra_pcie_dw {
>         u8 init_link_width;
>         u32 msi_ctrl_int;
>         u32 num_lanes;
> -       u32 max_speed;
> +       int max_speed;
>         u32 cid;
>         u32 cfg_link_cap_l1sub;
>         u32 pcie_cap_base;
> @@ -911,7 +911,7 @@ static void tegra_pcie_prepare_host(struct pcie_port =
*pp)
>         dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, v=
al);
>
>         /* Configure Max Speed from DT */
> -       if (pcie->max_speed && pcie->max_speed !=3D -EINVAL) {
> +       if (pcie->max_speed > 0) {
>                 val =3D dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
>                                         PCI_EXP_LNKCAP);
>                 val &=3D ~PCI_EXP_LNKCAP_SLS;
> @@ -1830,7 +1830,7 @@ static void pex_ep_event_pex_rst_deassert(struct te=
gra_pcie_dw *pcie)
>         dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
>
>         /* Configure Max Speed from DT */
> -       if (pcie->max_speed && pcie->max_speed !=3D -EINVAL) {
> +       if (pcie->max_speed > 0) {
>                 val =3D dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
>                                         PCI_EXP_LNKCAP);
>                 val &=3D ~PCI_EXP_LNKCAP_SLS;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 81ceeaa6f1d5..19bf652256d8 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -584,15 +584,22 @@ EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
>   *
>   * @node: device tree node with the max link speed information
>   *
> - * Returns the associated max link speed from DT, or a negative value if=
 the
> - * required property is not found or is invalid.
> + * Returns the associated max link speed from DT, -ENOENT if the require=
d
> + * property is not found or -EINVAL if the required property is invalid.
>   */
>  int of_pci_get_max_link_speed(struct device_node *node)
>  {
>         u32 max_link_speed;
> +       int ret;
> +
> +       /* of_property_read_u32 returns -EINVAL if property does not exis=
t */
> +       ret =3D of_property_read_u32(node, "max-link-speed", &max_link_sp=
eed);
> +       if (ret =3D=3D -EINVAL)
> +               return -ENOENT;

Generally, it's considered bad to change return values (though I guess
this was happening. In hindsight, not present probably should have
been -ENOENT. But it shouldn't really matter. The kernel should treat
malformed as not present. It's not the kernel's job to validate the DT
(the schema should and does now).

Plus you are adding capability to distinguish not present and out of
bounds, but I don't see you using that?

If there's any error with max-link-speed, then just use the max speed
for the block which should be implied by the compatible string if
there's more than one.

Rob
