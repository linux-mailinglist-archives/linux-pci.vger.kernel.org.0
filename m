Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD939546065
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348316AbiFJItq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiFJItY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:49:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01597156B52;
        Fri, 10 Jun 2022 01:49:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m25so25535480lji.11;
        Fri, 10 Jun 2022 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hTpHz6/6Fx2nYSgjquiYmzEB7q95ijXdymuUvmeVwF4=;
        b=k84/+bz/5ZVc3Is9kXEbUH236It7kfTAy2UraKVxROO0BQTRYgM8QF+mDzv8qXYJf6
         gQZC3LJlkfi4z37eQWr1J5Maz3E1D0ltL6Ttfs3QoiY4+8n541OhCQohISGR/kUTWfbn
         eQOD7OAa6jtD3DQTUbfqPtLejsCKlOX8tOw+NJLhLpMGtA2znXYyu7CQmp8eD8z+oLA/
         rCrDG3FeKMZHdPq8GVzEuq8NiCj+Z2nS4NqlP26H8/myrAuHOmSxUWlSVrjCq8+iwff/
         q3G9MIYuB+3vmwRAAlAyRzQxbPnmp7zIDIeiwAgkNO72xkhRc8w3Z1vi9mCZiebVpz0+
         Ylqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hTpHz6/6Fx2nYSgjquiYmzEB7q95ijXdymuUvmeVwF4=;
        b=SSgEIinLlgR+0IB13xEKanSPcjVmNOlgjoaBkxUfwEyO7/vo6aDt+K8QL5aw+lqsMM
         JqwGnAbxFU3rKUQ7Q/HWib5E9ZwZ13OLeI47+XgpUbupj59BjgKD3ZmTgTsyP3kkazk3
         hFcf6JC84PnVaNkWAeQ2BDMmQGX0hl7HGwrcQiJYU3sa0eR5X3IGb4sW4AL03IP0sY1S
         3NjMtBUa9TbXyXFP2eTJQsFWCCF3JjMl/nub7imUORxB9uyf6O6yHv0SJhCgi9dY3Gls
         BWZWTwsJFkHwDz802EplNs45s6Hj5pw99JG6y3nyB7sJhiqNKNZSfe32dMLc20weqv+p
         v/jA==
X-Gm-Message-State: AOAM532lsB8kEkGjMuKfu3GWCGrjHqwujt5cQ1gcpuNY7rWJNYyT3k4y
        667Vj8qymBw8CWP5unaynwA=
X-Google-Smtp-Source: ABdhPJwWrIiBGY5P9dXg8F/AbSB5sSUnSRXg5m9zAxlJF30v2Es8hCHpoopqdD5bwmjCVlmygl+gEQ==
X-Received: by 2002:a05:651c:1417:b0:258:df6a:731e with SMTP id u23-20020a05651c141700b00258df6a731emr3302342lje.129.1654850961261;
        Fri, 10 Jun 2022 01:49:21 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a27-20020a056512201b00b00478641f62c0sm4635883lfb.28.2022.06.10.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:49:20 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:49:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] PCI: dwc: Add hw version and dma-ranges support
Message-ID: <20220610084918.eytzkynn6y3gs6q4@mobilestation>
References: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:44:28AM +0300, Serge Semin wrote:
> This patchset is a second one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> Link: ---you are looking at it---
> [3: In-progress v3] PCI: dwc: Add extended YAML-schema and Baikal-T1 support
> Link: ---being submitted afterwards---
> [4: In-progress v2] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> 
> Note it is very recommended to merge the patchsets in the same order as
> they are listed in the set above in order to have them applied smoothly.
> Nothing prevents them from being reviewed synchronously though.
> 
> Originally the patches submitted in this patchset were a part of the series:
> Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> but due to the reviewers requests the series was expanded to about 30
> patches which made it too bulky for a comfortable review. So I decided to
> split it up into two patchsets: 2. and 3. in the table above.
> 
> Regarding the series content. This patchset is about adding new features
> to the DW PCIe core, Root Port and Endpoint drivers. First we suggest to
> add a more verbose link-up log message. Really printing link generation
> and width would be much more informative than just "link up". Then a
> series of IP-core version-related patches go, like using a native FourCC
> version representation, adding the IP-core auto-detection, adding a better
> structured IP-core version/type interface and finally dropping manual
> IP-core version setups from the platforms which are supposed to have it
> auto-detected. After that the platform-specific host de-initialization
> method is introduced. It's unused in the framework of this patchset but
> will be utilized in the next one (see the table above). A series of iATU
> optimizations, cleanups and new features goes afterwards. In particular we
> suggest to drop some redundant enumerations, add iATU regions size
> detection procedure and then use the regions parameters to verify the
> requested by the platform iATU ranges/dma-ranges settings. After that the
> dma-ranges property support is added for the DW PCIe Host controllers.
> 
> Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Test the error condition first and return straight away if it comes true
>   in the link up waiting and link state logging method (@Joe).
> - Move the dw_pcie_region_type enumeration removal patch to being applied
>   before the IB/OB iATU windows setup simplification patch (@Rob).
> - Move the iATU region selection procedure into a helper function (@Rob).
> - Rebase from kernel v5.17 onto v5.18-rc3 since the later kernel has
>   already DT bindings converted. (@Rob)
> - Simplify the iATU region selection procedure by recalculating the base
>   address only if the space is unrolled. The iATU viewport base address
>   will be saved in the pci->atu_base field.
> - Move the IP-core version detection procedure call from
>   dw_pcie_ep_init_complete() to dw_pcie_ep_init().
> - Add a new patch: "PCI: dwc: Detect iATU settings after getting
>   "addr_space" resource."
> 
> Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
> Changelog v3:

> - Fix pcie-tegra194-acpi.c driver to using the new macros names.
>   (@Manivannan)
> - Drop in/outbound iATU window size alignment constraint. (@Manivannan)
> - Detach this series of patches into a dedicated patchset.

@Mani, several patches have been changed or removed from the series
so I have to drop you tag from some of them. Could you please have
alook at the patchset one more time?

-Sergey

> - Rebase onto kernel v5.18.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (15):
>   PCI: dwc: Add more verbose link-up message
>   PCI: dwc: Detect iATU settings after getting "addr_space" resource
>   PCI: dwc: Convert to using native IP-core versions representation
>   PCI: dwc: Add IP-core version detection procedure
>   PCI: dwc: Introduce Synopsys IP-core versions/types interface
>   PCI: intel-gw: Drop manual DW PCIe controller version setup
>   PCI: tegra194: Drop manual DW PCIe controller version setup
>   PCI: dwc: Add host de-initialization callback
>   PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
>   PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
>   PCI: dwc: Simplify in/outbound iATU setup methods
>   PCI: dwc: Add iATU regions size detection procedure
>   PCI: dwc: Verify in/out regions against iATU constraints
>   PCI: dwc: Check iATU in/outbound ranges setup methods status
>   PCI: dwc: Introduce dma-ranges property support for RC-host
> 
>  drivers/pci/controller/dwc/pci-keystone.c     |  12 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  40 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 202 +++++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 461 ++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.h  | 123 ++---
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  22 +-
>  .../pci/controller/dwc/pcie-tegra194-acpi.c   |   7 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   1 -
>  8 files changed, 461 insertions(+), 407 deletions(-)
> 
> -- 
> 2.35.1
> 
