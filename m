Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B183462D7B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 08:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhK3HcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 02:32:02 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:43966 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhK3HcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 02:32:01 -0500
Received: by mail-pj1-f44.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso16405897pjb.2;
        Mon, 29 Nov 2021 23:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iz5wEeRsS04GwX3xBqETJnARTyHG1Ba5oDn/u/+myP8=;
        b=XKId3QStNQkGrTpbR593Z6uBke4qDjLBgsTFPidtDloIiQGRyHWNSJOa95nY1CcunO
         Ef6JyTmICE+BBGqcii2iO7aTK5Zbw+eAb1WhEcgbtq7srwZ2nvitOLSpzpCCtY1ihtkh
         BResbo/zPZBZH4nbp8waAgkxF4LrNIhONv1ryc35wCN8cTeIyN8Csfhgn+vqMKoJdalm
         hI9ZDPybP7YVxFa9F7qE/WazG7SMVhh1+QOABsiZAh5zpGdeLXmE8FLO6hI70LAquPxh
         hDa9zNNUeLNtkjII8LQTRBCTdmayfq47Y5jVx0+ii1LjXCyH7Z5ZsPACq8XgOYpC0vIg
         8L7w==
X-Gm-Message-State: AOAM5338cqBe66Fv1MwFko8kQlkZR8W3cYsweUgDHfkApFs6q4IZsAaq
        DQ7UAEDLcMZKMuOHNON6YqQ=
X-Google-Smtp-Source: ABdhPJwBFzSLckRpxVwWDl/mHPiHMQEZD61fOwq8WhCy6SEBFljPTruH+oE41JFx+FFafXHr2ulzPw==
X-Received: by 2002:a17:90b:3b43:: with SMTP id ot3mr4017318pjb.205.1638257322820;
        Mon, 29 Nov 2021 23:28:42 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v18sm5375354pgo.11.2021.11.29.23.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 23:28:42 -0800 (PST)
Date:   Tue, 30 Nov 2021 08:28:32 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16()
 return instead of u16
Message-ID: <YaXSoLpIfrTh81/+@rocinante>
References: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

Thank you for sending the patch over!  Much appreciated!

A small nitpick, thus feel free to ignore it, of course: if I may, I would
suggest the following subject:

  PCI: qcom: Use __be16 type to store return value from cpu_to_be16()

Or something along the lines.

> cpu_to_be16() returns __be16 value but the driver uses u16 and that's
> incorrect. Fix it by using __be16 as the datatype of bdf_be variable.

It would be "data type" in the above.

Not really a requirement to do so, but you could include the actual
warning, as sometimes this is useful for reference later, as per:

  drivers/pci/controller/dwc/pcie-qcom.c:1346:30: warning: incorrect type in initializer (different base types)
  drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    expected unsigned short [usertype] bdf_be
  drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    got restricted __be16 [usertype]

> @@ -1343,7 +1343,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
>  
>  	/* Look for an available entry to hold the mapping */
>  	for (i = 0; i < nr_map; i++) {
> -		u16 bdf_be = cpu_to_be16(map[i].bdf);
> +		__be16 bdf_be = cpu_to_be16(map[i].bdf);
>  		u32 val;
>  		u8 hash;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Also, since I have your attention, it seems we have a number of unused
macros in the qcom driver, as per:

  drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_BDF_TRANSLATE_CFG            0x24C
  drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SID_OFFSET                   0x234
  drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE          0x16C

And also in the qcom-ep driver, as per:

  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_BRIDGE_FLUSH_N           BIT(12)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MHI_A7                   BIT(7)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MHI_Q6                   BIT(6)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_SPACE_SIZE              0x358
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PLS_PME                  BIT(17)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_MSB_CTRL                        0x2c0
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_DEBUG                    BIT(4)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_L1SUB_TIMEOUT            BIT(9)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_DBI_BASE_ADDR_HI                 0x354
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_ATU_BASE_ADDR                    0x634
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_SPACE_SIZE_HI           0x35c
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_LTR                      BIT(5)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_DBI_BASE_ADDR                    0x350
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SRIS_MODE                                0x644
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MMIO_WRITE                       BIT(10)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PLS_ERR                  BIT(15)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_AER_LEGACY                       BIT(14)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_CFG_WRITE                        BIT(11)
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_ATU_BASE_ADDR_HI                 0x638
  drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PME_LEGACY                       BIT(16)

Are these needed, or would it be fine to drop these?

	Krzysztof
