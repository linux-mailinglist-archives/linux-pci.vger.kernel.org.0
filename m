Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215836439A8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiLEXmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 18:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLEXmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 18:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF631FCC5;
        Mon,  5 Dec 2022 15:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2014CB815C9;
        Mon,  5 Dec 2022 23:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AFFC433D6;
        Mon,  5 Dec 2022 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670283727;
        bh=4wJabThFZ4VUXjAcvXIT97D1YyfJXyrel4+YB/Ab+gk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZobKRLT5ZAge7Mfr+9Ip+dxbQpBkCk2RTtEPH47l4VyLYW/DFp9y9lCOVM+13yuWZ
         fllnOwfZ79glqC/04eGRrZQXiGq45ZaHctcQak9QyU0/Rb2O9O4Z82roEN2n2fq41j
         KhCv33+LONiVSItlj/XlkeRrghNVtvj1StcxVtYxrL5NcmXUIFKcfYfEdVhatTB01t
         lmU8URLZPu8mJmvRX1fk3gTbtlZ/wETFq4mdjBk69QVyhuf2ekVz/0kMn6hgN+irfb
         Z6i0UmSd9ZzjN8eBqwo1DH6uCwoWPBxrZiBqHd4AdUStpbhc+gwEX+bAiMpLQpweJy
         l3ah6Xu5mC+Dg==
Received: by mail-vs1-f54.google.com with SMTP id c184so12679246vsc.3;
        Mon, 05 Dec 2022 15:42:07 -0800 (PST)
X-Gm-Message-State: ANoB5plwsgCiwfBWuug66O6CSXBgiSE1jpilM5W40J2pDh9T4PZ8C4+b
        wdN0OjTbqOwgnsLOxBrczGGVg4IvqH5jiycOwQ==
X-Google-Smtp-Source: AA0mqf52qMjSmyIkwFrSYPkLIs/sPSoB5CM3A/eqb99puUmDiOUo5CG5r5eXPIEw7a2BH2dvI7oXrkkI0RUmvAZQWgU=
X-Received: by 2002:a05:6102:2381:b0:3b0:c6ec:cc6a with SMTP id
 v1-20020a056102238100b003b0c6eccc6amr16733521vsr.0.1670283726721; Mon, 05 Dec
 2022 15:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221114155333.234496-1-jonathanh@nvidia.com> <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome>
In-Reply-To: <Y3ap1o2SbNvFw8Vd@orome>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Dec 2022 17:41:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
Message-ID: <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
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

On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > From: Vidya Sagar <vidyas@nvidia.com>
> >
> > Add support for ECAM aperture that is only supported for Tegra234
> > devices.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> > Changes since V2:
> > - Avoid duplication of reg items and reg-names
> > Changes since V1:
> > - Restricted the ECAM aperture to only Tegra234 devices that support it.
> >
> >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> >  2 files changed, 33 insertions(+), 3 deletions(-)
>
> Both patches applied now.

linux-next now fails with this. I suspect it is due to Sergey's
changes to the DWC schema.

/builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
fixed:
        'dbi' was expected
        'dbi2' was expected
        'ecam' is not one of ['elbi', 'app']
        'atu' was expected
        'dma' was expected
        'phy' was expected
        'config' was expected
        /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
fixed:
                'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
                'ecam' is not one of ['atu_dma']
                'ecam' is not one of ['smu', 'mpu']
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
