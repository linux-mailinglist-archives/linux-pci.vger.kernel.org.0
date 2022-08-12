Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A67590A62
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiHLCrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHLCr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 22:47:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4F9F0FB;
        Thu, 11 Aug 2022 19:47:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so36672457ejp.2;
        Thu, 11 Aug 2022 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=GcNdwEO8FoZtzCiz5/zB16w3s7IblMBBq798/8mACkU=;
        b=DeZWWkEoQ8aVoGUnbk4zfbh/E0W9q8D02hcEftJ6RaFyrJTMVzb0x4lIhMoC3QPGAr
         /W8IcAvJyFCNxV/J5WuaOgIChYrQ6N6l/kPpwOaRdTMzaDTo+mDyYhP7izXqgD+Qt7Bj
         2wtEnzfHA7INN+ZskcRGPNzgDNfJU/rUTZmxMTYZBacO9lWduVLHH6MXqoE0qTYF/CBa
         mWWlvEx9C0Z4mrSlMioqEbbDZaTmxDg6bGF4J63eDwRSh0PItuJf4WPE2smw4kboy+6s
         T26Qp0FQ7EtUMSqelzBLjUE4sKZuH9EWw6XjWFgtIQvvWecIskhKA0qklmvnoxRtw3WR
         Aihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=GcNdwEO8FoZtzCiz5/zB16w3s7IblMBBq798/8mACkU=;
        b=acrx13aicdLPKWYWU1OwHb0yN1Zeodk0cpUjxyyPoUOKyP7722M311VUx1D+NzvVER
         PtZ++D5mdau1krjHRPREMVZqMOy8wawEbdV4nhUt7BpKcPO2lqZ6xZzGgEJMaA23BZhr
         vwGR2af89EANjTzxdFZ8yVA976whvQzqwwshjyAlqjbSytVc3ka0im5hT62nUk0QmwCG
         p/rRoYaM96aXQsX0+OwkaVgI3Nz7A75zCbdreLY+0iHOvvsZmO9JWtwfK4TfnlIbnCyF
         abPweHKmcrZnpCvd54v6GjXIuPsm2s6+ljnEAAFRomJJkD8umP+nRrp23acvnaFrKYyT
         62Zg==
X-Gm-Message-State: ACgBeo2MxHN5fOGC58ITostUlMgjU0j9EbuSvBNM1x6+D7fbVj2dkoni
        HcJ46ZDvnGa54s3Pke2ealYvxI96VnD8bPCv/7s=
X-Google-Smtp-Source: AA6agR4Re/OSbedyix7zj107RLI4c5Cka8uFz3/RD4s3QZXauUItCqEa4RGkuRAoiZX8Pisj1WJKVnJVdAGU5eGZPww=
X-Received: by 2002:a17:906:7e43:b0:72b:52de:b039 with SMTP id
 z3-20020a1709067e4300b0072b52deb039mr1264832ejr.198.1660272447023; Thu, 11
 Aug 2022 19:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220812000327.3154251-1-willmcvicker@google.com> <20220812000327.3154251-2-willmcvicker@google.com>
In-Reply-To: <20220812000327.3154251-2-willmcvicker@google.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Thu, 11 Aug 2022 19:47:15 -0700
Message-ID: <CAPOBaE6rQmk6yZhhRPvvqcOHSv_83Z=qXDoOEMhkcCFw91A5JQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
To:     Will McVicker <willmcvicker@google.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2022, Will McVicker wrote:
> Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() whi=
ch
> uses the coherent DMA mask to try to return an allocation within the DMA
> mask limits. With that, we now can drop the msi_page parameter in struct
> dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
> continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
> device will fail to probe when ZONE_DMA32 is disabled.
>
> Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>

> ---
> .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
> drivers/pci/controller/dwc/pcie-designware.h  |  1 -
> 2 files changed, 7 insertions(+), 22 deletions(-)

=E2=80=A6..
