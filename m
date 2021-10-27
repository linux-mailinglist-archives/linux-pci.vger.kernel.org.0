Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75943D6C7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 00:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ0WlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 18:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhJ0WlN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 18:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6526610CB;
        Wed, 27 Oct 2021 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635374327;
        bh=35c80/puX4yheOLYZ+/8XIuODUrQTE7OA/dywvGPSWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ioYqQkE9e25oMHOczxXd/NIP7hUxvsSeSoiPPbAFJvi+sE/eBcpfXZkhptKtnSkZa
         u//RA1vKiJsJBzFmLgTJrxNwo47hxfVztMNHYhpJW1SjaZ7MwYgfVJQBIqO5lPmwj2
         6VkVBtSRv0Z2E99iagSdOKwBJtlUq6+6wz7UaUJpuh3GkYrHp4TJAOJrE7sqR+RPQB
         o0iTCLNzpCbV7+zr0bwDHX02WtXNsPhlu8wEwGBdZMMLCkgVFNJn7y8kOfyCJhhpRp
         I78qW6/7i46Wq1zYGdpjEqS0g8GqeTaVJSPsWzbHJY4lOk1veHKKkCPmA6+fiMdTZU
         eOvFUcewS94Aw==
Date:   Wed, 27 Oct 2021 17:38:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update information related to the PCI
 sub-system
Message-ID: <20211027223845.GA257469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027105041.24087-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 27, 2021 at 10:50:41AM +0000, Krzysztof Wilczyński wrote:
> Update the following information related to the PCI sub-system which
> includes the PCI drivers, PCI native host bridge and end-point drivers,
> and the PCI end-point sub-system.
> 
>  - Sort fields as per preferred order
>  - Sort files in the alphabetical order
>  - Update old Patchwork URLs
>  - Update Git repository for the PCI end-point sub-system
>  - Add Bugzilla link
>  - Add link to the official IRC channel
>  - Add files "drivers/pci/pci-bridge-emul.{c,h}" to the right
>    section so that proper ownership is returned for both files
>    from the get_maintainer.pl script
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.16, thanks!

> ---
> Changes in v2:
>   Add "drivers/pci/pci-bridge-emul.h" file that was missing as per the
>   feedback from Pali Rohár.
>   Update the PCI end-point sub-system Git repository link as per the
>   feedback from Kishon Vijay Abraham I.
> 
>  MAINTAINERS | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80eebc1d9ed5..4436959c2f73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14459,9 +14459,12 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>  F:	Documentation/PCI/endpoint/*
>  F:	Documentation/misc-devices/pci-endpoint-test.rst
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	drivers/pci/endpoint/
>  F:	tools/pci/
> @@ -14507,15 +14510,21 @@ R:	Rob Herring <robh@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>  F:	drivers/pci/controller/
> +F:	drivers/pci/pci-bridge-emul.c
> +F:	drivers/pci/pci-bridge-emul.h
>  
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  F:	Documentation/PCI/
>  F:	Documentation/devicetree/bindings/pci/
> -- 
> 2.33.1
> 
