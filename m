Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FD6242F5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiKJNKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 08:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiKJNKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 08:10:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5E78323;
        Thu, 10 Nov 2022 05:10:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so3140578lfh.3;
        Thu, 10 Nov 2022 05:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6oojRd9wGjZywldLmfsnpu/d0gdtcDmLaZ/t1Ckm/8=;
        b=WrQfiHN1je8hcTWn349PJTeQ5pqYf7LIw4xZgFyloVr+CwHHboDuy5eQUnSGOvtSBp
         /uoTOZ0iDX8Cp0JG8uI0I/VzBn3ui5i8GSltRGXluubbbppWVARUiEWj9NLeU5KzlF1B
         Rgs/Mb/n94u7KhdfZl4+EZ+jmQ+DOX2ENJXK7Tg/qhX3wNbcpNk7NUB2AG3KqVuoevX5
         gtMFc5CMXHLPV2my5hnq9Dah+LCOcuhyXkPVFHTWId2EShP/bXELds96hQ5uybOSr7MZ
         gy4PQ19nWcXas5ThU+9RPEZ6Yy1ZBsn0CltHUDPZqTq4lhYOe6diw5yXzoQeuOfzzuAB
         a+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6oojRd9wGjZywldLmfsnpu/d0gdtcDmLaZ/t1Ckm/8=;
        b=Rz9rzwc347166bRDRP/0dPMb1UdxMhKcdjU30FGotZAvzhT2cljFX+Mg9bkq+JF3d7
         wZyFM2/2/wCLgcKwX4Zi/AEA/f5wa+8kivm8C6Lwa/Dqv+HW0aN1TzHZm+6f2u5idytJ
         KJqigbTlZzOeJ+2DcDQTkf5K2zonHXBVcNSK1rwVD/qbIQmI9bFUHVXtpp9cgpiApKzq
         6DO1cAVyyYgfBfG4ZXIqM8iDPKlyMtP+xGRzoT/H53fFQXhsKh/Un+xbhkLeq7UNd7Vu
         wOq8oxASSn8jKn0j759AS5wlho0UkiKD1NWZdxbGz1ZqMtyPsE3g6lXYdRH81xFfimwo
         gB1Q==
X-Gm-Message-State: ACrzQf31mFtpt8+HNWSekqI3QZSR4oMid5X5f7GszTnpW1BKI02pEbHR
        67XWz+5obotX11ONXNeU6DU=
X-Google-Smtp-Source: AMsMyM7nyWffXx6XzKoDvbegcOD16IIRre08SE7TZFAZBi3ghAI7hnDoKNgXLl7xvlwWOFCXwk3V5g==
X-Received: by 2002:a19:6708:0:b0:4a2:5be6:c0bf with SMTP id b8-20020a196708000000b004a25be6c0bfmr1576839lfc.390.1668085810123;
        Thu, 10 Nov 2022 05:10:10 -0800 (PST)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b004979da67114sm2734508lfv.255.2022.11.10.05.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:10:09 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:10:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <20221110131006.dkwrelulzrm52fwd@mobilestation>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-18-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB534178751E369DA4C031AE77D83E9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB534178751E369DA4C031AE77D83E9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro

On Wed, Nov 09, 2022 at 02:17:45AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Tuesday, November 8, 2022 5:50 AM
> > 
> > Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
> > the separate parts of the DW PCIe core driver. It doesn't really make
> > sense since the both controller types have identical set of the core CSR
> > regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Host
> > and EP initialization methods by moving the platform-specific registers
> > space getting and mapping into a common method. It gets to be even more
> > justified seeing the CSRs base address pointers are preserved in the
> > common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
> > initialization will be moved to the new method too in order to have a
> > single function for all the generic platform properties handling in single
> > place.
> > 
> > A nice side-effect of this change is that the pcie-designware-host.c and
> > pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
> > storage modification, which makes the DW PCIe core, Root Port and Endpoint
> > modules more coherent.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch created on v3 lap of the series.
> > 
> > Changelog v4:
> > - Convert the method name from dw_pcie_get_res() to
> >   dw_pcie_get_resources(). (@Bjorn)
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 26 +------
> >  .../pci/controller/dwc/pcie-designware-host.c | 15 +---
> >  drivers/pci/controller/dwc/pcie-designware.c  | 75 ++++++++++++++-----
> >  drivers/pci/controller/dwc/pcie-designware.h  |  3 +
> >  4 files changed, 65 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 237bb01d7852..80a64b63c055 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -13,8 +13,6 @@
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > 
> > -#include "../../pci.h"
> > -
> >  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> >  {
> >  	struct pci_epc *epc = ep->epc;
> > @@ -688,29 +686,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct device *dev = pci->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> > -	struct device_node *np = dev->of_node;
> 
> Removing this np causes the following build error if CONFIG_PCIE_DW_EP is enabled:
> ---
>   CC      drivers/pci/controller/dwc/pcie-designware-ep.o
> drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_init':
> drivers/pci/controller/dwc/pcie-designware-ep.c:751:35: error: 'np' undeclared (first use in this function); did you mean 'ep'?
>   751 |         ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>       |                                   ^~
>       |                                   ep
> drivers/pci/controller/dwc/pcie-designware-ep.c:751:35: note: each undeclared identifier is reported only once for each function it appears in
> ---
> 
> So, we should keep the np or use "dev->of_node" to the of_property_read_u8().

Indeed. Thanks for noticing that. I'll fix it in v7.

-Sergey

> 
> Best regards,
> Yoshihiro Shimoda
> 
