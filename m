Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACF94B7E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfHSRQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 13:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbfHSRQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 13:16:45 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B719E22CEA;
        Mon, 19 Aug 2019 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566235004;
        bh=EDR5Wbl/Ry90tNv36Z6AqGHpo4JgKirGnRhRxzrYsRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfqbmhkVZKCugzq7XTLbi5TcvAllu4ld0wsNRnK/WCyPRsk15gyJA4N6abjVKPZs7
         liD5jbvVLsXrZzW2s/WMFZ9ZgQIki6HxfAaiOglPAVB/Kq40OT2pBGL+T42IH4jdRF
         Dyz2WwtuTw6CPCZKWm9Fh3xiyBfTJHitBSyzkR/M=
Date:   Mon, 19 Aug 2019 12:16:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation PCI: Fix pciebus-howto.rst filename typo
Message-ID: <20190819171642.GR253360@google.com>
References: <20190816135357.142733-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816135357.142733-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 08:53:58AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 2e6422444894 ("Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST")
> incorrectly renamed PCIEBUS-HOWTO.txt to picebus-howto.rst.
> 
> Rename it to pciebus-howto.rst.
> 
> Fixes: 2e6422444894 ("Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst                                | 2 +-
>  Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} (100%)

I merged the commit that added this typo (2e6422444894), so I applied
this fix to my for-linus branch for v5.3.

> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index f4c6121868c3..6768305e4c26 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -9,7 +9,7 @@ Linux PCI Bus Subsystem
>     :numbered:
>  
>     pci
> -   picebus-howto
> +   pciebus-howto
>     pci-iov-howto
>     msi-howto
>     acpi-info
> diff --git a/Documentation/PCI/picebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
> similarity index 100%
> rename from Documentation/PCI/picebus-howto.rst
> rename to Documentation/PCI/pciebus-howto.rst
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
