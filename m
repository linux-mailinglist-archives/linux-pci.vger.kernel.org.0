Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE63BA537
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGBVob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 17:44:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C61C061762
        for <linux-pci@vger.kernel.org>; Fri,  2 Jul 2021 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JrrUntpKBxnvw/95yAg0zRU2RQC+D12Iu5YLE5r+EBQ=; b=NPl/Gk0FpKrJr3gHPbqQpraGdW
        XUEsbMlhKliQ/E5BV9RMz0hHUumBrSWTr6fRQeVUlxF/5JCdP4efCX8xcbMxqbaMlg0zZ8L213QIf
        2JcWfyeenboAr1Bh5hKXvxgB/5dJG5zCMgaKLwRMnNVgE7+vp/94FiH2UYyJL53uW5aTxjEwedJKc
        qrrLV+RRPe/+YPzdaX0zZ0O1mTJ16/HIetU/m1OEVFH4kERh6aXm1kPBblUbF8dS35MRbwLc+Vo/N
        R2niUN3+Mid1SmZBqptYWz5wrXockdMvBd7P6X/F83fOakqMEp4d1VcSS8d9Hg61iJCqY6YqJBOEe
        +C+U4yjw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzQv7-0045wN-TI; Fri, 02 Jul 2021 21:41:58 +0000
Subject: Re: [PATCH v3] PCI: iproc: Fix a non-compliant kernel-doc
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210702204022.1654290-1-kw@linux.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9fd51762-ade4-619a-dd14-6194e11f38eb@infradead.org>
Date:   Fri, 2 Jul 2021 14:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702204022.1654290-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/2/21 1:40 PM, Krzysztof Wilczyński wrote:
> Fix a non-compliant kernel-doc used to describe struct and enum types
> and functions in the pcie-iproc.c, pcie-iproc-msi.c and pcie-iproc.h
> files.
> 
> Add missing documentation of the "mem" filed of the struct iproc_pcie,
> and the enum values "IPROC_PCIE_IB_MAP_MEM", "IPROC_PCIE_IB_MAP_IO" and
> "IPROC_PCIE_IB_MAP_INVALID" of the enum iproc_pcie_ib_map_type.
> 
> Thus, resolve the following build time warning related to kernel-doc:
> 
>   drivers/pci/controller/pcie-iproc.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:153: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:441: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:623: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:901: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_MEM' not described in enum 'iproc_pcie_ib_map_type'
>   drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_IO' not described in enum 'iproc_pcie_ib_map_type'
>   drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_INVALID' not described in enum 'iproc_pcie_ib_map_type'
> 
>   drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
>   drivers/pci/controller/pcie-iproc.h:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.h:28: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.h:39: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.h:51: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/pci/controller/pcie-iproc.h:112: warning: Function parameter or member 'mem' not described in 'iproc_pcie'
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 54 +++++++--------
>  drivers/pci/controller/pcie-iproc.c     | 49 +++++++-------
>  drivers/pci/controller/pcie-iproc.h     | 88 +++++++++++++++----------
>  3 files changed, 103 insertions(+), 88 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
