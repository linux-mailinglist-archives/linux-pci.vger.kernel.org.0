Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1AE62A0E9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKOSBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKOSA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 13:00:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D362531235;
        Tue, 15 Nov 2022 10:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DDE9B81A59;
        Tue, 15 Nov 2022 18:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDA4C433B5;
        Tue, 15 Nov 2022 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668535220;
        bh=V+CDw9Lkisi0pVuYP/vfuaiILE7103hOmqneHcdz7K4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DpXCK2plJGNPu+0M8wHbEdKu/WJY4aLUaFyzENRpJWF9UhGvFSyuTVswdjCNMTCc7
         0VBrULhtgPAfyKxtw0znCGEzu29uv4GtsBJGO8+ieSg1/usokIxocCTT/oVG9P+Svl
         r7bMwijJTWWcoI1jRTmVCAZrqkpLUGqBVqEd2i8fdIsqRW3FcBxgaiS/2V1vQgFy+P
         KBYscfgywKJDSbyaG95Nl1mf9nwF825DqCRlmuQNDfUK4GkfUPMfR/QqbQZFOOFy9G
         AVg/pedgdi64bq17xeT6MOLLLbhwH8mCwwqQwwHyc359WJuK/QMp/6RCduNnqZuJR+
         Ervg/LYaRer0g==
Received: by mail-lj1-f170.google.com with SMTP id u2so18565322ljl.3;
        Tue, 15 Nov 2022 10:00:20 -0800 (PST)
X-Gm-Message-State: ANoB5pk4ymGSGobNp8w3eRdrv94uQLQBRpc+zZz2LQVAhi2agHJucZPb
        s+7YJgv4lO0h2EO1V7LqgPyEuT52UzTUMmE77g==
X-Google-Smtp-Source: AA0mqf4zsHpIKzELoBNtkrNEltVvWv6+X5mMUF7dvrGkfZPdg/U6t9+lLgKOIerV413GobUiXZJXyeo65Y4F6JleoLU=
X-Received: by 2002:a2e:a80b:0:b0:275:1343:df71 with SMTP id
 l11-20020a2ea80b000000b002751343df71mr6791315ljq.215.1668535218200; Tue, 15
 Nov 2022 10:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20221114155333.234496-1-jonathanh@nvidia.com> <20221114155333.234496-2-jonathanh@nvidia.com>
 <20221115020136.GA3973578-robh@kernel.org> <f8148686-796f-62a6-e424-733966f7db0b@nvidia.com>
In-Reply-To: <f8148686-796f-62a6-e424-733966f7db0b@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Nov 2022 12:00:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HWqLLk5dwYxNc0sKuiguT1DeTSFke+GSML5UACD=yFA@mail.gmail.com>
Message-ID: <CAL_Jsq+HWqLLk5dwYxNc0sKuiguT1DeTSFke+GSML5UACD=yFA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Tue, Nov 15, 2022 at 10:03 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 15/11/2022 02:01, Rob Herring wrote:
> > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> >> From: Vidya Sagar <vidyas@nvidia.com>
> >>
> >> Add support for ECAM aperture that is only supported for Tegra234
> >> devices.
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >> Changes since V2:
> >> - Avoid duplication of reg items and reg-names
> >> Changes since V1:
> >> - Restricted the ECAM aperture to only Tegra234 devices that support it.
> >>
> >>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> >>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> >>   2 files changed, 33 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> >> index 75da3e8eecb9..fe81d52c7277 100644
> >> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> >> @@ -27,6 +27,7 @@ properties:
> >>         - nvidia,tegra234-pcie
> >>
> >>     reg:
> >> +    minItems: 4
> >>       items:
> >>         - description: controller's application logic registers
> >>         - description: configuration registers
> >> @@ -35,13 +36,16 @@ properties:
> >>             available for software access.
> >>         - description: aperture where the Root Port's own configuration
> >>             registers are available.
> >> +      - description: aperture to access the configuration space through ECAM.
> >>
> >>     reg-names:
> >> +    minItems: 4
> >>       items:
> >>         - const: appl
> >>         - const: config
> >>         - const: atu_dma
> >>         - const: dbi
> >> +      - const: ecam
> >
> > Wouldn't this be mutually exclusive with 'config'? 'config' is not
> > really h/w, but an just an iATU window typically.
>
> Yes that is true, however, I was chatting with Sagar and we really need
> both ranges to be defined.
>
> > Where's the driver change to use this?
>
> For Linux there is not one. However, we need this for our port of the
> EDK2 bootloader [0] that parses device-tree and can support booting
> Linux with either device-tree or ACPI. We wanted to have a common
> device-tree we can use for EDK2 and Linux.

Ok, makes sense.

Acked-by: Rob Herring <robh@kernel.org>
