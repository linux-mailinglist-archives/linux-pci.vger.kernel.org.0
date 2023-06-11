Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96C72B3B2
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jun 2023 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFKTeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jun 2023 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKTeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2023 15:34:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F7D8;
        Sun, 11 Jun 2023 12:34:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so41120661fa.2;
        Sun, 11 Jun 2023 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686512055; x=1689104055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dHzxGucEvO+WvWW2cMpLxl9/XblvFiP+Ut6gaJ/P94=;
        b=E8ZXMspp23irl2US2pX2pXlZGYnzbHA9WwVwDTxaQJ+rxWNSqn9Hc0WblcfvQsWhUk
         woTqgqasIn80VbYXtOqsh8II+lzQSITHdLmYvwysC+8HcEwa+QmxWPqASnOCbU6Bgrkw
         4GO2gRzMT5jcbOcrFsULMEZwW3gW10KJW9meOM5pKQORW5qlMp6N5wuo4QmXsqoKg14a
         byVMlwx8KmD6JyA307S5Nfudye4N44jXaqxI0Rtig4JPUUtXM0ZkMPjLDRKcYHNofc8P
         b5ihXVhPjf0bXioJWhpBjwO30pE1tQ/ntjm8b/kWHh27hKKEHweQxo8aVHfUh2bgeOGg
         Jg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512055; x=1689104055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dHzxGucEvO+WvWW2cMpLxl9/XblvFiP+Ut6gaJ/P94=;
        b=XSFJ5xVOGmVyVZPNzUHxu1zVWjoTlesG6woEKLwFVRLhEiDUDhHoaH6G4E7RvqQWke
         qCHxs5GCXzvDUR/gRzKhNrV61nRXuxuHA/tISZChONt3GL/sKkdfC6hfWNfrxfekp5Jw
         ub38nfk8aXvRbpy9psjdqJd3jxmLS/pqnOkxuPcRwktBu5+Puf2qufQTp+EMQgodcQeo
         /NMxe5GHudu+z73imebjjSX5t5x+d6aQLXdzXJzT6bgcPGpuRIu9yMHbKopVBGFGsq/E
         pQPR7bRGIwXjN0G0oUDxhBIqkAB2slr95vsqaVSWDwnA9xmInlEtRhT9IG1C0kOmdcRz
         6H1Q==
X-Gm-Message-State: AC+VfDzcUpDgBQSXvj386gcuhM1XsYYC75JFJLmM8bHhnXLlws9Xf+P5
        LNVgLUKbI7c3RfDUBK082bc=
X-Google-Smtp-Source: ACHHUZ51U6QbOA8QM1YWM2eU3q4QiFEfFoY/F2BvlQIXNcS1CbAqJIT9F9Szl6ySK6fSf11t1duaxQ==
X-Received: by 2002:a2e:3c0c:0:b0:2af:25cf:92ae with SMTP id j12-20020a2e3c0c000000b002af25cf92aemr2002532lja.22.1686512055116;
        Sun, 11 Jun 2023 12:34:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id d21-20020a2eb055000000b002aeee2a093csm1411992ljl.59.2023.06.11.12.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:34:14 -0700 (PDT)
Date:   Sun, 11 Jun 2023 22:34:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230611193412.a5btmqlzk2oqommz@mobilestation>
References: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 11, 2023 at 10:19:54PM +0300, Serge Semin wrote:
> It turns out the recent DW PCIe-related patchset was merged in with
> several relatively trivial issues left unsettled (noted by Bjorn and
> Manivannan). All of these lefovers have been fixed in this patchset.
> Namely the series starts with two bug-fixes. The first one concerns the
> improper link-mode initialization in case if the CDM-check is enabled. The
> second unfortunate mistake I made in the IP-core version type helper. In
> particular instead of testing the IP-core version type the macro function
> referred to the just IP-core version which obviously wasn't what I
> intended.
> 
> Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> asynchronous probe type which saved us of about 15% of bootup time if no any
> PCIe peripheral device attached to the port.
> 
> Then the patchset contains the Baikal-T1 PCIe driver fix. The
> corresponding patch removes the false error message printed during the
> controller probe procedure. I accidentally added the unconditional
> dev_err_probe() method invocation. It was obviously wrong.
> 
> Then two trivial cleanups are introduced. The first one concerns the
> duplicated fast-link-mode flag unsetting. The second one implies
> dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> function.
> 
> The series continues with a patch inspired by the last @Bjorn note
> regarding the generic resources request interface. As @Bjorn correctly
> said it would be nice to have the new interface used wider in the DW PCIe
> subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> PCIe driver can be easily converted to using the generic clock names.
> That's what is done in the noted patch.
> 
> The patchset is closed with a series of MAINTAINERS-list related patches.
> Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> update the MAINTAINER-list with the new files added in the framework of
> that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> DW PCIe core driver maintainers. Secondly seeing how long it took for my
> patchsets to review and not having any comments from the original driver
> maintainers I'd suggest to add myself as the reviewer of the DW PCIe
> driver. Thus hopefully the new updates review process will be performed
> with much less latencies. For the same reason @Manivannan is added to the
> maintainers list of the DW PCIe/eDMA drivers as he already agreed to be
> in.
> 
> Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rebase onto the kernel 6.3-rc2.
> 
> Link: https://lore.kernel.org/linux-pci/20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Drop the patch:
>   [PATCH v2 01/11] PCI: dwc: Fix port link CSR improper init if CDM check enabled
>   and rebase onto the already submitted by @Yoshihiro fix:
>   commit cdce67099117 ("PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled")
> - Just resend.
> 
> Link: https://lore.kernel.org/linux-pci/20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v4:
> - Demote @Gustavo to being DW PCIe/eDMA drivers reviewer:
>   [PATCH v4 9/14] MAINTAINERS: Demote Gustavo Pimentel to DW PCIe core reviewer
>   [PATCH v4 12/14] MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
> - Add Manivannan to the DW PCIe/eDMA drivers maintainers list:
>   [PATCH v4 10/14] MAINTAINERS: Add Manivannan to DW PCIe core maintainers list
>   [PATCH v4 13/14] MAINTAINERS: Add Manivannan to DW eDMA driver maintainers list
> 
> Link: https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v5:
> - Rebase onto the kernel 6.4-rc1.
> - Just resend.
> 

> Link: https://lore.kernel.org/linux-pci/20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v6:
> - Remove Vinod and DMA-engine mailing-list from Cc-list since the
>   DMA-related patches have already been merged in.
> - Drop the next patches:
>   [PATCH RESEND v5 12/14] MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
>   [PATCH RESEND v5 13/14] MAINTAINERS: Add Manivannan to DW eDMA driver maintainers list
>   [PATCH RESEND v5 14/14] MAINTAINERS: Add myself as the DW eDMA driver reviewer
>   since they are in the dmeengine next git-branch already.
> - Just resend.
> 
> Link: https://lore.kernel.org/linux-pci/20230531112602.7222-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v7:
> - Just resend.

I don't know how come v6 was marked as "Not Applicable" in patchwork.
I tested it on both "next" and "controller/dwc" branches. Not a
glimpse of any merge conflict. If there is some another branch I
should have based the series on please tell me which one. Anyway here
is v7 just in case if the previous patchset was lost.

-Serge(y)

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (11):
>   PCI: dwc: Fix erroneous version type test helper
>   PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
>   PCI: bt1: Enable async probe type
>   PCI: bt1: Fix printing false error message
>   PCI: dwc: Drop duplicated fast-link-mode flag unsetting
>   PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
>   PCI: visconti: Convert to using generic resources getter
>   MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
>   MAINTAINERS: Demote Gustavo Pimentel to DW PCIe core reviewer
>   MAINTAINERS: Add Manivannan to DW PCIe core maintainers list
>   MAINTAINERS: Add myself as the DW PCIe core reviewer
> 
>  MAINTAINERS                                   |  7 ++--
>  drivers/pci/controller/dwc/pcie-bt1.c         |  5 ++-
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  2 -
>  drivers/pci/controller/dwc/pcie-designware.h  |  7 +++-
>  drivers/pci/controller/dwc/pcie-visconti.c    | 37 +++++++++----------
>  6 files changed, 31 insertions(+), 29 deletions(-)
> 
> -- 
> 2.40.0
> 
> 
