Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4446C428E13
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhJKNh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 09:37:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3964 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhJKNh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 09:37:28 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSfpL1VfCz6H7ct;
        Mon, 11 Oct 2021 21:31:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 15:35:23 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 14:35:22 +0100
Date:   Mon, 11 Oct 2021 14:35:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>
Subject: Re: [PATCH v3 09/10] cxl/pci: Use pci core's DVSEC functionality
Message-ID: <20211011143504.00003b2d@Huawei.com>
In-Reply-To: <163379788528.692348.11581080806976608802.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379788528.692348.11581080806976608802.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 9 Oct 2021 09:44:45 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Reduce maintenance burden of DVSEC query implementation by using the
> centralized PCI core implementation.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: kill cxl_pci_dvsec()]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Very pleased to see this being cleaned up.  Thanks,
fwiw
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |   26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b6bc8e5ca028..f2e2a02d1fe6 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -340,29 +340,6 @@ static void cxl_unmap_regblock(struct pci_dev *pdev,
>  	map->base = NULL;
>  }
>  
> -static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> -{
> -	int pos;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> -	if (!pos)
> -		return 0;
> -
> -	while (pos) {
> -		u16 vendor, id;
> -
> -		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> -		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> -		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> -			return pos;
> -
> -		pos = pci_find_next_ext_capability(pdev, pos,
> -						   PCI_EXT_CAP_ID_DVSEC);
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>  {
>  	struct cxl_component_reg_map *comp_map;
> @@ -449,7 +426,8 @@ static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	u32 regloc_size, regblocks;
>  	int regloc, i;
>  
> -	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					   PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
>  	if (!regloc)
>  		return -ENXIO;
>  
> 

