Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB335EBCE4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiI0INv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiI0INe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:13:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA62ABF27;
        Tue, 27 Sep 2022 01:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D740BCE1763;
        Tue, 27 Sep 2022 08:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD08FC433D6;
        Tue, 27 Sep 2022 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664266139;
        bh=Mb19XfGnPCcnwswVS6PF2KmTYQWlJKV6Z8OZtSEzClo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2XhKXo4qdh4EP/FiVyhKpJbNfTSadbk6ffhXzLFpCd5LdkuJKrvrGxDZNSMZPUDr
         f+GVP1PIIdazNdmzgwRA5JnM7y0wWw/r2kXiEZ2eAlsZPZ1nwI3q6IAZ8JXhFE9tt7
         AhVh5u8vPwP7uoG3jSqUF5TW8RNxY3ZeVh8l1R7yrfrAkDED1u2RvoApRZf/GIjJPM
         tUXFy0jnsjig/CyhzDfHcoVLUxF6JPKFyhE5QrGkveHIWSMj2Eh4nnWz3erMHmBWbS
         vBEBpQI/JvT9WcUFlri1/BbkNYTjsv/HxemmwbbRAxTocCSlog8Fk8UCBfwx6DX9YZ
         1lapEghthd67g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od5eK-0005Ts-QN; Tue, 27 Sep 2022 10:09:04 +0200
Date:   Tue, 27 Sep 2022 10:09:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/5] phy: qcom-qmp-pcie: support separate tables for
 EP mode
Message-ID: <YzKvoN6hplGOKzsr@hovoldconsulting.com>
References: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
 <20220926173435.881688-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926173435.881688-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 08:34:32PM +0300, Dmitry Baryshkov wrote:
> The PCIe QMP PHY requires different programming sequences when being
> used for the RC (Root Complex) or for the EP (End Point) modes. Allow
> selecting the submode and thus selecting a set of PHY programming
> tables.
> 
> Since the RC and EP modes share common some common init sequence, the
> common sequence is kept in the main table and the sequence differences
> are pushed to the extra tables.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 47 +++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index dc8f0f236212..dd7911879b10 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> @@ -1320,10 +1321,14 @@ struct qmp_phy_cfg {
>  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	const struct qmp_phy_cfg_tables tables;
>  	/*
> -	 * Additional init sequence for PHY blocks, providing additional
> -	 * register programming. Unless required it can be left omitted.
> +	 * Additional init sequences for PHY blocks, providing additional
> +	 * register programming. They are used for providing separate sequences
> +	 * for the Root Complex and for the End Point usecases.

"use cases", drop the second "for the".


> +	 *
> +	 * If EP mode is not supported, both tables can be left empty.

s/empty/unset/

>  	 */
>  	const struct qmp_phy_cfg_tables *tables_rc;
> +	const struct qmp_phy_cfg_tables *tables_ep;
>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;

> +static int qmp_pcie_set_mode(struct phy *phy,
> +				 enum phy_mode mode, int submode)

No need for line break.

> +{
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +	case PHY_MODE_PCIE_EP:
> +		qphy->mode = submode;
> +		break;
> +	default:
> +		dev_err(&phy->dev, "Unuspported submode %d\n", submode);

You forgot to fix the "unsupported" typo.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
