Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3430F75C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhBDQMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 11:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237257AbhBDQLi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 11:11:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 947EC64E2C;
        Thu,  4 Feb 2021 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612455049;
        bh=r6oygDdZU2GXmNaLqeahpVj6BCG8uM0b/k8n/L7Sg1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cFl9IIrh6K8lBgtUSI0HuY7QLEgg8v1droBcE10QXq6cnnWG6+9mGMHrb7t/01UcG
         X1zHwTr1WafbzW/jwvx46OAXtr1+HcR2D/av+Udsl3vdbzTrsJuyiOHGL4XnhAHNah
         AHfkW5N6AOS+JJ1v6dWTi0yzNzsqnwNqENtIDsmwQdjJZ5PGYncoJMYai3g+mL7pEc
         YzKjH8Zxt6jy96UEI9xHDr+EeMJ29N13CFN9CohSCTIcYNHGGVgzAMYwTso2S4bjn7
         eu1k3dRO7cTiAV8G843jmJ+QVKl6/UdAoZ1B9hmCCdCVS4EHNRJjO+sQx7xFwVxid0
         D+j0hO8ksqXUg==
Date:   Thu, 4 Feb 2021 10:10:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, prime.zeng@huawei.com,
        linuxarm@openeuler.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Message-ID: <20210204161048.GA68790@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Masahiro, Michal, linux-kbuild, linux-kernel]

On Thu, Feb 04, 2021 at 07:30:15PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.

So I guess the current behavior is:

  If CONFIG_PCI_DEBUG=y, add -DDEBUG to CFLAGS in the current
  directory, but not in any subdirectories

and the behavior after this patch is:

  If CONFIG_PCI_DEBUG=y, add -DDEBUG to CFLAGS in the current
  directory and any subdirectories

Is that right?  That makes sense to me.  I wonder if any other places
have this issue?

'git grep "^ccflags.*-DDEBUG"' finds a few cases where subdirectories
use their own debug config options, e.g.,

  drivers/i2c/Makefile:ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
  drivers/i2c/algos/Makefile:ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
  drivers/i2c/busses/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
  drivers/i2c/muxes/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG

But some have subdirectories that look like they probably should be
included by using subdir-ccflags, e.g.,

  drivers/base/Makefile:ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
  drivers/base/power/Makefile:ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
    # drivers/base/{firmware_loader,regmap,test}/ not included

  drivers/hwmon/Makefile:ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
    # drivers/hwmon/{occ,pmbus}/ not included

  drivers/pps/Makefile:ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
  drivers/pps/clients/Makefile:ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
    # drivers/pps/generators/ not included

There are many more places that add -DDEBUG to ccflags-y that *don't*
have subdirectories.

I wonder the default should be that we use subdir-ccflags all the
time, and use ccflags only when we actually want different
CONFIG_*_DEBUG options for subdirectories.

> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 11cc794..d62c4ac 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> -- 
> 2.8.1
> 
