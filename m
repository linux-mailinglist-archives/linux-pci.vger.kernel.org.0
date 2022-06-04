Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682D253D403
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jun 2022 02:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbiFDAHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFDAHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 20:07:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA413F62
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 17:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FD20B82504
        for <linux-pci@vger.kernel.org>; Sat,  4 Jun 2022 00:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92416C385A9;
        Sat,  4 Jun 2022 00:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654301234;
        bh=5Xi9zd2YjII8DzjrTwlagHX4OFYRSglPRHB6VASJ1fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SblEr/wquSAkcrJ/ALxmGWdLNmNUaVcHiTtnrNnMSwTrwNl6KbyC/lv5skAtkvXhH
         Fdz6KjcBRpckzEP8WcTtY33VDNcvUaTf5RJx2VvXRaYEYV8npPLc26ohUwksPkhIUT
         +zJGyWRs3jcR/SY2ngSbUIf0FEc7emkhQ+aYCU7sI8/t9p8Hb/wQARYg7w3e7QM5pC
         HRxQp8dZNBHpGGUbOpsK3JTjFgpm4Mx2ul5uERQS0tm4mroM4CmSgEK+xG8NABKvkH
         yafwApFR8b5DvLcW3rp57zerH56vjDD3Hpvr43fZ41stHC2V0i+7mP/MIp2YFVd0kN
         VCcHewuf+6EPg==
Date:   Fri, 3 Jun 2022 19:07:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Message-ID: <20220604000712.GA118018@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f336dd51-a6f2-4168-9e4b-1a6dc3d7da6a@www.fastmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 11:57:47PM +0100, Jiaxun Yang wrote:
> 在2022年6月2日六月 下午5:20，Bjorn Helgaas写道：.
> >
> > I'd really like to have a single implementation of whatever quirk
> > works around this.  I don't think we should have multiple copies
> > just because we assume some firmware takes care of part of this
> > for us.
> >
> Yeah that was my idea when I was writing the present version of
> workaround.  However in later LS7A revisions Loongson somehow raised
> MRRS for several PCIe controllers on chip to 1024 and other ports
> remains to be 256. Kernel have no way to aware of this change and we
> can only rely on firmware to set proper value.

That's fine; we need a controller-specific way to find the limit
(whether it's fixed for all versions or discovered from firmware
settings or whatever).

My hope is that given that controller-specific value, we can have a
single quirk that works on keystone, loongson, etc. to enforce the
limit on all relevant devices.  Some platform firmware might do that
configuration already, but it's OK if a generic quirk re-does it.

I don't think it's worth having two quirks, one that does the
configuration, and another that relies on firmware having done it.

> I have no idea how Loongson achieved this in hardware. All those
> PCIe controllers are attached under the same AXI bus should share
> the same AXI to HyperTransport bridge as AXI slave behind a bus
> matrix. Perhaps instead of fixing error handling of their AXI
> protocol implementation they just increased the buffer size in AXI
> bridge so it can accomplish larger requests at one time.

> >> In keystone’s case it’s likely that their firmware won’t do such thing, so
> >> their workaround shouldn’t be removed.
> >> And  no_inc_mrrs should be set for them to prevent device drivers modifying
> >> MRRS afterwards.
> >
> > I have the vague impression that this issue is related to an arm64 AXI
> > bus property [2] or maybe a DesignWare controller property [3], so
> > this might affect several PCIe controller drivers.
>
> In my understanding it’s likely to be a AXI implementation issue.

I know almost nothing about AXI, but this concerns me because it
sounds like other drivers could be affected.

Bjorn
