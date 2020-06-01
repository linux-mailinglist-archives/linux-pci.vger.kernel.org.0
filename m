Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6055B1EB192
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgFAWPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 18:15:21 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38925 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAWPV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 18:15:21 -0400
Received: by mail-il1-f194.google.com with SMTP id p5so9886325ile.6;
        Mon, 01 Jun 2020 15:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NS+4419j1EZwseeQ8FZfL5iKyQix2bOXtspSMPzkl2I=;
        b=Q6LAjkzsxQeADo/CM/CqzGEkgFg1243L9OgzWx+NWO6bEX5RvnwTQehoQziVBualbg
         sAoar+H6KqL487ycOAkOiW5h6SqcOKZVG/OkUhuusexQfbaBzCp6QyOIAcbx5wdWgnNH
         84pZyYaQVp6evmsG5M4+JdzbdKVXNKb/KZ7dnQY5unEtXUo1HG91OsQa/lK50X6pVLxl
         UL0d8La+FuKuUY3rtPkiRwSJCX0/jKKjP483JHPoJ7xmXRnr63/oJ8esB0K+lii/Y0g/
         orFUcRjI72zYYVUZvbMdW7hqGrY5WXe1YW+uOhhitt9aKtTO6Y8J17BdiUn2iiLB+aES
         L/gQ==
X-Gm-Message-State: AOAM531vFOLy32WnYFQWXnNLB6Cogbv+Bh69ZBdYcMUeEAu+b6sZ5IAB
        OK5qUSRyJexRJGnFnBIFtg==
X-Google-Smtp-Source: ABdhPJycT8bhzalRS25YKOoKKz9TW12nDQ0sSkYLt48dYgTBO9rRB6jfVambGBGuXDObLMa3lTmbTg==
X-Received: by 2002:a92:bad1:: with SMTP id t78mr127613ill.146.1591049720601;
        Mon, 01 Jun 2020 15:15:20 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v17sm411021iln.67.2020.06.01.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:15:20 -0700 (PDT)
Received: (nullmailer pid 1605858 invoked by uid 1000);
        Mon, 01 Jun 2020 22:15:18 -0000
Date:   Mon, 1 Jun 2020 16:15:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     jquinlan@broadcom.com, linux-pci@vger.kernel.org, kgene@kernel.org,
        lorenzo.pieralisi@arm.com, nsaenzjulienne@suse.de,
        thomas.petazzoni@bootlin.com, krzk@kernel.org,
        f.fainelli@gmail.com, jingoohan1@gmail.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: controller: convert to
 devm_platform_ioremap_resource()
Message-ID: <20200601221518.GA1605805@bogus>
References: <20200526160110.31898-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526160110.31898-1-zhengdejin5@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 27 May 2020 00:01:10 +0800, Dejin Zheng wrote:
> use devm_platform_ioremap_resource() to simplify code, it
> contains platform_get_resource() and devm_ioremap_resource().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 4 +---
>  drivers/pci/controller/pci-aardvark.c   | 5 ++---
>  drivers/pci/controller/pci-ftpci100.c   | 4 +---
>  drivers/pci/controller/pci-versatile.c  | 6 ++----
>  drivers/pci/controller/pcie-brcmstb.c   | 4 +---
>  5 files changed, 7 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
