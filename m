Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FDF6462FD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLGVJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 16:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGVJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 16:09:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483A69305;
        Wed,  7 Dec 2022 13:09:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so18214755pll.6;
        Wed, 07 Dec 2022 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btWEypjcT+k8JDXT8TUXEkd1ITl+OxYaOHRpyIuSB+Q=;
        b=JdluR9hLQyzafIBwoxEuG3oOuTCDFymdGJahJS3FEGsD+BSsJiHevDsdsVDN94f0S1
         t0qvC0VbXpgvj9IatQ0QFmjSe/MqiqBx/PGBuyxFXFFmkRmJZMznP+5w+QJ+N6QwM7/Y
         c99YBeE/lIh1r37lUUR73Fe0lAW7BGpRblhFxio57bmptNFzkajL4PPkSu5BtvrvLwr4
         I39svbz2VZluvxiRJV89HuoESIIgn6Gh56l1OGw4jAtvhwSxxFqUoAdueYf/w5w+WL8P
         lhgtQ2GGm/PP9L04Kb2jruEbMMaLGVzFX5Lyp09LjyEXF0vY3y8xtpXKJg4yZ7V85/qV
         IHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btWEypjcT+k8JDXT8TUXEkd1ITl+OxYaOHRpyIuSB+Q=;
        b=eWESUyjfON3NMnaA+OE/Y2UEIX36y6u10+O+m6s5M3UQFVmId0ivmZF2hUrxkR81Di
         pCq7pIEfl2lGIDFbUHkuh1sDuyEH21nhGQzvB2qE1Z/u6A1F5pZrwsGVPaZhTxJZ21VM
         xmjFjsZCmheCYhyUxWpo0159iFbEbwmfMTyDeeakkTj3BDO5acpNHY2217P7TECKpG6A
         Rnl5OkVnyj86WI9UqlpNSbXRPJMOnigrXDA1QD2o6ZURil7iquF27oG0xbGChPsPgDfv
         r3Iz6a9owRnWXGUAgbry1xo3T4zvohC3Y35K4CWO6ZgFuQgPVw+B/fR6OVlLGUNpUHx6
         CGyg==
X-Gm-Message-State: ANoB5pkZfYrwoIMAKuWY5+w4AWaB4N8R1H5Iqfzmx69jhs+6yjumKgIm
        aQbqy3GpA/c08q9Z5G3EmTQ=
X-Google-Smtp-Source: AA0mqf7tdn9mnthjnsiCh4+fVFnlYxbawxeUHWV90HLGgMY48JD1D2x+FVc0JeApp+vU3mBr/GWgEw==
X-Received: by 2002:a17:902:7805:b0:189:f06e:fd90 with SMTP id p5-20020a170902780500b00189f06efd90mr7245160pll.50.1670447359554;
        Wed, 07 Dec 2022 13:09:19 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:524a:9944:58ed:e916])
        by smtp.gmail.com with ESMTPSA id l125-20020a622583000000b0056b8181861esm6473280pfl.19.2022.12.07.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:09:18 -0800 (PST)
Date:   Wed, 7 Dec 2022 13:09:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <Y5EA+4Ce/4IklLdJ@google.com>
References: <Y5DhigXLHMZPhI/E@google.com>
 <20221207201807.GA1468291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207201807.GA1468291@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 02:18:07PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 07, 2022 at 10:55:06AM -0800, Dmitry Torokhov wrote:
> > ...
> > I wonder if you could also consider picking up the mvebu patch:
> > 
> > 	https://lore.kernel.org/all/Y3KbhIi4ZsSO7+Cl@google.com/
> > 
> > pci-mvebu.c is the very last user of of_get_named_gpio_flags() in the
> > next tree, which we also want to stop exporting.
> 
> Sure, but the 0-day bot found a couple issues, which I haven't
> bothered to look into:
> 
>   https://lore.kernel.org/all/202211151503.HLlq2Z4B-lkp@intel.com/

Ugh, indeed, I asumed this was an existing issue and of course I was
wrong. linux/irqchip/chained_irq.h was previously included indirectly
via linux/of_gpio.h and linux/gpio/driver.h.

I sent out v3 tha compiles cleanly.

Thanks.

-- 
Dmitry
