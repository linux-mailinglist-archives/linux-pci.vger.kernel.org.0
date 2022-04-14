Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8729B501BF6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiDNTaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbiDNTaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 15:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF37ECB1A;
        Thu, 14 Apr 2022 12:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD7C61D46;
        Thu, 14 Apr 2022 19:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CFC385A1;
        Thu, 14 Apr 2022 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649964452;
        bh=KnMJB1zO5X3qgQXNARs/Rriw7wFtyJlRQ7Vu8tNqNNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JkEC3OGQavU5xCzgOxJRs8/hPF6uB7IexQKFtClIx00CflVCUdm/+GAUuYgjdl4W2
         QKWFuNf75EJ/ieS8U1kPssWKsQEf6HA5VDhIiYJ28xs+kY4iGk2UWfQd/C/V1uvDS2
         qiW31TXWqYa+s+7GWadfSA9DGE2jJwftVOJL7dx8MSs5BAdTM9ZtDZoGcw7O9YnZ3c
         Eei8MVf2YeepVsvvLYUNQa3qVEDDZ3VqUkjVC/ymyWhdQsVXHoQp9ISUsJsjF62AYy
         zLkC3SJPLN+uT3VR8CzR4nogeWL5QjjWvfCW0CZ9OWAMui3bvLJ3lXu2EgBwAXWeHY
         OzsUouLfPpPNw==
Date:   Thu, 14 Apr 2022 14:27:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Message-ID: <20220414192730.GA763552@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311234938.8706-2-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 11, 2022 at 05:49:35PM -0600, Li Yang wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This property is to indicate the endianness when accessing the
> PEX_LUT and PF register block, so if these registers are
> implemented in big-endian, specify this property.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index f36efa73a470..215d2ee65c83 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -40,6 +40,10 @@ Required properties:
>    of the data transferred from/to the IP block. This can avoid the software
>    cache flush/invalid actions, and improve the performance significantly.
>  
> +Optional properties:
> +- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
> +  this property.

What's the purpose of this?  I don't see any code that uses this
property.

I guess this might be related to of_device_is_big_endian()?  I do see
some code that uses of_device_is_big_endian(), but nothing that looks
relevant to layerscape in particular.

>  Example:
>  
>  	pcie@3400000 {
> -- 
> 2.25.1
> 
