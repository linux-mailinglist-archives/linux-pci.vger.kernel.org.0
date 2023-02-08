Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1168F02A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjBHNxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 08:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHNxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 08:53:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAA55BD;
        Wed,  8 Feb 2023 05:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631D9616DB;
        Wed,  8 Feb 2023 13:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6159C4339C;
        Wed,  8 Feb 2023 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675864418;
        bh=WwZKQNxRYbqexgKDjQvTmVvAVguLZdCf+9wuce5cegc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCQu46mSBp8RJz4vlxRncrYGHOuOyo2WGakUbKNAetsH6MdUfzqakBEa69HiezR6Z
         00Ek36sVzAA2YtpP7QK+Y0mZMgnc1G1eEpxvlKBRev+8sXtYOR8B81ocKAH6Yv5ZtJ
         NceLIecmQ8Eny/5Ea7Ka1IgYhH2Qm+hYGLMN2025cEBKvk1uVKUbhhV5x2tpZeYwkd
         L/ynGBW33BV2ZfxQs+3OUWF7eZAVRlVMjpI3BxU0Ys+ec7yy2KQXd5cdldgfDDtjGt
         H0v6PzTif9NlSdev+/t1HVsonh5kNx+ILTrOMVoPDwVY6/BvoyYVCKBfmHhGbKmQGw
         1+RB2S4DuyP+A==
Received: by mail-vs1-f43.google.com with SMTP id g3so8593889vsr.10;
        Wed, 08 Feb 2023 05:53:38 -0800 (PST)
X-Gm-Message-State: AO0yUKWvg4eJPUY+pQmpgTpAYJC7D3kn9ivmi3ZYqAPrEZrXCEDzEI56
        20B/MZr6j4JQiJRyFCoNObCVlivpQzXBXbUVzg==
X-Google-Smtp-Source: AK7set+ImJrDNogmqu8sQhEjSEmDyYaksK4p7FJ2BBdAAXBshp9GrzyjMw/MJkaeHGApQp62+gUCL3AP6J6XeAKbu2w=
X-Received: by 2002:a67:cc1d:0:b0:3f3:5ce0:85ab with SMTP id
 q29-20020a67cc1d000000b003f35ce085abmr2344443vsl.26.1675864417722; Wed, 08
 Feb 2023 05:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com> <20230208111645.3863534-2-mmaddireddy@nvidia.com>
In-Reply-To: <20230208111645.3863534-2-mmaddireddy@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Feb 2023 07:53:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJtx+AMFC6SRUEVEgLbiWqv=Ov2cN=oqofZhqvtd1c8vQ@mail.gmail.com>
Message-ID: <CAL_JsqJtx+AMFC6SRUEVEgLbiWqv=Ov2cN=oqofZhqvtd1c8vQ@mail.gmail.com>
Subject: Re: [RFC,v14 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq
 and PCI irq
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 8, 2023 at 5:17 AM Manikanta Maddireddy
<mmaddireddy@nvidia.com> wrote:
>
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> Add device tree support to pass PCIe WAKE# pin information to PCI core
> driver. To support PCIe WAKE# and PCI irqs, add definition of the optional
> properties "interrupts" and "interrupt-names". These properties should be
> defined by the PCIe port to which wake capable Endpoint is connected,
> so the definition is added under "PCI-PCI Bridge properties" section.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I did? 5 years ago it seems. Times change and evolve. Don't add to
pci.txt. This must be a schema now. PCI schema lives in dtschema.

Rob
