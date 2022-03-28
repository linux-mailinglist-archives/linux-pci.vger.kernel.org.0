Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725D24E9F2D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiC1Sxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbiC1Sxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 14:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA359644DD;
        Mon, 28 Mar 2022 11:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C526121C;
        Mon, 28 Mar 2022 18:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD98C004DD;
        Mon, 28 Mar 2022 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648493528;
        bh=u5yZg0ynUEhZ3+K56tIjbNb4wQz9q4pZXSSN0Va1QRM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dHuq3HQI76JS7or/PSye/mbCBLHhmsQ8iHfU2Iz1h9HijDrIAaghYkjPOwwyBQWGB
         h+BarIKxRpEDThmdQC9RYTThbn+QRn0B6XcmPQaO4RpXu8g0TQdOc8mF5CYRSNcPEu
         vu9LEJpmPd0SQA7PptXC0rnZvaMJF+Gfp2DHy4Z/RTyoYfHhLGj4Ww9H512tGipZNI
         slfAMUq/f7bP6OmJOIgfN/nQKdUP7D4Ep0KIV4vgPU1H9hfxrjgjZSWdeU8Jx2SqL8
         ee9Jksk8v4rGeeXyf0c+vhPmjhMJcqEF4HqJmmRsgvnLilEOoL4ZoDXF2kUkQUczNe
         //KVxsqiYnTRg==
Message-ID: <35d98937-40cb-7f57-ab53-49153aa5ce7d@kernel.org>
Date:   Mon, 28 Mar 2022 20:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
References: <CGME20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe@epcms2p1>
 <20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe@epcms2p1>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe@epcms2p1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 04:14, 이왕석 wrote:
> Add support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> This is based on arm64 and support GEN4 & 2lane.
> This PCIe controller is based on DesignWare Hardware core
> and uses DesignWare core functions to implement the driver.
> This is based on driver/pci/controller/dwc/pci-exynos.c
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  31 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-artpec8.c | 912 ++++++++++++++++++++++++++++++
>  3 files changed, 944 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
> 

I took a look at the your driver and at existing PCIe Exynos driver.
Unfortunately PCIe Exynos driver is in poor shape, really poor. This
would explain that maybe it's better to have new driver instead of
merging them, especially that hardware is different. Although I am still
waiting for some description of these differences...

I said that Exynos PCIe looks poor... but what is worse, it looks like
you based on it so you copied or some bad patterns it had.

Except this the driver has several coding style issues, so please be
sure to run checkpatch, sparse and smatch before sending it.

Please work on this driver to make it close to Linux coding style, so
there will be no need for us, reviewers, focus on basic stuff.

Optionally, send all this to staging. :)

Best regards,
Krzysztof
