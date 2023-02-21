Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A733769E4ED
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 17:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjBUQiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjBUQiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 11:38:21 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D951A679;
        Tue, 21 Feb 2023 08:37:55 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1720600a5f0so6190337fac.11;
        Tue, 21 Feb 2023 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLjHRJBIZDzt/xCM/EXWPMqxEiDZeKfzk/U/vJzGizY=;
        b=Q6TIWdFHznVqxgc0h3jk1x7ZiS2M7VrijVzxfD0B03fs3VUL77+UK5+p8sknOYKEwp
         s9d5U1jX18ywsbJoJo+fjulSps8Y2evCVJx4xTZ5Dff781zMtcZO9oGaPHv6RheQoybX
         OpvT+NooxzxAZXit3bdNEGsWCaZl+RjYmRB00Rcc0lbyQOOdP1bsnvz1xG3k0ziBZdnj
         IxCTeQNGd1s+m2EHWP3cfpY4fIYYzN0YllN39JPfqxn9sLMrRlcW8tKcp5wCuISBLOgN
         YbL1a94rqSaVBaONZv7cYjN4A7gMwK90Bor7iURPs3z8Ax+59qKYvKgK33+GVYgDcc5F
         kSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLjHRJBIZDzt/xCM/EXWPMqxEiDZeKfzk/U/vJzGizY=;
        b=h8JG02IQfxxmKSNrwW2XpnUP0dUiTywERP3Csrd+f/ig0/vuVW/SH8jtIg3EiRPSOr
         iyNG0rOm8CN99RXniRZ/pJSeVSk4EyjDIcNMQMkGku8iPDbWEfYv3PGh4QNYV6q3DK+N
         41CqdeHrX8/NIFNLrCk6YLhup7jX0vdmD6yaBxf0pvz39KalNcJe1FW1wWMVN2ndQ6jV
         u4mDY7k2ANXGHkF2CmJBhxmMBa1EJ+T+r2tsZxu3T9ApEvTcKhZwdseMCQVqViDfQDta
         Ql2O5gx6bT9Yj2rnhkt+MtCCj8O/V8eSRO6uOms1B2DkMq2ZlaiZwK67XXaUUwyK5YPF
         lmgg==
X-Gm-Message-State: AO0yUKUbBrVzO19kBzC9qeKD1NydGxhkMNsstBq03WnuzISrLrJFFNs1
        IU7h7Aeuy/dOwpuXfCG/2/fOzp1KMQuEAxMXO98=
X-Google-Smtp-Source: AK7set+P6wOe9Kc2Cw/k6qWFoE3y4T8bv6Cwc+0ZGi/kPqlK62itYqIL+Sr9eN0HksHZWT3y6ouMqd9jE76hhkyG1h4=
X-Received: by 2002:a05:6871:460b:b0:16e:c845:9f9 with SMTP id
 nf11-20020a056871460b00b0016ec84509f9mr686434oab.110.1676997472927; Tue, 21
 Feb 2023 08:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-10-rick.wertenbroek@gmail.com> <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
 <CAAEEuhpDTmAvBZhC9RCueOvqbLb=AttV1KxJrOUBcjHQrpVXmA@mail.gmail.com>
 <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com> <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
In-Reply-To: <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 21 Feb 2023 17:37:16 +0100
Message-ID: <CAAEEuhrnz-u1wUe2OVBawSvrsze+rNObSqhb+SEcAqfc-n2c_g@mail.gmail.com>
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

On Tue, Feb 21, 2023 at 2:19 PM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> On Tue, Feb 21, 2023 at 11:55 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 2/21/23 19:47, Rick Wertenbroek wrote:
> > > On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
> > > <damien.lemoal@opensource.wdc.com> wrote:
> > >>
> > >> On 2/14/23 23:08, Rick Wertenbroek wrote:
> > >>> The RK3399 PCIe endpoint core supports only a single PCIe physcial
> > >>> function (function number 0), therefore return -EINVAL if set_msi() is
> > >>> called with a function number greater than 0.
> > >>> The PCIe standard only allows the multi message capability (MMC) value
> > >>> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
> > >>> called with a MMC value of over 0x5.
> > >>>
> > >>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > >>> ---
> > >>>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
> > >>>  1 file changed, 10 insertions(+)
> > >>>
> > >>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > >>> index b7865a94e..80634b690 100644
> > >>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > >>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > >>> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
> > >>>       struct rockchip_pcie *rockchip = &ep->rockchip;
> > >>>       u32 flags;
> > >>>
> > >>> +     if (fn) {
> > >>> +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
> > >>> +             return -EINVAL;
> > >>> +     }
> > >>
> > >> Checking this here is late... Given that at most only one physical
> > >> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
> > >> Something like:
> > >>
> > >>         err = of_property_read_u8(dev->of_node, "max-functions",
> > >>                                   &ep->epc->max_functions);
> > >>
> > >>         if (err < 0 || ep->epc->max_functions > 1)
> > >>
> > >>                 ep->epc->max_functions = 1;
> > >>
> > >
> > > Yes, this could be moved to the probe, thanks.
> > >
> > >> And all the macros with the (fn) argument could also be simplified
> > >> (argument fn removed) since fn will always be 0.
> > >
> > > These functions cannot be simplified because they have to follow the signature
> > > given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
> > > function number as a parameter. If we change the function signature we won't
> > > be able to assign these functions to the pc_epc_ops structure
> >
> > I was not suggesting to change the functions signature. I was suggesting
> > dropping the fn argument for the *macros*, e.g.
> >
> > ROCKCHIP_PCIE_EP_FUNC_BASE(fn) -> ROCKCHIP_PCIE_EP_FUNC_BASE
> >
> > since fn is always 0.
> >
> > That said, I am not entirely sure if the limit really is 1 function at most. The
> > TRM seems to be suggesting that up to 4 functions can be supported...
> >
> > [...]
> >
> > >> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
> > >> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
> > >> here all the time.
> > >
> > > Yes, this could be an improvement but this is the way it is written
> > > everywhere in this
> > > driver, I chose to keep it so as to remain coherent with the rest of the driver.
> > > Cleaning this is not so important since this code will not be
> > > rewritten / changed so
> > > often. But I agree that it might be nicer. But, on the other side if
> > > at some point
> > > support for virtual functions would be added, the offsets would need
> > > to be computed
> > > based on the virtual function number and the code would be written
> > > like it is now,
> > > so I suggest keeping this the way it is for now.
> >
> > Yes, sure, this can be cleaned later.
> >
> > A more pressing problem is the lack of support for MSIX despite the fact that
> > the controller supports that *and* advertize it as a capability. That is what
> > was causing my problem with the Linux nvme driver and my prototype nvme epf
> > function driver: the host driver was seeing MSIX support (1 vector supported by
> > default), and so was allocating one MSIX for the device probe. But on the EP
> > end, it is MSI or INTX only... Working on adding that to solve this issue.
> >
>
> I have seen this too, the controller advertises the capability. However, the TRM
> (section 17.5.9) says that MSI-X is not supported (MSI / INTx only as you said).
> So the solution should be to modify the probe function of the endpoint
> controller
> so that the MSI-X capability would not be advertised, this should fix
> your problem.
>
> I wonder if one could still implement MSI-X because from the endpoint we would
> just need to implement it as a message (TLP) over PCIe (because the space for
> the vectors is allocated and written, so that part should be ok). I am
> not an expert
> on MSI-X, but the reason the endpoint cannot send them could be because MSI-X
> requires some fields in the PCIe header descriptor to be filled with values that
> cannot be set through the "desc0-3" registers of the RK3399 PCIe endpoint core.
>
> Anyways, the endpoint should not advertise the MSI-X capabilities when it cannot
> send such interrupts. Once this is fixed you should be able to have your NVMe
> function running.
>
> Regards.
> Rick
>

It is possible to disable MSI-X by skipping the MSI-X capability
structure in the PCIe
capabilities structures linked-list.
The current linked list is MSI cap (0x90) -> MSI-X cap (0xb0) -> PCIe
Device cap (0xc0)
So we want to set MSI (0x90) -> PCIe Device cap (0xc0)

This can be done by writing 0xc0 to bits 15-8 of 0xFDA0'0090 (MSI cap).
I tested this quickly through devmem2 before loading the endpoint
function driver
and it fixes the issue of MSI-X capabilities being advertised to the host.

In the driver the changes would look like this;
In the probe function you can disable MSI-X as follows:

@@ -631,6 +618,28 @@ static int rockchip_pcie_ep_probe(struct
platform_device *pdev)

        ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;

+       /*
+        * Disable MSI-X because the controller is not capable of MSI-X
+        * This requires to skip the MSI-X capabilities entry in the
+        * chain of PCIe capabilities, we get the next pointer from the
+        * MSI-X entry and set that in the MSI capability entry, this way
+        * the MSI-X entry is skipped (left out of the linked-list)
+        */
+       cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+               ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+       cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+       cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+               ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+       cfg_msi |= cfg_msix_cp;
+
+       rockchip_pcie_write(rockchip, cfg_msi,
+               PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
        rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
PCIE_CLIENT_CONFIG);

        return 0;
 err_epc_mem_exit:
        pci_epc_mem_exit(epc);

In the pcie-rockchip.h add the following #defines:

@@ -216,21 +227,28 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS                    0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS               BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG                  0x90
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET                      8
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK                        GENMASK(15, 8)
+#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET                    16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET         17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK           GENMASK(19, 17)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET         20
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK           GENMASK(22, 20)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME                         BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP       BIT(24)
+#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG                  0xb0
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET          8
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK            GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR                                0x1
 #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR           0x3

I will add this to the next version of the patch set.
Thank you Damien for pointing this out ! This should solve the issues
you have with
your NVMe endpoint function regarding MSI-X interrupts.

Regards
Rick

>
> > --
> > Damien Le Moal
> > Western Digital Research
> >
