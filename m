Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF16D7B04
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjDELTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjDELTL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 07:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E52736;
        Wed,  5 Apr 2023 04:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F5506393E;
        Wed,  5 Apr 2023 11:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C2BC433EF;
        Wed,  5 Apr 2023 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680693549;
        bh=BUqrMf5rugKOvu5i7YMra5i2Meg/d8oi/Wngm9HZQ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbuhl6EJw/SVKi8omiyWSr41YolSgsDeuXiZjJpIzHCnerSej0RciO5pHzzy5e84q
         8hQK0D0/hPvIdJDJaNt4csp029xip1uOKnaxLfournFZFuXTiw44fFh7xeFarH2Ust
         i3PL2nw+WQKul4NY9QXpp5eVHGjVZQT/aASf4AGuNV2utltrnyeCAv67TMneJWV6XS
         0w5acvUiHRzi7atkPH6NaNBQPv5SwiMy0CGWCnTHIeQ3Zt4YtFu9InLfvN2qfQUDeB
         mp4lQS9bEZh4mlN7s7mTnqm7vF5gpLNoZ9IagOymAQSRG4dR2FjLTEf/m8B+n4unro
         hE/uZhLykbtxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pk1Ay-0002dY-9y; Wed, 05 Apr 2023 13:19:40 +0200
Date:   Wed, 5 Apr 2023 13:19:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Fix unit address of example root port
Message-ID: <ZC1ZTHeRqtghwVBB@hovoldconsulting.com>
References: <20230317112019.9090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317112019.9090-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 17, 2023 at 12:20:19PM +0100, Johan Hovold wrote:
> Fix the unit address of the example root port which is identical to the
> device number (i.e. 1).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

This one hasn't showed up in linux-next yet. Could you pick it up for
6.4, Lorenzo?

>  Documentation/devicetree/bindings/pci/pci.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..8b7c52436558 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -76,7 +76,7 @@ Example:
>  pcie@10000000 {
>  	compatible = "pci-host-ecam-generic";
>  	...
> -	pcie@0008 {
> +	pcie@1 {
>  		/* Root port 00:01.0 is external-facing */
>  		reg = <0x00000800 0 0 0 0>;
>  		external-facing;

Johan
