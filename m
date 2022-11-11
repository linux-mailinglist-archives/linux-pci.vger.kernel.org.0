Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0688E626110
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 19:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKKS1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 13:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKS1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 13:27:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF104D5CA;
        Fri, 11 Nov 2022 10:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B358BCE2923;
        Fri, 11 Nov 2022 18:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41C3C4347C;
        Fri, 11 Nov 2022 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668191254;
        bh=r2cI09RUXuELqRiuQS5kKQ79PQPgCuGaFw4FvQy4K9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bn606Xi8F0jx27buuhj9XwSONaHLGZzzcIotUYXv4ZKWBQeeUDyfRoNmj2JFkndd/
         4GIp4ngPAWf2LF184mjQo29YdjxybzAGlKmAO4UYd8tL6hDLuktD1SfEBXUvoUFaom
         ltrxbltUqo5iJcClAQG4PnmPmYGhuBiQd3PlxoV8JF6GGnyBonr3LsB8B9jQ+RHbow
         GorUBHsmsaLEKbMk5A0qMAvES5X7ifMVGSSjygOiqI42xDskcQbZXFBqY1HBZS7/ZZ
         9j5W4TIP75bvJcf3j37BS1T0Ygffu/VOfPQs006iPYcfjPes/FIHeY1ih8kWlVkmPl
         K0JJoVRcOFZgA==
Received: by mail-lf1-f51.google.com with SMTP id r12so9521721lfp.1;
        Fri, 11 Nov 2022 10:27:34 -0800 (PST)
X-Gm-Message-State: ANoB5plbcoOMms5rkoVUQ5NJgeHnugrE0l0WbBEe/TyNN3DfF3zO2Y8f
        unNZbyWo6Ttf9lo/zXSMAfoJOMNFJ6GSH2ft2g==
X-Google-Smtp-Source: AA0mqf5AsfopZSW40P5z5SuakKi9gWyzraY7YgC+syc1XRIXJFwAM0ajx5uLiWLRMjx1lWptwFOAR2YFY1YIdK1z7HM=
X-Received: by 2002:a05:6512:b1a:b0:4b0:3e46:2b75 with SMTP id
 w26-20020a0565120b1a00b004b03e462b75mr1111916lfu.368.1668191252668; Fri, 11
 Nov 2022 10:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20221031153954.1163623-1-helgaas@kernel.org>
In-Reply-To: <20221031153954.1163623-1-helgaas@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Nov 2022 12:27:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKt81KKopsGML7k3mvBqFCQ5VkKx31eCdjntpsHBkTMkw@mail.gmail.com>
Message-ID: <CAL_JsqKt81KKopsGML7k3mvBqFCQ5VkKx31eCdjntpsHBkTMkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: Remove unnecessary <linux/of_irq.h> includes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 10:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Many host controller drivers #include <linux/of_irq.h> even though they
> don't need it.  Remove the unnecessary #includes.

Note that the same is often true of the other of_*.h headers.

of_device.h and of_platform.h are tricky though as one includes the
other (with a decade old comment to fix). I started down that rabbit
hole once...

Rob
