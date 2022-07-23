Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956D57ECDF
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 11:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiGWJFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Jul 2022 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiGWJFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jul 2022 05:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6363D6;
        Sat, 23 Jul 2022 02:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92E360F08;
        Sat, 23 Jul 2022 09:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE9C341C0;
        Sat, 23 Jul 2022 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658567110;
        bh=qyaEZkJAJZmgLW7HETADbLW1hQVlF8cNoPLnBbxZO6s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PGjyWEEoqkcIbM4DWheEeD8YNv2O3srm8nL8L1XKPbzmEmPfbgQHrrgQdG/EBvLBN
         tZ/jC+4JcZ7Pj2cZW6W4Xf1fbENlPvr4i/m88pbRrC0mH+Cyz8D7u1LkSCUmnKHMRL
         d/qF42vksBfgH1rGhVWx40DegVSpUyOxjkSa5HFBFcZhCkh/tn1FAy49MzBGT9IXuJ
         3j72zOVtTOL4Jn7CxlxbZAZ2N6753s0wM02ln+UMBbmVrhJq8hNZ4uX8hYjH3CoHhZ
         6pXNUqk2TdxyASLRiaVHJKOH8ON/V6wBxzrkFnDwfDf92wSOQVEqhl+Rhnks/VThJU
         uSDDWEIWKUX5A==
Received: by pali.im (Postfix)
        id B19E0CDA; Sat, 23 Jul 2022 11:05:06 +0200 (CEST)
Date:   Sat, 23 Jul 2022 11:05:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220723090506.wofibbrrhicvxi4t@pali>
References: <20220710225108.bgedria6igtqpz5l@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220710225108.bgedria6igtqpz5l@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle reminder...

On Monday 11 July 2022 00:51:08 Pali Rohár wrote:
> Hello!
> 
> Together with Mauri we are working on extending pci-mvebu.c driver to
> support Orion PCIe controllers as these controllers are same as mvebu
> controller.
> 
> There is just one big difference: Config space access on Orion is
> different. mvebu uses classic Intel CFC/CF8 registers for indirect
> config space access but Orion has direct memory mapped config space.
> So Orion DTS files need to have this memory range for config space and
> pci-mvebu.c driver have to read this range from DTS and properly map it.
> 
> So my question is: How to properly define config space range in device
> tree file? In which device tree property and in which format? Please
> note that this memory range of config space is PCIe root port specific
> and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> 
> Krzysztof, would you be able to help with proper definition of this
> property, so it would be fine also for schema checkers or other
> automatic testing tools?
