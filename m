Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B65EDAAA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiI1K4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 06:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiI1Kzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 06:55:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E14EE21F2;
        Wed, 28 Sep 2022 03:54:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z4so1958742lft.2;
        Wed, 28 Sep 2022 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=51m+2Gh5GzzXA1oZLWBMoREyLh81V5FJkxq7+9c9iyQ=;
        b=eQpK8Dp3x3wvLl1NBHpv8IeKRexpJuT/ZtUy/lgZVDGprjmHBn62efhPZvusvPdYLC
         ZpUQAfxUH5hTpSTYz9aSwliD8voIvAR3dAdpX/aX46euRVA+x+RiRyV/RNmT1BgKqW0z
         B4qfRnbi55cWXv+4vGiiv47EIdRf81XSdfakYPU5oA2+UVMvcIKvZt6bN9rp2kcMJIEs
         emc0SlLUkabcUzRY1uJCpj5EcA3e+oaoP/o1zcrdfab4u/BOAT8UqF1Fc6Yl2lTKYFdX
         15ZceMnkvcwFDWtD3BnAJ3fbEodOPLAI0sB0RWLzDjj23k9IBYZi0s2cTPqUCxzzkl4C
         CdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=51m+2Gh5GzzXA1oZLWBMoREyLh81V5FJkxq7+9c9iyQ=;
        b=UI4Kng6oPDLU6SdKbl5zXpBT6C9qt2q8bmfZvw3OfproKu0RoNW/KYkmqLwOWjAsJy
         kBgpYeHaZjHm52FVeXKkZXxOULFvVmg6l2+1kim70TrmaYbTIySK5HXTCyycQ/mr5kVY
         qrdRpmbRQ8wyePQ4oE8GXl1qiB0FMhe8NBqkejXjzUgBiQw/XbQuFhNVPE2QIGnkq9ri
         TJoabnRt813LsiFbb0nn2YqfTZaOSb5y6/gC0kGDcO8cCDTULplKjTWVVeaqNuVlPUsV
         yLFvPo1jtTxrSZg3hPXh/iv5DUNbTkoSL3NfGcFIlPa7zleIOYEOrcVJ5Q0KNgyaoPlf
         NgRA==
X-Gm-Message-State: ACrzQf3CBuGxyOZxUTvjkQGUsfZP0Od7rE6RBys/aPtfNv6WMLCL2qTq
        ILFY0EcPxElX0S77v9qbEsk=
X-Google-Smtp-Source: AMsMyM7gc2f88K86Uln6JgpNwtUi7gJAAqHKUnRsybb9mRhAQxBLr7uRrVrYk2iBvN67FjpaWkO+5A==
X-Received: by 2002:ac2:57c9:0:b0:49c:3e64:de95 with SMTP id k9-20020ac257c9000000b0049c3e64de95mr13228543lfo.452.1664362407479;
        Wed, 28 Sep 2022 03:53:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b004979e231fafsm441446lfq.38.2022.09.28.03.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:53:26 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:53:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH RESEND v4 00/15] PCI: dwc: Add hw version and dma-ranges
 support
Message-ID: <20220928105324.mhsvl6asvbsbogvj@mobilestation>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220729023645.GA423256@bhelgaas>
 <YzQBjHYI9REEaqeL@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQBjHYI9REEaqeL@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 10:10:52AM +0200, Lorenzo Pieralisi wrote:
> On Thu, Jul 28, 2022 at 09:36:45PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 24, 2022 at 05:39:32PM +0300, Serge Semin wrote:
> > > This patchset is a second one in the series created in the framework of
> > > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > > Serge Semin (15):
> > >   PCI: dwc: Add more verbose link-up message
> > >   PCI: dwc: Detect iATU settings after getting "addr_space" resource
> > >   PCI: dwc: Convert to using native IP-core versions representation
> > >   PCI: dwc: Add IP-core version detection procedure
> > >   PCI: dwc: Introduce Synopsys IP-core versions/types interface
> > >   PCI: intel-gw: Drop manual DW PCIe controller version setup
> > >   PCI: tegra194: Drop manual DW PCIe controller version setup
> > >   PCI: dwc: Add host de-initialization callback
> > >   PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
> > >   PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
> > >   PCI: dwc: Simplify in/outbound iATU setup methods
> > >   PCI: dwc: Add iATU regions size detection procedure
> > >   PCI: dwc: Verify in/out regions against iATU constraints
> > >   PCI: dwc: Check iATU in/outbound ranges setup methods status
> > 
> > I applied the above to pci/ctrl/dwc for v5.20, thanks!
> > 
> > >   PCI: dwc: Introduce dma-ranges property support for RC-host
> > 
> > I deferred this one for now because the current value isn't clear yet.
> > If we have a user for it, I'll be glad to add it.
> 

> This one is still deferred and I agree with Bjorn it should be part of
> a series that actually requires it - it would also simplify the review.

Have already moved it to the next patchset:
https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
See the patch in there:
https://lore.kernel.org/linux-pci/20220822184701.25246-16-Sergey.Semin@baikalelectronics.ru/

-Sergey

> 
> Lorenzo
