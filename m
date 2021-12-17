Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227B1479157
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 17:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhLQQVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 11:21:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhLQQVl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 11:21:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E164B82965;
        Fri, 17 Dec 2021 16:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D0C36AE1;
        Fri, 17 Dec 2021 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639758099;
        bh=huC7uz1dGwNTuzWeqgiNaG3sk3EcmBrJ63xBA1P61zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mxARPdYm02vkR1wXFYlvgPaemHFGDbK6rk8Q8VKGK2inUv6cF06cWgLjrlNCcE57P
         k7NnlyE+Ps3w+SWlHxqIrKLJ6XKiQCWVG5XcLm/rHuNfTyMonUPDp8z1FClHNR2zK4
         3js6fQKPxr2k1IwbKvO/i/1skiFSDdm388/qqWM80bXKWTJd8oHyGjJcLP4b5xTIiX
         mUjkl5MXsfB+7cUKnej+WTSwJVFtBVZOY06cecM/ilXUM9YUdUidyUZcYFdDo6YE4y
         Ohkr6d3W22cfQoYSrx3w/f2X/pL9xyeQC3zRKocib623SbWB4yqaT6yel7pSGgimjI
         KeJ7pC5WHXPvw==
Date:   Fri, 17 Dec 2021 10:21:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/14] dt-bindings: PCI: Add support for Airoha EN7532
Message-ID: <20211217162137.GA894954@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217112345.14029-10-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17, 2021 at 12:23:39PM +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> EN7532 is an ARM based platform SoC integrating the same PCIe IP as
> MT7622, add a binding for it.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Crispin <john@phrozen.org>

Needs a sign-off from you, Felix:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.14#n418

> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 57ae73462272..684227522267 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -7,6 +7,7 @@ Required properties:
>  	"mediatek,mt7622-pcie"
>  	"mediatek,mt7623-pcie"
>  	"mediatek,mt7629-pcie"
> +	"airoha,en7523-pcie"
>  - device_type: Must be "pci"
>  - reg: Base addresses and lengths of the root ports.
>  - reg-names: Names of the above areas to use during resource lookup.
> -- 
> 2.34.1
> 
