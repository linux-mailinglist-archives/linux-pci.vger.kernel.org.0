Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D476EE45D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDYPCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjDYPCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 11:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72578CC17;
        Tue, 25 Apr 2023 08:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5207E62638;
        Tue, 25 Apr 2023 15:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B2C433D2;
        Tue, 25 Apr 2023 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682434967;
        bh=ehMxtfgPPt4ARwMuISJWQt1frJpETdzqR5PFSNkI3Ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mid3BpQNkz6A4sjuloyiRKEi/ZNvzgU2H0NOiRRhgSZ71U0S6bXkX6ganwSq0PamO
         dBeY8lg7AsBhniOmSiARWDU+IeLIixSdqKlUbmKVU9UgTV0QJpmwBJ72qREEkRCaty
         JNdEMHZ/2w0Jec6hFQbICB4DXClWLB1op62Siq+umyaJkYrrWlaOrvScBxM1E8aGdr
         +GMQGdmm4RHgNsPcSv29QxXguXbUHWXJNc3W/TpL//VdujmJQBQAeDxvODqaL/QUDm
         LcELcr6SCF/iIrewVCo/ItAniVBW+X98IGLRjYTpAZtci8HC8fVJ7wN4E0thfakauJ
         X7To8A8ioovBw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-54fe2e39156so69672287b3.2;
        Tue, 25 Apr 2023 08:02:47 -0700 (PDT)
X-Gm-Message-State: AAQBX9de6bwLaWNip+O47QpvlRScM1bWDszxCjdSNM9mi59VG5oXoG+u
        e917maeT1SOmqDXm4naRNMUGQGfi2OWPsy8LfA==
X-Google-Smtp-Source: AKy350ajbnJBSl+HX3xPAJuZvpzT6q61Hk4UPSoaLf53K+qGoELszHvCtA9ylEA2fRvYJV8F5bUvL1c7LsJ5XbQC+d8=
X-Received: by 2002:a81:658a:0:b0:54f:badd:d148 with SMTP id
 z132-20020a81658a000000b0054fbaddd148mr10819011ywb.14.1682434966624; Tue, 25
 Apr 2023 08:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <1681877994-16487-1-git-send-email-lizhi.hou@amd.com>
 <1681877994-16487-3-git-send-email-lizhi.hou@amd.com> <20230419231155.GA899497-robh@kernel.org>
 <20d251bc-c4ec-64cc-8e6b-10c24cae6c9b@amd.com>
In-Reply-To: <20d251bc-c4ec-64cc-8e6b-10c24cae6c9b@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Apr 2023 10:02:35 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+P-_w8q7ahKpRzw=A1kkWBWocrWnni8P4LmpxffS0pfA@mail.gmail.com>
Message-ID: <CAL_Jsq+P-_w8q7ahKpRzw=A1kkWBWocrWnni8P4LmpxffS0pfA@mail.gmail.com>
Subject: Re: [PATCH V8 2/3] PCI: Create device tree node for selected devices
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 11:05=E2=80=AFAM Lizhi Hou <lizhi.hou@amd.com> wrot=
e:
> On 4/19/23 16:11, Rob Herring wrote:
> > On Tue, Apr 18, 2023 at 09:19:53PM -0700, Lizhi Hou wrote:
> >> The PCI endpoint device such as Xilinx Alveo PCI card maps the registe=
r
> >> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> >> the PCI core discovers devices and BARs using the PCI enumeration proc=
ess.
> >> There is no infrastructure to discover the hardware peripherals that a=
re
> >> present in a PCI device, and which can be accessed through the PCI BAR=
s.

[...]

> >> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >> index 196834ed44fe..42a5cfac2d34 100644
> >> --- a/drivers/pci/of.c
> >> +++ b/drivers/pci/of.c
> >> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *=
pdev, struct of_phandle_args *
> >>              } else {
> >>                      /* We found a P2P bridge, check if it has a node =
*/
> >>                      ppnode =3D pci_device_to_OF_node(ppdev);
> >> +                    if (ppnode && of_node_check_flag(ppnode, OF_DYNAM=
IC))
> >> +                            ppnode =3D NULL;
> > Again, different behavior if dynamic. I'm not seeing why you need this
> > change.
> This change is required. For dynamic generated node, we do not generate
> interrupt routing related properties. Thus we need to fallback to use
> pci_swizzle_interrupt_pin(). Generating interrupt routing related
> properties might be difficult. I think we can differ it to the future
> patches. Or just use pci_swizzle_interrupt_pin() which is much simpler.

I don't think we need to generate anything else in the DT. I think we
need to break from the loop if (ppnode && of_property_present(ppnode,
"interrupt-map")) instead.


> >> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset =
*ocs,
> >> +                       struct device_node *np)
> >> +{
> >> +    struct of_pci_addr_pair *reg;
> >> +    int i =3D 1, resno, ret =3D 0;
> >> +    u32 flags, base_addr;
> >> +    resource_size_t sz;
> >> +
> >> +    reg =3D kcalloc(PCI_STD_NUM_BARS + 1, sizeof(*reg), GFP_KERNEL);
> >> +    if (!reg)
> >> +            return -ENOMEM;
> >> +
> >> +    /* configuration space */
> >> +    of_pci_set_address(pdev, reg[0].phys_addr, 0, 0, 0, true);
> >> +
> >> +    base_addr =3D PCI_BASE_ADDRESS_0;
> >> +    for (resno =3D PCI_STD_RESOURCES; resno <=3D PCI_STD_RESOURCE_END=
;
> >> +         resno++, base_addr +=3D 4) {
> >> +            sz =3D pci_resource_len(pdev, resno);
> >> +            if (!sz)
> >> +                    continue;
> >> +
> >> +            ret =3D of_pci_get_addr_flags(&pdev->resource[resno], &fl=
ags);
> >> +            if (ret)
> >> +                    continue;
> >> +
> >> +            of_pci_set_address(pdev, reg[i].phys_addr, 0, base_addr, =
flags,
> >> +                               true);
> >> +            reg[i].size[0] =3D FIELD_GET(OF_PCI_SIZE_HI, (u64)sz);
> >> +            reg[i].size[1] =3D FIELD_GET(OF_PCI_SIZE_LO, (u64)sz);
> >> +            i++;
> >> +    }
> >> +
> >> +    ret =3D of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)re=
g,
> > I believe this should be 'assigned-addresses' rather than 'reg'. But th=
e
> > config space entry above does go in 'reg'.
>
> Do you mean I need to add 'assigned-addresses' in this patch?

Yes, but on further thought, I think they can just be omitted. They
are only needed
if we need of_pci_address_to_resource() to work.

>
> For 'reg', it needs to have pairs for memory space or I/O space. Here is
> what I saw in IEEE1275:
>
> "In the first such pair, the phys-addr component shall be the
> Configuration Space address of the
> beginning of the function's set of configuration registers (i.e. the
> rrrrrrrr field is zero) and the size component shall
> be zero. Each additional (phys-addr, size) pair shall specify the
> address of an addressable region of Memory Space or I/
> O Space associated with the function. In these pairs, if the "n" bit of
> phys.hi is 0, reflecting a relocatable address, then
> phys.mid and phys.lo specify an address relative to the value of the
> associated base register. In general this value will be
> zero, specifying an address range corresponding directly to the
> hardware's. If the "n" bit of phys.hi is 1, reflecting a nonrelocatable
> address, then phys.mid and phys.hi specify an absolute PCI address."

I think this is a case where true OpenFirmware and FDT differ
slightly. In OF, the DT reflects everything the firmware discovered
and configured. FDT is more just what's static and not discoverable.
(Though generating nodes here is more OF like.) For example, we don't
put the bus numbers in the DT as those are dynamic and assigned by the
OS. The purpose of the BAR registers in reg is to define the BAR size
(and address only if fixed). We don't need that unless what's
discoverable is wrong and we want to override it.


> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 57ddcc59af30..9120ca63a82a 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -1634,7 +1634,8 @@ static int pci_dma_configure(struct device *dev)
> >>      bridge =3D pci_get_host_bridge_device(to_pci_dev(dev));
> >>
> >>      if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> >> -        bridge->parent->of_node) {
> >> +        bridge->parent->of_node &&
> >> +        !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
> > Again, I don't think changing behavior for dynamic case is right. I
> > haven't dug into what an ACPI+DT case would look like here. (Hint:
> > someone that wants this merged can dig into that)
>
> I think this is required. Without dynamic node, on pure DT system,
> has_acpi_companion() will return false. Then "ret" is 0 and the
> following iommu_device_use_default_domain() might be called.
>
> With dynamic node, of_dma_configure() might return error because dma
> related properties are not generated. Thus, "ret" is none zero and the
> following iommu_device_use_default_domain() will be skipped.

Again, dynamic is the wrong thing to key off of. If we need
properties, then they should be added. However, I think the host
bridge should have what's needed. If the code needs to handle this
case, then we need to figure out the right thing to do.

Rob
