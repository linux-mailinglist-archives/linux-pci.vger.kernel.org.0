Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCEE26BC53
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPGOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:14:04 -0400
Received: from verein.lst.de ([213.95.11.211]:51030 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIPGOD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 02:14:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3122868B05; Wed, 16 Sep 2020 08:13:59 +0200 (CEST)
Date:   Wed, 16 Sep 2020 08:13:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        arnaud.pouliquen@st.com, loic.pallardy.st.com@lst.de
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200916061359.GA8424@lst.de>
References: <20200914073343.1579578-1-hch@lst.de> <20200914073343.1579578-7-hch@lst.de> <20200914230147.GA3251212@xps15> <20200915054122.GA18079@lst.de> <20200915195501.GA3666944@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915195501.GA3666944@xps15>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 01:55:01PM -0600, Mathieu Poirier wrote:
> That did the trick - the stm32 platform driver's probe() function completes and
> the remote processor is operatinal. 
> 
> That being said the value returned by function dma_to_pfn()
> is 0x137fff in the original code and 0xfffff with your patches applied.

Yes, that is intentional.  The old code just applied the range and got
an out of range offset, the new one reports the max offset.
