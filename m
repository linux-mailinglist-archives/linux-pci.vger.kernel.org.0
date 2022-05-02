Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1497B517252
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385692AbiEBPSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiEBPSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:18:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A4298;
        Mon,  2 May 2022 08:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBFF1B817E7;
        Mon,  2 May 2022 15:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B60C385B1;
        Mon,  2 May 2022 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651504510;
        bh=AAbFLuuCoK5/ZzZ6oNqF+aIbI7ECKwxlG30WX64inp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jIqH4BMBpWuq8bW4qyQsutlWhYSRg/irjCYxs+qD+KDqmP+r1Q3ee5EWy/tF7ioQx
         jZT9spSWIgoHoB+ISUyqVWAg0pnRqXjOxdhm9klVH0Lqj4FrQNDFp4OFM5etkAu3qY
         9UStjDNcrkV49sc7G2BDzrZWjjFYZFsSrGTOP02cH/HqG6RkGIiDG92KmTHL3YKS0s
         kr6ldY7xHfhTjr37dJBbhY+UvEQ9eZczZzpvMAKHneJuaKP2WlqmZMquDa7qJu2Onv
         sm3gQEJnmIrS2uuYCt0QU8v5WjqfC5n40dxxa+EHExfghQiGCjRkk/Dkh+1x2/o712
         wLzjxc9Sms0tQ==
Received: by mail-pf1-f171.google.com with SMTP id p8so12520791pfh.8;
        Mon, 02 May 2022 08:15:10 -0700 (PDT)
X-Gm-Message-State: AOAM5325GIFfxoDH4K656QUvUI49/2j/p/E4cPj6C4sin3rbbMvhmm4c
        QYd+0SehdolL2YPaijvjKH4cjV5Wqz1tPjeUbQ==
X-Google-Smtp-Source: ABdhPJwHBPi2P2uvm2CYtmrpzGHuRDARkQbnREo1NzypK7DH0CQ13TaJKE/1cJpu8l9ubZLX7Zqz3RZrJdPa4oUyaXc=
X-Received: by 2002:aa7:8893:0:b0:4fb:10e1:8976 with SMTP id
 z19-20020aa78893000000b004fb10e18976mr11530962pfe.36.1651504510172; Mon, 02
 May 2022 08:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093832.32778-1-marcan@marcan.st> <20220502093832.32778-4-marcan@marcan.st>
In-Reply-To: <20220502093832.32778-4-marcan@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 May 2022 10:14:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
Message-ID: <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
To:     Hector Martin <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 2, 2022 at 4:39 AM Hector Martin <marcan@marcan.st> wrote:
>
> WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
> Add support for this to the PCIe controller. This is modeled after how
> pcie-fu740 does it.

It did, but it's not ideal really. The problem is the GPIO is really
associated with the device (WiFi/SD) rather than the PCI host and
therefore should be part of a WiFi or SD node. You probably don't have
one (yet), but I would suspect that SD will need one for all the
standard MMC/SD DT properties. The secondary issue is we'll end up
adding more power sequencing properties to control ordering and timing
for different devices. The exception here is standard PCI slot
properties like perst#, clkreq, and standard voltage rails can go in
the host bridge (and for new bindings, those should really be in the
root port node). For a complicated example, see Hikey960 or 970.

Of course with power control related properties there's a chicken or
egg issue that the PCI device is not discoverable until the device is
powered on. This issue comes up over and over with various hacky
solutions in the bindings. The PCI subsystem needs to solve this. My
suggestion is that if the firmware says there is a device on the bus
and it wasn't probed, then we should force probing (or add a pre-probe
hook for drivers). That is what MDIO bus does for example.

Rob
