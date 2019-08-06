Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA583A8D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfHFUpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 16:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfHFUpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 16:45:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D842070D;
        Tue,  6 Aug 2019 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565124305;
        bh=Ept2ZE2dVwxnUGPdGoCKGowF3bDyqrktzsllLK2gBD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXiccCYuqzw66vSLT3do0yUVHYuGlr1lXPc479R1C5dFZz2zEC8fPWecjQyvIUdKj
         R/lUV2cP36LPYgP9mHNQVAtrlSA7B/omXWM2GqI8PBM+0nGCD9385btAAj1wlP5ecO
         /Rul5pBy72XWo+6py72K0J/ypK4ipD7Vz8WRawBU=
Date:   Tue, 6 Aug 2019 15:45:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: use PCI_SRIOV_NUM_BARS in loops instead of
 PCI_IOV_RESOURCE_END
Message-ID: <20190806204502.GU151852@google.com>
References: <20190806140715.19847-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806140715.19847-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 05:07:15PM +0300, Denis Efremov wrote:
> It's a general pattern to write loops with 'i < PCI_SRIOV_NUM_BARS'
> condition. This patch fixes remaining loops which violates this implicit
> agreement.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied with Kuppuswamy's reviewed-by to pci/misc for v5.4, thanks!

> ---
>  drivers/pci/iov.c       | 4 ++--
>  drivers/pci/setup-bus.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 525fd3f272b3..9b48818ced01 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -557,8 +557,8 @@ static void sriov_restore_state(struct pci_dev *dev)
>  	ctrl |= iov->ctrl & PCI_SRIOV_CTRL_ARI;
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
>  
> -	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++)
> -		pci_update_resource(dev, i);
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> +		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>  
>  	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>  	pci_iov_set_numvfs(dev, iov->num_VFs);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1fa6519be..e7dbe21705ba 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1662,8 +1662,8 @@ static int iov_resources_unassigned(struct pci_dev *dev, void *data)
>  	int i;
>  	bool *unassigned = data;
>  
> -	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> -		struct resource *r = &dev->resource[i];
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		struct resource *r = &dev->resource[i + PCI_IOV_RESOURCES];
>  		struct pci_bus_region region;
>  
>  		/* Not assigned or rejected by kernel? */
> -- 
> 2.21.0
> 
