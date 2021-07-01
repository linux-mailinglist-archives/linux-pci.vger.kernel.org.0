Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70A3B90EE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhGALE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 07:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236040AbhGALE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 07:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8EEC613F1;
        Thu,  1 Jul 2021 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625137318;
        bh=5OlkYH2zI98aLCHwkLqZ/xa3N9z/0GZDPOPlot1MpkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r2wZOtYxaAOKX1YbyQxygtV5Ov0XTJYPaTL7YbAf+mbM0pRKkvLZE3J4d8HYhsQ9S
         JlKTuLERGvF9lYAWz1p7heF87IMJ2et7u0qORMvfhUMk888tMXNs7OUq+DX8cFc2KY
         FnDgzLHljsPKhnfBh+KqWJzwI3syJrEY2ONuZdbBJfpQf4D5KrW6e3ANhEf/+TXZ0X
         GxtTs56NQHPesEZtKriyMkdIx5SF8JHE66a3petMS73xxjlyBaH1Du/2JuwwALe9QG
         QOWmK6bsqstoEc/tH7QxE3+4z4aHHB9XQa8fMh97WrDwahfjDGDqdkhmt1H3x/YlN4
         SXZUaojPk391A==
Date:   Thu, 1 Jul 2021 06:01:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joyce Ooi <joyce.ooi@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera PCIE
 maintainer
Message-ID: <20210701110156.GA37094@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701065247.152292-1-joyce.ooi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 02:52:47PM +0800, Joyce Ooi wrote:
> This patch is to replace Ley Foon Tan as Altera PCIE maintainer as she
> has moved to a different role.
> 
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
> ---
>  MAINTAINERS |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66d047d..7693c5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14148,7 +14148,7 @@ F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
>  F:	drivers/pci/controller/pci-aardvark.c
>  
>  PCI DRIVER FOR ALTERA PCIE IP
> -M:	Ley Foon Tan <ley.foon.tan@intel.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	rfi@lists.rocketboards.org (moderated for non-subscribers)

Thanks!  What about rfi@lists.rocketboards.org?  I've gotten several
bounce messages from it in the last few days ("connection timed out"
messages, not "held for moderation").

>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> @@ -14353,7 +14353,7 @@ S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
>  PCI MSI DRIVER FOR ALTERA MSI IP
> -M:	Ley Foon Tan <ley.foon.tan@intel.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 1.7.1
> 
