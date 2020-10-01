Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C096A28016E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbgJAOi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 10:38:58 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:40620 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 10:38:56 -0400
Received: by mail-oo1-f51.google.com with SMTP id r4so1521534ooq.7;
        Thu, 01 Oct 2020 07:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yw4PrtN2Oth71g1kkUHChb6hrSduqK9Jl/Zu6XocOVo=;
        b=EafjM6xMFA/CQLxvgAExNho/3hgd5SvZ4mWiIfw2uQNJQkQ80Y6d/svWovWHyBWzZC
         wyfVILqEOdwDOcZj3AcVSu99Fvoj8Q9ThQQRxHle1Mtc7544kBHJiJZAtjNBSdJ7gTjR
         05aL2OfDE6XLo95XMGfNM3/RtldjBTWG/TryOxKL+/f5Ng2QPsLJe85pdpjzdY4zhAc5
         wRQdIDwC+zMZdPYOIFVkjlUf6IcC9y4HGMt5g8Ktm4Olzwd3dW49Jo50OJ+I/fYAGfeh
         NblmfuH4GafPp1+2KMYeKqvgqH/Z49J6xUpVb/vw19xRmAsFJ9q04jGqa2AbPAEAL5Xx
         20YQ==
X-Gm-Message-State: AOAM532yZrdWVKAWraKHh94nPIisu6BuimnhxsSIV2ZqQdGycJKfOtOc
        Tg3vqkb/sPfbVURXgXPzZ0nDET9HZLkT
X-Google-Smtp-Source: ABdhPJxF5EB9x3lb+v720bQlEah/PCRCyq1Kuaq2eyvBxqKu28unh05tSRnVBb9N3qGvlPmuGCaEcg==
X-Received: by 2002:a4a:dc99:: with SMTP id g25mr5830794oou.64.1601563135749;
        Thu, 01 Oct 2020 07:38:55 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d28sm1344888ooa.7.2020.10.01.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:38:55 -0700 (PDT)
Received: (nullmailer pid 703882 invoked by uid 1000);
        Thu, 01 Oct 2020 14:38:54 -0000
Date:   Thu, 1 Oct 2020 09:38:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>
Subject: Re: [PATCH -next] PCI: cadence: simplify the return expression of
 cdns_pcie_host_init_address_translation()
Message-ID: <20201001143854.GA703733@bogus>
References: <20200921131053.92752-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131053.92752-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Sep 2020 21:10:53 +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
