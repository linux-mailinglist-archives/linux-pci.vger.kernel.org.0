Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAE2EE78F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAGVS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbhAGVS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 16:18:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E34223444;
        Thu,  7 Jan 2021 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610054297;
        bh=D6fEKeHxVC5JjeEwv+JgxzCrChA94vlku5jKeprP6CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E+XkDqoZMnzRDSuweqfYeIk25ixs60kttRc7hwnLMYCjPq1sh/ZrA6BDeMSSgP1px
         2iQFyUJ3HWBswlYfYgqJWECJPrytpUzWpyp1N4Ehe2+CMdjp7P6WJbZN6byzhxPQi5
         q9SZfJcC/MB9Rdb4J4xEE/HKD5MxYvx9oHUrBIERsiUbLiJicnQHQ21bEg2wGCaGkq
         osrEBAfcp334H+geVCBXh/S5IFzhqK9iapC2DXAz3REscQ8Gqi4w+O8CbpqXKyB7Hj
         Ex1bJLVlN3YOIHFEI4MJ6fOhoZaK1YslaQyywgkK4QE9p8Y3Scg58MnoU6vHlom26m
         VrAqsXFEJT+fw==
Date:   Thu, 7 Jan 2021 15:18:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmoy Das <nirmoy.das@amd.com>
Cc:     bhelgaas@google.com, ckoenig.leichtzumerken@gmail.com,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devspam@moreofthesa.me.uk
Subject: Re: [PATCH 1/4] PCI: Export pci_rebar_get_possible_sizes()
Message-ID: <20210107211816.GA1392756@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107175017.15893-2-nirmoy.das@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 07, 2021 at 06:50:14PM +0100, Nirmoy Das wrote:
> From: Darren Salt <devspam@moreofthesa.me.uk>
> 
> Export pci_rebar_get_possible_sizes() for use by modular drivers.
> 
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c   | 1 +
>  drivers/pci/pci.h   | 1 -
>  include/linux/pci.h | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..ef80ed451415 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3579,6 +3579,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>  	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>  }
> +EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>  
>  /**
>   * pci_rebar_get_current_size - get the current size of a BAR
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f86cae9aa1f4..640ae7d74fc3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -608,7 +608,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  			  struct resource *res);
>  #endif
>  
> -u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
>  int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
>  int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
>  static inline u64 pci_rebar_size_to_bytes(int size)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..9999040cfad9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1226,6 +1226,7 @@ void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>  int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
>  void pci_release_resource(struct pci_dev *dev, int resno);
> +u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
>  int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
> -- 
> 2.29.2
> 
