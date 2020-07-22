Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6553922987E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgGVMtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 08:48:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB65C0619DC;
        Wed, 22 Jul 2020 05:48:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 682032C8; Wed, 22 Jul 2020 14:48:56 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:48:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] iommu/dma: Avoid SAC address trick for PCIe devices
Message-ID: <20200722124854.GZ27672@8bytes.org>
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
 <d412c292d222eb36469effd338e985f9d9e24cd6.1594207679.git.robin.murphy@arm.com>
 <20200713131426.GQ27672@8bytes.org>
 <ad3f66c8-7772-731d-cd0a-c5d6d46297cb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3f66c8-7772-731d-cd0a-c5d6d46297cb@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 12:42:36PM +0100, Robin Murphy wrote:
> Oh bother - yes, this could have been masking all manner of bugs. That
> system will presumably also break if you managed to exhaust the 32-bit IOVA
> space such that the allocator moved up to the higher range anyway, or if you
> passed the XHCI through to a VM with a sufficiently wacky GPA layout, but I
> guess those are cases that simply nobody's run into yet.
> 
> Does the firmware actually report any upper address constraint such that
> Sebastian's IVRS aperture patches might help?

No, it doesn't. I am not sure what the best way is to get these issues
found and fixed. I doubt they will be getting fixed when the allocation
pattern isn't changed, maybe we can put your changes behind a config
variable and start testing/reporting bugs/etc.

Regards,

	Joerg
