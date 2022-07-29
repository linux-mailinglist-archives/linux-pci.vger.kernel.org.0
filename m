Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0E584AD1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 06:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiG2Ew3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2Ew3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 00:52:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363154C9A;
        Thu, 28 Jul 2022 21:52:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w18so3972988lje.1;
        Thu, 28 Jul 2022 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U//rHniD2tw0/VYgrwbz6wuLOPOazyISqLkTQwotf7Q=;
        b=GNh1rTfE04nZGUD91XUpeC5IR4KK1p2XFZOPHcLCiuoqB/vbz6IiXh1hvRkZyGHcjr
         GDDlkiN+9oRY8n0r3K6jEjQn+SovynfK94bDsq8jXFH0ZiLPyHvHOcz9aUST3jZql6Hi
         B+WR2T+XcUxXaWrXfk1dba4vsIA2I0SE5IMHYQ9oO+kaXheoGn5NTl/hbIyVolqtj0M4
         RJm5faD8a6MPW+SOiur996wxslkyI3bU4MQqhfVXfxYLVWOHXxfB150yKXZiN7OdaEL+
         v/sW0WsT7Cn1lDZs50+yPlbqbSIzW8O8eANcOuiZ/ve+HpCreNLAxyzpVFIdC9+YUpim
         xbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U//rHniD2tw0/VYgrwbz6wuLOPOazyISqLkTQwotf7Q=;
        b=naqvm3Qf45gVMcZjA+fgzLYbCWobPrIHf0cmMbSz+1bqZaVvUo0YxDiGi0V32gg6AW
         Z+fDRNhfO7nJKm+old/pAlksWjqr8EQT9A8rfJrbs68wq/lJBWJk9kKU9XS7QrHJcyvk
         DIqc8scKOBLLuDR7nUM0Plzj/49YN6IrWOmMc6+dXu6yZ6RF9N3JRgIIyfi4+AXINyM5
         yzcBA1HlMVM9V8tK11p8ZXNSzyCuL7OClNOIFE+up+5LiM8rURsMoCeeK576xHHZAK2R
         a8uvemdu6iXHyIthlZQOQB+1rqUrwscxMwcwBMQeLO3mZFaTHIPbs+vva3zQYnQIMf/v
         MyNA==
X-Gm-Message-State: AJIora9rfHkKyG8JOs0S35DcX7reHn03o7VXvBPLkWBtIWQYpVUsm4xy
        lvQvStkE1BREpcP1fjO3Pzg=
X-Google-Smtp-Source: AGRyM1u7pAXqChgUTZ8m9O3Xd8snQcmPUsdVzTWUXjqwSkUCoQJ3F/xm/ROdh0vZQ7u44yqMgJKu6w==
X-Received: by 2002:a2e:9941:0:b0:25b:c885:3143 with SMTP id r1-20020a2e9941000000b0025bc8853143mr567312ljj.477.1659070343730;
        Thu, 28 Jul 2022 21:52:23 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b00488d1acb7b0sm204898lfs.130.2022.07.28.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 21:52:23 -0700 (PDT)
Date:   Fri, 29 Jul 2022 07:52:20 +0300
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
Message-ID: <20220729045220.akdabli5szd5lbdt@mobilestation>
References: <20220624143947.8991-16-Sergey.Semin@baikalelectronics.ru>
 <20220728221120.GA330510@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728221120.GA330510@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 05:11:20PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:39:47PM +0300, Serge Semin wrote:
> > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > property has the same format as the "ranges" property. The only difference
> > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > property. Even though the DW PCIe controllers are normally equipped with
> > the internal Address Translation Unit which inbound and outbound tables
> > can be used to implement both properties semantics, it was surprising for
> > me to discover that the host-related part of the DW PCIe driver currently
> > supports the "ranges" property only while the "dma-ranges" windows are
> > just ignored. Having the "dma-ranges" supported in the driver would be
> > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > mapping and require a customized PCIe memory layout. So let's fix that by
> > introducing the "dma-ranges" property support.
> 

> Do we have a platform that requires this yet?  Or does this fix a bug?
> 
> I see that dw_pcie_host_init() calls devm_pci_alloc_host_bridge(),
> which eventually parses "dma-ranges", but I don't see any DWC DT
> bindings that use it yet.
> 
> I'm not clear on what value this adds today.

There are several points of having this supported.
First of all, generic PCIe DT-bindings permit having the dma-ranges
specified for the PCIe RCs. If so having it unsupported by the driver
just breaks the bindings or at least makes it incomplete.
Second, the main point of this patchset is to add the dma-ranges
support.) Especially seeing some other PCIe RC drivers do have it
supported too.
Finally. It is required for our platform (and for all the platforms
with similar issues). The problem is that the outbound source window
base address (on CPU-side) is size-unaligned. It resides at the 128MB
base address (size is somewhat about ~335MB). In case of the
one-on-one CPU->PCI mapping the peripherals with relatively big BARs
(at least of 256MB) and which need the BARs having size-aligned memory
won't be supported. So we had to remap the PCIe space to the
size-aligned base address. But in its turn that caused the PCIe-CPU
memory overlap. So PCIe DMA stopped working for the overlapped memory
due to the implicit P2P transactions. In order to fix that we had to
add the dma-ranges support to the DW PCIe driver and use it to remap
the overlapped memory. So please add this patch to the repo. We really
need it.

-Sergey

> 
> Bjorn
