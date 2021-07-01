Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6523B9881
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhGAWNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 18:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhGAWNY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 18:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A369F61400;
        Thu,  1 Jul 2021 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625177453;
        bh=pH7dATbUtCrASeuOIG1FOhR4E4lRvxGEQRtc5eAb8Lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EbHhb4cW33XjqwX4d7DrU4e7c+PspIdudXoP/CXq9GVRXPnKpBzW3zAfjVBONZpM3
         Bli8zon/yTduZ1Zs/sOiiTHywKoWZd46bVWUSRLPNg+c93DzN5w5wFbojUfe7WNOUA
         4lpjfzbamrAC9BWrMadXxUULf93fPKdaQdOj4XbG+IIns2E4NsCn+zt1xcffY9Lims
         fBjJjo9b2INzaRdVnOtOb9xWTZOyqfSm/58MwuLsTBrnPg/6DLSmHOBDqvhwkRYob9
         o4vBqgf7thVP6FirE679Dq0Bkb8B4j9p4wXJP9jAbCYV+5j8AACm+ghvHLLIqMN/DH
         2jQn26HPf1HwA==
Date:   Thu, 1 Jul 2021 17:10:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cpcihp: Move declaration of cpci_debug to the
 header file
Message-ID: <20210701221052.GA85522@bjorn-Precision-5520>
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
