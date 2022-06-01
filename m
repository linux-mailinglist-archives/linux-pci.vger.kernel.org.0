Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC2539B1B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiFACIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 22:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFACIM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 22:08:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B35EBD0
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 19:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEB47B81757
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 02:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE176C385A9;
        Wed,  1 Jun 2022 02:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654049288;
        bh=2Q4oAXD5N4jS78GpmMoVNJY2SjAad85g7c35RBwGihw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f526NKehNYTFY7d7Qj9mi05dsM1y960k+s/LP3MUOU/GuNVciZ+jbI8Z4yKU6vdn6
         /WIFn/ZvYDg8ngtwx9SbmjisvpgNXhZTgyUJWJbD8y9qkOk6RRsTdqNNA9/Yyvc6pk
         dLm9FbbdFjbkkhJMNnrYPG/Wc8lhuSpsqqQ7Lq6rH+j3goftZJaor0inUdNr5DWpnO
         uL5i7pu0kyZdM+HPlxjrZXn6MM9CWSjpxmdibtKOLYlZMc8lxtJZZRz56bB3U+SmGy
         eN2smH2sBM9DXAGY3oGcNT8pxACBn/ndrmp0PJ7bGN6AlmeZkRXG2syffZlB69MeXQ
         OpEZOEf6Tiu9A==
Date:   Tue, 31 May 2022 21:08:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 1/6] PCI: loongson: Use generic 8/16/32-bit config
 ops on LS2K/LS7A
Message-ID: <20220601020806.GA793482@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:41PM +0800, Huacai Chen wrote:
> LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
> we can disable CFG0 for them and safely use pci_generic_config_read()/
> pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> generic_config_write32().
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

After removing cast below,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> @@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  
>  	priv = pci_host_bridge_priv(bridge);
>  	priv->pdev = pdev;
> -	priv->flags = (unsigned long)of_device_get_match_data(dev);
> +	priv->data = (struct loongson_pci_data *)of_device_get_match_data(dev);

No cast needed.
