Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2A11A2FA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 04:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKD0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 22:26:22 -0500
Received: from mx.socionext.com ([202.248.49.38]:46298 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKD0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 22:26:22 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Dec 2019 12:26:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 19871603AB;
        Wed, 11 Dec 2019 12:26:21 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 11 Dec 2019 12:26:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 8879F4034C;
        Wed, 11 Dec 2019 12:26:20 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6B65512044A;
        Wed, 11 Dec 2019 12:26:20 +0900 (JST)
Date:   Wed, 11 Dec 2019 12:26:20 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: endpoint: Fix clearing start entry in configfs
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <1568282211-24713-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1568282211-24713-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20191211122620.F5A9.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Is there any comments about this?
I think this fix needs to stop and restart endpoint controller
using configfs 'logically' at least.

Thank you,

On Thu, 12 Sep 2019 18:56:51 +0900 <hayashi.kunihiko@socionext.com> wrote:

> The value of 'start' entry is no change whenever writing 0 to configfs.
> So the endpoint that stopped once can't restart.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> Since the possibility of restarting endpoint is up to each controller,
> if restart is prohibited on purpose for some reason, this patch can be
> ignored.
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d1288a0..4fead88 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
>  
>  	if (!start) {
>  		pci_epc_stop(epc);
> +		epc_group->start = 0;
>  		return len;
>  	}
>  
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi

