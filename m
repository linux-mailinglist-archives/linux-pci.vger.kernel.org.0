Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE058AAFF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiHEMpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHEMpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 08:45:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8831B79E;
        Fri,  5 Aug 2022 05:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 198CEB82756;
        Fri,  5 Aug 2022 12:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9717CC433D6;
        Fri,  5 Aug 2022 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659703504;
        bh=RpHuoKL2UGBwsxt7NltwOhTg3dkIpbQAwReG+w/GQik=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Rt8dL+9yokv0qzRXJvV+EhXJyDxFvmyvjZlLUObivuaa3KwnemXBk1+k/XJnYgOj5
         i1WDwfl5ila+2jYZODQ4ivs/uxAsTLCqUm2iQLdo6usnQa7vGZdMt4MskyP1OPyoje
         b6FyODP4tyJt2FeHVZpMzKOKjPUs4BBwAaYkwfkdZuAUycPG79AVi6T9zeMPcWky7R
         Fh7ekqXXbFg5Ltz7WyYr7HGYP9MWRVbcoAnPLtAhwc4iJ35G5f44/CMWppcr3JJZ66
         TYyUwSVkysWYr4vYttroAJxIyPk1BkGZBQJYXLCjU7WwxiSaVWL2OVksPxz9vM0inU
         A77YOueJpOzow==
Received: by pali.im (Postfix)
        id 1FF9582D; Fri,  5 Aug 2022 14:45:02 +0200 (CEST)
Date:   Fri, 5 Aug 2022 14:45:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220805124501.t5miqz2pifzb73st@pali>
References: <20220710225108.bgedria6igtqpz5l@pali>
 <20220723090506.wofibbrrhicvxi4t@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220723090506.wofibbrrhicvxi4t@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle reminder...

On Saturday 23 July 2022 11:05:06 Pali Rohár wrote:
> Gentle reminder...
> 
> On Monday 11 July 2022 00:51:08 Pali Rohár wrote:
> > Hello!
> > 
> > Together with Mauri we are working on extending pci-mvebu.c driver to
> > support Orion PCIe controllers as these controllers are same as mvebu
> > controller.
> > 
> > There is just one big difference: Config space access on Orion is
> > different. mvebu uses classic Intel CFC/CF8 registers for indirect
> > config space access but Orion has direct memory mapped config space.
> > So Orion DTS files need to have this memory range for config space and
> > pci-mvebu.c driver have to read this range from DTS and properly map it.
> > 
> > So my question is: How to properly define config space range in device
> > tree file? In which device tree property and in which format? Please
> > note that this memory range of config space is PCIe root port specific
> > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> > 
> > Krzysztof, would you be able to help with proper definition of this
> > property, so it would be fine also for schema checkers or other
> > automatic testing tools?
