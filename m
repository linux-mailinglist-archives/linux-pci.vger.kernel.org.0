Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53969E135
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjBUNTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 08:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjBUNTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 08:19:40 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115284690;
        Tue, 21 Feb 2023 05:19:39 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t22so4351926oiw.12;
        Tue, 21 Feb 2023 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iMwe4PtMwH0nNT/jVRzm0LMyDYgd6+g6SaK53AI4ls=;
        b=oUM+2G/80g+PFG9doQ2H+eCMdzTBZtKUsxidOPjENobZUj8rZtLr4YzuiMEZy/Fa7S
         l+3QBAIokOo/tLcUARb6xk5Fq2L9j26rhaDjrP1F7XIxA4Q9xq1wYEOroV6BoiZ8i2OV
         WE2z8J7DO3LMNVBAVkwS1vSi9iUv6wKyJ/OkUiK/zFhJQTqxfcJCykGFdF32aWdVQWxO
         GzPy/VSVdAkDG3xo1Bro58FExnLEHPXdMi0/iUFuZWcnhFQP+Gi2D8VaLB941CkXRexp
         KoG+VmKJxAjm+wsEqZjvHwbxt128nUC15A0ITh3fqhDgM5qYhXdOVyPbSx/lEsrUtpgR
         kQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iMwe4PtMwH0nNT/jVRzm0LMyDYgd6+g6SaK53AI4ls=;
        b=eME1y7Auv+TVMVd/KU671OBAvB8zWVTIvdW1BqSIoWbxhVcH6kiiGE0SEZgXZrFcpJ
         PeOKVvMOHGaOj569TLd+QCwvFyLcpmIO/8Gcgx5joT7MzT9IwJmb1x7SgCBThnxSO1uW
         X5Fb1sPbTuNz2E832CzBrjRL5pDftiu8mrmK0FpZrdAtN46HGbUTU1ayZpzbDWfP9wH3
         VcSCMD65s77UU0T+xqRe4qZ1qEv33cAeckqDWKWW4nuXY5JIWRYfuY73lzpaT/7NY3Wc
         97O69laDlCJYi3EsIZ7Gj0wbU+dvgZ3X5gLKqygm7awD3zNhJSiceuqLOWRR+UJDsfLV
         olmQ==
X-Gm-Message-State: AO0yUKWLZ8vOnPAmcUPU5EPt6H5aDI5n7oJHclVnRWwcSanalK0p69g2
        rLDk45o0peyB3hdnGLpoky22m7ykHJTuU//gGQg=
X-Google-Smtp-Source: AK7set8LP8CGoQD5zRZ3BNEveYYECJPdFB73CrdzuWQp87GptR8TVi6WAjM1n/DjaPb4CxU1SiKpfiQHdbWSf1bCbUc=
X-Received: by 2002:a05:6808:1211:b0:383:b2c0:4e24 with SMTP id
 a17-20020a056808121100b00383b2c04e24mr210340oil.110.1676985578247; Tue, 21
 Feb 2023 05:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-10-rick.wertenbroek@gmail.com> <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
 <CAAEEuhpDTmAvBZhC9RCueOvqbLb=AttV1KxJrOUBcjHQrpVXmA@mail.gmail.com> <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com>
In-Reply-To: <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 21 Feb 2023 14:19:01 +0100
Message-ID: <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
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

On Tue, Feb 21, 2023 at 11:55 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/21/23 19:47, Rick Wertenbroek wrote:
> > On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 2/14/23 23:08, Rick Wertenbroek wrote:
> >>> The RK3399 PCIe endpoint core supports only a single PCIe physcial
> >>> function (function number 0), therefore return -EINVAL if set_msi() is
> >>> called with a function number greater than 0.
> >>> The PCIe standard only allows the multi message capability (MMC) value
> >>> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
> >>> called with a MMC value of over 0x5.
> >>>
> >>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >>> ---
> >>>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> >>> index b7865a94e..80634b690 100644
> >>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> >>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> >>> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
> >>>       struct rockchip_pcie *rockchip = &ep->rockchip;
> >>>       u32 flags;
> >>>
> >>> +     if (fn) {
> >>> +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
> >>> +             return -EINVAL;
> >>> +     }
> >>
> >> Checking this here is late... Given that at most only one physical
> >> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
> >> Something like:
> >>
> >>         err = of_property_read_u8(dev->of_node, "max-functions",
> >>                                   &ep->epc->max_functions);
> >>
> >>         if (err < 0 || ep->epc->max_functions > 1)
> >>
> >>                 ep->epc->max_functions = 1;
> >>
> >
> > Yes, this could be moved to the probe, thanks.
> >
> >> And all the macros with the (fn) argument could also be simplified
> >> (argument fn removed) since fn will always be 0.
> >
> > These functions cannot be simplified because they have to follow the signature
> > given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
> > function number as a parameter. If we change the function signature we won't
> > be able to assign these functions to the pc_epc_ops structure
>
> I was not suggesting to change the functions signature. I was suggesting
> dropping the fn argument for the *macros*, e.g.
>
> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) -> ROCKCHIP_PCIE_EP_FUNC_BASE
>
> since fn is always 0.
>
> That said, I am not entirely sure if the limit really is 1 function at most. The
> TRM seems to be suggesting that up to 4 functions can be supported...
>
> [...]
>
> >> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
> >> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
> >> here all the time.
> >
> > Yes, this could be an improvement but this is the way it is written
> > everywhere in this
> > driver, I chose to keep it so as to remain coherent with the rest of the driver.
> > Cleaning this is not so important since this code will not be
> > rewritten / changed so
> > often. But I agree that it might be nicer. But, on the other side if
> > at some point
> > support for virtual functions would be added, the offsets would need
> > to be computed
> > based on the virtual function number and the code would be written
> > like it is now,
> > so I suggest keeping this the way it is for now.
>
> Yes, sure, this can be cleaned later.
>
> A more pressing problem is the lack of support for MSIX despite the fact that
> the controller supports that *and* advertize it as a capability. That is what
> was causing my problem with the Linux nvme driver and my prototype nvme epf
> function driver: the host driver was seeing MSIX support (1 vector supported by
> default), and so was allocating one MSIX for the device probe. But on the EP
> end, it is MSI or INTX only... Working on adding that to solve this issue.
>

I have seen this too, the controller advertises the capability. However, the TRM
(section 17.5.9) says that MSI-X is not supported (MSI / INTx only as you said).
So the solution should be to modify the probe function of the endpoint
controller
so that the MSI-X capability would not be advertised, this should fix
your problem.

I wonder if one could still implement MSI-X because from the endpoint we would
just need to implement it as a message (TLP) over PCIe (because the space for
the vectors is allocated and written, so that part should be ok). I am
not an expert
on MSI-X, but the reason the endpoint cannot send them could be because MSI-X
requires some fields in the PCIe header descriptor to be filled with values that
cannot be set through the "desc0-3" registers of the RK3399 PCIe endpoint core.

Anyways, the endpoint should not advertise the MSI-X capabilities when it cannot
send such interrupts. Once this is fixed you should be able to have your NVMe
function running.

Regards.
Rick


> --
> Damien Le Moal
> Western Digital Research
>
