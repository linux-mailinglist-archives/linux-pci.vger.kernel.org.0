Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E065445576
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKDOmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 10:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDOms (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 10:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4A74611C4;
        Thu,  4 Nov 2021 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636036810;
        bh=687rLpiG01Zpuh8NQUwUHtcrXN+VF8fyKRnrMJ3tyGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a2JSLmc3gJzL0FnCt92baFKI9KkHMhpxhUUSFTgDkUPBcAwxgWVwrWvAfsfmaLclS
         MSIzrZkpWE9I/28UDzYhHwtUZxPPUjROOaOdeCPt7nghlHB559CSgSkvvIN0wTpTOs
         NxwZyJyRNRRK6uBChYGomuTGHNHQeAPKNJLYYPLXLfcpQxID9BshoP1aTvuRXu0eHQ
         u/ju63azEefFoIEPnyiVFeLxxwc1ffxHXMa49cM+yudBBsQKd/+o/tuZDeYppOgWUx
         qiWQPbKfyXnUcozzvDM7lW2MZBH2aPEl1qgh5xuxqcxLPF5u47MAlfdVm/bEluq+rE
         uvI5clewY44vQ==
Date:   Thu, 4 Nov 2021 09:40:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] PCI: vmd: Remove duplicated include in vmd.c
Message-ID: <20211104144008.GA753593@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104063720.29375-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04, 2021 at 02:37:19AM -0400, Wan Jiabing wrote:
> Fix following checkincludes.pl warning:
> ./drivers/pci/controller/vmd.c: linux/device.h is included more than once.
> 
> The include is in line 7. Remove the duplicated here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Squashed in, thanks!

> ---
>  drivers/pci/controller/vmd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index b48d9998e324..a45e8e59d3d4 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -10,7 +10,6 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/device.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> -- 
> 2.20.1
> 
