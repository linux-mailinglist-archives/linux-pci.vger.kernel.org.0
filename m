Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E42B9BBF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 20:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKST4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 14:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgKST4c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 14:56:32 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9769A2224D;
        Thu, 19 Nov 2020 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605815791;
        bh=dErbzcv3kR/xdYe7GVFdgHBkg9LK5dXcA6T+ijj9rpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TEfH60p0Hoyo86weK5rZ40gatR1l75RDcEo4vHtLLB3HMBxlfkKgPZwEzOksVgO46
         7NEmA0LUJcJXHiW0lkkze/LC0T6pjP4AZhHqEMXkVSla1iWQGqjLjkk3drwcDJjd+5
         fxJLxsr8yFh1REeVzfQCLX4y9OLBVFVDzF27ekKg=
Date:   Thu, 19 Nov 2020 13:56:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com
Subject: Re: [v4,3/3] MAINTAINERS: update entry for MediaTek PCIe controller
Message-ID: <20201119195630.GA197187@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118082935.26828-4-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow the convention and include more information in the subject,
e.g.,

  MAINTAINERS: Add Jianjun Wang as MediaTek PCI co-maintainer

On Wed, Nov 18, 2020 at 04:29:35PM +0800, Jianjun Wang wrote:
> Add maintainer for MediaTek PCIe controller driver.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..5c6110468526 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13459,6 +13459,7 @@ F:	drivers/pci/controller/dwc/pcie-histb.c
>  
>  PCIE DRIVER FOR MEDIATEK
>  M:	Ryder Lee <ryder.lee@mediatek.com>
> +M:	Jianjun Wang <jianjun.wang@mediatek.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-mediatek@lists.infradead.org
>  S:	Supported
> -- 
> 2.25.1
> 
