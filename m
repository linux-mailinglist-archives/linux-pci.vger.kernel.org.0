Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA26C3ACA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCUTiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCUTiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137D20D01
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A64E61DE8
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 19:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F6C433EF;
        Tue, 21 Mar 2023 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679427368;
        bh=xNhJkoWeys0XGRIS/dbJCM88XAaTUzUgp55h8H8U2Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQq1ww+5DdqR4vEP4j3OLHZoGon2iuJmMcGC0H8UwT9Eow5H1jKc+f+EL6M/GI/5E
         IQREWbrrHnlBLX/BqIkwqH2w6+JyfNVIh8L2TjR15VDjmbHiEWVf5hPIz5sHuN+Hjr
         CobPNP0c0GtPGrW2gKErfp20NwVl/aIWr+y+F/LOSCDdJlp6aU8/fdacguBJhob0Nu
         AE6CW6SUGdGNbJUEYxjr/MMyw2mQzub+BChRf4h3lpyUHM7awwt489x+REFFYrDIKO
         UUN4DxrHfaQyrlyyLrCWtMFYA5c875YlcCtve+QtN3rk7qEdpYlFb4YUsLq0Fe5VER
         pbQuYWT66tfOg==
Received: by pali.im (Postfix)
        id 92291582; Tue, 21 Mar 2023 20:36:04 +0100 (CET)
Date:   Tue, 21 Mar 2023 20:36:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 01/15] PCI: aardvark: Convert to platform remove callback
 returning void
Message-ID: <20230321193604.7iopueamqtaqrlfi@pali>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
 <20230321193208.366561-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321193208.366561-2-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 21 March 2023 20:31:54 Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

There are more important fixes for this driver waiting on the list, so I
do not see reason for sending such unimportant change for this driver
which does not fix any issue. I would suggest to put this change at the
end of the pending queue of aardvark patches to prevent any rebasing of
the important fixes patches and possible merge conflicts.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/pci-aardvark.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 513d8edf3a5c..71ecd7ddcc8a 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1927,7 +1927,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int advk_pcie_remove(struct platform_device *pdev)
> +static void advk_pcie_remove(struct platform_device *pdev)
>  {
>  	struct advk_pcie *pcie = platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> @@ -1989,8 +1989,6 @@ static int advk_pcie_remove(struct platform_device *pdev)
>  
>  	/* Disable phy */
>  	advk_pcie_disable_phy(pcie);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id advk_pcie_of_match_table[] = {
> @@ -2005,7 +2003,7 @@ static struct platform_driver advk_pcie_driver = {
>  		.of_match_table = advk_pcie_of_match_table,
>  	},
>  	.probe = advk_pcie_probe,
> -	.remove = advk_pcie_remove,
> +	.remove_new = advk_pcie_remove,
>  };
>  module_platform_driver(advk_pcie_driver);
>  
> -- 
> 2.39.2
> 
