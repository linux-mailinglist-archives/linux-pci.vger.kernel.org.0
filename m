Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C071158461B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiG1SxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1SxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 14:53:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330C743EE;
        Thu, 28 Jul 2022 11:53:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so4113825lft.8;
        Thu, 28 Jul 2022 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqDuXzOWTVq7U9l2+ECUplWD7jFZHdMOUjcOJGRtYg8=;
        b=oTsUjBvaphUVin2C+irLGt/eQKo8mEz1OmLk6F+TFa44ZlbqPfzst4bMz9r/xmHSJn
         thA2IcTMKOtkE6tSKOAoLZeDN9FCKJOUe6kVcn7gDptnjwA2zrQ62oIqrel+7PJy1eiN
         Bz4Jy2DumSblx8a+L+V3MUsziemK6oDsm3XXQ9nJl4DqDHl9dr7qFXz00Pba9LA5P9Sy
         Tdq/417wkgMqW5LmNlpGXjAdixfia0K5C0RoOmOwJYOEDwrS/dQYxVFs/5wobUFefq6M
         L5bZ5MPFbowYk7VxyDWZSVHPwrE3X42q5Xm82TlVolK+O5NlXoj96r7m+1z1WU5dLTab
         4o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqDuXzOWTVq7U9l2+ECUplWD7jFZHdMOUjcOJGRtYg8=;
        b=PHN7/lMdiuSHNm4K7NgKIYg8J3vgIjc0cP66RO3bDQ5H7CkeajccK/1/otzGzLNf3q
         G2ZVpNVFa++39uQiBGW3SvNbzMVgN+r4+7sEQNFB5ZvPHTc6RjBHPtBaCe9Lzd5ZYsm9
         k5IjD+wvSC7RxcFMxg1hkj6uJ60zZm89qOA0hv/MZi9rxTC8IdJXmTO9dmHAGrGOowYW
         brVMUa7mBdStK2uDTlh7dHFD/n61NsB9M9vrYiRtdni1uh8txrlsD8RxbCJw8GlXv+QY
         RIQdolyA//imBpmhR+Am/4bbgVjWfe0cCPkAdKTicKXyyCr7YZyk1STObQCxI+CirGRG
         wHfg==
X-Gm-Message-State: AJIora8/M+y1H2jLegPhGAQ9lGIwp7mZJjG99gXD/v5/pWa5XAqOdEfD
        JDxX6ODQ8e92SDRR5SDBGiA=
X-Google-Smtp-Source: AGRyM1vxbrmC9UG6lvhuS8D++pmLdPzd/EMFdQeBuXzwgUbAdL+jtkgDOa5UQ8z/YDvwcmjbrXhETQ==
X-Received: by 2002:a05:6512:ac6:b0:48a:8379:bcc0 with SMTP id n6-20020a0565120ac600b0048a8379bcc0mr56793lfu.601.1659034394104;
        Thu, 28 Jul 2022 11:53:14 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y14-20020a0565123f0e00b0048a9a756763sm322087lfa.19.2022.07.28.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 11:53:13 -0700 (PDT)
Date:   Thu, 28 Jul 2022 21:53:11 +0300
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
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 03/15] PCI: dwc: Convert to using native
 IP-core versions representation
Message-ID: <20220728185311.3b4n2izy64fdpfk6@mobilestation>
References: <20220624143947.8991-4-Sergey.Semin@baikalelectronics.ru>
 <20220728152418.GA302516@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728152418.GA302516@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 10:24:18AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:39:35PM +0300, Serge Semin wrote:
> > Since DWC PCIe v4.70a the controller version can be read from the
> > PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> > format [1]. It's standard versioning approach for the Synopsys DWC
> > IP-cores. Moreover some of the DWC kernel drivers already make use of it
> > to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> > recent DW SPI driver).
> 

> These references to other drivers might be useful, but without a
> function name or file name, I can't easily find them.

1. DW APB SSI driver, defined in drivers/spi/spi-dw.h:
#define DW_HSSI_102A                    0x3130322a
#define dw_spi_ip_is(_dws, _ip) ...
#define dw_spi_ver_is(_dws, _ip, _ver) ...
#define dw_spi_ver_is_ge(_dws, _ip, _ver) ...

2. DWC USB3 driver, defined in drivers/usb/dwc3/core.h
#define DWC3_IP                 0x5533
#define DWC31_IP                0x3331
#define DWC32_IP                0x3332
#define DWC3_REVISION_173A      0x5533173a
#define DWC3_REVISION_175A      0x5533175a
...
#define DWC31_REVISION_110A     0x3131302a
#define DWC31_REVISION_120A     0x3132302a
...
#define DWC3_IP_IS(_ip) ...
#define DWC3_VER_IS(_ip, _ver) ...
#define DWC3_VER_IS_PRIOR(_ip, _ver) ...
#define DWC3_VER_IS_WITHIN(_ip, _from, _to) ...
#define DWC3_VER_TYPE_IS_WITHIN(_ip, _ver, _from, _to) ...

Regarding the STMMAC (DW MAC/GMAC/xGMAC) driver. I've harried up to
claim it has the native IP-core versioning support. The current kernel
driver doesn't have it. Instead I have it implemented in my local
repo, but it isn't ready to be submitted yet. I need some more time to
finish my DW GMAC/xGMAC work first.

Ideally we could have created a common interface for all the drivers.
I thought about it first when I was initially creating the patchsets.
But now I don't time left for this at all. The review process's taken
way much more time than I had/planned to spend for the PCIe-patches.
So what I can do at this stage is to provide minor fixes if required.

-Sergey

> 
> > In order to preserve the standard version
> > representation and prevent the data conversion back and forth, we suggest
> > to preserve the native version representation in the DWC PCIe driver too
> > in the same way as it has already been done in the rest of the DWC
> > drivers. IP-core version reading from the CSR will be introduced in the
> > next commit together with a simple macro-based API to use it.
> > 
> > [1] https://en.wikipedia.org/wiki/FourCC
