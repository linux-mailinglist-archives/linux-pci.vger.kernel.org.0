Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE86028016D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgJAOih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 10:38:37 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41146 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbgJAOih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 10:38:37 -0400
Received: by mail-oi1-f175.google.com with SMTP id x69so5802379oia.8;
        Thu, 01 Oct 2020 07:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05WM9O11nXEnB8MaY5uRJWUk6wfX4i1dcR/R2xP+z94=;
        b=JPiXV3ByjLy1FEQxIu5kd2NbPNYBUAJa+2HfxivBU0aIYT6sZu0UMVqrRbYY9GPSpx
         JRMLdwrt9Fxcch12C7TbJ9Cm1CH/hF99GZRtEC4G5VCswcGhFVolSJUuHu2DEGo+Tyuy
         IPOo7AzZGC6Bb8kznV1rmGV1p5twti3xAeNupwzccfWDZQ2ixufO5Nm29YRu4PHBxUhN
         PwncDXKLcbp0GP4cLk5XGnU8zieeZKWjaonkAriY5werNpe+eOMRRZpBEUf5dclB4l5l
         338qfLTVzjBb26ZlgbhDDpYm/EZSeYER8/5a++CeP+ia+/CWr35/CDPnWzycBngzHN+W
         ZHOw==
X-Gm-Message-State: AOAM533MCwnY+/jSBrcszX6jZ8jYe7mxSds3zFo0eXqt0SKLO+1cti/m
        8dhpmY1LLQf3WjcC/3/ul+Vqf9SknnfZ
X-Google-Smtp-Source: ABdhPJyuohX6ohqzLB9qD1xifWRMkw+CWKN7NONCu57jyZ9ed/4xYQv5FTKVzba0L2YxiOkT75uEfw==
X-Received: by 2002:aca:f203:: with SMTP id q3mr180483oih.148.1601563116805;
        Thu, 01 Oct 2020 07:38:36 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm1238668otj.19.2020.10.01.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:38:36 -0700 (PDT)
Received: (nullmailer pid 703354 invoked by uid 1000);
        Thu, 01 Oct 2020 14:38:35 -0000
Date:   Thu, 1 Oct 2020 09:38:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH -next] PCI: mobiveil: simplify the return expression of
 mobiveil_pcie_init_irq_domain
Message-ID: <20201001143835.GA703320@bogus>
References: <20200921082447.2591877-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921082447.2591877-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Sep 2020 16:24:47 +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
