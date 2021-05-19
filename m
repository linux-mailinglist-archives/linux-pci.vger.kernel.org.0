Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A93894C2
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhESRoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhESRoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 13:44:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C85C06175F
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5krfrM4G24fq+W6Q8vJBEQO/S1Gc1aU6HN66wtnDmkc=; b=ICqHKQXMGVeAvsALhJmxCT3nKX
        PCHxS3gXUhvyFIOBzevBfEVpwf2EdTqRtERASLmzF2oItYfcwCjQlf6bHpnlBhtRo9VnlFHel/FcW
        xklbRMI4hAlSbLKBVe2pU1z9QhZMbbnANtbOJPoCXsLmYmaPGbiDn5fWa+O31fvv5WtGOM7kL2mWp
        0ffI95KCuBxFsX7tpLiMfVyNw5z7c86fbFqSFmAZV730tE51Q7hlgcEUUyPBzn3LliR7Zduw8774r
        TcdkECjasUcd1QMDmaUmmvy5ygZOW1Q37hPPx2A4osHpKcxL5jLlxNdHkvhEShpkUVgPjTOUFOVCX
        Aa5eHgQA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljQDU-00FfR9-LZ; Wed, 19 May 2021 17:42:44 +0000
Subject: Re: [PATCH] PCI: iproc: Fix a non-compliant kernel-doc
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210519173556.163360-1-kw@linux.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1c2de58-64bf-75b7-0976-fba906c58273@infradead.org>
Date:   Wed, 19 May 2021 10:42:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519173556.163360-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/19/21 10:35 AM, Krzysztof Wilczyński wrote:
> Correct a non-compliant kernel-doc at the top of the pcie-iproc-mci.c
> file, and resolve build time warning related to kernel-doc:
> 
>   drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index eede4e8f3f75..65ea83d2abfa 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -49,14 +49,14 @@ enum iproc_msi_reg {
>  struct iproc_msi;
>  
>  /**
> - * iProc MSI group
> - *
> - * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
> - * event queue.
> + * struct iproc_msi_grp - iProc MSI group
>   *
>   * @msi: pointer to iProc MSI data
>   * @gic_irq: GIC interrupt
>   * @eq: Event queue number
> + *
> + * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
> + * event queue.
>   */
>  struct iproc_msi_grp {
>  	struct iproc_msi *msi;
> @@ -65,10 +65,7 @@ struct iproc_msi_grp {
>  };
>  
>  /**
> - * iProc event queue based MSI
> - *
> - * Only meant to be used on platforms without MSI support integrated into the
> - * GIC.
> + * struct iproc_msi - iProc event queue based MSI
>   *
>   * @pcie: pointer to iProc PCIe data
>   * @reg_offsets: MSI register offsets
> @@ -89,6 +86,9 @@ struct iproc_msi_grp {
>   * @eq_cpu: pointer to allocated memory region for MSI event queues
>   * @eq_dma: DMA address of MSI event queues
>   * @msi_addr: MSI address
> + *
> + * Only meant to be used on platforms without MSI support integrated into the
> + * GIC.
>   */
>  struct iproc_msi {
>  	struct iproc_pcie *pcie;
> 


-- 
~Randy

