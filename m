Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C46F3B8B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfKGWhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 17:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfKGWhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 17:37:33 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F4E21D6C;
        Thu,  7 Nov 2019 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573166252;
        bh=BV0iYE2pK8z5Zm2oLyWaaY+OMKD3bbWq6DTnhzbiVfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVT9eiNGkd2sRLfVTRPveLQ3v4LoyGnnjO5molzcmSrWEs3GItbEsuT4/Kvj4np7+
         Eufdd32J2R030mIgLVp/4PRh2HZ+bj4Ul/t8yVO+g9COSCGleDQHkMC3xIy1UULfqP
         n+GB8nzfjxj/I82FFm0iUlHCK0FTrnY+VILSbSpo=
Date:   Fri, 8 Nov 2019 07:37:26 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191107223726.GA23651@redsun51.ssa.fujisawa.hgst.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
> No functional changes implied.

[snip] 

> -	while (true) {
> +	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  		if (slot_status == (u16) ~0) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
> @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  						   PCI_EXP_SLTSTA_CC);
>  			return 1;
>  		}
> -		if (timeout < 0)
> -			break;
>  		msleep(10);
>  		timeout -= 10;
> -	}
> +	} while (timeout > 0);
>  	return 0;	/* timeout */
>  }

If you really want to ensure no funcitonal change, I think the end of
the loop needs to be 'while (timeout >= 0);'
