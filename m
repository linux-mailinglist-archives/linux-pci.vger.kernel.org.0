Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0E263B03
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 04:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgIJB60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 21:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgIJBfe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 21:35:34 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F22820BED;
        Thu, 10 Sep 2020 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599701144;
        bh=xZgHaS/AuVVZO8yGCPOPXDcpWyNutVURYRYfQPr7Bss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=txo7aca9vIw5rLwXzQT8UF0NYSKzIfloMTcnJx6ZdTO3R4ZCacyJMggjs+EMAuj6b
         NHpMd135cykYDYK61eWWmBTadSmzFtjzr6hrg/xjia5KhINN0b+kWlnmDm68RC/5FH
         68HZR8LN14yL8kZwA+6ymLjOgMmwi6l4NyKA0CRI=
Date:   Wed, 9 Sep 2020 20:25:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in
 pci_read_config
Message-ID: <20200910012543.GA745909@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824052025.48362-1-benbjiang@tencent.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> From: Jiang Biao <benbjiang@tencent.com>
> 
> pci_read_config() could block several ms in kernel space, mainly
> caused by the while loop to call pci_user_read_config_dword().
> Singel pci_user_read_config_dword() loop could consume 130us+,
>               |    pci_user_read_config_dword() {
>               |      _raw_spin_lock_irq() {
> ! 136.698 us  |        native_queued_spin_lock_slowpath();
> ! 137.582 us  |      }
>               |      pci_read() {
>               |        raw_pci_read() {
>               |          pci_conf1_read() {
>   0.230 us    |            _raw_spin_lock_irqsave();
>   0.035 us    |            _raw_spin_unlock_irqrestore();
>   8.476 us    |          }
>   8.790 us    |        }
>   9.091 us    |      }
> ! 147.263 us  |    }
> and dozens of the loop could consume ms+.
> 
> If we execute some lspci commands concurrently, ms+ scheduling
> latency could be detected.
> 
> Add scheduling chance in the loop to improve the latency.

Thanks for the patch, this makes a lot of sense.

Shouldn't we do the same in pci_write_config()?

> Reported-by: Bin Lai <robinlai@tencent.com>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  drivers/pci/pci-sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d78df9..3b9f63d 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -708,6 +708,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>  		data[off - init_off + 3] = (val >> 24) & 0xff;
>  		off += 4;
>  		size -= 4;
> +		cond_resched();
>  	}
>  
>  	if (size >= 2) {
> -- 
> 1.8.3.1
> 
