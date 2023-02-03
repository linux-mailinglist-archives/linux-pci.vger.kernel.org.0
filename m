Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511C689EE6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBCQHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 11:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjBCQHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 11:07:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461549E9ED;
        Fri,  3 Feb 2023 08:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E8B61F7F;
        Fri,  3 Feb 2023 16:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C04FC433D2;
        Fri,  3 Feb 2023 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675440459;
        bh=zKmjPVFEtNDSBXoOI9UXflM0Sd030QsBid++FCTj9a8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KCZFCV0l0H/S8DfZ12ZyuwUPpalMdOIG4AQnLd51yD76Q1ONGjslziezKEteefy5J
         baLG7VSVB92tcZvq3dvulixb2uBE3HK1OKHEOeA9MeGq70fY/dhGdTQ4LI1PCeHtka
         +qslJuriyAOi7B6Yxx0fDk9Ae27ItNvamV5bKoAIea26TgXdNFyhchbA0smWIgi0nE
         Ac23dx2EQNy67fPe+LBz6KinbcJo38qORfKMPBvyFN1wFKKwd5biXzgVtTIbQ8pAag
         ic03GSWR/aC8m3zE0g4cKFlAUlxjmnybkVfCtYPJPCpPK2S4V/aVy3hJmhBXEPFJZF
         rAOUVt1zzqzoA==
Received: by mail-vs1-f50.google.com with SMTP id j7so5813111vsl.11;
        Fri, 03 Feb 2023 08:07:39 -0800 (PST)
X-Gm-Message-State: AO0yUKW9lxaabhNRQh93JhZCR9UcWxeV9tUvdFKhBunsksPsQ89D9qc/
        X37aYO56CaAhdcTp0yQSRwDAa9J2G69m6xPx1A==
X-Google-Smtp-Source: AK7set+p/4oE02Qtrd3KwUPO2TJMoCv7VYc0zIaV/SZKSXWLDPZxq/rLmvpgU5zF2KcbzmAfoLSdEu2R7mH3ELmM7nc=
X-Received: by 2002:a67:eb03:0:b0:3ea:c8c:48a5 with SMTP id
 a3-20020a67eb03000000b003ea0c8c48a5mr1730235vso.53.1675440457975; Fri, 03 Feb
 2023 08:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20230111032830.20447-1-jian.yang@mediatek.com> <20230111032830.20447-3-jian.yang@mediatek.com>
In-Reply-To: <20230111032830.20447-3-jian.yang@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Feb 2023 10:07:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+eAQ-M9a+9g7Kk3GC9WjE_4mZXXrsdm4PucOJ4p2QYVQ@mail.gmail.com>
Message-ID: <CAL_Jsq+eAQ-M9a+9g7Kk3GC9WjE_4mZXXrsdm4PucOJ4p2QYVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
To:     Jian Yang <jian.yang@mediatek.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chuanjia.liu@mediatek.com, jieyy.yang@mediatek.com,
        qizhong.cheng@mediatek.com, rex-bc.chen@mediatek.com,
        david-yh.chiu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 9:28 PM Jian Yang <jian.yang@mediatek.com> wrote:
>
> From: "jian.yang" <jian.yang@mediatek.com>
>
> Add new properties to support control power supplies and reset pin of
> a downstream component.
>
> Signed-off-by: jian.yang <jian.yang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 7e8c7a2a5f9b..46149cc63989 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -84,6 +84,29 @@ properties:
>      items:
>        enum: [ phy, mac ]
>
> +  pcie1v8-supply:
> +    description:
> +      The regulator phandle that provides 1.8V power to downstream component.
> +
> +  pcie3v3-supply:
> +    description:
> +      The regulator phandle that provides 3.3V power to downstream component.
> +
> +  pcie12v-supply:
> +    description:
> +      The regulator phandle that provides 12V power to downstream component.

While in some bindings we've allowed these in the host bridge node,
that is a mistake. These should be in the root port node. You probably
don't have one in DT, so add one.

> +
> +  dsc-reset-gpios:
> +    description:
> +      The reset GPIO of a downstream component.
> +    maxItems: 1
> +
> +  dsc-reset-msleep:

Doesn't the PCI spec define this time? We're talking about PERST#, right?

> +    description:
> +      The delay time between assertion and de-assertion of a downstream
> +      component's reset GPIO.
> +    maxItems: 1
> +
>    clocks:
>      minItems: 4
>      maxItems: 6
> --
> 2.18.0
>
