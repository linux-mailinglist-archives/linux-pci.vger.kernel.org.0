Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83558F3D1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiHJVa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 17:30:28 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560426F2;
        Wed, 10 Aug 2022 14:30:27 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id o2so13244319iof.8;
        Wed, 10 Aug 2022 14:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1LBUVir9vATe8Xj/pz3Y3zCIETCVWzxLWfVraL7qb4Y=;
        b=PYkBu60GQjh+VzNnuOEbLfoZ/0Ur8GE4v/AurKXvUDUwvFkauzmtJmoc79sIxVCg3C
         AmzBLRyeju3hK2q7W8gnehl2BryvwbrAntN3O8mwSe4VSboOqKeb8NdIc9zPHiqLfp6X
         mSZqkdOS+GLQVHPJ/G5/Zbn5ffFSymF5tnvteO7NvcrSX5Y4A0/cvabSLsCAc7L0aXBb
         Vaek8S0H8TmOB9gkw0DYHmK31iIreM7ORmAvUh86rlHbAz09+mOhGCG3oCK4AnP39Uww
         SfI44xkaja/nLDZ1gFTWHLe7A3ecFBXKizkZ+5NBS69aTzlSmW8sB2W5tali86rRd9CP
         VjLQ==
X-Gm-Message-State: ACgBeo0SYQuG/frezM7jZzkuQRKxRNT92zY3oU14UBmBA1LQDRG5prDQ
        M5eB73JkLqWMVBNuaejNIQ==
X-Google-Smtp-Source: AA6agR66QDJkIq5UA1bHyktkUvb721uD2WolnEDkZPq3ujfMTPEVO6D9L0tmqsIyWOCiJXzj31oGwA==
X-Received: by 2002:a05:6638:4194:b0:33f:4795:5c68 with SMTP id az20-20020a056638419400b0033f47955c68mr13230426jab.193.1660167026570;
        Wed, 10 Aug 2022 14:30:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s2-20020a02b142000000b00343478edef5sm734022jah.65.2022.08.10.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:30:25 -0700 (PDT)
Received: (nullmailer pid 584812 invoked by uid 1000);
        Wed, 10 Aug 2022 21:30:23 -0000
Date:   Wed, 10 Aug 2022 15:30:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <20220810213023.GB557589-robh@kernel.org>
References: <20220810183536.1630940-1-willmcvicker@google.com>
 <20220810183536.1630940-3-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810183536.1630940-3-willmcvicker@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 10, 2022 at 06:35:35PM +0000, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> risking not being able to get a 32-bit address during DMA allocation.
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the
> msi_msg page due to a DMA address overflow (seen in [1]). With this
> patch, the PCIe driver can advertise 64-bit support via it's MSI
> capabilities to hint to the PCIe host driver to set the DMA mask to
> 64-bits.
> 
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.c      |  9 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
