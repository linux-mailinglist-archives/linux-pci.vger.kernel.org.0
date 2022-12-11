Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDC649533
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLKRQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 12:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKRQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 12:16:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8DE0C4;
        Sun, 11 Dec 2022 09:16:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so14809327lfa.9;
        Sun, 11 Dec 2022 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2DNHmS3fylLel+oZvu0tLHDRVwogY7TDzQkfnHP98c=;
        b=kDDur/1+3usP1zvO0m0CkWQQtlCWkAMMeyGgmhaU1sQ6vhe4fVyZfP2kkeZ6vqX/OS
         yZOxEjB8lNOLCHEYXH42sw2STK8uyX1r0bpW/n8/EyHuSBheTRPa5G8JZzzkMK2mFwH9
         tc+FGEBzAb3n+HmCwAddUvlxjJm0AhSn7JKQDK7HJfTMJ/IlPj+24PR5Iwm5NTmj/sS2
         BC4wvdfBI4vlq8f5m8wfrIz/3KzSDXHCvjnQfE3Xkh3huhM0cBFaZSzD2uw/IbmgiU3O
         Zb2xl7dnV1yXmmiwZCJaJ/0fdduoPiQWGY14rOtRRHgcNS9B0Epvw/3iBhiUxXwkdbUM
         a1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2DNHmS3fylLel+oZvu0tLHDRVwogY7TDzQkfnHP98c=;
        b=5dqAC2M8gB4hiQNKZ4bnceoIWlUwW/4JiOHnczGMAEjfgibysiXhk6rrNyI/NW1C56
         7hSmG+fhIYQOmGe9yl7YUbDNAA6bn8m+1qWPNAiO6wOeq4qWBZcuGhc0j0BX0LJQ9YyY
         HsMrRTGKqvhSKFb9G5vSV9T7AgzoOPhP63+CTSMUmZ3MudDr1ySZ+6Y3Sy66PNsU52az
         OVDhYsiS56ZUyA6tM9zF51/qi+36sMP9z9LODw3cDjGg67/0i5W9NHIaTIC/s5CHNPHq
         Ndh0PJNuxWED90CjcxYqMrTdmDgl3cVRTDPXuH0bShqzJYRhiNOKPh73TXqO3pD8kNxW
         Gfjg==
X-Gm-Message-State: ANoB5plEKkgTRp1cD7ujv7LIuZC7qreKmfkx9Pcerz47jAQRctXe1zDC
        EMR2/WXGnHdc284PiKtgq8o=
X-Google-Smtp-Source: AA0mqf4Zu5Z0Gy/+BqrIPom15lElZzdBKjFcwPaxKsZsW38Xtnw86wBE7wzcfPdfR1IdeK8ApDiM0Q==
X-Received: by 2002:a05:6512:b1c:b0:4a4:68b7:dee8 with SMTP id w28-20020a0565120b1c00b004a468b7dee8mr4819493lfu.68.1670778976282;
        Sun, 11 Dec 2022 09:16:16 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id j2-20020a056512028200b0049f54c5f2a4sm1249666lfp.229.2022.12.11.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:16:15 -0800 (PST)
Date:   Sun, 11 Dec 2022 20:16:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <20221211171613.ba4u3k5onw3uzjy7@mobilestation>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome>
 <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
 <Y49xg7wptRweHd4I@orome>
 <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
 <20221209101743.uzyw5ejubkbfm5di@mobilestation>
 <CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 08:29:52AM -0600, Rob Herring wrote:
> On Fri, Dec 9, 2022 at 4:17 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Tue, Dec 06, 2022 at 03:14:58PM -0600, Rob Herring wrote:
> > > On Tue, Dec 6, 2022 at 10:44 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> > > > > On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > > > > > From: Vidya Sagar <vidyas@nvidia.com>
> > > > > > >
> > > > > > > Add support for ECAM aperture that is only supported for Tegra234
> > > > > > > devices.
> > > > > > >
> > > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > > > ---
> > > > > > > Changes since V2:
> > > > > > > - Avoid duplication of reg items and reg-names
> > > > > > > Changes since V1:
> > > > > > > - Restricted the ECAM aperture to only Tegra234 devices that support it.
> > > > > > >
> > > > > > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> > > > > > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > > > > > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > Both patches applied now.
> > > > >
> > > > > linux-next now fails with this. I suspect it is due to Sergey's
> > > > > changes to the DWC schema.
> > > > >
> > > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > > > fixed:
> > > > >         'dbi' was expected
> > > > >         'dbi2' was expected
> > > > >         'ecam' is not one of ['elbi', 'app']
> > > > >         'atu' was expected
> > > > >         'dma' was expected
> > > > >         'phy' was expected
> > > > >         'config' was expected
> > > > >         /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > > > fixed:
> > > > >                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
> > > > >                 'ecam' is not one of ['atu_dma']
> > > > >                 'ecam' is not one of ['smu', 'mpu']
> > > > >         From schema:
> > > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> > > >
> > > > Stephen reported the other day that he wasn't able to resolve this
> > > > conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
> > > > now propagated to ARM SoC so it can't be easily backed out, but I guess
> > > > we could revert on that tree and instead apply the patch to the DT tree
> > > > and resolve the conflict there.
> > > >
> > > > I guess the better alternative would be to try and resolve the merge
> > > > properly and let Stephen (and Linus) know.
> > >
> >
> > > Instead, can you prepare a patch on top of Sergey's adding a 'oneOf'
> > > entry with 'ecam'. As this is a new thing, it should have its own
> > > entry. Then when merging, we just throw out the change from your side.
> >
> > Right, the only change that is required here is to extend the
> > reg-names oneOf list of the DT-bindings:
> > < Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > with the 'ecam' entry. If it's a vendor-specific part then add to the
> > last the last entry defines the vendor-specific duplicates of the generic CSR
> > spaces.
> >
> > On the other hand I don't really see a reason in adding the ECAM CSRs
> > space to the generic DW PCIe device since basically the ECAM memory is
> > just a pre-configured outbound iATU window. So if it's a ECAM-based
> > device then it should have been already configured by the system
> > bootloader upon the kernel boot up. Thus there is no point in having
> > the generic DW PCIe resources and it should be just a generic
> > ECAM-based device with a single ECAM CSR space as the
> > "snps,dw-pcie-ecam"/"pci-host-ecam-generic" DT-bindings require
> > especially seeing the Nvidia low-level driver doesn't use the ECAM
> > registers at all. Moreover the DW PCIe core driver doesn't
> > differentiate between the already configured iATU windows and the one
> > available for the ranges-based mapping. Instead the DW PCIe core just
> > disables all the detected in- and outbound iATUs by means of the
> > dw_pcie_iatu_setup() method. So the pre-configured ECAM space will be
> > reset by the driver core anyway.
> 

> This was discussed some before. This is for the firmware/bootloader to
> setup ECAM mode. Then the kernel will see generic (ACPI) ECAM.
> 
> Yes, it is iATU config, but so is 'config'. If we were starting over,
> I'd say 'reg' should just have the entire address space for iATU and
> the driver could figure out how to configure it (beyond what ranges
> says). But that ship has sailed. Also, note that the address range
> here is disjoint from 'config', so it looks like we'd need 2 entries
> anyways.

Thanks for the explanation. I've got another suggestion them. The
semantics of the 'config' reg-space and the ECAM reg-space is very
similar. The only difference is the way the corresponding outbound
iATU window is configured. The DW PCIe driver just maps it in
accordance with the requested peripheral device BDF value so the very
first 4KB is translated to the CFG TLPs sent out to that device. The
same space could be mapped with the
IATU_REGION_CTRL_2_OFF_OUTBOUND_i.CFG_SHIFT_MODE flag set. So the
entire PCIe BDFs space will be available via the same MMIO region.
Thus the corresponding peripheral device will be available at the
BDF-based offset with respect to the 'config' reg-space base address.
Of course in the later case the 'config' MMIO range must be much
greater (256MB) than in the former case (4KB), but still the
difference in just the way the window is configured.  Moreover the DW
PCIe driver could be easier fixed to using the later approach if the
'config' reg-space is specified wide enough to map the entire PCIe bus
CFG-space (256MB).

Based on that and on the fact you said that the ECAM reg-space will be
used by the bootloader/firmware only anyway, I'd suggest to just
extend the 'config' reg-space semantics. So the bootloader/firmware
will be able to use it to create a generic ECAM device. The kernel DW
PCIe driver will by default use it to remap each peripheral device
CFG-space on request, but at some point the driver could be converted
to map the entire PCIe BDFs similarly to the ECAM space. Thus we won't
need to add a redundant ECAM reg-space. What do you think?

* hopefully it isn't too late for the suggested approach.

-Serge(y)

> 
> Rob
