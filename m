Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E4625CD7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiKKOVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiKKOVb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:21:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD23391F8;
        Fri, 11 Nov 2022 06:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B3461FE2;
        Fri, 11 Nov 2022 14:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C0C433D6;
        Fri, 11 Nov 2022 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668175925;
        bh=WAd2AYa8S4taz0elUVTwqEBq+wYIB9mqbkD9M3zK2u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6Huf1RI0OOaM1olOX7NVqvOguysOcK98u/zds/K81EFra/5WrvbzAX/bPkLv1toQ
         xVSVf9vhf/RX39Z0olTzjxGuzNQFg14t5FMj/Z+WGJMadaCWnxODNkFnxD+ByPw1Ko
         17QKR9+A1fKQmURaxLCM23yno/O1blfEHCOxwK3gw0tEn5K7SUDiEGTtBslmoDPfU0
         W3Vy7GfuxXUq4bzoF6k2sYN9OTxh1ehALTAflJNa5OM28aQ+sAOX3mpoUXJf5pfFpu
         aBlgDA+7vDvHzto9QHhLIOByO0iKLMnnIOcbm75MadCqKzYNdbRvg/z1x49z7/71nN
         ayn9HPu4483ZA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
Date:   Fri, 11 Nov 2022 15:11:57 +0100
Message-Id: <166817589315.218084.10094910873903826248.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815025006.48167-1-mie@igel.co.jp>
References: <20220815025006.48167-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Aug 2022 11:50:06 +0900, Shunsuke Mie wrote:
> Change to follow the Kconfig style guide. This patch fixes to use tab
> rather than space to indent, while help text is indented an additional
> two spaces.
> 
> 

Applied to pci/misc, thanks!

[1/1] PCI: endpoint: fix Kconfig indent style
      https://git.kernel.org/lpieralisi/pci/c/2759ddf7535d

Thanks,
Lorenzo
