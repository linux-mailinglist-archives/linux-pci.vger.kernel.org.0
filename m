Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E687EF05C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjKQK3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345827AbjKQK3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:29:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F0DD51;
        Fri, 17 Nov 2023 02:29:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C514C433C7;
        Fri, 17 Nov 2023 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700216943;
        bh=6ojBfPtGsykYO6BkGzyzKQW4IsE0MACKzcENBodryjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAzrvEpg87B/5pkgFMFV67PnJ3Yp9jFqRDNJ8Vt5NGj3xC8VZvrGUisrv6B1Ki/Uh
         pmJaql2Hf/poztSX8w9nDtnn/7GEHWJz1FotKlr7dkS6TvIEsivXJYY2R/mjx0QNSB
         eKCcNr885umgAF++UKTbNsU6YFi3hCbYM8BtvSwcYxRvD4WEpmvV2XKYngqbdbbJEP
         YUn4KoM04Z83s5cGJ0nbMnCS7s7zVRlvpoTrOHd6v+OVWNvmxn7tqSccpkzBHOrBcE
         03705HR/Lbi0dKt4dpnODqkflREzkjR+lFPfgHflzaix+ykfGOqozjYmMj5JWgkotX
         aoTThAV2WEO7A==
Date:   Fri, 17 Nov 2023 15:58:55 +0530
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
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 3/6] PCI: qcom: Fix deadlock when enabling ASPM
Message-ID: <20231117102855.GL250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114135553.32301-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:55:50PM +0100, Johan Hovold wrote:
> The qcom_pcie_enable_aspm() helper is called from pci_walk_bus() during
> host init to enable ASPM.
> 
> Since pci_walk_bus() already holds a pci_bus_sem read lock, use the new
> locked helper to enable link states in order to avoid a potential
> deadlock (e.g. in case someone takes a write lock before reacquiring
> the read lock).
> 
> This issue was reported by lockdep:
> 
>    ============================================
>    WARNING: possible recursive locking detected
>    6.7.0-rc1 #4 Not tainted
>    --------------------------------------------
>    kworker/u16:6/147 is trying to acquire lock:
>    ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_enable_link_state+0x74/0x1e8
> 
>    but task is already holding lock:
>    ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc
> 
>    other info that might help us debug this:
>     Possible unsafe locking scenario:
> 
>           CPU0
>           ----
>      lock(pci_bus_sem);
>      lock(pci_bus_sem);
> 
>     *** DEADLOCK ***
> 
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ce3ece28fed2..21523115f6a4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -971,7 +971,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
>  {
>  	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
>  	pci_set_power_state(pdev, PCI_D0);
> -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
