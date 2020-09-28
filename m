Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE327B7C3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgI1XPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 19:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgI1XPb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 19:15:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7978B23A40;
        Mon, 28 Sep 2020 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601332763;
        bh=kcdtApje+MBHdfUB2c2kJF6E7KxaJcvAdCzfKChA118=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AZfVaZqOhQrLRTWFaK+3oe/rJbTCK9wNNBBhz2CH0NbvtONNqYw9OzJx54t+PFWoy
         0bM3QR6hcc+ZKBGNusjuEQiO4mjK94byDszMcY4mEox17to9V+IREFI9tug/q/Uzcm
         TbLFoRYzjg9WiRWwCbkLwifP9Dt4+Uesfg8fvNvk=
Date:   Mon, 28 Sep 2020 17:39:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Heng <liheng40@huawei.com>
Cc:     konrad.wilk@oracle.com, bhelgaas@google.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] xen: Fix a previous prototype warning in xen.c
Message-ID: <20200928223922.GA2503371@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600958176-23406-1-git-send-email-liheng40@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:36:16PM +0800, Li Heng wrote:
> Fix the warning:
> arch/x86/pci/xen.c:423:13: warning:
> no previous prototype for ‘xen_msi_init’ [-Wmissing-prototypes]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>

Applied to pci/misc for v5.10, thanks!

> ---
>  arch/x86/pci/xen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 89395a5..f663a5f 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -420,7 +420,7 @@ int __init pci_xen_init(void)
>  }
> 
>  #ifdef CONFIG_PCI_MSI
> -void __init xen_msi_init(void)
> +static void __init xen_msi_init(void)
>  {
>  	if (!disable_apic) {
>  		/*
> --
> 2.7.4
> 
