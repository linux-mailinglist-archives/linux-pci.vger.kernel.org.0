Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B27434D7A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJTO0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 10:26:10 -0400
Received: from foss.arm.com ([217.140.110.172]:60690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhJTO0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 10:26:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23BA9D6E;
        Wed, 20 Oct 2021 07:23:54 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5132A3F73D;
        Wed, 20 Oct 2021 07:23:52 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@phrozen.org, neil@brown.name, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
Date:   Wed, 20 Oct 2021 15:23:45 +0100
Message-Id: <163473978253.23166.3894301849923362863.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Sep 2021 07:00:32 +0200, Sergio Paracuellos wrote:
> MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> Topology is as follows:
> 
> 
>                           MT7621 PCIe HOST Topology
> 
> [...]

Applied to pci/mt7621, thanks!

[1/3] dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
      https://git.kernel.org/lpieralisi/pci/c/e5bc5605e7
[2/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
      https://git.kernel.org/lpieralisi/pci/c/5797a2b2bc
[3/3] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
      https://git.kernel.org/lpieralisi/pci/c/eb1d7d438c

Thanks,
Lorenzo
