Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51145EB2B8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIZUyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIZUxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 16:53:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68EAED84;
        Mon, 26 Sep 2022 13:53:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h3so8864342lja.1;
        Mon, 26 Sep 2022 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FMc3Y59a61qmemE+Mlyalv3Fdm9mXvRwbGeyg5kaP7c=;
        b=KmSsCwg5KieOLEo2miTUWW9SMvZ1Sx/ppKWul6CbqePRoR1Z8Ts6yW1ov733+j7fIT
         pLz8CO3qRoHNAGUNYLz6b+PONfr95Bct4QXktrWc0Z3J7hLBfAAQ7THi0snn7r2bBiiv
         Yfn9HvC7srMWUA318yf4iFbIjr6y6Cv+zPOPALg1XKuIEUnh2RlPXfm8WWCd55Se6oVs
         7vqE2KAV321o1XZB9zGRV2CfTHOqx/zVTW67+038palJoC2NLO6pMLTN/SnkiQaekhKJ
         t7tl/OqaijOvOQmgTepNAQ4jNfBg3OhaapcOYmw/Litr+vkPconmJ35fSAWtsNfVIaeR
         wk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FMc3Y59a61qmemE+Mlyalv3Fdm9mXvRwbGeyg5kaP7c=;
        b=kcUkbrEwrlF06lvXyAF6qKJnPTNXIzpH6hNmjG/o41qxblrT2RU5PZHzXr2ZzPQftM
         BOMTTZ7WjOp4u2tY58pQsFG8MKXuExnYPhOZMVwIGxEhWbfztdhqb7JbBp+/CclfI+J8
         4Z8d8rbe2xrj6/VyK7Yq7XnOgbDkh780TnEmC07DZGNNdylfJXyN0aQ1Fnb5Ier7BM4Y
         Jnx3BrAgJYoW6ZOKCkE8bU/vJh0s0ZiX3ZW8ZTxnCSVd31c+y6yLerKncA5P6fwCkcWD
         3u2u08wvjiQAEvL1EjSlZK79+NKD3+jyL3uIGPBLi9FZbTRCzj6Mnv0uO/zLsp+7Ff4z
         +rCg==
X-Gm-Message-State: ACrzQf35w61yipY6+gflf+yz1i2mjZ5N3M/nUxyh0GLhl8htdoeNz6pU
        cNVPWn0VjH3PI2PvcLUpTl9Z7b9o2v+SLQ==
X-Google-Smtp-Source: AMsMyM4FVIUDLVx8IWM9Oyck9CF7/Duaa7FQJ4SWOK+lo7Sn/FcizNivqN3IySBjESwOPcAnvS204w==
X-Received: by 2002:a2e:b893:0:b0:26c:22e0:716d with SMTP id r19-20020a2eb893000000b0026c22e0716dmr8851725ljp.48.1664225617750;
        Mon, 26 Sep 2022 13:53:37 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id p7-20020a056512138700b0049482adb3basm2627627lfa.63.2022.09.26.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:53:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 23:53:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        William McVicker <willmcvicker@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220926205333.qlhb5ojmx4sktzt5@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <20220912000211.ct6asuhhmnatje5e@mobilestation>
 <YzF8N/jzkWsjcgdD@lpieralisi>
 <20220926124924.4vodhncnuaorrlwj@mobilestation>
 <20220926143127.GB19031@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926143127.GB19031@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 04:31:28PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 03:49:24PM +0300, Serge Semin wrote:
> > @Christoph, @Marek, @Bjorn, @Rob could you please join to the
> > DMA-mask related discussion. @Lorenzo can't decide which driver should
> > initialize the device DMA-mask.
> 

> The driver that does the actual DMA mapping or allocation functions
> need to set it.  But even with your comments on the questions I'm
> still confused what struct device you are even talking about.  Can
> you explain this a bit better?

We are talking about the DW PCIe Root Port controller with DW eDMA engine
embedded. It' simplified structure can be represented as follows:

         +---------------+     +--------+
         | System memory |     | CPU(s) |
         +---------------+     +--------+
                ^  |              |  ^
                | ... System bus ... |
               ... |              | ...
                |  v              v  |
 +------------+------+--------+----------+------+
 | DW PCIe RP | AXI-m|        | AXI-s/DBI|      |
 |            +------+        +----------+      |
 |                ^              ^     |        |
 |         +------+----+         |    CSRs      |
 |         v           v         v              |
 |     +-------+  +---------+ +----------+      |
 |     | eDMA  |  | in-iATU | | out-iATU |      |
 |     +-------+  +---------+ +----------+      |
 |         ^           ^           ^            |
 |         +--------+--+---+-------+            |
 +------------------| PIPE |--------------------+
                    +------+
                      | ^
                      v |
                   PCIe bus

The DW PCIe controller device is instantiated as a platform device
defined in the system DT source file. The device is probed by the
DW PCIe low-level driver, which after the platform-specific setups
initiates the generic DW PCIe host-controller registration. On the way
of that procedure the DW PCIe core tries to auto-detect the DW eDMA
engine availability. If the engine is found, the DW eDMA probe method
is called in order to register the DMA-engine device. After that the
PCIe host bridge is registered. Both the PCIe host-bridge and
DMA-engine devices will have the DW PCIe platform device as parent.

Getting back to the sketch above. Here is a short description of the
content:
1. DW eDMA is capable of performing the data transfers from/to System
memory to/from PCIe bus memory.
2. in-iATU is the Inbound Address Translation Unit, which is
responsible for the PCIe bus peripheral devices to access the system
memory. The "dma-ranges" DT-property is used to initialize the
PCIe<->Sys memory mapping. (@William note the In-iATU setup doesn't
affect the eDMA transfers.)
3. out-iATU is responsible for the CPU(s) to access the PCIe bus
peripheral devices memory/cfg-space.

So eDMA and in-iATU are using the same AXI-master interface to access
the system memory. Thus the DMAable memory capability is the same for
both of them (Though in-iATU may have some specific mapping based on
the "dma-ranges" DT-property setup). Neither DW eDMA nor DW PCIe Root
Port CSRs region have any register to auto-detect the AXI-m interface
address bus width. It's selected during the IP-core synthesize and is
platform-specific. The question is: "What driver/code is supposed to
set the DMA-mask of the DW PCIe platform device?" Seeing the parental
platform device is used to perform the memory-mapping for both DW eDMA
clients and PCIe-bus peripheral device drivers, and seeing the AXI-m
interface parameters aren't auto-detectable and are platform-specific,
the only place it should be done in is the DW PCIe low-level device
driver. I don't really see any alternative... What is your opinion?

-Sergey
