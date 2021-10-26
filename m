Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D043BD66
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhJZWra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 18:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233975AbhJZWr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 18:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635288305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJE/NWaCXXuQJcL5mzxI+NTTaI/OiIBRLTuPGxxf3aI=;
        b=ZZNtxXUMcJ+Wc8yHHbVB41fG38w0lqA9xMrtvEnNQpcydGeZufuWG/eO2etGTB7J3spwFv
        XhRVI+Nb5VGwMi8330Fce3ZXXFQwZgqMB+R707503Bf44S0w4X8WNQoTAKllsc6lm/L5IZ
        xu2pM8BjVrDWkA5Wv516Kllb6NoRAoM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-WFqzKx6yPzCSYy-yIf6_7w-1; Tue, 26 Oct 2021 18:45:03 -0400
X-MC-Unique: WFqzKx6yPzCSYy-yIf6_7w-1
Received: by mail-oi1-f199.google.com with SMTP id x17-20020a544011000000b00298d5769310so262516oie.12
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 15:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJE/NWaCXXuQJcL5mzxI+NTTaI/OiIBRLTuPGxxf3aI=;
        b=aDKqkEYD959Su8wFneByM4iJpUwMLO89yOK5GZmSUo9S4AWC5ov4h9z/ER1u1oKfph
         h//63LJczFx71RBHst0Y41VpRGEEaZJX5FW8NA57+Z2yMg5Ye2zUcRJi5+TtgyKEL429
         KaxNCtDDY31hTSOZHEeKNzaIySw73SgCy/VBdnkhO80fpeX/IBnhebvXJCTXBsKBxopx
         YW9+T4xEXU44dXYOEKcCkMqhmZkNsSEtFspWGJLnV5LPwlnrT9AM7BXaHzPWxQM7vWgy
         eQe7ic6TY00t90zvex6p2QDexP06fRhBmqKYczfyms6ZV3YGhVWag7Fyw5fZOBOVkEBJ
         c+/A==
X-Gm-Message-State: AOAM533FPr86y26v35kMimU6wKE5M6qUg+4nIA2+E2wRYQHAZOETzSZQ
        k5sjMLwoKe8KmC83watnCLPrQ8oGYGgAOU6c/CwmqgkS/wdFZsqC/hImj0o4BQ6hhhSl24HhMwD
        WrQvLeNXEtatINoRrA1lY
X-Received: by 2002:a05:6830:1d45:: with SMTP id p5mr20523565oth.119.1635288303226;
        Tue, 26 Oct 2021 15:45:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXzoESXDPfwzLPzCD0Nx5lpJaiiuMOlKBtYPO4JtmD8tZGc81LbNNRF/rF3gEAr9cN/JGILA==
X-Received: by 2002:a05:6830:1d45:: with SMTP id p5mr20523550oth.119.1635288303052;
        Tue, 26 Oct 2021 15:45:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d4sm2594393otu.57.2021.10.26.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:45:02 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:45:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V4 mlx5-next 12/13] vfio/pci: Expose
 vfio_pci_aer_err_detected()
Message-ID: <20211026164501.57f87b2d.alex.williamson@redhat.com>
In-Reply-To: <20211026090605.91646-13-yishaih@nvidia.com>
References: <20211026090605.91646-1-yishaih@nvidia.com>
        <20211026090605.91646-13-yishaih@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Oct 2021 12:06:04 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> Expose vfio_pci_aer_err_detected() to be used by drivers as part of
> their pci_error_handlers structure.
> 
> Next patch for mlx5 driver will use it.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 +++--
>  include/linux/vfio_pci_core.h    | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index e581a327f90d..0f4a50de913f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1901,8 +1901,8 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
>  
> -static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> +pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> +					   pci_channel_state_t state)
>  {
>  	struct vfio_pci_core_device *vdev;
>  	struct vfio_device *device;
> @@ -1924,6 +1924,7 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
> +EXPORT_SYMBOL_GPL(vfio_pci_aer_err_detected);

Should it also be renamed to vfio_pci_core_aer_err_detected at the same
time?  Thanks,

Alex

>  
>  int vfio_pci_core_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
>  {
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index ef9a44b6cf5d..768336b02fd6 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -230,6 +230,8 @@ int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
> +pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> +					   pci_channel_state_t state);
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  {

