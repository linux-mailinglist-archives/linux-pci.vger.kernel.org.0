Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10171DC0BF
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgETU77 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:59:59 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36074 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgETU77 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:59:59 -0400
Received: by mail-il1-f195.google.com with SMTP id 17so4793070ilj.3;
        Wed, 20 May 2020 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAntt9LZM4aXhtYbB5IsDq5XlgAc1476xVm09j70Cvc=;
        b=BCnLh7qdISOoNSsyP0mZFf208FmWrPt7enPnbMMGeccb9JUkk2cneIe9aHH0AUoKUL
         hhRAdMqVoHwKfSFPEt9Mn0rAinUhyoSNM8Gaw1nyPqbxYbltmQlm4gBLoo0lni1z1lUB
         38n74WK8/T5XMr+zQpNhzEXNGuKmEQxEraFNhjL6P6O28r7Yw27+xaH+wWaOOL/ROCq1
         3msfzsO/J7p9L6IdiUcOa2b0tIq1jPUZMTg/UYk8faHxiak9pRQijBQLOCaLArPwhCuV
         Vu/LUcPeyYVfMdevjZIO8DIxPL19BduVxIuEmH5D7r6Mdz/HVkn1qpFRL1oZPJwXFJP0
         7n7Q==
X-Gm-Message-State: AOAM533Bg8CAz5WBpy7+EdfC7yfw0uRhnQE/PM+dkCZ+G0KtumIqzGbY
        gAkold9zCeXz06GUXUcB0A==
X-Google-Smtp-Source: ABdhPJzPaTCpz4Tn8plu0LlLEYCHFebPD9zDcz7rBBGbnzlj8cCSRMP2lemNIxHg9WTA5zFlXjkBKg==
X-Received: by 2002:a92:afc6:: with SMTP id v67mr5758075ill.292.1590008397663;
        Wed, 20 May 2020 13:59:57 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o70sm1993204ild.3.2020.05.20.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:59:57 -0700 (PDT)
Received: (nullmailer pid 568868 invoked by uid 1000);
        Wed, 20 May 2020 20:59:56 -0000
Date:   Wed, 20 May 2020 14:59:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-omap@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] PCI: cadence: Fix cdns_pcie_{host|ep}_setup()
 error path
Message-ID: <20200520205956.GA568767@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-2-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:16 +0530, Kishon Vijay Abraham I wrote:
> commit bd22885aa188 ("PCI: cadence: Refactor driver to use as a core
> library") while refactoring the Cadence PCIe driver to be used as
> library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
> and cdns_pcie_host_setup() but missed to remove the corresponding
> pm_runtime_put_sync() in the error path. Fix it here.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 9 ++-------
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 6 +-----
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
