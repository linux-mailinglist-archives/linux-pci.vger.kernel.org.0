Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550E52A894
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2019 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfEZFsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 May 2019 01:48:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEZFsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 May 2019 01:48:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so7271674pgb.3
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2019 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1mbn5gY5Ly2COk6hSx+B8iGsTtL0c4swiFd6dIhVpI=;
        b=q32mHuXkhsVRJi5P75fk+cYqfmL5FYaU2EF/MxwHcRp5689RwAVCmsRikxIY4pi5Os
         jRC09tMdpss013NPDY6S/WUfPWL/Q+Fde/yTlTluNTt0rXSlTGXLfUE7ubdjuCu5yruQ
         N66RDYti9ea4YxawCDNI2wj6sa/l37+gmuYQN4xreG+KF7xRwiaOUyW6Psf//3Kioyuy
         H1FuCPNP0nvU2h11Ous1UzCDezt+ypwRxbsDWqTxH8oyux37LYhSw3guRTKJ6rKoPqi+
         92w9tBRnCMs52U4X7eRsGGWbD0nd4H7+sM1tutRdYHz8P1oDsn12KcKpriutYq8xhwul
         QhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1mbn5gY5Ly2COk6hSx+B8iGsTtL0c4swiFd6dIhVpI=;
        b=gpScSK/xsdBm/x4CERAqTAxffyUJBMdDkOV71/uygm+ofnlFNJBBYuCKCXu1rBiNhP
         aVP4rOHNdub45qZjEX8lZgs+aiiOA5TQinUGakPmxzz3V6XisGyuh1tuisa2SsNIe0B9
         +k7kFzvg7FWOeEw9Jjt3OJG/JkgCEeIYdgXnfX1FyhsVPXp5eEemlmRR5IlF3cFULI1r
         EZIRPQLJO+kcoj5il0T3g990becMKE4PtbMU8naTFsqumWL7xfuQWjrNcjh7AoiWS6MW
         SWxzO53RWiqJLO0s/pZApcpdtq6E7aZK9Ci5twieNBKAvra4TXa9uSAzlXfMNEBd0qi8
         opaQ==
X-Gm-Message-State: APjAAAXkQuYIHmry39tc+6zJoFJvd039U+xVHhi7u1a0k1mDoAI8Y95x
        7rOeeo+NOYQlo66SlU7luGSQMRIwSCE=
X-Google-Smtp-Source: APXvYqyM+DyIl1ulyTQdPYLeGn3PVr/zhEVyeU3tLpnb4G+2GjthBdDn8D9fu4Zczwn8At2enmO1NQ==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr11245400pfd.171.1558849730290;
        Sat, 25 May 2019 22:48:50 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a64sm6011216pgc.53.2019.05.25.22.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 22:48:49 -0700 (PDT)
Date:   Sat, 25 May 2019 22:49:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least
 100 ms
Message-ID: <20190526054918.GK2085@tuxbook-pro>
References: <20190523194409.17718-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523194409.17718-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 23 May 12:44 PDT 2019, Niklas Cassel wrote:

> Currently, there is only a 1 ms sleep after asserting PERST.
> 
> Reading the datasheets for different endpoints, some require PERST to be
> asserted for 10 ms in order for the endpoint to perform a reset, others
> require it to be asserted for 50 ms.
> 
> Several SoCs using this driver uses PCIe Mini Card, where we don't know
> what endpoint will be plugged in.
> 
> The PCI Express Card Electromechanical Specification specifies:
> "On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
> the power rails achieving specified operating limits."
> 
> Add a sleep of 100 ms before deasserting PERST, in order to ensure that
> we are compliant with the spec.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0ed235d560e3..cae24376237c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
>  
> +	/* Ensure that PERST has been asserted for at least 100 ms */
> +	msleep(100);
>  	qcom_ep_reset_deassert(pcie);
>  
>  	ret = qcom_pcie_establish_link(pcie);
> -- 
> 2.21.0
> 
