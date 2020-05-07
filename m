Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6881C9909
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGSNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 14:13:18 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:37469 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGSNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 14:13:17 -0400
Received: by mail-oo1-f65.google.com with SMTP id v6so1558969oou.4;
        Thu, 07 May 2020 11:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G5yuqVqzlYuNUS6BzsyczFiXvtDmajE6nmIOPOTL+co=;
        b=FV5mqNmrm4ZtMaKZYJEygDtaFfcBF5fjbNc5ELVtmIxHxcSEdZlqbQlCmsNLRL+Lhl
         1n/Ek/JbktpDEflfP/qhLDtPBQ33gCiaZtPb3LD4lnRjjT9+je1TMrjRMlUOF8uw+egm
         QOBMSsaxTiFHMORuXh5pohbtolMCHpE0ZeREx9sgdlQX1vqLZdsEL+ZJ5z4qU7dJfILl
         owSYQCjWAYjFBaAApIQqhFgflGLT9EFQJx6RrADRdoh3q0qsnpnJVuZYUbJRgGkxFFZ7
         uYbKXKZpRBQCgzG3+y3sN3l5TrE2uPMgfzUCmeL9p6FEHI2HkguoSkn8qg234BamDdOQ
         fSVw==
X-Gm-Message-State: AGi0PubG+TRVM7WmVbCF79Ao57pJJzSbW0bz8VRdEE6/w8Utmr5mF7KD
        FzDPmHT/BkvkXe23kFWWng==
X-Google-Smtp-Source: APiQypLnrVJU4jXjyeAEeEq5NZXUl0k0NVDycnKbTqrLkF6KTOGkFNBdqRUalc0CZfs9BzR1UPSByQ==
X-Received: by 2002:a4a:9c55:: with SMTP id c21mr12846656ook.25.1588875195883;
        Thu, 07 May 2020 11:13:15 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t186sm1583007oif.13.2020.05.07.11.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:13:15 -0700 (PDT)
Received: (nullmailer pid 23913 invoked by uid 1000);
        Thu, 07 May 2020 18:13:14 -0000
Date:   Thu, 7 May 2020 13:13:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set tx
 term offset
Message-ID: <20200507181314.GA21663@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-10-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-10-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 12:06:16AM +0200, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add tx term offset support to pcie qcom driver need in some revision of
> the ipq806x SoC.
> Ipq8064 have tx term offset set to 7.
> Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index da8058fd1925..372d2c8508b5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,9 @@
>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12, 16)
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> +
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PHY_REFCLK_SSP_EN			BIT(16)
>  #define PHY_REFCLK_USE_PAD			BIT(12)
> @@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
>  	u32 tx_swing_full;
>  	u32 tx_swing_low;
>  	u32 rx0_eq;
> +	u8 phy_tx0_term_offset;
>  };
>  
>  struct qcom_pcie_resources_1_0_0 {
> @@ -318,6 +322,11 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->ext_reset))
>  		return PTR_ERR(res->ext_reset);
>  
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
> +		res->phy_tx0_term_offset = 7;

Based on my other comments, you'll want to turn this into match data.

> +	else
> +		res->phy_tx0_term_offset = 0;
> +
