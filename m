Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6438994A
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESW3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESW3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 18:29:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF928C061574
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=DennC/wwIRjHkYwhduExeoUmNn4x0McdEgmjFsstdGM=; b=KP000V+5R0FBjW9Gm5AtlaGck5
        RXOdg9oi1Ia+V0QLfdBal35ETsB00NYbv2D1pZFh/IneAUwPY9JTiPCYcsG+aQpEBm88eP/hNAOQj
        w+2Kn8cBOFcHfrTKR5fKbbEw1XayQ7nAET3qdNWaza7zb/hiUFX3nbBLvQMpvh9XwGpA/QdP9yUG0
        FnwR7T4y1WGdosIu7HGCIY0eN9PaQQ7y9EAlGVOnbThzuhXcDRbGpXCKN1nwGducgNgCAwW0zGJDi
        DY5zc/OonT1cFBfVGhRKxXmEfjDl+PrGypSsVsBxeza9whBj9g7erLtEODj3mUpefEo3Uo5lFmJBO
        n2xW2l5Q==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljUg5-00Foxd-69; Wed, 19 May 2021 22:28:33 +0000
Subject: Re: [PATCH v2] PCI: iproc: Fix a non-compliant kernel-doc
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210519183829.165982-1-kw@linux.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3623373c-b95c-344f-63c3-3eeeda623e90@infradead.org>
Date:   Wed, 19 May 2021 15:28:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519183829.165982-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is a really good cleanup, but there is still one kernel-doc
warning remaining after this patch is applied. Please see below.


On 5/19/21 11:38 AM, Krzysztof Wilczyński wrote:
> Correct a non-compliant kernel-doc used to describe struct and enum
> types and functions in the pcie-iproc.c and pcie-iproc-msi.c files, and
> resolve the following build time warning related to kernel-doc:
> 
>   drivers/pci/controller/pcie-iproc.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:153: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:441: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:623: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:901: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
>   drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++--------
>  drivers/pci/controller/pcie-iproc.c     | 14 ++++++++------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index eede4e8f3f75..65ea83d2abfa 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 02e52f698eeb..8e45288c9abc 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c

> @@ -136,7 +137,7 @@ static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
>  };
>  
>  /**
> - * iProc PCIe inbound mapping type
> + * enum iproc_pcie_ib_map_type - iProc PCIe inbound mapping type.
>   */
>  enum iproc_pcie_ib_map_type {
>  	/* for DDR memory */

The above gives me this:

pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_MEM' not described in enum 'iproc_pcie_ib_map_type'
pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_IO' not described in enum 'iproc_pcie_ib_map_type'
pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_INVALID' not described in enum 'iproc_pcie_ib_map_type'


If you could fix that, it would be Nice. :)

Even if not, it's a good cleanup. Thanks.


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

