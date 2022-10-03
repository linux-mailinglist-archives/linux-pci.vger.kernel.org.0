Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7265F3415
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJCREY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCREX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 13:04:23 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C5232;
        Mon,  3 Oct 2022 10:04:22 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so7152504ooo.8;
        Mon, 03 Oct 2022 10:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NYr0VC06lbXqd7qj91DzV9j6nlyBOPrH0yPGaMJiNAo=;
        b=OkZUAlWiFdLfEI29pSOosCdXnU8AUCKz+37py/hx0nBAOif+K+X53OQDXkz4cVNMTf
         0/fQ/ye9Z7zVppAN/vzutguRji61gzgg+5l9f1vqQA/ItQ9Y+bbB3yoEeLgemjwgqLu2
         hPDGWOa73pm/nqM4UGGnY978bBMlLIjlXOS2cMZdX3xkcf9UKDwgqMK2ERPKU/XIZ6NY
         /Hi3ga/gq98ByTXYj4/nUevFDWKnC2PIOroBG0FCgJlpnML6skjhenfkBM6dUQdsuSF8
         F84XhIFjUIFOWBiORhAYfXkprkCuHydTXX38gKl+hyuQKzU9P1MZMeELQW340OYXvN81
         vJeg==
X-Gm-Message-State: ACrzQf0Wl6vpf9ocr01GP5Z5NhNPERUyThBf2jauGJgQb/HJrO2k5t3V
        Lz8bavXBBG/lvevpbp/dogR4UAPTmg==
X-Google-Smtp-Source: AMsMyM7JXErF4kIzwfsf1GByUwBd+bPUdo8gtQ2N/mxv/de4dZ68pQUgbegX7feNH+jTqmjPu0oEOw==
X-Received: by 2002:a4a:80cd:0:b0:44a:dce5:bbc3 with SMTP id a13-20020a4a80cd000000b0044adce5bbc3mr8006380oog.26.1664816662018;
        Mon, 03 Oct 2022 10:04:22 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d20-20020a4aeb94000000b00476995b5f0fsm2155210ooj.9.2022.10.03.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:04:21 -0700 (PDT)
Received: (nullmailer pid 2452606 invoked by uid 1000);
        Mon, 03 Oct 2022 17:04:20 -0000
Date:   Mon, 3 Oct 2022 12:04:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221003170420.GA2450476-robh@kernel.org>
References: <20220930192747.21471-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 01, 2022 at 12:57:43AM +0530, Vidya Sagar wrote:
> To support the Hot-plug feature, PCIe spec has a well-defined model for 
> hardware implementation and software programming interface. There are also
> some architectures/platforms where the Hot-plug feature is implemented in a
> non-standard way and software support for the respective implementations is
> available with the kernel. This patch series attempts to add support for one
> such non-standard way of supporting the Hot-plug feature where a single GPIO
> is used to detect and report the Hot-Plug and Unplug events to the SW.
> The platforms that can use this piece of software need to have GPIO routed
> from the slot to the controller which can indicate the presence/absence of
> the downstream device through its state. This GPIO should also have the
> capability to interrupt the system when the connection/disconnection event
> takes place.
> A GPIO Hot-plug framework is written which looks for a "hotplug-gpios" named
> GPIO entry in the corresponding device-tree entry of the controller and
> registers a hot-pluggable slot with the Hot-plug framework.
> The platform drivers of the PCIe host bridges/root ports can register with the
> aforementioned GPIO Hot-Plug framework along with ops to perform any platform
> specific tasks during Hot-Plug/Unplug events.
> 
> Oza Pawandeep made an attempt to upstream support for a similar Hot-plug
> feature implementation at a platform level, but the implementation as such
> was very specific to that platform (at least the way I understood it).
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-2-git-send-email-oza.oza@broadcom.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-3-git-send-email-oza.oza@broadcom.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-4-git-send-email-oza.oza@broadcom.com/
> This current series also attempts to address that by extracting out all the
> common code to do with GPIO and Hot-plug core framework and expecting the
> platform drivers to only register/unregister with the GPIO framework. So,
> @Oza, could you try using the GPIO framework from this series and enable
> Hot-plug support for your platform if it still makes sense?
> 
> @Rob,
> Regarding the DT documentation change to add about 'hotplug-gpios, I'm not
> sure if pci.txt is the right place or the dt-schema repository
> i.e https://github.com/devicetree-org/dt-schema
> But, in the interest of keeping all the changes related to this feature in the
> the same repository, I made the changes to the pci.txt file in this repo itself.
> Please let me know if the documentation change needs to be moved to the other
> repo.

Nothing should be added to pci.txt. So yes, dt-schema is where this 
needs to end up.

Rob
