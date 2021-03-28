Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6934BCF8
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhC1Pi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 11:38:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhC1PiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 11:38:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1lQXUP-0008MZ-D0
        for linux-pci@vger.kernel.org; Sun, 28 Mar 2021 15:38:09 +0000
Received: by mail-io1-f72.google.com with SMTP id c4so9227832ioq.15
        for <linux-pci@vger.kernel.org>; Sun, 28 Mar 2021 08:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1J2me4BRR0mUOZbWzDbk8ObXSy9+cWyrkTA57Rydf9I=;
        b=VK2M4RNyt09G1PKApXxCOGmMmEZZ73UbX62ZJyTSXdN73JpNn1jLjDLJyZYVlR+d02
         S5dY3o8L1Oij9DE56wJUd0wpi+/lp024kElWipha/EwTOuft5ztWhf/wfMNvIrYb0+FQ
         9e12OuviB/JKSJETkoAe//rivHrGsLtZqM1UpbYyo12orOeq7b8Anqx9kNT1E/R/TtgX
         6PPLmtURN8dzByBuyWSghqW4LshTQUk44k7WWfEC087XWtF9oANickpTk1aR7JxHiW5u
         +USvIg8VR5EroaHX5dHvezpugjWfxxZjn8XCJAnkxjjzp2woFqogZKWxx05SMwB64lE8
         D7cg==
X-Gm-Message-State: AOAM533MKd4l78vOP5pg3Hd3uXeYNpakMlfEGMv9UkuxrFyyI20vveru
        uxYmJ3XefvtA4yMyviIm47SLC55rl1bbuHT03kCi02d1K8MP3Mp7wS46oOa1zGnaq7L2kTG/vVB
        Dn9e5UFUKkq6DGXl82Rr+8uIA2KyaLlxSzVkO8Q==
X-Received: by 2002:a92:c150:: with SMTP id b16mr16793309ilh.202.1616945888367;
        Sun, 28 Mar 2021 08:38:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytCZecaEq92p4ZHqxX/W6THB3gXSvr2bCtovOLqeTc68eQQrzsH7O1CGOyUBSPw6BReMeOcA==
X-Received: by 2002:a92:c150:: with SMTP id b16mr16793295ilh.202.1616945888031;
        Sun, 28 Mar 2021 08:38:08 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id 14sm8335316ilt.54.2021.03.28.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:38:07 -0700 (PDT)
Date:   Sun, 28 Mar 2021 09:38:05 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: fix a mistake about cfg address
Message-ID: <YGCi3TWLK3D9gw10@xps13.dannf>
References: <20210328144118.305074-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328144118.305074-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 28, 2021 at 10:41:18PM +0800, Dejin Zheng wrote:
> It has a wrong modification to the xgene driver by the commit
> e2dcd20b1645a. it use devm_platform_ioremap_resource_byname() to
> simplify codes and remove the res variable, But the following code
> needs to use this res variable, So after this commit, the port->cfg_addr
> will get a wrong address. Now, revert it.
> 
> Fixes: e2dcd20b1645a ("PCI: controller: Convert to devm_platform_ioremap_resource_byname()")
> Reported-by: dann.frazier@canonical.com
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Tested-by: dann frazier <dann.frazier@canonical.com>

Thanks!

  -dann

> ---
>  drivers/pci/controller/pci-xgene.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 2afdc865253e..7f503dd4ff81 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -354,7 +354,8 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
>  	if (IS_ERR(port->csr_base))
>  		return PTR_ERR(port->csr_base);
>  
> -	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	port->cfg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(port->cfg_base))
>  		return PTR_ERR(port->cfg_base);
>  	port->cfg_addr = res->start;
