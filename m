Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6D59156A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiHLSVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 14:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E18EB2DA1;
        Fri, 12 Aug 2022 11:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0970361336;
        Fri, 12 Aug 2022 18:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE15C433D6;
        Fri, 12 Aug 2022 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660328477;
        bh=eiqOy+SxPsGO+aA2z0ZhN60jzp90jIs1wwhTjj/uyPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oWGKL3TXV5p/wjnoeDVhwpS9Ojz6UgMWG1/5ucTazMa1w7DwDZTetOh49jbvs9XXF
         E5m9Bhtb00uJAJh9rc/o9hJiDEyFoRN90j4LCXol5Y1Rp14Ux82DcEsgADMCwL2Znr
         WXY7qk1V4hddY2AmjPyysbybCOulno1PfFFStFVBQzR7M2x7DVN2scfuEPegOyzgz/
         aKUAM5samP5ggi3scQuER0CI6VudTItIaj/SZKKgV/LbEAy0X25AzRIq2i3H+3RLjH
         XX31WBBK58H92XzV9i4v3ck0BmaMbAZsw3YdDu7GMhwiJNxcctA0ibZG9ZaAIdVG9V
         sUJlelT1iYqpA==
Received: by mail-vk1-f172.google.com with SMTP id w129so862395vkg.10;
        Fri, 12 Aug 2022 11:21:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3bRu/r4qS05ZeFvuqYR+4w/TKMgPDrnnKp+lHMqxVOzzQE5mKV
        XpKBXKShwZd/gozxPvkIS9Tj81jwjCCM9z+7Eg==
X-Google-Smtp-Source: AA6agR7+Cc6IB89IDiPACrr3oe5jtJotXYaVMq7TE/kbH00BUgKrUiNMWBCDWjDrND8CnXiK9rTH2oY+62cEYezh7VI=
X-Received: by 2002:ac5:c959:0:b0:377:adad:62cb with SMTP id
 s25-20020ac5c959000000b00377adad62cbmr2446296vkm.26.1660328476406; Fri, 12
 Aug 2022 11:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220812000327.3154251-1-willmcvicker@google.com> <20220812000327.3154251-2-willmcvicker@google.com>
In-Reply-To: <20220812000327.3154251-2-willmcvicker@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Aug 2022 12:21:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAP1kh7Hv6G08PuvpW8oRkXYasT=+6-VXAYg=fXfBvSA@mail.gmail.com>
Message-ID: <CAL_JsqLAP1kh7Hv6G08PuvpW8oRkXYasT=+6-VXAYg=fXfBvSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 11, 2022 at 6:03 PM Will McVicker <willmcvicker@google.com> wrote:
>
> Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() which
> uses the coherent DMA mask to try to return an allocation within the DMA
> mask limits. With that, we now can drop the msi_page parameter in struct
> dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
> continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
> device will fail to probe when ZONE_DMA32 is disabled.
>
> Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  2 files changed, 7 insertions(+), 22 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
