Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7A6870D9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBAWKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 17:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBAWKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 17:10:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4982873755;
        Wed,  1 Feb 2023 14:10:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED0961972;
        Wed,  1 Feb 2023 22:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7D8C433D2;
        Wed,  1 Feb 2023 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675289451;
        bh=KFViytPAQpuSOyz4tKk8cFMgRc5dOd10znyuecgbq7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A66ArSLQp7MJkX/stLQUAejMgTpL2aoozfwWRLcgyf0MV9WO2xS7BA8i6hlBHEWCq
         fcagJEIefiLRzehdVFyLRRNWSedKrovJyik0RD5eHXmDVsj84bSQNrL2NwWt3Q+ML8
         NnLuQGpdbkSzHL/CQw2xA324Om5821CSVYx86+ef4iIgq0pAS1dAl2M6FHE9aRuC15
         lDyQKwoUp9DMDjLzemLNJ/NliDnk5k/P1hy1W6UNF5CoJfdcFiheTn2K6gvtwOZeOt
         6G5CrbzYm8FjIEaRA4ctStHfzGw3rkLfe1epV68m8JKR+XlRBk1jUBZqPUP07saJvJ
         htYxfDTlmJkEg==
Date:   Wed, 1 Feb 2023 16:10:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH V2 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20230201221049.GA1902318@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c58ec0-3cb2-5385-eeac-6ca37b6b1509@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 01:35:16PM +0100, Thorsten Leemhuis wrote:
> Just wondering: what's the status here? This looks stalled.
> 
> I'm asking, as the patches in this thread are supposed to fix this
> regression:
> https://bugzilla.kernel.org/show_bug.cgi?id=216884

#regzbot resolve: [patch 1/2] will fix bz216884, but it is not a regression
