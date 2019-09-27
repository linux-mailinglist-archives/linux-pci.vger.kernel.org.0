Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3BBC05E7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfI0NA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 09:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfI0NA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 09:00:28 -0400
Received: from localhost (173-25-179-30.client.mchsi.com [173.25.179.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1986217D9;
        Fri, 27 Sep 2019 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569589227;
        bh=ZRR5GpkwR6Aa/fDKrENAmahjuJ9MmYU6dJrGLK0V3IM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLGDBjTbXzad8oglmmKMJkBY3QdwZGNWEqTeYBha0ElHoxMTT2hrgqjCgjoXZxZNm
         9OEB/HIJx2kyrPpqOTpDvWxP/FHkmbzA5zVt3lgky1adf7UXlzw+kdURO8B0TeJqAo
         4q3SUtGL9Ed/I+iD/QrosE2eIpzuZ9UbjCd+0zPQ=
Date:   Fri, 27 Sep 2019 08:00:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     tiantao6 <tiantao6@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] PCI: vc: fix warning: no previous prototype
Message-ID: <20190927130026.GA40841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568205651-60209-1-git-send-email-tiantao6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 11, 2019 at 08:40:51PM +0800, tiantao6 wrote:
> From: tiantao <tiantao6@huawei.com>
> 
> drivers/pci/vc.c:351:5: warning: no previous prototype for
> pci_save_vc_state [-Wmissing-prototypes]
> int pci_save_vc_state(struct pci_dev *dev)
> 
> drivers/pci/vc.c:388:6: warning: no previous prototype for
> pci_restore_vc_state [-Wmissing-prototypes]
> void pci_restore_vc_state(struct pci_dev *dev)
> 
> drivers/pci/vc.c:412:6: warning: no previous prototype for
> pci_allocate_vc_save_buffers [-Wmissing-prototypes]
> void pci_allocate_vc_save_buffers(struct pci_dev *dev)
> 
> Signed-off-by: Tian Tao <tiantao6@huawei.com>

Thanks, this was fixed incidentally by ca78410403dd ("PCI: Get rid of
dev->has_secondary_link flag").

> ---
>  drivers/pci/vc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index b39e854..111f6d3 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -12,6 +12,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/types.h>
> +#include "pci.h"
>  
>  /**
>   * pci_vc_save_restore_dwords - Save or restore a series of dwords
> -- 
> 2.7.4
> 
