Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA283DCCC2
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhHAQzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 12:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhHAQzS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Aug 2021 12:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC51B60EE9;
        Sun,  1 Aug 2021 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627836910;
        bh=t0F14vvjAbS4suu+eRLbQ6noEGxXjuGG6u4ukmGqh6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRK5hsfv4Q6r3RUtHh4pyi4copIhvH6jbUo5DSq6T6Ki2cDN6SxK9S/xOYMw5HuM4
         yXX7ca6ZtTailRC+RpMXG5ZEt8ZahdFo0mKdP3q48ALNXSu3saxQcfEAAJzS8uudaC
         Zw+3lcnySqlv8h4qRplaYL1EPDPLvpK/deQKfpxjcO5B2zpDo311ATs8cG/hXcinJN
         dcE4pVsT34V1p7cRi4/U2tMWfbKhuGT/TNtRAtgVeDQpwGAHmZzZikey+ukHskqV2J
         ND0yrMwcn0S9H1fRddsXUgTIh5vzbDe1YAcgCqrkygDjXh+vGKHdo02c1Oclzy6BJ+
         1YU0FpdD5eLJw==
Date:   Sun, 1 Aug 2021 18:55:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v8 00/11] Add support for Hikey 970 PCIe
Message-ID: <20210801185500.7fbb1849@coco.lan>
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Fri, 30 Jul 2021 11:50:03 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> On this version, the DT bindings were split on a separate patch series:
> 	https://lore.kernel.org/lkml/cover.1627637448.git.mchehab+huawei@kernel.org/
> 
> The patches here should apply cleanly on the top of v5.14-rc1.
> 
> patch1 contains a PHY for Kirin 970 PCIe.
> 
> The remaining patches add support for Kirin 970 at the pcie-kirin driver, and
> add the needed logic to compile it as module and to allow to dynamically
> remove the driver in runtime.
> 
> Tested on HiKey970:
> 
>   # lspci -D -PP
>   0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
>   0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
>   0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)


As a reference, this is HiKey970 with both M.2 and mini-PCIe slots with
devices:

# lspci -D -PP
0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
0000:00:00.0/01:00.0/02:05.0/05:00.0 Network controller: Intel Corporation Centrino Advanced-N + WiMAX 6250 [Kilmer Peak] (rev 5e)
0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

Regards,
Mauro

Thanks,
Mauro
