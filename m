Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0026483CA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLIOaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 09:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLIOaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 09:30:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D100205C5;
        Fri,  9 Dec 2022 06:30:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8E2EB8287F;
        Fri,  9 Dec 2022 14:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E31C433F1;
        Fri,  9 Dec 2022 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670596205;
        bh=a+obGw3XVMUgASOc8FIE8ScuBYM0lR28Ui9u4J3KSSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=evYP4PkUi2/2b7jX7db6YhIdWE1vyjJsHtneNdVjASPc3wp/JvLGQvPueihcNQJAP
         /qtC+41vZU4R5OEri+9O5Iw3sN3FrNCpQtxe+ZaToNocefQI53eEKOs70UjyIFvj5M
         pmeklMhsIjMCjoKNsJJFgW7Np+XsWSFB8jsHhijZBZ5EFnqifkxDgFRMzW17gV2Z9A
         6acYGobJjHtpcwkiS5ZrJNw8XDh8dgL8CwahFmYwDvdtheDG2cMHw1YpQw/0XSaUmn
         onKb+5C6K+mNHd2wQhU8TD0RPEXwOan1ItvzaHTlblzAlVplQLrNQFlNvjXC2bur/h
         giX8eVEKXzNSA==
Received: by mail-vk1-f173.google.com with SMTP id z23so2182504vkb.12;
        Fri, 09 Dec 2022 06:30:05 -0800 (PST)
X-Gm-Message-State: ANoB5pmXH4yWeyVQ8NZqU7SS4Et1qp4MyO4XyJKTJGo2khdLdx4KOqTh
        mh6cfuDgD3jWqNsWLPJx2cfNw3TMh9hvLP+aVQ==
X-Google-Smtp-Source: AA0mqf53boM2A4hfZJBHsALfQhmvj3CWarRFhZegP+duCkmWd1VI9ygmXmydjZTSN0pUVc4Gpi0ad+IlynSnuQ5IjzY=
X-Received: by 2002:a1f:2348:0:b0:3bd:51f6:1f3 with SMTP id
 j69-20020a1f2348000000b003bd51f601f3mr15880344vkj.35.1670596204403; Fri, 09
 Dec 2022 06:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20221114155333.234496-1-jonathanh@nvidia.com> <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome> <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
 <Y49xg7wptRweHd4I@orome> <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
 <20221209101743.uzyw5ejubkbfm5di@mobilestation>
In-Reply-To: <20221209101743.uzyw5ejubkbfm5di@mobilestation>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Dec 2022 08:29:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com>
Message-ID: <CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 9, 2022 at 4:17 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Tue, Dec 06, 2022 at 03:14:58PM -0600, Rob Herring wrote:
> > On Tue, Dec 6, 2022 at 10:44 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> > > > On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > > > > From: Vidya Sagar <vidyas@nvidia.com>
> > > > > >
> > > > > > Add support for ECAM aperture that is only supported for Tegra234
> > > > > > devices.
> > > > > >
> > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > > ---
> > > > > > Changes since V2:
> > > > > > - Avoid duplication of reg items and reg-names
> > > > > > Changes since V1:
> > > > > > - Restricted the ECAM aperture to only Tegra234 devices that support it.
> > > > > >
> > > > > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> > > > > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > > > > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > > > >
> > > > > Both patches applied now.
> > > >
> > > > linux-next now fails with this. I suspect it is due to Sergey's
> > > > changes to the DWC schema.
> > > >
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > > fixed:
> > > >         'dbi' was expected
> > > >         'dbi2' was expected
> > > >         'ecam' is not one of ['elbi', 'app']
> > > >         'atu' was expected
> > > >         'dma' was expected
> > > >         'phy' was expected
> > > >         'config' was expected
> > > >         /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > > fixed:
> > > >                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
> > > >                 'ecam' is not one of ['atu_dma']
> > > >                 'ecam' is not one of ['smu', 'mpu']
> > > >         From schema:
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> > >
> > > Stephen reported the other day that he wasn't able to resolve this
> > > conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
> > > now propagated to ARM SoC so it can't be easily backed out, but I guess
> > > we could revert on that tree and instead apply the patch to the DT tree
> > > and resolve the conflict there.
> > >
> > > I guess the better alternative would be to try and resolve the merge
> > > properly and let Stephen (and Linus) know.
> >
>
> > Instead, can you prepare a patch on top of Sergey's adding a 'oneOf'
> > entry with 'ecam'. As this is a new thing, it should have its own
> > entry. Then when merging, we just throw out the change from your side.
>
> Right, the only change that is required here is to extend the
> reg-names oneOf list of the DT-bindings:
> < Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> with the 'ecam' entry. If it's a vendor-specific part then add to the
> last the last entry defines the vendor-specific duplicates of the generic CSR
> spaces.
>
> On the other hand I don't really see a reason in adding the ECAM CSRs
> space to the generic DW PCIe device since basically the ECAM memory is
> just a pre-configured outbound iATU window. So if it's a ECAM-based
> device then it should have been already configured by the system
> bootloader upon the kernel boot up. Thus there is no point in having
> the generic DW PCIe resources and it should be just a generic
> ECAM-based device with a single ECAM CSR space as the
> "snps,dw-pcie-ecam"/"pci-host-ecam-generic" DT-bindings require
> especially seeing the Nvidia low-level driver doesn't use the ECAM
> registers at all. Moreover the DW PCIe core driver doesn't
> differentiate between the already configured iATU windows and the one
> available for the ranges-based mapping. Instead the DW PCIe core just
> disables all the detected in- and outbound iATUs by means of the
> dw_pcie_iatu_setup() method. So the pre-configured ECAM space will be
> reset by the driver core anyway.

This was discussed some before. This is for the firmware/bootloader to
setup ECAM mode. Then the kernel will see generic (ACPI) ECAM.

Yes, it is iATU config, but so is 'config'. If we were starting over,
I'd say 'reg' should just have the entire address space for iATU and
the driver could figure out how to configure it (beyond what ranges
says). But that ship has sailed. Also, note that the address range
here is disjoint from 'config', so it looks like we'd need 2 entries
anyways.

Rob
