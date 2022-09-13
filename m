Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128F5B78E1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiIMRw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiIMRwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:52:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16766B8CB
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so2490998pjo.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mOxAMUogtoyYUzgUNAUeU/aryd/IVil8/scHRPr/eFw=;
        b=aarOS6S7gYd7JGHJjJgCzUOjml0HcNO0Qmcym4j8zO0MvyOYbMrv0NxMtO2a/biFeQ
         o0Xqn+dWFXNJzrgeE2QE0cSXP23X8q+mc2+Y6jcWYs42+TLO57Qj5PF0GOfSZ+W3oDop
         Hjd10pmYMHhG34tcVzS6yGrrZp3Jgsl5RznXwu3BH0iHpUWU+Bce0fwXz7z4e4xFEDuO
         nGFvSS7r9yJdv+sDJ0OrxlFZKj9accAm479+GhXPR0rBu3//OAY6e+jcJ1GhJdtdGVpp
         RqTSvPnZpP/tVL/Uljnzi5t/dbPPqTDnARrx5Om9TX8+H8yd08jvpc3rKWAzudTSlLp8
         qvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mOxAMUogtoyYUzgUNAUeU/aryd/IVil8/scHRPr/eFw=;
        b=AUJV8YHWCntgvGZ/C/Cx/0P5W47Gjedn4XPMN7/a9c3SpQP5DD0PiWLlDD6vaw5yso
         bF733GbDs3pphQPddNw4zZS61G9W7mOlOhzKi6xXPAxaLJCzmz1QJ06NQWaMPY3vXPxb
         EKg5KR6zl640yOvt0bgzrNUMsnpidPlyyWpWa6IcD6NWlh/s3x++MY778JFHA+uj67MZ
         FGetkNVAqimASgoSPibedgi/Pv2IMSqLc7eAu2xyxV/h9w8zMLg/sxpwt3+UJmd3VJzY
         kvvYaKj63xwMIfnYnEb7ixO7u1mbVrqNunOWDhOJr2btKnP4ZO3GOsyuac3NFc7xs/RP
         lPWA==
X-Gm-Message-State: ACgBeo3amSZBOTWNcWqg9O0JY5WL75MXnGtB8ph5aDGTvBV5uDP2p3xY
        3po9cGzx22KShwwBoO9q5xWt
X-Google-Smtp-Source: AA6agR5G8ywMFC6Ev8+ovqpgBABc21gMNzFuXa9i0WAbkzl9/zuBT2661JF0GnSjQQYvMlf9iMJogg==
X-Received: by 2002:a17:903:186:b0:178:2ca7:fae5 with SMTP id z6-20020a170903018600b001782ca7fae5mr11829857plg.173.1663087925186;
        Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017854cee6ebsm335327plg.72.2022.09.13.09.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 09:52:04 -0700 (PDT)
Date:   Tue, 13 Sep 2022 22:21:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220913165159.GH25849@workstation>
References: <20220913101237.4337-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913101237.4337-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> not having an endpoint connected to the slot is not an error.
> So, changing the macro from dev_err to dev_info to log the event.
> 

But the link up not happening is an actual error and -ETIMEDOUT is being
returned. So I don't think the log severity should be changed.

Thanks,
Mani

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 650a7f22f9d0..25154555aa7a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> -		dev_err(pci->dev, "Phy link never came up\n");
> +		dev_info(pci->dev, "Phy link never came up\n");
>  		return -ETIMEDOUT;
>  	}
>  
> -- 
> 2.17.1
> 
