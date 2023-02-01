Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5574685E14
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 04:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBADmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 22:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBADmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 22:42:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088534017
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 19:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25AF4CE203D
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 03:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8F4C433EF;
        Wed,  1 Feb 2023 03:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675222960;
        bh=5OoDBwcMsk1LOgtZ3RQTgi/v+8CiPb2TdgY0y/tCVjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TCNaUuVo1DqV+CIHi9VuTIvNXGZIfbJa6IuWKTONbYe3pbrZUUZsZZ9pSnWppyWER
         QademlRNHY3TZB5Ym22sExpk6LfZ2m4THWJJ4b/EdUsBuaE26L2HHLF40jrC6Kw7tJ
         egksPjsmisQUJuCGYubcevr2DNhrsJQQVAIlqUeOEX5zLF9Ernp+9IlnwHGxmAZ59c
         7Gq9/kTsP+xb9Neo3U5hMa4WrM4pggx8ndhUbYLZ3mXRx0QAvcbfDQ1cwXUCA+nKSS
         BoHYq+xtspMGMmaA0GZ5OILkOa94eaKjw7T578uYiLc69iJlKdJh7+U1JenQvD+OTL
         fI4bC4aw9652A==
Date:   Tue, 31 Jan 2023 21:42:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 1/2] PCI: Omit pci_disable_device() in
 pcie_port_device_remove()
Message-ID: <20230201034238.GA1824609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201023803.660469-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 10:38:02AM +0800, Huacai Chen wrote:
> This patch has a long story.

Understatement of the year :)

> @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);

Interesting.  What I had in mind was keeping the original
pcie_port_device_remove() unchanged, adding the new
pcie_portdrv_shutdown(), and omitting pci_disable_device() just from 
pcie_portdrv_shutdown().

I haven't thought about the implications of omitting
pci_disable_device() from the .remove() method
(pcie_port_device_remove()).

Just pointing this out quickly before going to bed in case you have a
chance to think about what's the best strategy :)

Bjorn
