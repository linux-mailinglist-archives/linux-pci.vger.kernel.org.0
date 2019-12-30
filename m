Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D330112D091
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfL3OZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 09:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfL3OZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 09:25:59 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCCB206DB;
        Mon, 30 Dec 2019 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577715958;
        bh=F3b85m/vpqlDIFab9PqhwIdF9cMEQxEYRRvy4W2Hhjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iAF+UjrN4Xkt9xxgoKiTyr4ydAzMHqDcU8sNPfPwvDrWE7Sc+Uiivo85X3ry848+w
         RUn86kZialLDvibCD648Ps41HkWP0eJBFp8jan3aGEBPRkuk8Lyk69BRaydNrRWWTB
         6eWA2gUziHFD90GK23xl8ufhyejM1OrWD0YWAIp0=
Date:   Mon, 30 Dec 2019 08:25:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.or, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2] Documentation: PCI: msi-howto.rst: Fix wrong function
 name
Message-ID: <20191230142557.GA188380@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230131428.1200-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 30, 2019 at 09:14:28PM +0800, Zenghui Yu wrote:
> pci_irq_alloc_vectors() -> pci_alloc_irq_vectors().
> 
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Applied to pci/misc for v5.6, thanks!

> ---
> 
> v1 -> v2:
> 	Add Andrew's R-b tag.
> 
>  Documentation/PCI/msi-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index 994cbb660ade..aa2046af69f7 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -283,5 +283,5 @@ or disabled (0).  If 0 is found in any of the msi_bus files belonging
>  to bridges between the PCI root and the device, MSIs are disabled.
>  
>  It is also worth checking the device driver to see whether it supports MSIs.
> -For example, it may contain calls to pci_irq_alloc_vectors() with the
> +For example, it may contain calls to pci_alloc_irq_vectors() with the
>  PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
> -- 
> 2.19.1
> 
> 
