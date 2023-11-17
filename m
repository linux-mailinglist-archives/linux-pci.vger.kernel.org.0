Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098B7EF0A5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKQKgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQKgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:36:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C02B9;
        Fri, 17 Nov 2023 02:36:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58447C433C7;
        Fri, 17 Nov 2023 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700217398;
        bh=US34hMxupTHZ9TsBDq1dqsqsLDXa5zqsP2aagnEpwKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR6SB/dR/hVs2o/TszmjzGLOeimKanmbfi2ETFu4k5U890FEwX+E3cbJYpPUvVchv
         eYyPt/9i2ejlP//6KUHJ+qtNIyDxXc4H60sE91eg+CgdoPCmb8Y8MrIaCReO9U4Qfg
         a+MI3ZVsdgEHCF8Mjd8MkfS8GUC1USIdY33mJKC9GjYuQ2z9mfWllQVwp+0wTnZmd6
         Uu9u53mLL6URdgK+w4RePlVR0pdHm9ZAMBsGts25rlzBAvZy/awnzkqpSu1wr0HMq6
         WiO+pAMpaQcLPZaygSdcctl1vMCk3YwKAIYYnp8aa9yAaCYpQu7mh4tbeQFITTn+IM
         V5Uy2XjfLHWyg==
Date:   Fri, 17 Nov 2023 16:06:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] PCI/ASPM: Add lockdep assert to link state helper
Message-ID: <20231117103630.GO250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114135553.32301-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:55:53PM +0100, Johan Hovold wrote:
> Add a lockdep assert to the locked disable link state helper which
> should only be called with a pci_bus_sem read lock held.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pcie/aspm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 19b7256d2dc9..ef2e7a186f57 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1090,6 +1090,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
>  
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  {
> +	lockdep_assert_held_read(&pci_bus_sem);
> +
>  	return __pci_disable_link_state(pdev, state, true);
>  }
>  EXPORT_SYMBOL(pci_disable_link_state_locked);
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
