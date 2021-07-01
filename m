Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413B3B97C8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhGAUxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:53:14 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45761 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhGAUxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 16:53:14 -0400
Received: by mail-lf1-f53.google.com with SMTP id bq39so1554984lfb.12
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 13:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNnWqssbpNlrqeNTedR8Co4e27hSBMSc+oyPNDRDHGs=;
        b=iIEeNdVtDK60TAlkSxAPXmaPNseC/F80RgyAFTnm8NFi+IQObTSrTGh9Nv2OIGqXGJ
         CMv0Zh4WuX1bY13EB+pVWauzsL5ynpDw4+7ohKgiFfcmTJfTdGKeOZySBr2If+U5BmxY
         eLeQDPsxF96YIWFqzf7MHJe9+YFIFUZBF6wRL4XdDGqgU08ZHAeBqtNJXZlTz9dvxukF
         XLigkGez9fTD5P7tvG7qHBsUtGIxngx+Pa/EM/RxwWkysXlF0kvY30E5QbhjmwPGq/ni
         8apEmVK/D/ge/N9zQkDMx26+T+DLVbM2ZcRmX1JizlhIC6LCV7JrrMNPIdJHTWKFS0lh
         aqkg==
X-Gm-Message-State: AOAM530x1J75/c+ezFNJ6WRrv4EJqgiDQDV4j3+LmDrPdUHC2oYQGnIp
        WLNQQoJ6eaXe/RNFDJ4ijPg=
X-Google-Smtp-Source: ABdhPJz4s/pTAiLcSDdCzemQVgXpOXt3LsUrWeQiApW17o3lnXh5B1RpKXh1OzjwE0JSceNJvmKXtQ==
X-Received: by 2002:ac2:5ec9:: with SMTP id d9mr1133633lfq.60.1625172641640;
        Thu, 01 Jul 2021 13:50:41 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d37sm70760lfv.68.2021.07.01.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:50:41 -0700 (PDT)
Date:   Thu, 1 Jul 2021 22:50:40 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: artpec6: Remove surplus break statement after return
Message-ID: <20210701205040.GA309322@rocinante>
References: <20210701191640.1493543-1-kw@linux.com>
 <20210701195614.GA84355@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210701195614.GA84355@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> According to
> 
>   $ git grep -n -A1 "return.*;" drivers/pci
> 
> there's at least one more instance in
> drivers/pci/controller/dwc/pcie-designware-plat.c.

Nice find!  I will send a patch shortly.  Thank you!

[...]
> >  		pci->ep.ops = &pcie_ep_ops;
> >  
> >  		return dw_pcie_ep_init(&pci->ep);
> > -		break;
> >  	}
> 
> Not related to your patch, but I'm not really a fan of the block here
> (needed because of the local "u32 val" declaration) because we end up
> with two close braces at the same indent level.  I'd rather declare
> the variable at the top with the other local variables and dispense
> with the braces.

No problem!  I will sent v2 to take care of this too in the same time.

	Krzysztof
