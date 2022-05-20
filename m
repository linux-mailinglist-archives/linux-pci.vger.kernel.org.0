Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADA52E9C7
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiETKUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiETKUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 06:20:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0C14AF58;
        Fri, 20 May 2022 03:20:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v8so11591342lfd.8;
        Fri, 20 May 2022 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jr2/tZIykC2hkx0YAEoLMXwIXaVVJ/UTjNBy9AppwQc=;
        b=NEZtKLqrlRSZZgjjqOu3fylayqnLDpmIDToXGcNCM9Z8kZDY06fK3BTVCGohdpOl2l
         06YueTNTr5QqY0IMon8Df5wVxSteZyv1mGzL1S6iwOh2ml/UGHBQ3B/0vNC0NrdGQN1B
         YILZSfUpR/AqEIoL0yM9nB5ao5Q+FKznbbuDCfcxVjAx6Dbklm2l5LQoiXS2MK6LXVyQ
         HjnhzPZmYhYloC6xQHrgSizK2tWuXbkqm8A93vdZhgCYia1EFsmqm0Y3d+NBLQXh7P+M
         7eBFgL5zrRqtdzS0dvsEAp3RESONVB5VWM1Kd2CHe7TRzKQ93J+hiBDvFYKrb5mg9Vke
         YcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jr2/tZIykC2hkx0YAEoLMXwIXaVVJ/UTjNBy9AppwQc=;
        b=mZpCLbsOefS5ncbC+Q+B7ChDiZPK/vnMK+Z81Is8shlxmy7iI9K3eBmctteVJF4MAN
         S/VcX0XPjx2U3VNd35GcukLFXf7n5hrI1aekSEgr2BtDaRcLm72lrF7RxGXEuC5t91P5
         iLRPM6npOmUB0n1tGdEaRRQaNjEGkjFMcogOIN8md2X90u1DHzcKdt5ZrtWemZda+FHU
         NzXSwT1lgV1DfX2VqzM7Hr5MdC4ciUA3yEKUhJIEpaBQwcTBYUScWXMxX86/Xa3UNaNh
         sT2iH5ws7y0wd3GpOL0T0aUfc+UmAfdSlljxOmlWowms11Gd5nPSBNvO9QH1UPM4GgJu
         cFhw==
X-Gm-Message-State: AOAM533RpzpLd2RxIM4jpSnGjPbdkChQwSne5HiT0MV/ifBs/74idxb8
        DW5umw+eLjvP3rU0RNx4/gs=
X-Google-Smtp-Source: ABdhPJwn4wz8N1Dlypz9jSN4j2n++E7OtDEYCjyAkcSka1/YQeIRmWhB+WX0UlO/8lEy+9ypQtRsLw==
X-Received: by 2002:a19:4309:0:b0:477:c013:d0b0 with SMTP id q9-20020a194309000000b00477c013d0b0mr6541574lfa.105.1653042033989;
        Fri, 20 May 2022 03:20:33 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id v17-20020ac258f1000000b004785060bad6sm236262lfo.201.2022.05.20.03.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:20:33 -0700 (PDT)
Date:   Fri, 20 May 2022 13:20:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/17] PCI: dwc: Add host de-initialization callback
Message-ID: <20220520102031.xd54d4dcnbhomxdi@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-9-Sergey.Semin@baikalelectronics.ru>
 <20220516204828.GF3209795-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516204828.GF3209795-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 03:48:28PM -0500, Rob Herring wrote:
> On Wed, May 04, 2022 at 12:46:29AM +0300, Serge Semin wrote:
> > Seeing the platform-specific DW PCIe host-initialization is performed from
> > within the generic dw_pcie_host_init() method by means of the dedicated
> > dw_pcie_ops.host_init() callback, there must be declared an antagonist
> > which would perform the corresponding cleanups. Let's add such callback
> > then. It will be called in the dw_pcie_host_deinit() method and in the
> > cleanup-on-error path in the dw_pcie_host_init() function.
> 

> I'm not really a fan of .host_init() to begin with as it isn't really 
> clear by the name when it is supposed to be called and what init to do. 
> The drv probe -> dw_pcie_host_init -> drv .host_init() -> return to drv 
> sequence isn't great either. I'd rather see more fine grained and well 
> defined hooks. So I'm hesitant to add a host_deinit()...

What you say is a matter of another change. This patch just fixes the
already defined init-hook interface. Indeed the initializations
performed in the framework of the init-method need to be cleaned up in
case of the PCIe host probe procedure failure. I can't fix the DW PCIe
platform drivers since they may have some specifics I am not aware of,
but at least the interface needs to be provided for the new drivers.
One such low-level driver is submitted for review in this patchset.

What you suggest is a lot of additional work including preliminary
design settling discussions and consequent review. Alas I don't have
time for this anymore especially seeing the need for such finer grained
hooking isn't justified by neither the current platform drivers nor
the driver submitted by me. Sorry I can't fulfill your request.

-Sergey

> 
> Rob
