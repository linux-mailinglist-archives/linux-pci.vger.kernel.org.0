Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDC6390A1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 21:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYUW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 15:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKYUWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 15:22:25 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0356D4E;
        Fri, 25 Nov 2022 12:22:24 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id q7so6324313ljp.9;
        Fri, 25 Nov 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrivPsGjqYI2qsTebVxkSU3A8EFzqEYQB/7YRWG2cGs=;
        b=Iqk8gGXFGHV8ysoBM1SQjhd6ciqUpA3RR7QQ1pKqwh9UeBW7tS164McC+IWua2QW+a
         rX7rETzCq/sKLF+X24pmuSXRk5DVQPQyZFevDyuwSMh4DamJpkyy76mj+d0OXqDR+jcm
         YdbjuB12H5JJCPTZ6gxESd6bKQ7O8g3XS4rzuiaTr86ju58aZBPCOcgqJAB4M8OWQalC
         DjKjDw+QZ8UqQUmJmTZ8v+Xzfa6ZhPYMBSfF0u8Pe9QDKVLv6uYE5OsgfLG2RlrHvAaV
         N/cWVg0xW/fYYq8NJSVR1uN51Gu/6veNhbaPsvyl7NvJxcIdPLDvI3l0YoP5MI5SRhir
         aRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrivPsGjqYI2qsTebVxkSU3A8EFzqEYQB/7YRWG2cGs=;
        b=qOxVAnwRyIZlTSSYP6UqfT8xm2lYzk9u20xD9KPyDtW/iSU0GZxayk7nDBuRYOeOtl
         ds1Q5/YQs/HZws+YV5x+L2BNka7ijyuK78NSrcWnjnrIFl2IVGb2NJeKDXyVlWFGiwMA
         ujG7ZnMgTnooGYRpdSpuBY/tVTfwcoswh+5FEM5P1ydexsx20aAINwsmt4S6hWxzroZy
         iondlSkxw2WYSTOhKOuMBmF7UOOhwJXY+ueGYzJCLkXUu4najL2NbKfTLO+zrlzDj4XL
         4Q/Rp9ecpB6Z9wBFGW4g9dA/BYEk+owuwCYhhrTj7NilHHeh3WvJmb77E3Ny5gePB4NO
         1znw==
X-Gm-Message-State: ANoB5pks09bKjcLX4fS62rKVcwmtWMLl4RFlxYU/pHag5urlzd8W2Y1F
        oyYfAIt4H67q1uUUk27Gj8Y=
X-Google-Smtp-Source: AA0mqf7NeCyxKbhNIBriwvK620tuG6AKeKBW5502QtEGzdRQABFCD3CVsUgU/fHKB+xs9TZJMbrd6g==
X-Received: by 2002:a2e:a224:0:b0:277:309:f1ad with SMTP id i4-20020a2ea224000000b002770309f1admr7288678ljm.244.1669407742754;
        Fri, 25 Nov 2022 12:22:22 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b0049f87fb416dsm647172lfr.12.2022.11.25.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:22:22 -0800 (PST)
Date:   Fri, 25 Nov 2022 23:22:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-pci@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v7 00/20] PCI: dwc: Add generic resources and Baikal-T1
 support
Message-ID: <20221125202219.snbjwtmqdqpotwwk@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <166921583106.17960.15949667825256145052.b4-ty@kernel.org>
 <20221125125852.bozaykbckfkek4i3@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125125852.bozaykbckfkek4i3@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 25, 2022 at 03:58:55PM +0300, Serge Semin wrote:
> On Wed, Nov 23, 2022 at 04:09:12PM +0100, Lorenzo Pieralisi wrote:
> > On Sun, 13 Nov 2022 22:12:41 +0300, Serge Semin wrote:
> > > This patchset is a third one in the series created in the framework of
> > > my Baikal-T1 PCIe/eDMA-related work:
> > > 
> > > [1: Done v5] PCI: dwc: Various fixes and cleanups
> > > Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> > > Merged: kernel 6.0-rc1
> > > [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> > > Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> > > Merged: kernel 6.0-rc1
> > > [3: In-review v7] PCI: dwc: Add generic resources and Baikal-T1 support
> > > Link: ---you are looking at it---
> > > [4: Done v6] dmaengine: dw-edma: Add RP/EP local DMA support
> > > Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
> > > 
> > > [...]
> > 
> > I think it is time we merged this series - we went through
> > several rounds of reviews and it should be ready for
> > mainline (in particular wrt using the generic infrastructure
> > it puts in place).
> > 
> > Applied to pci/dwc, thank you.
> 
> Thanks. We've finally done that!
> 

> Could you please merge the DW eDMA part in too?

@Lorenzo, hold on with this for sometime. @Robin submitted some comments
there.

-Serge(y)

> Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
> Due to the dependencies we agreed to hold it on for until the last DW
> PCIe patchset is merged in. See discussion here:
> https://lore.kernel.org/dmaengine/20220616183900.ww7ora37kmve7av2@mobilestation/
> and here (Vinod ab-tag):
> https://lore.kernel.org/linux-pci/YuKFnjrxnyNa+98X@matsya/
> and here (the last thread mentioned the dependencies):
> https://lore.kernel.org/linux-pci/20220825112843.4pbh37x6wemsdmmp@mobilestation/
> 
> The eDMA series has got all the ab/rb/tb-tags from @Vinod and @Mani side.
> The only tiny exception is
> [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
> for which I had to drop the tags due to an update per the @Robin request
> in the framework of the dma-ranges/DMA-mask discussion:
> https://lore.kernel.org/linux-pci/20220927104831.bovlzl74osb4t5d3@mobilestation/
> https://lore.kernel.org/linux-pci/20221007224515.sseyabdfa2phcsdz@mobilestation/
> 
> I failed to reach @Robin since November 8, 2022. If you are able to
> effectively draw his attention so he looked at the updated patch, that
> would be great. Other than that I see no barrier to merge the DW eDMA
> series in too.
> 
> -Serge(y)
> 
> > 
> > [01/20] dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
> >         https://git.kernel.org/lpieralisi/pci/c/b8a83e600bdd
> > [02/20] dt-bindings: visconti-pcie: Fix interrupts array max constraints
> >         https://git.kernel.org/lpieralisi/pci/c/4cf4b9b70ab2
> > [03/20] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
> >         https://git.kernel.org/lpieralisi/pci/c/057646a5db2f
> > [04/20] dt-bindings: PCI: dwc: Remove bus node from the examples
> >         https://git.kernel.org/lpieralisi/pci/c/b9fe9985aee2
> > [05/20] dt-bindings: PCI: dwc: Add phys/phy-names common properties
> >         https://git.kernel.org/lpieralisi/pci/c/875596361910
> > [06/20] dt-bindings: PCI: dwc: Add max-link-speed common property
> >         https://git.kernel.org/lpieralisi/pci/c/eaa9d8865287
> > [07/20] dt-bindings: PCI: dwc: Apply generic schema for generic device only
> >         https://git.kernel.org/lpieralisi/pci/c/f133396e2d00
> > [08/20] dt-bindings: PCI: dwc: Add max-functions EP property
> >         https://git.kernel.org/lpieralisi/pci/c/12f7936c7a0e
> > [09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> >         https://git.kernel.org/lpieralisi/pci/c/35486813c41b
> > [10/20] dt-bindings: PCI: dwc: Add reg/reg-names common properties
> >         https://git.kernel.org/lpieralisi/pci/c/4cc13eedb892
> > [11/20] dt-bindings: PCI: dwc: Add clocks/resets common properties
> >         https://git.kernel.org/lpieralisi/pci/c/bd9504af9169
> > [12/20] dt-bindings: PCI: dwc: Add dma-coherent property
> >         https://git.kernel.org/lpieralisi/pci/c/4a8972542a6d
> > [13/20] dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
> >         https://git.kernel.org/lpieralisi/pci/c/98b59129cb9f
> > [14/20] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
> >         https://git.kernel.org/lpieralisi/pci/c/ce27c4e61f2d
> > [15/20] PCI: dwc: Introduce dma-ranges property support for RC-host
> >         https://git.kernel.org/lpieralisi/pci/c/8522e17d4cab
> > [16/20] PCI: dwc: Introduce generic controller capabilities interface
> >         https://git.kernel.org/lpieralisi/pci/c/7f9e982dc4fc
> > [17/20] PCI: dwc: Introduce generic resources getter
> >         https://git.kernel.org/lpieralisi/pci/c/ef8c58877fe7
> > [18/20] PCI: dwc: Combine iATU detection procedures
> >         https://git.kernel.org/lpieralisi/pci/c/9f67ecdd9579
> > [19/20] PCI: dwc: Introduce generic platform clocks and resets
> >         https://git.kernel.org/lpieralisi/pci/c/ef69f852a978
> > [20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
> >         https://git.kernel.org/lpieralisi/pci/c/ba6ed462dcf4
> > 
> > Thanks,
> > Lorenzo
