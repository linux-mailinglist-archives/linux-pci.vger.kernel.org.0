Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DF508CA1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiDTQBQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiDTQBP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA7326D6;
        Wed, 20 Apr 2022 08:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769D8618FA;
        Wed, 20 Apr 2022 15:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A839EC385A1;
        Wed, 20 Apr 2022 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650470307;
        bh=VvLMFQx+kyGUgqKbI5QdNFQWU8MFY2kgwwVYHLQ1fjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Al1tKU0PVMhdgvBzcru+cjod1p0+mweJT3K9CV5c+C9Pgfz7Tw4QPaGjXyVYsWtB5
         xgTwiHh8kHcD+FpxZzTx2vwEo5iT6Yv9fZ7FFQZNzCmpcdoTOU3gEjy2sQjt+TVYGc
         befJfu4gftHbZdludJ669rTmJI7BxUpySPFzHaOe8sytcI+fiNZO520CFnkXMYAKy8
         6eh/A7Jal0X353b3UX8SloBkNA9/8RFhVa24aU/acM4gS4Hp1UKlGMQVbf1z8Cb7Vp
         QSQEoqfY6a56IoidVgyfwm9nEDJNjKc29U6SoAfoZ+/b5LvUK8q+QLGtcfqj4SirZl
         KUP7qEn+kzh0g==
Date:   Wed, 20 Apr 2022 10:58:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: fix unused pci_restore_standard_config without
 suspend/hibernate
Message-ID: <20220420155825.GA1298368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420141135.444820-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 04:11:35PM +0200, Krzysztof Kozlowski wrote:
> The pci_restore_standard_config() is called only by functions within
> CONFIG_SUSPEND or CONFIG_HIBERNATION, so a configuration with only PM
> leads to a warning:
> 
>   drivers/pci/pci-driver.c:533:12: error: ‘pci_restore_standard_config’ defined but not used [-Werror=unused-function]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to pci/pm for v5.19, thanks!

> ---
>  drivers/pci/pci-driver.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dc18c1faf5e5..a2e6aabfa324 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -522,9 +522,9 @@ static void pci_device_shutdown(struct device *dev)
>  		pci_clear_master(pci_dev);
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  
> -/* Auxiliary functions used for system resume and run-time resume. */
> +/* Auxiliary functions used for system resume. */
>  
>  /**
>   * pci_restore_standard_config - restore standard config registers of PCI device
> @@ -544,6 +544,11 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
>  	pci_pme_restore(pci_dev);
>  	return 0;
>  }
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_PM
> +
> +/* Auxiliary functions used for system resume and run-time resume. */
>  
>  static void pci_pm_default_resume(struct pci_dev *pci_dev)
>  {
> @@ -558,8 +563,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  	pci_restore_state(pci_dev);
>  	pci_pme_restore(pci_dev);
>  }
> -
> -#endif
> +#endif /* CONFIG_PM */
>  
>  #ifdef CONFIG_PM_SLEEP
>  
> -- 
> 2.32.0
> 
