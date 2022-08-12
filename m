Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26639590A60
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 04:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiHLCqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiHLCql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 22:46:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F69F0FB;
        Thu, 11 Aug 2022 19:46:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id tl27so36647916ejc.1;
        Thu, 11 Aug 2022 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=m8K5xxHwUtOlWka2i6KidQAMvBpegqn38fZBXaEsEIc=;
        b=fV/velC9xLyGIOZLWcp3Vw9RcnTqwhpM8islnyY72m1h0Des98lc3O6K4i1NrXnmC5
         EVuMx5t0FGpKrtyQDltGc3ZfOxIDC8GnuHpt/T2DuFa/5bw5eim71R2xx2tH/nSd+Uo2
         1lzkoOV9Bg4H8LST9vEv0suWoQaDPCnNGN5XrWdc7HBN2c7RUPOWU1Kf9O1UQBNuO1Pn
         n+ConE9IxAUmXDpxmt3iEafU/EJXPbm6IUHyqiSf2aOQDflQ5j1udy/nWm8GEw02cTRk
         6UCn+D9lxLusyOBQyYESxv3oUWe91fy8AegzWKzqZZfZGw6VDtN6KsszGtvFKWAMUKSQ
         5smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=m8K5xxHwUtOlWka2i6KidQAMvBpegqn38fZBXaEsEIc=;
        b=gzl2YTj6Np1tuLki397UGMrxyROUUnKntgf0eGq8c30StHolL/0wuNCN90W1K/R4C9
         ZkX/RygKqyC9v/qx2W//BCtCoCD60oi0OLZXN67Xcc+fHHAb+UMoHF03SzgKBbWdwFgH
         Bh6p3EtfBj4ErIZB92yq59OKS24qWKUCkEiK5Bs2D4e6NU/I/MfV+7NcBoWNkcmQBSXm
         LyQyqsLTQTYLjCv34h1gj3gRZqgJfFRB52RTmAnbOIRjbWRf5t1p6dfSmzkHCO6hK6mv
         i5QbxMKCUXSy+TPnc9I9RZnAGgHjcyouCwbPXMT7v8RtgJz/zQI88z+WTqME4l1jbKd1
         TvqA==
X-Gm-Message-State: ACgBeo3MBcJm+OcPes2jdjR18XbDJVav/iWBYR6wqX/DavDcAlR43vJI
        pyZgg/m7yySZV7Nj/5g1EhQTklFiqkeQQ+i7UAs=
X-Google-Smtp-Source: AA6agR5b7HObKtXs3naVHqtJypGvy4P4OlIv+FJRNmjtEQkFAzRk+muDRIuvPDTKCrbbTOlAoAhRwJGtvxYxcEBu1xc=
X-Received: by 2002:a17:907:d9e:b0:731:1a5:8c68 with SMTP id
 go30-20020a1709070d9e00b0073101a58c68mr1254296ejc.365.1660272399187; Thu, 11
 Aug 2022 19:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220812000327.3154251-1-willmcvicker@google.com> <20220812000327.3154251-3-willmcvicker@google.com>
In-Reply-To: <20220812000327.3154251-3-willmcvicker@google.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Thu, 11 Aug 2022 19:46:27 -0700
Message-ID: <CAPOBaE5_teX6-39ofwC=YG3scc4dT+S47sQNUZYeu7WMzpe1mQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: dwc: Add support for 64-bit MSI target address
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
        kernel test robot <lkp@intel.com>
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
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> risking not being able to get a 32-bit address during DMA allocation.
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the
> msi_msg page due to a DMA address overflow (seen in [1]). With this
> patch, the PCIe device can advertise 64-bit support via its MSI
> capabilities to hint to the PCIe host driver to set the DMA mask to
> 64-bits.
>
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>

> ---
> drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
> drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++++++
> drivers/pci/controller/dwc/pcie-designware.h      |  1 +
> 3 files changed, 21 insertions(+), 2 deletions(-)
=E2=80=A6..
