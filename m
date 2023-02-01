Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE6686E83
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjBAS6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 13:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjBAS6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 13:58:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA11113D8
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 10:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE354B8227B
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42BC433EF;
        Wed,  1 Feb 2023 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675277878;
        bh=gfRulSagIlW3TrSRXkarJS9aisxQRtM0EMn6g5+F1JI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J6jduH6JBMUUXD7HVdovlW8AAc1AXOG+nizYtiFBOQQwc/RgeihkjLvNlZ1XWDDrU
         bfimnshZfTZpNQ8CI8BDX9rdVunICs0GZAaWmM0YNin4TkVKVlSZolAf0eFxnecviC
         QY1LsX19slgRSFOoY0uQHVAyuiW1JcfH9WTWf0TZd/5Cq8AKwMJONi7la5NN1EoFf3
         g+OOQ+JF/kMxeLB8h6uzxc+QVVek59K/X/lj7aruTeqlSfmfHIgjpMvwrCRLsALh+X
         OPM4HiPNZh98jiU+8YwmNTXfbZ81qf/9VlZUgqoZWBYU6fvHZxj7t0NSt2ckqOxvs1
         +fLn2s5/qXj2A==
Date:   Wed, 1 Feb 2023 12:57:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH V4 0/2] PCI: Resolve Loongson's LS7A PCI problems
Message-ID: <20230201185756.GA1882554@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201043018.778499-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 12:30:16PM +0800, Huacai Chen wrote:
> This patchset attempt to resolves Loongson's LS7A PCI problems: the
> first patch remove pci_disable_device() in pcie_portdrv_remove() to
> avoid poweroff/reboot failure; the second patch improves the mrrs quirk
> for LS7A chipset; 
> 
> V1 -> V2:
> 1, Update commit messages and comments.
> 
> V2 -> V3:
> 1, Simply remove pci_disable_device() in pcie_port_device_remove() to
>    solve poweroff/reboot failure.
> 2, Update commit messages and comments.
> 
> V3 -> V4:
> 1, Just remove pci_disable_device() in pcie_portdrv_shutdown() and keep
>    pcie_portdrv_remove() be the same logic as before.
> 
> Huacai Chen, Tiezhu Yang and Jianmin Lv(2):
>  PCI: Omit pci_disable_device() in .shutdown().
>  PCI: loongson: Improve the MRRS quirk for LS7A.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

I applied both to pci/enumeration for v6.3, thanks!

I added a diagnostic message in pcie_set_readq() and reworked the
commit logs, so take a look and make sure I didn't mess it up:

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/log/?h=pci/enumeration&id=8b3517f88ff2
