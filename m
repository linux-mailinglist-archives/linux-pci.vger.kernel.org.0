Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3771B4943
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDVP53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 11:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVP52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 11:57:28 -0400
Received: from localhost (mobile-166-175-189-88.mycingular.net [166.175.189.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0AD20767;
        Wed, 22 Apr 2020 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587571048;
        bh=NyNpK/86NyGs08RdSy78MItgrXja6gNlU9ieF7+7oUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uDhv4LmAX3Oh8fvGuoUc+Q24H3zx8jwxLOwR97K7PV1839R6pigReGVeH+SoYglKy
         8Ov6XEwKrLSuJHFmB4I1oaNrJhTY0jeJ/Y4OOptHL9jHEgyKnRGvKsvd9lpRyjh/AM
         yuZYPK+nVPVPMQ3VvLpVvUh/SP8qapFociAa2DaU=
Date:   Wed, 22 Apr 2020 10:57:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH] MAINTAINERS: Add Rob Herring and remove Andy Murray as
 PCI reviewers
Message-ID: <20200422155726.GA222395@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422150336.10528-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 04:03:36PM +0100, Lorenzo Pieralisi wrote:
> Andy Murray decided to step down as PCI controller reviewer and
> Rob Herring is willing to help review PCI controller patches.
> 
> Update the respective MAINTAINERS entries to reflect this change.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>

Applied to for-linus for v5.7, thanks.  Thanks for all your help,
Andrew, and thanks for your willingness to help out, Rob.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..4fd752f5ca61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13038,7 +13038,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>  
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> -R:	Andrew Murray <amurray@thegoodpenguin.co.uk>
> +R:	Rob Herring <robh@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> -- 
> 2.26.1
> 
