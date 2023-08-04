Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B657702AC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHDOMR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjHDOMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 10:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07B358D;
        Fri,  4 Aug 2023 07:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB3562034;
        Fri,  4 Aug 2023 14:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F0FC433C8;
        Fri,  4 Aug 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691158332;
        bh=9m8AC+bsdBEd4+3Ct67I+iUT7kNtSSnWTLcE0cxGOh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vxuq8GcfU8CbW82M1aPE6KQUpdVQFhf1egy51e7jMh1jToGCYvtjif15Xo0Mj4wQg
         ijFSau1X9QiJ9uMAzVFonWEc/qIGnjHv3rpWYvFD1OuJecIAk5YuG9uIUGEIT4dldz
         mPLImK4uTj2W6cn5rB83oa7IzkzIvIlhbcMDFS31aPlQi9n99QtjZUv2fSvv8gSZyM
         NTWI6KkiXZ4e3jlznydwzqkDrlvPnaigvKdiQWa60AupQoHoquFuDPG53u9C6G0t5N
         z2Wzfvvrc+QcF0dqdMlil02Iww5rIof7INw3rbmTPO/OYV0x0VAbRxgc8CQ7wpE15h
         XAV0+XY8wDW3Q==
Date:   Fri, 4 Aug 2023 16:12:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 pci/net 0/3] Fix ENETC probing after 6fffbc7ae137
 ("PCI: Honor firmware's device disabled status")
Message-ID: <ZM0HNv8kxMIcjXst@kernel.org>
References: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 04:58:55PM +0300, Vladimir Oltean wrote:
> I'm not sure who should take this patch set (net maintainers or PCI
> maintainers). Everyone could pick up just their part, and that would
> work (no compile time dependencies). However, the entire series needs
> ACK from both sides and Rob for sure.
> 
> v1 at:
> https://lore.kernel.org/netdev/20230521115141.2384444-1-vladimir.oltean@nxp.com/
> 
> Vladimir Oltean (3):
>   PCI: move OF status = "disabled" detection to dev->match_driver
>   net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
>   net: enetc: remove of_device_is_available() handling

FWIIW, this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

