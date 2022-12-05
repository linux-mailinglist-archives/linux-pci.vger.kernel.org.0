Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB515642CBF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLEQ0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiLEQ0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 11:26:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3FE1DF12;
        Mon,  5 Dec 2022 08:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A742AB81144;
        Mon,  5 Dec 2022 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690BC433D6;
        Mon,  5 Dec 2022 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670257566;
        bh=IXjbw3od9RX52LgJlY0q/QMMPB1bl3URr+bdkX9l9ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABcF1w6j4l/W2nE40FUo6h9qxYW5EDKXgluAYok40DSQsdXi8xaBnr1imFdy7ZG6x
         1Lu4aT39+UBc6krnJv3sC7WLYewF66c5sz+wdVkF4Xbf9uTgtNqZoYVW52U864zwXr
         tTRpbqUMZITFNlCkfCI7l+qztQfbhGZdQgU+K2nMYChHUnlTrQ0GyEV4HCnxUL3t8g
         9bkyOVFkvrvAzEsSLEwm//ICLlWBtO2QMH/ABI0faCHHGkj5QrkXpyl8q7JeS/i2Mh
         bdabqDHQ6IwfKOZAxqmY4jaZqWHNHJ5fBbX2K9EhVWPLzOkj1XNTQc86BGEHAATWEx
         9n+ANSlx+PACQ==
Date:   Mon, 5 Dec 2022 17:26:00 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mt7621: add sentinel to quirks table
Message-ID: <Y44bmGfgEJNd8VhK@lpieralisi>
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
 <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Always capitalize the sentence in the subject.

"PCI: mt7621: Add sentinel to quirks table"

On Sat, Nov 05, 2022 at 06:52:42AM +1000, John Thomson wrote:
> With mt7621 soc_dev_attr fixed to register the soc as a device,
> kernel will experience an oops in soc_device_match_attr

Can we reword this please ? What you are describing *exposes* the
bug but it is not describing the bug per-se.

The bug is related to a missing sentinel in the struct
soc_device_attribute array and that's true regardless of whether it is
actually triggered or not.

Please update the commit log promptly and I shall send it upstream.

Thanks,
Lorenzo

> This quirk test was introduced in the staging driver in
> commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'"), and the staging driver was moved in
> commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
> controller driver") for the 5.16 kernel
> 
> Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 4bd1abf26008..ee7aad09d627 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct pci_host_bridge *host)
>  }
>  
>  static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
> -	{ .soc_id = "mt7621", .revision = "E2" }
> +	{ .soc_id = "mt7621", .revision = "E2" },
> +	{ /* sentinel */ }
>  };
>  
>  static int mt7621_pcie_probe(struct platform_device *pdev)
> -- 
> 2.37.2
> 
