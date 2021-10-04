Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D34204C7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhJDBrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 21:47:17 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38644 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhJDBrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 21:47:17 -0400
Received: by mail-ed1-f51.google.com with SMTP id dj4so59569344edb.5;
        Sun, 03 Oct 2021 18:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2opp7SKn8tj80hsfRWVcJMHlQPDGXQv0lvDgs/o4mXc=;
        b=5h4o8XgOe8k8AJ/Ohxz09yvVIFUfjEKegJAgyjLmee4Pz+fVviEl4WWNaF0TZO/ncj
         0PCcJFKw3ks7iXcstHQuWFqcCxiukuc4eyfA3PoAAXWl6SedpaSOorbq35AlsPgGJnIO
         pWOx0lkYscmawMhc3+WdCh0WuTM+1KH3TOnO9vWqt3SapzWEUIHzUJZI27QVRk2uKmfO
         +q2Akw6AgSW0zlzIFItP0ltPkOsoBQBL7GKgTBLVUTRW5r1QCAorzpL192KeTBXCx2GX
         TsG58GQ5QHsgAUA9m536zywksRaegUPe064PRmr1m7FTGE18pT9DTA0ISKA8iNVix9rU
         0Ypg==
X-Gm-Message-State: AOAM530iMLdZSDx+9QOKo9Mfh28/WtaCJFBuDzSq3/7miS8ojocXdiqL
        Nk7tkSWRtSeDFlKnb3ElO4DR/ijwsE/qzA==
X-Google-Smtp-Source: ABdhPJxFOaP/Wp9YJ+tx8TDFlQpEpTL094ZJOUeD0jKQ2mHyZ228hYJIN0cAVGmB3ir5OZe4tG+kcw==
X-Received: by 2002:a17:906:8e0c:: with SMTP id rx12mr14241334ejc.423.1633311927885;
        Sun, 03 Oct 2021 18:45:27 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b5sm6532123edu.13.2021.10.03.18.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:45:27 -0700 (PDT)
Date:   Mon, 4 Oct 2021 03:45:26 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
        hch@infradead.org, stefanha@redhat.com, oren@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <YVpctu416oj5gZ2i@rocinante>
References: <20211003091344.718-1-mgurtovoy@nvidia.com>
 <20211003091344.718-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211003091344.718-2-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bjorn as he has strong code formatting preference in the PCI tree]

Hi Max,

> Use the proper macro instead of hard-coded (-1) value.
> 
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Thank you for taking care of this!  Much appreciated!

> ---
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7fb5cd17cc98..b21065222c87 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -81,8 +81,8 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
>  	const struct cpumask *mask;
>  
>  #ifdef CONFIG_NUMA
> -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> -					  cpumask_of_node(dev_to_node(dev));
> +	mask = (dev_to_node(dev) == NUMA_NO_NODE) ? cpu_online_mask :
> +				cpumask_of_node(dev_to_node(dev));

Oh this somewhat awkward indentation we have with this ternary now,
and so I wonder if either:

	mask = (dev_to_node(dev) == NUMA_NO_NODE) ?
		cpu_online_mask : cpumask_of_node(dev_to_node(dev));

Or, perhaps (yes, a few more lines):

	if (dev_to_node(dev) == NUMA_NO_NODE)
		mask = cpu_online_mask;
	else
		mask = cpumask_of_node(node);

Would be easier on the eyes, so to speak.  What do you think (not a problem
if you don't want to change anything, thoguh)?

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
