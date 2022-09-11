Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F605B50C5
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 21:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIKTCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIKTCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 15:02:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4E31F60B;
        Sun, 11 Sep 2022 12:02:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a8so11442927lff.13;
        Sun, 11 Sep 2022 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R7k/HCYliz2JMXrD/gWTWpEn2AgS+sBNmeV7tUSLyYk=;
        b=F5IAJqUFjefPwXI/eMWPS2PIGXtuJxNJTKOU5kbxb2i83mqWX3NrZlh4f8mOSNsMxr
         2mHoaMOCRtHW5bVBw8XssdC4jXzAzTvvsjhFDYoYpbD2d0S5+T+hsY+UPbwmEa3QK/Yj
         8F/TdHJAm6EMDjlzPJ/g7CwX/VNIGDNHxFqyP8+wfV/8zbTf3n8OGTjH6ZO9tneEbXoB
         up5FesAkUoBpzA0p9wJR0p+ceE+C+ACyQh7WdNXkn5cOWQgwhG/chso2iM8JI0K1lTRS
         ZkKC2UXxEJ0SkSt+P4sq76xSC2J/TKx+OC08EtcM4X4hQom7LBanaGu+uV8nyEZZXsQn
         mMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R7k/HCYliz2JMXrD/gWTWpEn2AgS+sBNmeV7tUSLyYk=;
        b=xQk+96snRWCZcDcY1gCvTjdI2dDpAT39um4k/w9aVuQicYloeuaoelJAWBF6Kk+kN/
         NXaoO3T3/TfxEJaKxSrH+r2C77KpqoYeBX0xHhskG9hgxmT19AiZnLTSwznmb+Wc7uSU
         lVfQusE09UrIYtJdxkFPHS4ctiSGsQ9tnlPXddXCXwFCzgvC5rB1aLH3568wGYRS098s
         fHysNObtux6VsxAAX1emPp3qKChcv1ykHTnu6E6EXlPnSCxIlFFlhhR7n5IQL/aLD43Q
         +G4iqubfS4CqBhmzjFf8xT11HlhTlqO0eHRx+B3vWYdRDIR0ynSE+zwDM7+MBLTxwKXr
         AwGA==
X-Gm-Message-State: ACgBeo0dceynSnJN85scrwvwr5OGbIF+uERmyR6z1CeHxzPmjUgklZvi
        M+zsGbSP0jnsMoUFrr6mY/g=
X-Google-Smtp-Source: AA6agR661eYPiCA4jxDeckYPBpxq60oDtAYe5RRmXrEPt1VECUEn5OqLLxLGKQ70fP94XWdNryZo3g==
X-Received: by 2002:a05:6512:3a92:b0:499:2982:a520 with SMTP id q18-20020a0565123a9200b004992982a520mr3581742lfu.213.1662922948357;
        Sun, 11 Sep 2022 12:02:28 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y27-20020a056512045b00b00499019c34a3sm693631lfk.184.2022.09.11.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 12:02:27 -0700 (PDT)
Date:   Sun, 11 Sep 2022 22:02:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20220911190225.gmmmvbjbczsqwhdk@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-10-Sergey.Semin@baikalelectronics.ru>
 <20220831212443.GA267718-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831212443.GA267718-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 04:24:43PM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2022 at 09:46:50PM +0300, Serge Semin wrote:
> > Currently the 'interrupts' and 'interrupt-names' are defined being too
> > generic to really describe any actual IRQ interface. Moreover the DW PCIe
> > End-point devices are left with no IRQ signals. All of that can be fixed
> > by adding the IRQ-related properties to the common DW PCIe DT-schema and
> > defining a common and device-specific set of the IRQ names in accordance
> > with the hardware reference manual. Seeing there are common and dedicated
> > IRQ signals for DW PCIe Root Port and End-point controllers we suggest to
> > split the IRQ names up into two sets: common definitions available in the
> > snps,dw-pcie-common.yaml schema and Root Port specific names defined in
> > the snps,dw-pcie.yaml schema. The former one will be applied to both DW
> > PCIe RP and EP controllers, while the later one - for the RP only.
> > 
> > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > custom names assigned to the same IRQ resources we have no much choice but
> > to add them to the generic DT-schemas in order to have the schemas being
> > applicable for such devices. Let's mark these names as deprecated so not
> > to encourage the new DT-bindings to use them.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the next one:
> >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> >   by the Rob' request. (@Rob)
> > 
> > Changelog v5:
> > - Add platform-specific interrupt names, but mark them as deprecated.
> > ---
> >  .../bindings/pci/snps,dw-pcie-common.yaml     | 51 ++++++++++++++
> >  .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 67 ++++++++++++++++++-
> >  3 files changed, 132 insertions(+), 3 deletions(-)
> 

> I still don't like how you've done interrupts/clocks/reg. I'd suggest 
> dropping it if you want this series applied soonish.

I can't drop this modification because what is currently done with the
generic resource names much worse. Most importantly the generic names
suggested here are also added to the driver in the framework of this
patchset. So one way or another these new names need to be
added to the DT-bindings.

As I already said many times we need to find a solution which would
suit both of us. For me it's to add the new names with detailed
description and if possible restrict the non-standard resource names
usage. For you it's to implement a suitable named properties
constraints. At the same time you keep pushing only what you need
without concerning what is required for this patchset to be coherent
in accordance with the new functionality.

I've listed all the possible options in this message:
https://lore.kernel.org/linux-pci/20220619163727.xjdlx2jf565uhids@mobilestation/
I asked you many times to pay your attention to it, but you kept
ignoring these requests so I had to resubmit the series after waiting
more than two months for your response. Please let's find out a
solution which would suit both of us this time.

So you don't like having the "definitions" keyword in the DT-schemas.
Do you? Ok. I'll just move all the names defined in there right in the
named properties constraints. But in any case since these are the
common DT-schemas we are talking about we can't expect the names being
specified in a fixed order since at the very least some of them can be
absent in particular device implementation. What do you say on this?
Do you have any alternative solution I miss?

-Sergey

> 
> Rob
