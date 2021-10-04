Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8A421702
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhJDTJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 15:09:23 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:47099 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhJDTJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 15:09:22 -0400
Received: by mail-ed1-f41.google.com with SMTP id z20so17399374edc.13;
        Mon, 04 Oct 2021 12:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eS3yIdA30SJ4zKaXnysEXsznetD3b0GwKKFLH0KJiIA=;
        b=qW720hianUSEljN35lHZPyx5UZ6QQBSl/h5A09CudW45pliqK/1dsVro0HOM75rgpU
         bFTgeg5Rn6UWfBA7RzSHjgiNKm3OsnNHDUggURTnlo8W53inWFeeHfQz6n2f/Mmf/arQ
         daVcLdRQW+lr9MHuPlq5GuKTHudjnRQT4iG47rnKtIxzae7uitHdknCReIU6yPFTFOZe
         8KZObdd08jQquS0kf384Nw5LfirIIkwI69U9BtKSr/vABlvg7yvRZDSiqYXHwDu+LB+A
         dNbbYXyubS0aA1gO2QRDCCCTEbX/kKF+ML6IEznx+85/WZ2GzPv80qtOG5RCmFsMQf1g
         YcZQ==
X-Gm-Message-State: AOAM533XViy7fVBsQqIbJUULGAhD2/FMXAvPlGJ9FlXNz1LXWi06Kyql
        rzcZqdsrJ8YQUWotF2jNzVM=
X-Google-Smtp-Source: ABdhPJz59DF3DwT8lz6agMgOMI59aahhiOse27ZIVxQvuxAdX4wlgCyGM8OTNnrKJtvPf6N91t9AqQ==
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr5264219edc.272.1633374452230;
        Mon, 04 Oct 2021 12:07:32 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i6sm6740885ejd.57.2021.10.04.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:07:31 -0700 (PDT)
Date:   Mon, 4 Oct 2021 21:07:30 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
        hch@infradead.org, stefanha@redhat.com, oren@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <YVtQ8ummGgG9AOZE@rocinante>
References: <20211003091344.718-1-mgurtovoy@nvidia.com>
 <20211003091344.718-2-mgurtovoy@nvidia.com>
 <YVpctu416oj5gZ2i@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVpctu416oj5gZ2i@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Max,

[...]
> >  #ifdef CONFIG_NUMA
> > -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> > -					  cpumask_of_node(dev_to_node(dev));
> > +	mask = (dev_to_node(dev) == NUMA_NO_NODE) ? cpu_online_mask :
> > +				cpumask_of_node(dev_to_node(dev));
> 
> Oh this somewhat awkward indentation we have with this ternary now,
> and so I wonder if either:
> 
> 	mask = (dev_to_node(dev) == NUMA_NO_NODE) ?
> 		cpu_online_mask : cpumask_of_node(dev_to_node(dev));
> 
> Or, perhaps (yes, a few more lines):
> 
> 	if (dev_to_node(dev) == NUMA_NO_NODE)
> 		mask = cpu_online_mask;
> 	else
> 		mask = cpumask_of_node(node);

Doh!  I should be cpumask_of_node(dev_to_node(dev)) in the above, of
course.  Apologies!  Albeit, v3 you sent looks great!  Thank you!

	Krzysztof
