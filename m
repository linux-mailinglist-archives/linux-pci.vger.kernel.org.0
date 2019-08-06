Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1F83A9A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfHFUsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 16:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfHFUsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 16:48:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA8A20818;
        Tue,  6 Aug 2019 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565124483;
        bh=RXIWyokVY5jFs2cNty8/qR9NmcWvvGUIU49LRtWPjsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0nc9rOMh6f1LbzncBqUH6zKXv/iuHIJJLjKQhhSo1j0VDi7lWFLEz549NJin+0N4
         xOPldoIj1nl1bXaR/UosgFuoHdgbVOu7L0dicdlruXAXjUVjeiLLS1i2/KpC3JlqwT
         4JEYsa/N6iP8bWWh0To5Gqco57+uKpI42OIZWr7U=
Date:   Tue, 6 Aug 2019 15:48:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/pci: PCI_IOV_RESOURCES loop refactoring in
 zpci_map_resources
Message-ID: <20190806204801.GV151852@google.com>
References: <20190806160137.29275-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160137.29275-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patch!

Sebastian may have silently fixed this, but for future reference,

  $ git log --oneline arch/s390/pci/pci.c
  c7ff0e918a7c s390/pci: deal with devices that have no support for MIO instructions
  dcd33b23c9f3 s390/pci: fix assignment of bus resources
  56271303808f s390/pci: add parameter to disable usage of MIO instructions
  71ba41c9b1d9 s390/pci: provide support for MIO instructions
  81deca12c202 s390/pci: move io address mapping code to pci_insn.c
  fbfe07d440f2 s390/pci: add parameter to force floating irqs
  c840927cf5f2 s390/pci: move everything irq related to pci_irq.c
  066ee72aecdc s390/pci: remove unused define
  ...

shows that the typical style there is to start the subject with a verb
so it's an imperative sentence.

On Tue, Aug 06, 2019 at 07:01:37PM +0300, Denis Efremov wrote:
> This patch alters the for loop iteration scheme in zpci_map_resources
> to make it more usual. Thus, the patch generalizes the style for
> PCI_IOV_RESOURCES iteration and improves readability.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  arch/s390/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index b0e3b9a0e488..c7fea9bea8cb 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -431,13 +431,13 @@ static void zpci_map_resources(struct pci_dev *pdev)
>  	}
>  
>  #ifdef CONFIG_PCI_IOV
> -	i = PCI_IOV_RESOURCES;
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		int bar = i + PCI_IOV_RESOURCES;
>  
> -	for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
> -		len = pci_resource_len(pdev, i);
> +		len = pci_resource_len(pdev, bar);
>  		if (!len)
>  			continue;
> -		pdev->resource[i].parent = &iov_res;
> +		pdev->resource[bar].parent = &iov_res;
>  	}
>  #endif
>  }
> -- 
> 2.21.0
> 
