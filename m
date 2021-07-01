Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062B33B95BF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGAR7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 13:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhGAR7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 13:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C6E613DD;
        Thu,  1 Jul 2021 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625162201;
        bh=NyBvgaZPchBNsApofJiL0TQRScH+mnCzNII+o4g+/1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mnx89TNBxzMocqrY8+v5319A1Pr1XJJub+npPbeggQcfXoNs9bhmxyRhO9uF6bTkS
         WUaV7xuPKYByCdTw3uOPSOlyovA/B7LfNuvXlFlmdq+92m2TbJpPXYD4LvvWv+H8Ek
         SMaa3yj0okE5EbKLK+6JEk+br9LuugsevX/7x3S9YisE/1/B97vOXi6wMqfApet1od
         vLaHssfAL+yRVXYzMQZQbF+SbPd5kdHz13zk8xhpgy3h0CVSrn1PNJVYyXTI1ImLho
         CXwz33AfAZjgghheBDaQvqap0laRIf7sDOObZPoxtTqdpJbozPxlE3FVbocIDkzQJW
         R4TT5M/OkZaXw==
Date:   Thu, 1 Jul 2021 12:56:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpcihp: Move declaration of cpci_debug to the
 header file
Message-ID: <20210701175639.GA73684@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510024529.3221347-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 02:45:29AM +0000, Krzysztof Wilczyński wrote:
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
> ---
>  drivers/pci/hotplug/cpci_hotplug.h      | 3 +++
>  drivers/pci/hotplug/cpci_hotplug_core.c | 1 -
>  drivers/pci/hotplug/cpci_hotplug_pci.c  | 2 --
>  3 files changed, 3 insertions(+), 3 deletions(-)
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
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..7a78e6340291 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -44,7 +44,6 @@ static DECLARE_RWSEM(list_rwsem);
>  static LIST_HEAD(slot_list);
>  static int slots;
>  static atomic_t extracting;
> -int cpci_debug;

We can add a declaration, but we still need a *definition* somewhere,
right?

drivers/pci/hotplug/ has several drivers that are split over multiple
files.  IMHO there is zero benefit to splitting them into multiple
files and one of the downsides is things like this that shouldn't be
global, but are global because of the split.

Not sure it's worth the churn of squashing them together, at least for
ancient things like this.  pciehp is a perennial thorn in my side,
though.  Every time I look for something, I try two or three files
before finding the right one.

>  static struct cpci_hp_controller *controller;
>  static struct task_struct *cpci_thread;
>  static int thread_finished;
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
> 2.31.1
> 
