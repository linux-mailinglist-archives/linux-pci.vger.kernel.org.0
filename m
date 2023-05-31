Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF807189C6
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEaTCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEaTCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 15:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8330FA3;
        Wed, 31 May 2023 12:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 185C163131;
        Wed, 31 May 2023 19:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35457C433EF;
        Wed, 31 May 2023 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685559750;
        bh=vu5Qjh+VB1GDRs5s1cdR+tuxP7UelRPqE3c33LlYEJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bOvXz+L3v70OxM0QZ95wPRW3XwWjg/e3v5jXibLPWljPtST7UglAxPNe6uqLouG+E
         vawYzs5G/x9QhfB8i7RPtbeb+6BjLr1lU+kTc0KBxumX5TtT07QMRlJ2eIhPL/l6t0
         eMKCF0+zoQyTaj41D8TvmUr/pEaqH98cfAdN4ZlZ9G6MV4guPQ/pkBS/G9YSPRwMda
         TchlsMvrQVmcIlw9UywyZmnjYnFrp7Yi19YCiDWqkeEjp9rxIfKgZeGh1blFAZvAvc
         QGb3w7fwEbnoY2YAhNuoLMLJk44nCdutBqQ0iihZkAoJS5eMu2b0UfCGQTuqgHlXg0
         anje3ozSPud3A==
Date:   Wed, 31 May 2023 14:02:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: updated max-link-speed for newer
 generations
Message-ID: <ZHeZxPRGw+X83V1k@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531092121.291770-2-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Possible subject:

  dt-bindings: Add gen5, gen6 max-link-speed values

On Wed, May 31, 2023 at 10:21:21AM +0100, Ben Dooks wrote:
> Add updated max-link-speed values for newer generation PCIe link
> speeds.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..56391e193fc4 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -22,8 +22,9 @@ driver implementation may support the following properties:
>     If present this property specifies PCI gen for link capability.  Host
>     drivers could add this as a strategy to avoid unnecessary operation for
>     unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> +   unsupported link speed, etc.  Must be '6' for gen6,  '5' for gen5,
> +   '4' for gen4, '3' for gen3, '2' for gen2, and '1' for gen1.
> +   Any other values are invalid.

I really wish we'd used values with some connection to the actual
speed, e.g., "16" for 16 GT/s.  These "gen X" values are a real hassle
to convert back to the speed.  But I guess that's water under the
bridge.

Maybe we should annotate the documentation here, though, e.g.,

  '6' for gen6 (64.0 GT/s), '5' for gen5 (32.0 GT/s), ...

Do I have that right?  I don't see "gen5" etc in the specs themselves,
so this is just based on Google.

Bjorn
