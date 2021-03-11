Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E56337F93
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCKVW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 16:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhCKVV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 16:21:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 697FF64F91;
        Thu, 11 Mar 2021 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615497715;
        bh=bWhxGi69aLbiI/43wckgcUfry0IkgWHtLgLYXm6vlTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VFZMUY4cjDc2Tq79J0o6EQ8Qn48LImTG3qu6cTzyvNmo02Pl6daYmQY12J/tqYBtE
         tuILkyblqzQ9tuI3vAv49HEMUirjxoyjh6NlwCAjhD1DwSBfsoOYZ9u5XAgHk+ElPm
         Xl2NnYKUfdlJLnzgGNJK6LAmmJRpaGe90rG+CgmfEf1Nb5ibJnfLJRbFEIc/6Y/VpX
         ZH82YIDYEAFnGNtu8zVvy1i6lerDqJZYodAsmw454jORVGUgxRqarM5nKHWqOOTKdP
         f/Fcs3FdP8BdD+P2mAoX7pH/yzOMfEjpNg64sJn5bsSCZGASAVbCGygTF600Fp5Wdf
         PZBny2/epZKpg==
Date:   Thu, 11 Mar 2021 15:21:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] MAINTAINERS: Update PCI patchwork to kernel.org instance
Message-ID: <20210311212153.GA2169497@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311211223.2168267-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 03:12:23PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We now use the kernel.org patchwork instance.  Update the links in
> MAINTAINERS.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I put this on for-linus for v5.12.

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..a3c2e930b3d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13843,7 +13843,7 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  R:	Rob Herring <robh@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +Q:	http://patchwork.kernel.org/project/linux-pci/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
>  F:	drivers/pci/controller/
>  
> @@ -13851,7 +13851,7 @@ PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +Q:	http://patchwork.kernel.org/project/linux-pci/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  F:	Documentation/PCI/
>  F:	Documentation/devicetree/bindings/pci/
> -- 
> 2.25.1
> 
