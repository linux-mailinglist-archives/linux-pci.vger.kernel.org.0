Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CF4216FE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhJDTG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 15:06:26 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52798 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhJDTGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 15:06:13 -0400
Received: by mail-wm1-f48.google.com with SMTP id m42so3730071wms.2;
        Mon, 04 Oct 2021 12:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DHNaQQHi7hNZ23P7b8lQ+OjND7rNc8bX1seiwOi+5ks=;
        b=wg1IwUJZk8/tJubB1FjnM60BihWF4ew8UXr3YsCbDr9nUHtjIiG+TkoVzMpXwxHGyW
         g5uBr3mW9ztFaIJPMtDjYvYkh9hc6NGyd8l0XZT/oUtyCdNjfGaMMBVQkKC4cpsHCbFA
         Qa38yjAmI99TscY9g82e0jqo5PZrUeQKBxk23ZC7OlQhOA/C79W2jO9XonO0cEVZeJiF
         JNFbB302HD4XEnodd4TN1M9xLEpvjz/jg0hFogya1vr6H5gjd+24u+BGciJ113rpyuJV
         YJaoWj6iSSSLsColMt8HCs88DJGhUbVBijCiLUTNEsfHSzvhf79RUyc/lYIgxfAcWE4G
         Lm/w==
X-Gm-Message-State: AOAM530/oiDoMPOJb1qlm9zXr9TtV2x59p7/sJiUrZJwNwUOvTXoiyrG
        Cd66CmHZ+2BevQCXsBr7h7KDvOLYgkE=
X-Google-Smtp-Source: ABdhPJw4x7rSy4mmoHFL8msM3I2jVhk0WW+9IRFYElGR1p6/X46cVBxuPenvdE0cb3HM8FAM00FJHA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr5611853wmk.131.1633374263137;
        Mon, 04 Oct 2021 12:04:23 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x10sm14089683wmk.42.2021.10.04.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:04:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 21:04:21 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, stefanha@redhat.com, oren@nvidia.com
Subject: Re: [PATCH v3 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <YVtQNSoCJG5cJb4b@rocinante>
References: <20211004133453.18881-1-mgurtovoy@nvidia.com>
 <20211004133453.18881-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004133453.18881-2-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Max!

> Use the proper macro instead of hard-coded (-1) value.
> 
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/pci/pci-sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7fb5cd17cc98..f807b92afa6c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -81,8 +81,10 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
>  	const struct cpumask *mask;
>  
>  #ifdef CONFIG_NUMA
> -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> -					  cpumask_of_node(dev_to_node(dev));
> +	if (dev_to_node(dev) == NUMA_NO_NODE)
> +		mask = cpu_online_mask;
> +	else
> +		mask = cpumask_of_node(dev_to_node(dev));
>  #else
>  	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
>  #endif
> -- 
> 2.18.1

Thank you!

	Krzysztof
