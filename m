Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94442B115
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 02:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhJMAta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 20:49:30 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38492 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJMAta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 20:49:30 -0400
Received: by mail-lf1-f43.google.com with SMTP id x27so4142202lfu.5;
        Tue, 12 Oct 2021 17:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cww5CWiG2lAFWq3mC6EgABYlReMWnDxQ5zuCkCa+u88=;
        b=FwZDLBBaEBvmtprzN7FTfWsj0yM4kgLHQuF/lm/ICZQ6uXKYreg4WrbQtUFDfQOUwT
         vdDZvEvaCoi0bOCV4d6INBLNjaUs+qwIZYwn1/RHJr6sKC425Ffk+Ye0Xe/MmTu+qen1
         PGTjpF8LPF5MOwUrCJxdIYxz0RjrhUOK2aFHzk2hA7o/0228CPbOq6tbeq83pHoKKsz4
         xCLhb2H8AK2oVCA4ezaVtKlSYtHWqeAFrZv3Mzd5Yx4jtq7o+9Umx8kHCLKzKBWPsac1
         q1kmyBEZq701MKPlnwzycKv4mTc+o36BdQHBjsryskjJQ50qPN7o5CZ5RLekbYH1zce+
         UTng==
X-Gm-Message-State: AOAM530DZc1vVYePuspMzucxH0rPAHNXRoFk2/vUoVlgHgxOkgDPKi/y
        pcRY8UO4onrIuznjZFvx726MmFGVQkxySA==
X-Google-Smtp-Source: ABdhPJxi6cyFOhnS0+nQ29c5JpLuTebvtE8tsdP7MbBSWH6nLdmzDhus317WyPqpnAI/bDD+wVyGGQ==
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr25000318lfv.481.1634086046368;
        Tue, 12 Oct 2021 17:47:26 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t22sm1268467ljj.61.2021.10.12.17.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:47:25 -0700 (PDT)
Date:   Wed, 13 Oct 2021 02:47:24 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Message-ID: <YWYsnGt3+LRI2q4W@rocinante>
References: <20211012133235.260534-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012133235.260534-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Colin!

> The pointer port_pdev is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index b4db7a065553..19fd2d38aaab 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -634,7 +634,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
>  {
>  	struct pci_config_window *cfg = pdev->sysdata;
>  	struct apple_pcie *pcie = cfg->priv;
> -	struct pci_dev *port_pdev = pdev;
> +	struct pci_dev *port_pdev;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
