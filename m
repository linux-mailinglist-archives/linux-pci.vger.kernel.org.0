Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74361945D4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCZRvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 13:51:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCZRvj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 13:51:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BF37FA;
        Thu, 26 Mar 2020 10:51:38 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 721823F71E;
        Thu, 26 Mar 2020 10:51:37 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:51:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: remove duplicate macro
 PCI_ENDPOINT_TEST_STATUS
Message-ID: <20200326175131.GA13622@e121166-lin.cambridge.arm.com>
References: <20200321112139.17184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321112139.17184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 21, 2020 at 11:21:39AM +0000, Lad Prabhakar wrote:
> PCI_ENDPOINT_TEST_STATUS is already defined in pci_endpoint_test.c along
> with the status bits, so this patch drops duplicate definition.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  This patch applies on top of pci/endpoint branch [1].
>  
>  [1] https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> 
>  drivers/misc/pci_endpoint_test.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/endpoint, thanks.

Lorenzo

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index b536ca4b14ca..a1bb94902b5a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -53,7 +53,6 @@
>  #define STATUS_SRC_ADDR_INVALID			BIT(7)
>  #define STATUS_DST_ADDR_INVALID			BIT(8)
>  
> -#define PCI_ENDPOINT_TEST_STATUS		0x8
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>  
> -- 
> 2.20.1
> 
