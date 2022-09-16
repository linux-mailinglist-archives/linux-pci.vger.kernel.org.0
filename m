Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851EE5BAD63
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIPM0y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPM0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 08:26:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDDAF0F2;
        Fri, 16 Sep 2022 05:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCC24B82695;
        Fri, 16 Sep 2022 12:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8ADC433C1;
        Fri, 16 Sep 2022 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663331209;
        bh=AW6TF25zOisYUbOOZkTVJzAVomJgQKWT2gCcg/cUS7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tsxuq501+aB/6YwnSPXSvYKXkOY2FP4N1HJCXgpbMvAQqOEeKpB0490Ngi8RdqU4d
         uzWOsi3chvT1t8Bijl+HJPoDjiKbv0mA5yUghmQjbO1risXyPzYk3Ouh7tZfHZhSX9
         tqwnQI9dGBt1oF1lCrbrYq+Uqicyp1VBd5q1G64c0VbzeAGsMXMuMEAnFQUCJGFmm4
         JuVeQPa5GQUwq+yvGS8da8mPJ22DrUbcgvShJQl3lwf4qGt4pEBzaga3wYd1z264YC
         rdRexfnTJZZvXG8YR/W17Ga8S1mulbVMPI+N+PqvxewNQv05Erj4i1MQA4FqSU0FWH
         eKF1qUVhkdXSA==
Date:   Fri, 16 Sep 2022 14:26:43 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: mvebu: use BIT() and GENMASK() macros instead
 of hardcoded hex values
Message-ID: <YyRrg8IZxK8aQSBE@lpieralisi>
References: <20220905185150.22220-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905185150.22220-1-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 08:51:49PM +0200, Pali Rohár wrote:

You must add a commit log, ditto for (2/2).

Thanks,
Lorenzo

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 8bde4727aca4..c222dc189567 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -44,7 +44,7 @@
>  #define PCIE_WIN5_BASE_OFF	0x1884
>  #define PCIE_WIN5_REMAP_OFF	0x188c
>  #define PCIE_CONF_ADDR_OFF	0x18f8
> -#define  PCIE_CONF_ADDR_EN		0x80000000
> +#define  PCIE_CONF_ADDR_EN		BIT(31)
>  #define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
>  #define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
>  #define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
> @@ -70,13 +70,13 @@
>  #define  PCIE_INT_ERR_MASK		(PCIE_INT_ERR_FATAL | PCIE_INT_ERR_NONFATAL | PCIE_INT_ERR_COR)
>  #define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
>  #define PCIE_CTRL_OFF		0x1a00
> -#define  PCIE_CTRL_X1_MODE		0x0001
> +#define  PCIE_CTRL_X1_MODE		BIT(0)
>  #define  PCIE_CTRL_RC_MODE		BIT(1)
>  #define  PCIE_CTRL_MASTER_HOT_RESET	BIT(24)
>  #define PCIE_STAT_OFF		0x1a04
> -#define  PCIE_STAT_BUS                  0xff00
> -#define  PCIE_STAT_DEV                  0x1f0000
>  #define  PCIE_STAT_LINK_DOWN		BIT(0)
> +#define  PCIE_STAT_BUS			GENMASK(15, 8)
> +#define  PCIE_STAT_DEV			GENMASK(20, 16)
>  #define PCIE_SSPL_OFF		0x1a0c
>  #define  PCIE_SSPL_VALUE_SHIFT		0
>  #define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
