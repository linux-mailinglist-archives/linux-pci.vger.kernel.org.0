Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DF294021
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgJTQDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 12:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgJTQDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 12:03:02 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEC621534;
        Tue, 20 Oct 2020 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603209781;
        bh=oLsjpAWsvX9lEqIdEw4cReNHKVcbecgMUj8JTFgOKcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j01t9UdNehO5PH/noqaa6zZr6RXF+N+ORGyNUoAvGvyWjh1Cj01uxM2JjPUL1UvL0
         ZU1aJRlTQBGhRHINcfJ5bBKWFnemlCSI9/hb2eA7OnTmVvlyc8kUBOH5njWx+aYxBp
         h7x02L5NszTMPy39zJTutyrrsjBW1McDCFrIXZQQ=
Date:   Tue, 20 Oct 2020 11:02:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     trix@redhat.com
Cc:     linus.walleij@linaro.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: remove unneeded break
Message-ID: <20201020160259.GA370179@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019190249.7825-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 12:02:49PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied with Linus' reviewed-by to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/controller/pci-v3-semi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index 1f54334f09f7..154a5398633c 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -658,7 +658,6 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
>  	default:
>  		dev_err(v3->dev, "illegal dma memory chunk size\n");
>  		return -EINVAL;
> -		break;
>  	}
>  	val |= V3_PCI_MAP_M_REG_EN | V3_PCI_MAP_M_ENABLE;
>  	*pci_map = val;
> -- 
> 2.18.1
> 
