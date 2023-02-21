Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F469DE28
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 11:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjBUKsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 05:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBUKsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 05:48:32 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1104212A0;
        Tue, 21 Feb 2023 02:48:29 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w7-20020a056830280700b0068dbf908574so760274otu.8;
        Tue, 21 Feb 2023 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWhkoZrCqDduAAXCQ/3bm5kDx4RMDspR2wAkQfDt+E8=;
        b=UHcUTDdYEQpMWq4NX968IGNGzakXuqOpOxqYWcpZ+7MnG4Q6b4c2vo0BWPrAtT7Fx2
         w4N5sQIY+UqaLLBl46hknlAXdIJwkeIJx5wPoqRNS13HwvY6yhl5GRxUM807G9G22CkB
         nx49hm4BkwdqqoSZ0xyz+HAmDxDDmd1CMaHg2dVT27zgttwPHReE9J8nhJjKXeHRB1v0
         CCh962bIKAkIymrnAcf7h7RzfruA3mbQocShMTzuJZr9XjdeDvxDNv8G5f1o5MKMbOe0
         BTZmyB5SQiIEap+e6paF65Pq6lXgTqxzkopmnkjYOsyZbg9wXUTw/njZYO98b50JKvq3
         RD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWhkoZrCqDduAAXCQ/3bm5kDx4RMDspR2wAkQfDt+E8=;
        b=uqAFTrjA0f/CqTZbUmn5ulfHSpA0gJwtdNezqGk+29hx4oiPfYyrLNs9t64AigRHKO
         nDuC/sa8jLCPAyjhcST+hP2niS9qA3F4mdlpMxiHIhUzyfKHN86Uu4Mu9qPcd91Ac7KR
         Bjhczz2oqrfSX4sTLhLN+ZJTctkF+87ekjOhYXCs7RFLESqXsT5mVpWv7yKHt6du3XmN
         /Uq9jVLvclpyEGTdpbKuElQnxZmvaWlCsxCTTZy6zYWrCNgNZFzH2VyftY2YpoEvprNO
         ye7ckvaJzX+jx3GCJ/bPUuYQk1+lvO5nCkaQFvcOj7Fl6DPTmj0AbuujIfBGWXO0kmdq
         cvyA==
X-Gm-Message-State: AO0yUKWBBzV1QdnhtJ21a1VO+w6qW1PN5Z2U0Mc5YJXweMXVgu3VeRCC
        hl3g1U4cZZKpgI8gRv7hrvQFHj0Iv5853pvt5no=
X-Google-Smtp-Source: AK7set+5gLqODBHp+HcDwdLrgO1/57B8n61dXKnw7NrxKfTzeL9XHP0Rkt8CmR2cd3Ek8yBkxrtUHBO8v/BndIPo2aA=
X-Received: by 2002:a05:6830:39e0:b0:690:ed96:e019 with SMTP id
 bt32-20020a05683039e000b00690ed96e019mr245346otb.4.1676976509250; Tue, 21 Feb
 2023 02:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-10-rick.wertenbroek@gmail.com> <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
In-Reply-To: <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 21 Feb 2023 11:47:53 +0100
Message-ID: <CAAEEuhpDTmAvBZhC9RCueOvqbLb=AttV1KxJrOUBcjHQrpVXmA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] PCI: rockchip: Add parameter check for RK3399 PCIe
 endpoint core set_msi()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/14/23 23:08, Rick Wertenbroek wrote:
> > The RK3399 PCIe endpoint core supports only a single PCIe physcial
> > function (function number 0), therefore return -EINVAL if set_msi() is
> > called with a function number greater than 0.
> > The PCIe standard only allows the multi message capability (MMC) value
> > to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
> > called with a MMC value of over 0x5.
> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index b7865a94e..80634b690 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
> >       struct rockchip_pcie *rockchip = &ep->rockchip;
> >       u32 flags;
> >
> > +     if (fn) {
> > +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
> > +             return -EINVAL;
> > +     }
>
> Checking this here is late... Given that at most only one physical
> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
> Something like:
>
>         err = of_property_read_u8(dev->of_node, "max-functions",
>                                   &ep->epc->max_functions);
>
>         if (err < 0 || ep->epc->max_functions > 1)
>
>                 ep->epc->max_functions = 1;
>

Yes, this could be moved to the probe, thanks.

> And all the macros with the (fn) argument could also be simplified
> (argument fn removed) since fn will always be 0.

These functions cannot be simplified because they have to follow the signature
given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
function number as a parameter. If we change the function signature we won't
be able to assign these functions to the pc_epc_ops structure

static const struct pci_epc_ops rockchip_pcie_epc_ops = {
       .write_header = rockchip_pcie_ep_write_header,
       .set_bar = rockchip_pcie_ep_set_bar,
       .clear_bar = rockchip_pcie_ep_clear_bar,
       .map_addr = rockchip_pcie_ep_map_addr,
       .unmap_addr = rockchip_pcie_ep_unmap_addr,
       .set_msi = rockchip_pcie_ep_set_msi,
       .get_msi = rockchip_pcie_ep_get_msi,
       .raise_irq = rockchip_pcie_ep_raise_irq,
       .start = rockchip_pcie_ep_start,
       .get_features = rockchip_pcie_ep_get_features,
};

>
> > +
> > +     if (mmc > 0x5) {
> > +             dev_err(&epc->dev, "Number of MSI IRQs cannot be more than 32\n");
>
> Long line. Please split it after the comma.
>
> > +             return -EINVAL;
> > +     }
> > +
> >       flags = rockchip_pcie_read(rockchip,
> >                                  ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> >                                  ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>
> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
> here all the time.

Yes, this could be an improvement but this is the way it is written
everywhere in this
driver, I chose to keep it so as to remain coherent with the rest of the driver.
Cleaning this is not so important since this code will not be
rewritten / changed so
often. But I agree that it might be nicer. But, on the other side if
at some point
support for virtual functions would be added, the offsets would need
to be computed
based on the virtual function number and the code would be written
like it is now,
so I suggest keeping this the way it is for now.

>
> --
> Damien Le Moal
> Western Digital Research
>

Thank you for your comments.

Regards
Rick
