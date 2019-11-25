Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E2109278
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfKYRAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 12:00:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbfKYRAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Nov 2019 12:00:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE04331B;
        Mon, 25 Nov 2019 09:00:38 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64D4E3F68E;
        Mon, 25 Nov 2019 09:00:38 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:00:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Keith from VMD maintainer
Message-ID: <20191125170033.GA30891@e121166-lin.cambridge.arm.com>
References: <20191122162501.27018-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122162501.27018-1-kbusch@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 23, 2019 at 01:25:01AM +0900, Keith Busch wrote:
> I no longer work in this capacity on the VMD driver.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/vmd - now Jon has to put up with me on his own :)

Lorenzo

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4f170d8bc29..064333607feb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12453,7 +12453,6 @@ F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>  F:	drivers/pci/controller/dwc/*imx6*
>  
>  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
> -M:	Keith Busch <keith.busch@intel.com>
>  M:	Jonathan Derrick <jonathan.derrick@intel.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 2.21.0
> 
