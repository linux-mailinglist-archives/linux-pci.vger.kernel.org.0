Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC6A88FB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfIDOsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 10:48:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfIDOsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 10:48:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA8828;
        Wed,  4 Sep 2019 07:48:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BEEB3F59C;
        Wed,  4 Sep 2019 07:48:44 -0700 (PDT)
Date:   Wed, 4 Sep 2019 15:48:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Propagate errors for optional resources
Message-ID: <20190904144842.GB28184@e121166-lin.cambridge.arm.com>
References: <20190829105319.14836-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829105319.14836-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 29, 2019 at 12:53:13PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> A common pattern exists among several PCI host controller drivers. Some
> of the resources that they support are optional, and the way that the
> drivers handle these resources is by propagating -EPROBE_DEFER and keep
> going without the resource otherwise. However, there can be several
> reasons for failing to obtain a resource (e.g. out of memory). Currently
> all of these reasons will cause the drivers to consider the optional
> resource to not be there. However, if the resource was in fact required
> in the specific case and requesting it failed because of some other
> reason, the drivers would still happily continue and cause potentially
> hard to find problems.
> 
> Instead of rolling all error codes into one, reverse the check and only
> handle -ENODEV as meaning "resource was not specified". Fatal errors in
> that case will cause the driver to fail to probe rather than continuing
> as if nothing had happened.
> 
> Changes in v2:
> - add Rockchip PCI patch which was previously separate
> - addressed Bjorn's comments regarding commit message
> - collected Reviewed-by, Tested-by and Acked-by tags
> 
> Thierry
> 
> Thierry Reding (6):
>   PCI: rockchip: Propagate errors for optional regulators
>   PCI: exynos: Propagate errors for optional PHYs
>   PCI: imx6: Propagate errors for optional regulators
>   PCI: armada8x: Propagate errors for optional PHYs
>   PCI: histb: Propagate errors for optional regulators
>   PCI: iproc: Propagate errors for optional PHYs
> 
>  drivers/pci/controller/dwc/pci-exynos.c      |  2 +-
>  drivers/pci/controller/dwc/pci-imx6.c        |  4 ++--
>  drivers/pci/controller/dwc/pcie-armada8k.c   |  7 +++----
>  drivers/pci/controller/dwc/pcie-histb.c      |  4 ++--
>  drivers/pci/controller/pcie-iproc-platform.c |  9 +++------
>  drivers/pci/controller/pcie-rockchip-host.c  | 16 ++++++++--------
>  6 files changed, 19 insertions(+), 23 deletions(-)

Applied to pci/misc for v5.4, thanks !

Lorenzo
