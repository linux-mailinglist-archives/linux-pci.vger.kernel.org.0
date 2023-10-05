Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD677BA284
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJEPkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjJEPjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 11:39:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66257E239;
        Thu,  5 Oct 2023 07:52:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5188DC433CA;
        Thu,  5 Oct 2023 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696517385;
        bh=3sV+Kpk/aoS9Ewxx5MLDNTFd0TDttPAvuUnzXSdo9/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aeBU9A4wkKpVleSQBS0RU912dt7oDQeQVY99NMmTq6YmxKN3dh2VGyPwCPcHPTLHf
         eOvTC6eLiHg+xAQ3zUdWo0pPbzW8pLq9AtV2oPcyDyuzAriFblF0jfhNonTYZMtv6m
         161bbkmQQ2I/bWip2oFAG6+Fh6u/memb20bKtw2aBVRyUWyPm4F8b4C/2hZSBAeeDf
         Ex3h2Of1QH6FLKh61m8Wjm2Og6BroPPDbJLtPun0Mr43p1DVuYJRNsXBSxkse71jT+
         P0bcnDsNGU35fdXySL3Bj62LbHvU6iS0ioO3opbdBIYqDJjSlbALLxJ4qdcsZ/B5wK
         9jZegSmhTS7qA==
Date:   Thu, 5 Oct 2023 09:49:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v23 12/16] PCI: add T_PVPERL macro
Message-ID: <20231005144943.GA746077@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926122431.3974714-13-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 09:24:27PM +0900, Yoshihiro Shimoda wrote:
> According to the PCI Express Card Electromechanical Specification,
> Power stable to PERST# inactive interval is 100 ms as minimum.
> So, add the macro to use PCIe controller drivers.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Beautiful, thank you!

No need to repost; whoever applies this, please:

  - s/add/Add/ in subject
  - Add sec 2.9.2 to spec citation in commit log and comment (can use
    "PCIe CEM r5.0, sec 2.9.2" for brevity)

> ---
>  drivers/pci/pci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 39a8932dc340..5ecbcf041179 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,9 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +/* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
> +#define PCIE_T_PVPERL_MS		100
> +
>  /*
>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>   * Recommends 1ms to 10ms timeout to check L2 ready.
> -- 
> 2.25.1
> 
