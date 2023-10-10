Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D47C019F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJJQ3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjJJQ3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:29:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BE93;
        Tue, 10 Oct 2023 09:29:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7414FC433C7;
        Tue, 10 Oct 2023 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696955387;
        bh=2yjmYeF5BHJBKV8W3tqM5P5MMJUgXgPBqJIgjiDA92w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Nr6M0O3MHp7l6KVRca4pqzSgQ+Ik2CGxx12mR4Xa+AAprnubSwBbyPYlwiAdwqcoS
         qYAPsmTgG8I8i7V35I9x8sPwKP2BMxe2TsbmDjBmFO3BeNvobB2kceq+XoV4xEfm+N
         I0tMDULKeTSQLoViAi5Nq2NHZUgqbqjOGRwVZ496JPB7jQ8quHHID2Rwik7wyWWKR2
         2SqVLYWH19rZXyYwWjaGbYVf5TZvT9V/6L2v9vulZnTh3aiF5xFxg3SCsirGh0VKdp
         2rbwDlmfhWuXy/pgJU6oOcLBuOmtdYd+s04fpHUhZvp5GsXpeEVyJTZUTeBBx2S/Ph
         7G9GFOLmF8lZw==
Date:   Tue, 10 Oct 2023 11:29:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Enable ASPM for platforms supporting
 1.9.0 ops
Message-ID: <20231010162945.GA978270@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010155914.9516-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 09:29:14PM +0530, Manivannan Sadhasivam wrote:
> ASPM is supported by Qcom host controllers/bridges on most of the recent
> platforms and so the devices tested so far. But for enabling ASPM by
> default (without Kconfig/cmdline/sysfs), BIOS has to enable ASPM on both
> host bridge and downstream devices during boot. Unfortunately, none of the
> BIOS available on Qcom platforms enables ASPM.

I think this covers over a PCI core defect.  If the devices advertise
ASPM support, which both the qcom host controller and the endpoint
devices do, the PCI core should be able to enable it without being
prodded as this patch does.

We had a long conversation about this at [1], but never came to a good
resolution.  Since we don't know how to fix the PCI core issue, I
guess we have no choice but to do things like this patch, at least for
now.

If/when we ever *do* fix the PCI core issue, it would likely result in
enabling ASPM (if advertised by both ends of the link) for *all* qcom
controllers, not just the 1.9.0 ones.

And I think that even today, users can enable ASPM on non-1.9.0
controllers via sysfs.  So if you are concerned about ASPM not being
tested on those controllers, you may want to make them not advertise
ASPM support.

Even with this patch, I guess hot-added devices don't get ASPM
enabled?  That's basically what [1] is about.

Bjorn

[1] https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/

> Due to this, the platforms
> making use of Qcom SoCs draw high power during runtime.
> 
> To fix this power issue, users/distros have to enable ASPM using configs
> such as (Kconfig/cmdline/sysfs) or the BIOS has to start enabling ASPM.
> The latter may happen in the future, but that won't address the issue on
> current platforms. Also, asking users/distros to enable a feature to get
> the power management right would provide an unpleasant out-of-the-box
> experience.
> 
> So the apt solution is to enable ASPM in the controller driver itself. And
> this is being accomplished by calling pci_enable_link_state() in the newly
> introduced host_post_init() callback for all the devices connected to the
> bus. This function enables all supported link low power states for both
> host bridge and the downstream devices.
> 
> Due to limited testing, ASPM is only enabled for platforms making use of
> ops_1_9_0 callbacks.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 367acb419a2b..c324c3daaa5a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -222,6 +222,7 @@ struct qcom_pcie_ops {
>  	int (*get_resources)(struct qcom_pcie *pcie);
>  	int (*init)(struct qcom_pcie *pcie);
>  	int (*post_init)(struct qcom_pcie *pcie);
> +	void (*host_post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -967,6 +968,22 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
  }
>  
> +static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> +{
> +	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> +}
> +
>  static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -1219,9 +1236,19 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	pcie->cfg->ops->deinit(pcie);
>  }
>  
> +static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (pcie->cfg->ops->host_post_init)
> +		pcie->cfg->ops->host_post_init(pcie);
> +}
> +
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.host_init	= qcom_pcie_host_init,
>  	.host_deinit	= qcom_pcie_host_deinit,
> +	.host_post_init	= qcom_pcie_host_post_init,
>  };
>  
>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1283,6 +1310,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_7_0,
>  	.init = qcom_pcie_init_2_7_0,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.config_sid = qcom_pcie_config_sid_1_9_0,
> -- 
> 2.25.1
> 
