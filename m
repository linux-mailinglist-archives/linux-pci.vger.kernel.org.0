Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42D5851AC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiG2Oib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiG2Oia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 10:38:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38867CB6;
        Fri, 29 Jul 2022 07:38:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so7581402lfd.9;
        Fri, 29 Jul 2022 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWcB4X8ENw9vtO1R4Hk4K+2CQ/dMncr7JEdlRLjexCY=;
        b=aufEE8sF+BMJDS0VfJg6CSw51VMg0z9s3/aEv05VpQddjA1NCYxxozP4a4E+CNFx6A
         k4CYJpHNCEEjQ1oYuCWrqVUdRi5QQtyw4BmWqytm/czsAABnIiYKs2hnVmB5OcAtE071
         MLApCHcbwtfHaKt55jqpijJ9X1xs1Hvduf79kUAiUJpLv7jsUEksAblKt62psk95fzVn
         mBPaOGTCxfmACvjRexIZhzrxDIbPunIUrBJjPbu9UKJ5aptzTBIYISbWvYj/RiTowZrE
         rwrd/mmerT3AM88snLyr4zwaMQT8Keui12FVYZ4oTsS3Ov6s19O8BLPA0vfIMCj9Qzx8
         Cahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWcB4X8ENw9vtO1R4Hk4K+2CQ/dMncr7JEdlRLjexCY=;
        b=JTap1TrdGp8Rd87axRkywsu1LdLKehQKJ1LAZEVYXRsLqNroCdlCjlOS3qeINCS0Fm
         ZQpAkpc1ihgkqo7L7IU7B3W2F36lBvMgIk9Qoy1IgU4CpZlU4Wu4sfsqpaaMzQXzB/l1
         3oTXJUgypCGqcq2r+sbzd8g1Oump4k8k6R2djo5+gurIvEF+2FzKeBCt14f6MzRDycop
         lUE6GaAlKnDWoiuuzaydgvX44XY6abTcwdGPOe8JFRgZdQzHI/9hu43qYkqrag23eFS/
         MKmXWL9I+7jByUOIxDnpxaZ7zznxw+Dj3iZoAivXIKC/2HptEQqhlgTFUyFZRbghG5mT
         I85Q==
X-Gm-Message-State: AJIora+PnGQ5gGQHQD8tl1xp8OZU4d8wEwWfP3HbnBqEhb+Ya0ju6YYc
        +WQc8++vou/Wx8Oz2cAHZwU=
X-Google-Smtp-Source: AGRyM1ses1MGHS/+TVzVcL6XWaiWRrJtziJMtkyuKaxN0vltHNtIqeuJbKM6B1AwZA9l3dmPomJCBQ==
X-Received: by 2002:a05:6512:3d1e:b0:48a:9502:1bda with SMTP id d30-20020a0565123d1e00b0048a95021bdamr1358237lfv.492.1659105506467;
        Fri, 29 Jul 2022 07:38:26 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651220d100b0048759bc6c1asm678484lfr.203.2022.07.29.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:38:25 -0700 (PDT)
Date:   Fri, 29 Jul 2022 17:38:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 15/15] PCI: dwc: Introduce dma-ranges property
 support for RC-host
Message-ID: <20220729143823.zpmyeimz7qgjjet6@mobilestation>
References: <20220729045220.akdabli5szd5lbdt@mobilestation>
 <20220729113345.GA445581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729113345.GA445581@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 29, 2022 at 06:33:45AM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 29, 2022 at 07:52:20AM +0300, Serge Semin wrote:
> > On Thu, Jul 28, 2022 at 05:11:20PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 24, 2022 at 05:39:47PM +0300, Serge Semin wrote:
> > > > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > > > property has the same format as the "ranges" property. The only difference
> > > > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > > > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > > > property. Even though the DW PCIe controllers are normally equipped with
> > > > the internal Address Translation Unit which inbound and outbound tables
> > > > can be used to implement both properties semantics, it was surprising for
> > > > me to discover that the host-related part of the DW PCIe driver currently
> > > > supports the "ranges" property only while the "dma-ranges" windows are
> > > > just ignored. Having the "dma-ranges" supported in the driver would be
> > > > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > > > mapping and require a customized PCIe memory layout. So let's fix that by
> > > > introducing the "dma-ranges" property support.
> > 
> > > Do we have a platform that requires this yet?  Or does this fix a bug?
> > > 
> > > I see that dw_pcie_host_init() calls devm_pci_alloc_host_bridge(),
> > > which eventually parses "dma-ranges", but I don't see any DWC DT
> > > bindings that use it yet.
> > > 
> > > I'm not clear on what value this adds today.
> > 
> > There are several points of having this supported.
> > First of all, generic PCIe DT-bindings permit having the dma-ranges
> > specified for the PCIe RCs. If so having it unsupported by the driver
> > just breaks the bindings or at least makes it incomplete.
> 

> Are there bindings in the tree that are broken and will be fixed by
> this?

Shortly speaking: explicitly none of them are broken, but implicitly most
of them are broken.)

As I said the generic DT-bindings permit having the dma-ranges
property specified for the PCIe RCs:
Link: https://github.com/robherring/dt-schema/blob/master/schemas/pci/pci-bus.yaml#L47

So all the PCIe RC bindings can be equipped with the dma-ranges
property. At least dtschema check tool won't print any error if the
property is specified for any of the currently available PCIe RC
device including DW PCIe RC. But if the dma-ranges aren't supported by
the driver having it specified won't give any expected effect. In case
of the DW PCIe RC device setting the dma-ranges property up won't
change anything because without this patch the dma-ranges won't be
accordingly translated to the inbound iATU settings.

> 
> > Second, the main point of this patchset is to add the dma-ranges
> > support.) Especially seeing some other PCIe RC drivers do have it
> > supported too.
> > Finally. It is required for our platform (and for all the platforms
> > with similar issues). The problem is that the outbound source window
> > base address (on CPU-side) is size-unaligned. It resides at the 128MB
> > base address (size is somewhat about ~335MB). In case of the
> > one-on-one CPU->PCI mapping the peripherals with relatively big BARs
> > (at least of 256MB) and which need the BARs having size-aligned memory
> > won't be supported. So we had to remap the PCIe space to the
> > size-aligned base address. But in its turn that caused the PCIe-CPU
> > memory overlap. So PCIe DMA stopped working for the overlapped memory
> > due to the implicit P2P transactions. In order to fix that we had to
> > add the dma-ranges support to the DW PCIe driver and use it to remap
> > the overlapped memory. So please add this patch to the repo. We really
> > need it.
> 

> Does the above apply to the pending Baikal-T1 driver? 

The problem described above is indeed specific to the Baikal-T1
platform.

> If so, let's
> just include this patch in that series.  Then we'll have a user of
> this functionality and we'll be able to exercise and test this code.

Basically it can be tested out on any platform, not only on ours. You
don't even need to have the problem described above. All you need is a
DW PCIe RC-device with the inbound iATU windows support, this patch
and a dts file with the dma-ranges specified for the corresponding DT
device node.

Secondly even if you do move this patch to that series it likely won't
be tested by anyone but me, which I and our customer have already done
many times here. By postponing the patch merge in you'll just postpone
the feature being utilized by the rest of the kernel users and nothing
else. I am sure it's working at least in our case. Let's add it to the
kernel on this cycle so in case of unexpected problems they could be
fixed in the next rc-stages.

-Sergey

> 
> Bjorn
