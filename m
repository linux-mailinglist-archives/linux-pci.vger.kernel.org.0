Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EE4EAF8E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiC2Osw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiC2Ost (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 10:48:49 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC5A94C5;
        Tue, 29 Mar 2022 07:47:06 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-de3ca1efbaso18917452fac.9;
        Tue, 29 Mar 2022 07:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNacSkhtv5IJOB39+Ynb54nY/qoQFWMGRXyHWBxG+7Y=;
        b=0MJS3FKGQvT25KuuUgAQeQGNkykjGu/RIiMwo6dA5wLxx6ZBkFh1S8qgyxkuahZIDb
         nelr8V2XbEQAF9PI4ZdWOpsJjhnfNp9hR5Jd5nTE+xjXK+3gs6Diu/BUFbVV3jY/BaYQ
         wRcmbFXoNXCFD8bJ6KwX7N2GBUlXlu61MFU/74rDUTDFeJg2VqID1T8KM4oStyLGSGKW
         nNqY3fDxIRGls9BIoOvcD0DiQxwcwce7G+S8fDdXlMLNh6sWhHxWNyQ1889lBtxxAxlj
         0/LFDPwlwhI/8cX37KNnB4ddF5O3iDV16RKfb0ZDeGKVhwpxq/lJfa07SNXtyKUgUCPK
         AWsw==
X-Gm-Message-State: AOAM532/FOEz4i/Zsep+mBKewRjtCZzEleOaOfhSPxv8Pjy6nBWAHCtM
        c3QKK5biSX5s6fkDmbCxqbikRv34cQ==
X-Google-Smtp-Source: ABdhPJxlmvBOjomcLq2SRUquEzBWLffZw3P2b+KP+xjs/3Rn7ha/syyvw9fwqdrvqE9O1XpHRRdK9g==
X-Received: by 2002:a05:6870:e253:b0:dd:a40e:ae92 with SMTP id d19-20020a056870e25300b000dda40eae92mr1619644oac.233.1648565225325;
        Tue, 29 Mar 2022 07:47:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h8-20020a056830400800b005cdceb42261sm6068792ots.66.2022.03.29.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:47:04 -0700 (PDT)
Received: (nullmailer pid 643208 invoked by uid 1000);
        Tue, 29 Mar 2022 14:47:02 -0000
Date:   Tue, 29 Mar 2022 09:47:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] PCI: dwc: Add more verbose link-up message
Message-ID: <YkMb5lT91ZveLTgg@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:37:21AM +0300, Serge Semin wrote:
> Printing just "link up" isn't that much informative especially when it
> comes to working with the PCI Express bus. Even if the link is up, due to
> multiple reasons the bus performance can degrade to slower speeds or to
> narrower width than both Root Port and its partner is capable of. In that
> case it would be handy to know the link specifications as early as
> possible. So let's add a more verbose message to the busy-wait link-state
> method, which will contain the link speed generation and the PCIe bus
> width in case if the link up state is discovered. Otherwise an error will
> be printed to the system log.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 22 +++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6e81264fdfb4..f1693e25afcb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -528,14 +528,26 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  
>  	/* Check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (dw_pcie_link_up(pci)) {
> -			dev_info(pci->dev, "Link up\n");
> -			return 0;
> -		}
> +		if (dw_pcie_link_up(pci))
> +			break;
> +
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}
>  
> -	dev_info(pci->dev, "Phy link never came up\n");
> +	if (retries < LINK_WAIT_MAX_RETRIES) {
> +		u32 offset, val;
> +
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +		dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +			 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +			 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));

Given these are standard registers can we do this in the core code? The 
main issue I think is that the config space accessors don't work until 
you create the bus struct. That still should be early enough.

I think it is possible some implementations don't report the link state 
in these registers. Maybe we don't really need to care.

Rob
