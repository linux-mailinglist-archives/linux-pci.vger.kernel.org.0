Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0872203B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFEHzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjFEHzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 03:55:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4210E5;
        Mon,  5 Jun 2023 00:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00DA4612FE;
        Mon,  5 Jun 2023 07:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D28C433D2;
        Mon,  5 Jun 2023 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685951657;
        bh=rmdkJYpI3/LXSafXa70F/fUmwmNmdhyZ+VfJnsbJCdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T64BH0R02IcyqAxlm6ybeVysJe5aOUtcsqeUlk5s83Q+0kfPsj6kC6hro0bW/wCTi
         Ozm35kzMCxIj6tvR3RN0ypvilHm1CWO0O+LDVOH/LBQFPnells1i32QtWrHI5xlZ+I
         qsgZg5fya6Va7M29gT3swelLzddd0TEJ6kQfxUy6phmnAlxocu9jEh5SE7i0y8N/8n
         ysfNC6bHl9qmPpZq74ZH7R4tw44K8xuKf7yBkbkTB6dEN3Lv2r4leO0HesR4su3EAk
         QXLxQA4aYWrxy6mpEvRs2oXz3FC+G1FEen7scnbNVvQ8ckHkKZNjM3K/OeK0EXvCxd
         aX72aNDORmsUg==
Date:   Mon, 5 Jun 2023 13:24:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Message-ID: <20230605075408.GA5536@thinkpad>
References: <20230113090350.1103494-1-mie@igel.co.jp>
 <20230113090350.1103494-2-mie@igel.co.jp>
 <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
 <978b63ac-90b5-b909-d259-0668b77f1cc8@kernel.org>
 <52b8f850-af8c-1971-9729-c5de37875bf9@amd.com>
 <38d41f97-14d5-e24b-3d19-6c4f96305c58@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38d41f97-14d5-e24b-3d19-6c4f96305c58@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 09:10:22PM +0900, Damien Le Moal wrote:
> On 6/2/23 20:39, Kishon Vijay Abraham I wrote:
> > 
> > 
> > On 6/2/2023 5:13 AM, Damien Le Moal wrote:
> >> On 6/2/23 00:06, Kishon Vijay Abraham I wrote:
> >>> Hi Shunsuke,
> >>>
> >>> On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
> >>>> Add an align_mem operation to the EPC ops, which function is used to
> >>>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
> >>>> restriction of EPC. The map function maps an aligned memory to include a
> >>>> requested memory region.
> >>>
> >>> I'd prefer all the PCIe address alignment restriction be handled in the
> >>> endpoint function drivers and not inside the core layer (esp in map and
> >>> unmap calls).
> >>
> >> That is a really *bad* idea ! Most function drivers should be able to work with
> >> any EP controller hardware. Asking these drivers to support all the alignment
> >> peculiarities of every possible EP controller is impossible.
> > 
> > Function drivers already work with various restrictions of EP controller 
> > hardware. pci_epc_features was added to provide such restrictions to 
> > function drivers. Not sure why it has to be different here.
> >>
> >>> IMO, get the pci address alignment restriction using pci_epc_features.
> >>> And use a bigger size (based on alignment restriction) in
> >>> pci_epc_mem_alloc_addr() and access the allocated window using an offset
> >>> (based on alignment value). You can add separate helpers if required.
> >>
> >> That is too simplistic and not enough. Example: Rick and I working on an nvme
> >> function driver are facing a lot of issues with the EPC API for mem & mapping
> >> management because we have 0 control over the PCI address that the host will
> >> use. Alignment is all over the place, and the current EPC memory API
> >> restrictions (window size limitations) make it impossible to transparently
> >> handle all cases. We endup with NVMe command failures simply because of the API
> >> limitations.
> > 
> > You mean restrictions w.r.t OB window address and not PCIe address?
> >>
> >> And sure, we can modify that driver to better support the EP controller we are
> >> using (rockchip). But we need to support other EP controllers as well. So API
> > 
> > Every EP controller can provide it's restrictions in pci_epc_features. 
> > Unless the alignment is going to change dynamically, don't see a need 
> > for adding new epc ops.
> > 
> > Not sure why the following cannot be handled from function driver?
> > 
> > From
> > 
> >         A                    A + S
> >          ┌────────────────────────┐
> >          │                        │
> >          │        OB WIN          │
> >          ├────────────────────────┤
> > mapping │                        │
> >          ▼                  B + S ▼
> >        B ┌────────────────────────┐
> >          │                        │
> >          │       PCI Address      │
> >          └────────────────────────┘
> > 
> > To
> > 
> > 
> >       A   A'│              A + S      A+S+alignment
> >        ┌────┼───────────────────┬──────┐
> >        │    │                   │      │
> >        │    │       OB WIN      │      │
> >        ├────┴───────────────────┴──────┤
> >        │                               |
> >        │                               |
> >     B' ▼   B                     B + S ▼
> >        ┌────┬──────────────────────────┐
> >        │    │                          │
> >        │    │     PCI Address          │
> >        └────┴──────────────────────────┘
> > 
> > So the changes in function driver will be
> > 1) Get alignment value in epc_features
> > 2) pci_epc_mem_alloc_addr()/pci_epc_map_addr() will take into account 
> > the alignment value (change in size parameter)
> > 3) Access host memory from an offset in the provided 
> > pci_epc_mem_alloc_addr().
> 
> The problem with all this is that some EP controllers (at least the rockchip for
> sure, likely the Cadence one as well) have alignment constraints that depend on
> the *host* PCI address (yes, the rockchip driver is still buggy in that respect,
> fixes coming, see at the end for the details about the rockchip). The current
> API does not allow for that to be gracefully handled and using the epc_features
> for that would not work at all.
> 
> With this dynamic constraint based on the host PCI address (which the EPF cannot
> control), we need EPC core functions that:
> 1) allocate memory from windows based on the PCI address they will be mapped to
> 2) Depending on the size of the transfer + the alignment need for a PCI address,
> a single memory window may not be enough, so we need the ability to allocate
> memory over multiple windows
> 3) Some nice helpers that avoid that pattern of mem alloc + map pci addr and
> simplify them with "map this PCI address for me and tell me the local CPU
> address for it, completely hiding any alignment concerns.
> 
> >> changes are definitely needed. Working on that. That is not easy as the mapping
> >> API and its semantic impacts data transfers (memcpy_from|toio and DMA).
> >>
> >> I do have a patch that does something similar as this one, but at a much higher
> >> level with a helper function that gives the function driver the offset into the
> >> allocated memory region to use for mapping a particular PCI address. And then
> >> this helper is then in turn used into a new pci_epc_map() function which does
> >> mem alloc + mapping in one go based on the EPC constraints. That hides all
> > 
> > pci_epc_map() was added only to perform mapping functionality. I'd 
> > prefer it stays that way instead of adding bunch of other things into it.
> 
> I am not proposing to add to it or to modify it. That function can remain the
> basic one for simple cases. But we need better functions for more complex EPF
> functions that need to map potentially large memory areas to random PCI addresses.
> 
> What I am proposing is to have more intelligent helpers using the current simple
> functions: essentially wrapping pci_epc_mem_alloc_addr()+pci_epc_map_addr() with
> pci_epc_map(), and similar for unmap. That would greatly simplify the code of
> EPF drivers that constantly need to map/unmap PCI address to serve IOs/transfers
> as requested by the host/RP side. Developers would still be free to use the
> verbose path if they wish to do so, modulo the mandatory fixes for gracefully
> handling alignment and allocation size, for which we need either to modify
> pci_epc_mem_alloc_addr() or new functions.
> 

I agree with this new API idea. Handling the alignment restrictions in the EPF
core reduces code duplication among the EPF drivers.

- Mani

> Note about the rk3399 EP controller: it has 1MB memory windows that can be used
> to map up to 1MB of PCI address space. This limits comes from the fact that the
> mapping controller uses at most the lower 22 bits from the local CPU address as
> the lower bits for the PCI address. But this also implies that the offset (the
> alignment) into the memory window must be equal to the mask of the PCI address
> to map over the number of bits of PCI address that will change over the range of
> addresses mapped (the number of bits of address changing over the address range
> [PCI_addr .. PCI_addr + mapping_size - 1]).
> 
> Notifying this alignment need to an EPF driver can only be done using an API.
> Cannot do that with epc_features fields.
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

-- 
மணிவண்ணன் சதாசிவம்
