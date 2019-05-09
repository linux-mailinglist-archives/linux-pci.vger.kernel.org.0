Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948F118B47
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEIOMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfEIOMm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:12:42 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC7C2085A;
        Thu,  9 May 2019 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411161;
        bh=gvXtCwB0sLdrpt5goC5N5snphtui02QgZflWutuvxYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8Cm60yZvIcQo+buFJ5EdbA/DOIxuuSxZIrEx1Q1iwB3KNptgpqKfLr2ot/qAwKN2
         2RHmLiDfnuJywOuNzxA96yC/TC1gsyNpvWbVCp+Hq4Q6FTYDA0+Frw0RI8LazilqaW
         nu7sj+DjlZls42Kad5oqlFclWRYZTxat/+YKL+ZA=
Date:   Thu, 9 May 2019 09:12:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 4/9] PCI/LINK: Prefix dmesg logs with PCIe service name
Message-ID: <20190509141240.GB88424@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-5-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-5-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:41PM -0500, Frederick Lawler wrote:
> bw_notification.c currently does not have any dmesg logs. As the
> service continues to expand in functionality, prefix logs anyways.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/bw_notification.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index d2eae3b7cc0f..a4bb90562cd5 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -14,6 +14,8 @@
>   * and warns when links become degraded in operation.
>   */
>  
> +#define dev_fmt(fmt) "BWN: " fmt

I think I'd drop this patch until it's needed.

>  #include "../pci.h"
>  #include "portdrv.h"
>  
> -- 
> 2.17.1
> 
