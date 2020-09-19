Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D727103A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Sep 2020 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgISTas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Sep 2020 15:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISTas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Sep 2020 15:30:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DEC0613CE;
        Sat, 19 Sep 2020 12:30:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so8857058wrt.3;
        Sat, 19 Sep 2020 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=5skGPhsyazVZaiVuubVh94FSwyjMzK0r2M2FZd4FHB8=;
        b=X9Qo5lggFQxq3aLs9JzxKNHoJaXuDiF2f7pe6k1UVptbiACRu2eRGd3iCoO9k3nxTa
         9mZ5pxMZi6h/VmAY8QPmrW5QHWSk/I6mY7TzBqKOD55IdnAY8lFzuFQK4XaIRKoQQU5o
         KvZ8oQiPM/mALL2xdwJCwQRjR6FhEuN9aqq0hRjGcYrWNL4tv4meWa+Z/jVh0dpqGKxR
         BN2HcrNUVDLE5gUejuyc/7osCxdLsSNMuZOX9Up01ivDZGhVP1N6ID0PzOoivA+vrcvX
         F3OZsWO1Ux+2WWonTXl9KRzXgaYUiVp60h7ghopQfPA1Xctta5n4oRhG3+DBWvMNTwnE
         9jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5skGPhsyazVZaiVuubVh94FSwyjMzK0r2M2FZd4FHB8=;
        b=trobrNfwe/EzUeL9LUXaBdqwgIbnMvJyHlbNDRLoUJLEL+UgVE49CufahBpU7SrItt
         Yj6a/rbX/90oeSY9Razy7V52P9cTKpNTYO4BQBbYDa4XqToN5oIoYkmO7DigHNd0W5BY
         /AZLGpMTovinNHSUTZoNbc14ox1WfDnv7Ys6LM+TDyuURYgHJl+WhkOT5O+djiA9MpRd
         6AUzTlvZ/UQ2ukUnP/WSE7RSGPUQ3v57gnrEdZY3cljsvKnWMJEliJX5MQNIkDo0a7is
         AjsZ8Qwteo+Azvl1RTXFv6dPxRGcxXVZJ4KaUQ69impVnmNoPKLBjM850XPILCugscd0
         AHlQ==
X-Gm-Message-State: AOAM531HrY8Vp92WYo1TXRie37SSk0rZmQscCbQs/C7Sdw0I0AIi3DNC
        AoJV4XWFZzMDPWP1R6WPnxc=
X-Google-Smtp-Source: ABdhPJzeClNOewceoNGCFqcHL4YGkoYbNhFUHBTSnoKrv0AfJSkX/cb+mQZse8N2TlRNJvoShb0KMA==
X-Received: by 2002:adf:8405:: with SMTP id 5mr46656012wrf.143.1600543846790;
        Sat, 19 Sep 2020 12:30:46 -0700 (PDT)
Received: from [192.168.43.148] (92.40.169.140.threembb.co.uk. [92.40.169.140])
        by smtp.gmail.com with ESMTPSA id b84sm12278004wmd.0.2020.09.19.12.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 12:30:46 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: keystone: Enable compile-testing on !ARM
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
 <20200906195128.279342-1-alex.dewar90@gmail.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <7f78ef86-f2c5-258f-88b3-0cd79c0799ea@gmail.com>
Date:   Sat, 19 Sep 2020 20:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906195128.279342-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-09-06 20:51, Alex Dewar wrote:
> Currently the Keystone driver can only be compile-tested on ARM, but
> this restriction seems unnecessary. Get rid of it to increase test
> coverage.
Friendly ping?
>
> Build-tested with allyesconfig on x86, ppc, mips and riscv.
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   drivers/pci/controller/dwc/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a3761c44f..ca36691314ed 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -107,7 +107,7 @@ config PCI_KEYSTONE
>   
>   config PCI_KEYSTONE_HOST
>   	bool "PCI Keystone Host Mode"
> -	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> +	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIE_DW_HOST
>   	select PCI_KEYSTONE
> @@ -119,7 +119,7 @@ config PCI_KEYSTONE_HOST
>   
>   config PCI_KEYSTONE_EP
>   	bool "PCI Keystone Endpoint Mode"
> -	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> +	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>   	depends on PCI_ENDPOINT
>   	select PCIE_DW_EP
>   	select PCI_KEYSTONE

