Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABE20363A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 13:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgFVLxx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgFVLxw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 07:53:52 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A53C061794;
        Mon, 22 Jun 2020 04:53:52 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AA30A36B; Mon, 22 Jun 2020 13:53:49 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:53:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200622115347.GG3701@8bytes.org>
References: <20200528073344.GO5221@8bytes.org>
 <20200601174104.GA734973@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601174104.GA734973@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 01, 2020 at 12:41:04PM -0500, Bjorn Helgaas wrote:
> I found this [1] from Paul Menzel, which was a slowdown caused by
> quirk_usb_early_handoff().  I think the real problem is individual
> quirks that take a long time.
> 
> The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
> course, they're only run for matching devices anyway.  So I'd rather
> keep them as PCI_FIXUP_FINAL than add a whole new phase.

Okay, so if it is not a performance problem, then I am fine with using
PCI_FIXUP_FINAL. But I dislike calling the fixups from IOMMU code, there
must be a better solution.


Regards,

	Joerg

> [1] https://lore.kernel.org/linux-pci/b1533fd5-1fae-7256-9597-36d3d5de9d2a@molgen.mpg.de/
