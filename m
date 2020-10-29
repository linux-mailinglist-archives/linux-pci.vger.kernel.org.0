Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C445329F0A6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgJ2P7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 11:59:22 -0400
Received: from verein.lst.de ([213.95.11.211]:49371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgJ2P7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 11:59:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7DE1567373; Thu, 29 Oct 2020 16:59:18 +0100 (CET)
Date:   Thu, 29 Oct 2020 16:59:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Fix 32-bit overflow with CONFIG_ARM_LPAE=n
Message-ID: <20201029155918.GA23872@lst.de>
References: <20201026152755.3738293-1-geert+renesas@glider.be> <20201027075551.GB22487@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027075551.GB22487@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 08:55:51AM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Rob and Frank: do you want to take this through the OF tree, or should
> I queue it up in the dma-mapping tree that caused the problem?

I've picked this up in the dma-mapping tree so that we don't miss
rc2.
