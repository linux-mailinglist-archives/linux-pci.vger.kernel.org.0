Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048B43B97AF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhGAUih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234094AbhGAUig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 16:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC1A7613F4;
        Thu,  1 Jul 2021 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625171766;
        bh=pH7dATbUtCrASeuOIG1FOhR4E4lRvxGEQRtc5eAb8Lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Frv69sO4DPumcYPtZbYVBUwRULypShfF6R1ZYaZOEZn+k4zWfOG9TwKpxPPS7sL6p
         /zGu+le3IL4dsFf0BYEWWMC/p5d+PfDJ/wum0os1Po6mYZU7Jq3k3ziWS6yGCIi9/L
         9DgCCfB9ijLbVIKuT0yDWIj2eU3sQ3q6I70JDcPleb5ArPEnjCx1zWyzvr0o6pNsBU
         3Rrnl6ZxwTz67C4QD9BomiiyyYTS9VFmWjsivQ1DUpgJkGMuh1XJzQru8dAXUm/fmt
         Lc2FKbbLEpCUNvW/Sw5Xr6EdA7qUQpGRuBHOX+0f4DzdpnMv+O5GVZHSsbbTNUSuTc
         Y/xnto9ovcStg==
Date:   Thu, 1 Jul 2021 15:36:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cpcihp: Move declaration of cpci_debug to the
 header file
Message-ID: <20210701203604.GA89386@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701184306.1492003-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 06:43:06PM +0000, Krzysztof Wilczyński wrote:
> At the moment, the global variable cpci_debug is declared in the
> cpci_hotplug_core.c file.  Since this variable has users outside of this
> file and uses the extern keyword to change its visibility, move the
> variable declaration to the header file.
> 
> This resolves the following sparse warning:
> 
>   drivers/pci/hotplug/cpci_hotplug_core.c:47:5: warning: symbol 'cpci_debug' was not declared. Should it be static?
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/hotplug for v5.14, thanks!

> ---
> Changes in v2:
>   Remove hunk that incorrectly removed definition of the cpci_debug
>   variable.
> 
>  drivers/pci/hotplug/cpci_hotplug.h     | 3 +++
>  drivers/pci/hotplug/cpci_hotplug_pci.c | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index f33ff2bca414..3fdd1b9bd8c3 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -75,6 +75,9 @@ int cpci_hp_unregister_bus(struct pci_bus *bus);
>  int cpci_hp_start(void);
>  int cpci_hp_stop(void);
>  
> +/* Global variables */
> +extern int cpci_debug;
> +
>  /*
>   * Internal function prototypes, these functions should not be used by
>   * board/chassis drivers.
> diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
> index 2c16adb7f4ec..6c48066acb44 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_pci.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
> @@ -19,8 +19,6 @@
>  
>  #define MY_NAME	"cpci_hotplug"
>  
> -extern int cpci_debug;
> -
>  #define dbg(format, arg...)					\
>  	do {							\
>  		if (cpci_debug)					\
> -- 
> 2.32.0
> 
