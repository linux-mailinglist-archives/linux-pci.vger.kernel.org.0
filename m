Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8E543BC8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiFHSxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiFHSxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1111742A5;
        Wed,  8 Jun 2022 11:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAA461C2C;
        Wed,  8 Jun 2022 18:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4613C34116;
        Wed,  8 Jun 2022 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654714396;
        bh=zEZS8wnr96oLeHkF7a5j7Jb1tu3P7t9B5UyyKqQuo5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QyLIK/zSQg/im0iyAEdHqWYH7sSC8snRcCjj5DYxwNgb9bfaSBucn6ZW35l5am89A
         kyAjv+MjWdOt2dYcwWTPQ1DFaEdzAHL64FQgo4QQqFHJc5mrl5FjtRWD85UiCq1Lc3
         RQzO9FOjnPF6OQEzsMDCk7N4XPrqhGE2f+3WV4ud7iqBu2v68VWrQeBgmB1pviGylL
         /7Q7wEDNa2HmFf5bRk347PQeSndxninI6Uets0th4h68K+S3R2uW5MfVI1aRBYEy3D
         vy/UnijJgBDp5DbPgSxDMUvTHo6+arkP+0PkfqqLxz1yibN9wbPN0aIFwamLsyrpXm
         vtRlAMN1j/5Fg==
Date:   Wed, 8 Jun 2022 13:53:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v9 2/8] PCI: imx6: Add the error propagation from
 host_init
Message-ID: <20220608185313.GA410761@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651801629-30223-3-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 09:47:03AM +0800, Richard Zhu wrote:
> Since there is error return check of the host_init callback, add error
> check to imx6_pcie_deassert_core_reset() function, and change the
> function type accordingly.

> @@ -878,11 +879,18 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  static int imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +	int ret;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
> -	imx6_pcie_deassert_core_reset(imx6_pcie);
> +	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pcie host init failed: %d.\n", ret);

Other messages from this driver do not include a trailing period.
