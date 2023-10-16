Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C57CB4F4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPU6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPU6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 16:58:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C68A7;
        Mon, 16 Oct 2023 13:58:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26FC433CA;
        Mon, 16 Oct 2023 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697489931;
        bh=dG6ltN79kbyGWDglciCzr1VcAQsge3LhDKGwMHp5vHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eHzBwg4p0suzaWPxo7lFCGwAAe15zegAj/iPL8AvWhjQaXH5tyZ9Qza55p8o25OT/
         VBFCgIMnndzrFWAuq/S72FGLecv5OarJHzYpa5wm0Lkjv2wMCU53p2rSoY9pKO3MCG
         o/a9t+IjiTRnWsgal/zhUnnBLvpufK1QDp7Y5+qYvpYr6dTuuLCor//08g1TJ1S9us
         D9KlRE8dRSpE6KsElyH6XjjHy2gSKduZ1ReW4mL8AbSiAJsoT+TJR40+y1pNU8kClG
         w0F/FW88GBQZKeNn4Dn76HFDIfzZRGSJerQM1+FL46HzYCK9uNrUHBzMB5D5FYL8n2
         q3dXwjr/0XCrQ==
Date:   Mon, 16 Oct 2023 15:58:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add host_post_init() callback
Message-ID: <20231016205849.GA1225381@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010155914.9516-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 09:29:13PM +0530, Manivannan Sadhasivam wrote:
> This callback can be used by the platform drivers to do configuration once
> all the devices are scanned. Like changing LNKCTL of all downstream devices
> to enable ASPM etc...
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a7170fd0e847..7991f0e179b2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -502,6 +502,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_stop_link;
>  
> +	if (pp->ops->host_post_init)
> +		pp->ops->host_post_init(pp);

I know we talked about this a little bit in the context of enabling
ASPM for devices below qcom 1.9.0 controllers at
https://lore.kernel.org/r/20231011050058.GC3508@thinkpad

But I didn't realize at the time that this callback adds a fundamental
difference between devices present at boot-time (these devices can be
affected by this callback) and any devices hot-added later (we never
run this callback again, so anything done by .host_post_init() never
applies to them).

We merged this for now, and it helps enable ASPM for builtin devices
on qcom, but I don't feel good about this from a larger DWC
perspective.  If other drivers use this and they support hot-add, I
think we're going to have problems.

>  	return 0;
>  
>  err_stop_link:
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ef0b2efa9f93..efb4d4754fc8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -301,6 +301,7 @@ enum dw_pcie_ltssm {
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> +	void (*host_post_init)(struct dw_pcie_rp *pp);
>  	int (*msi_host_init)(struct dw_pcie_rp *pp);
>  	void (*pme_turn_off)(struct dw_pcie_rp *pp);
>  };
> -- 
> 2.25.1
> 
