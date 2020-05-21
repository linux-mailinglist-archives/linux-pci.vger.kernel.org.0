Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C91DCB09
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEUK3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 06:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgEUK3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 06:29:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7774020721;
        Thu, 21 May 2020 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590056963;
        bh=1XPt6kD9iV7o2QBCozeLJ0Q2mmcvZqvbc2tntrfdIJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y246nv7zF5d7co4yRlK1N6muY6PEDZel/9PbdIwVyfa9s8yNWkkbSYEmCXDDHb58M
         OaUrpHlm3WhIQ/Q8dnyYsFS2GHrihtNqvyuYMfN3P9IgBigrBQMpsXYJo+boBgW9ib
         I7M6vSvkn7i2VZb8g5eCwf0NwOH0Sedc6cpmqgcY=
Date:   Thu, 21 May 2020 11:29:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Message-ID: <20200521102917.GD5360@willie-the-truck>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
 <20200520152201.3309416-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520152201.3309416-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 05:22:02PM +0200, Jean-Philippe Brucker wrote:
> The new pci_ats_supported() function checks if a device supports ATS and
> is allowed to use it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
