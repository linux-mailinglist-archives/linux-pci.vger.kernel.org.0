Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA2588426
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiHBWWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiHBWWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 18:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB654AFE;
        Tue,  2 Aug 2022 15:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E937B81F45;
        Tue,  2 Aug 2022 22:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66109C433D7;
        Tue,  2 Aug 2022 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659478923;
        bh=9VDhQQyT2A6k2G8P0OvmJ8l24hraDbeYrrioekoRq9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ksE43vgw5yPAp97pisFLn1VMujzKXlkfPpm8PiuTHHAnw/i4DUvp8pWYAhRlEz7R9
         6hWB+5zUcSucx8Otxq8+kHSpfuum2mKEpGAKzm1wzgwHIOxA8kqLJWWnjv3AcNhIj7
         70ASWFQZBqQfdTr3WLiBR36eWYIuOI9+l8M8QqG3YFaEHnx2W6ortl++uj5/lFr+xd
         jndtMFUmzHcvbPOnUmMmDz89w2jv2yvGo7zt9xVk4Ma8l99834n1LSXQ4oTcTH/GAP
         fNRddzTFv4Mdg/SSOu2LZFP/ui+5L/+k6aOUXukWBhxLpQxLgy9DwSRGOTjRI8AH/c
         3VgkVx+OsoBZQ==
Received: by mail-pg1-f179.google.com with SMTP id i71so7992310pge.9;
        Tue, 02 Aug 2022 15:22:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo1H3hy1YUfvUlEjj4brFy6Omg4PHnID8evPsO8P6K9gHC/M1QZ6
        1OPdlCATpaM+cqeF0wgpaxD+xZ+NmFixnrdjBw==
X-Google-Smtp-Source: AA6agR5CzuOzOwpHSN5b+WH1fxHUfAlYek1LHV5RvuPClFgI4f4JvRb9+DG82z3885fVG/s3a/RFDqymvboLdabT8FM=
X-Received: by 2002:aa7:982f:0:b0:52d:9787:c5c5 with SMTP id
 q15-20020aa7982f000000b0052d9787c5c5mr9518249pfl.24.1659478922946; Tue, 02
 Aug 2022 15:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220728175137.1172841-1-robh@kernel.org> <a673e846-e3d7-63e3-70cd-4adef3f761cc@arm.com>
In-Reply-To: <a673e846-e3d7-63e3-70cd-4adef3f761cc@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Aug 2022 16:21:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL37RQqGv6ZB5uxsnPFoUjKPh6uc7_SWpaqDJqvWAF4Dg@mail.gmail.com>
Message-ID: <CAL_JsqL37RQqGv6ZB5uxsnPFoUjKPh6uc7_SWpaqDJqvWAF4Dg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI properties
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 2, 2022 at 3:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-07-28 18:51, Rob Herring wrote:
> > Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
> > generic host. This fixes unevaluated property warnings on Arm Juno, AMD
> > Seattle, and FSL LS1028a.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > index 6bcaa8f2c3cf..d25423aa7167 100644
> > --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > @@ -106,6 +106,9 @@ properties:
> >       maxItems: 3
> >
> >     dma-coherent: true
> > +  iommu-map: true
> > +  iommu-map-mask: true
> > +  msi-parent: true
>
> Hmm, in general this set looks suspiciously incomplete without msi-map
> and msi-map-mask too. Am I right in thinking that the ideal thing to do
> here would be to convert pci-msi.txt and pci-iommu.txt to schema and
> $ref them?

I already added msi-map/msi-map-mask to pci-bus.yaml[1] as well as
schemas for iommu-map/iommu-map-mask[2] and msi-parent[3]. Since
msi-map is already in the referenced schema, it is allowed here.
msi-parent is separate because it is used elsewhere. iommu-map is
separate largely to make copying pci-iommu.txt as-is easier.

And yes, pci-iommu.txt can now be removed. pci-msi.txt is more
complicated as all of it hasn't been moved into schemas.

Rob

[1] https://github.com/devicetree-org/dt-schema/commit/109bde712466281e8c96a4fadb0f68e7a90a6eca
[2] https://github.com/devicetree-org/dt-schema/commit/3d44bf2b46a9ac638550ca3916d7d7f70823bb58
[3] https://github.com/devicetree-org/dt-schema/commit/59f2e3103b6e776afe4f42e45897f7eabae06fa4
