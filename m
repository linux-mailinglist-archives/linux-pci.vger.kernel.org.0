Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF43B26E278
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIQRcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIQRca (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 13:32:30 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07192137B;
        Thu, 17 Sep 2020 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600363950;
        bh=FILNgR3grz7ZmaIuphzbDr2tocKVxDkRDNJ9MW8uHO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q1NiPFr0WX2V61U67EWEAEyuEvbVfQ1B0TP8bOtiop0XX1i44JmzvhAYANhZrb6uj
         CJbIex+ECShGfs9IKcfqjZ7N6KXm/2WXG0UwmLFcEcep+q5GiLKIeztbAsdg8SNF3e
         eD1Dtgw+Rwm6iRckSqOLZKg5XKG1IG+Dp3iqqYuo=
Date:   Thu, 17 Sep 2020 12:32:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in
 pci_read_config
Message-ID: <20200917173228.GA1713970@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824052025.48362-1-benbjiang@tencent.com>
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
> 
> Reported-by: Bin Lai <robinlai@tencent.com>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>

Applied to pci/enumeration for v5.10, thanks!

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
