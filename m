Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2D3F3600
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhHTVYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhHTVYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:24:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E9E61102;
        Fri, 20 Aug 2021 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629494616;
        bh=DR5+xPR+Dm45+yzNiJITr0ADd0H7NeYcn/WPxNjvYO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nzI84HLBvAMPeG1ykv7lSnTwg9HSJGHa+1mQynmTJaod577O5hGIWJczchrW/Yvw9
         gN9mqXq5ATQU/+RGlg4jADIBaJghLKeBa9SzPlCKn5X2ovmVCxYpPwGZISeroKT6S2
         iePXYCOa3jS2jBLMIy/r+DVj+cisYKB5w7ZGUPjimly+FEYXAWojvqZ5/MHS4MjhPj
         deDDIJor6CrRRc/8v30+WoOACy72+QgujSF4YAr8T0nRpYendj+UMZ8j4tvYdaGjok
         CXXenygYORAqV7aUihNT6RUI9RV3oErzqRgT33ka8B6GqScydu+sDb07u7/YHGEX/4
         uBnie7AzOa2YA==
Date:   Fri, 20 Aug 2021 16:23:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bin Lai <robinlai@tencent.com>,
        Jiang Biao <benbjiang@tencent.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Allow scheduling to take place in
 proc_bus_pci_read()
Message-ID: <20210820212334.GA3360706@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210815150824.96773-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 15, 2021 at 03:08:24PM +0000, Krzysztof Wilczyński wrote:
> PCI configuration space reads from the /proc/bus/pci for a particular
> device, depending on the underlying hardware, can often take several
> milliseconds to complete.
> 
> Thus, add a schedule point in proc_bus_pci_read() to reduce the maximum
> latency.
> 
> A similar change has already been completed in the past for the sysfs
> counterpart in the commit 2ce02a864ac1 ("PCI: Add schedule point in
> pci_read_config()").
> 
> Link: https://lore.kernel.org/r/20200824052025.48362-1-benbjiang@tencent.com
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.15, thanks!

I tweaked your subject line to match 2ce02a864ac1:

  PCI: Add schedule point in proc_bus_pci_read()

> ---
>  drivers/pci/proc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index d32fbfc93ea9..cb18f8a13ab6 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -83,6 +83,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  		buf += 4;
>  		pos += 4;
>  		cnt -= 4;
> +		cond_resched();
>  	}
>  
>  	if (cnt >= 2) {
> -- 
> 2.32.0
> 
