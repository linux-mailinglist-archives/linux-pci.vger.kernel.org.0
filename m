Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BACF462E32
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhK3IIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 03:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhK3IIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 03:08:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A1C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 00:05:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h24so14742798pjq.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 00:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JZnXanF1JncK0+V5i9tCUqeQaS1j9qi6fWSj36F2/GE=;
        b=vt6p/YYS2aHI2KSFoCQuxryGlbAA50u6Oeyv1Xoz/wN2/lWbP4IZYRQxrJQOUOPXeU
         j9Z5B0PxWbkvBFfysdCWstkw7fNIyUdlNzfBGw/MbFTD7iXVS0GAQ5NVaS2+28XtSya9
         k+er8+AzB0KKGaBgXy79lYEAAqqgTDTB2XhYRbwcRfx3oYjk6n812HpZ2ERG6v6K2Vc7
         BNmTLmR4ogoolBnH8bPvXNE8YdlU794hYnWhBzG0qWu+1NqssEW+mACW/xomImUMw/ZY
         kWC61cOk1iAIWIiuLZk4Iyl2+UYI6hZJJun57PJ5Kt4+4S1X8gqdZ95/+NYENJifxJcY
         nhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JZnXanF1JncK0+V5i9tCUqeQaS1j9qi6fWSj36F2/GE=;
        b=aBgYy+V9F2WMtMruvBcKn79phtmtpbfGavFpwI/qT9rQF8tvRI3raASGXGQcJQYx2U
         Z3yKbiidgGqHzWLw8rKo18Vtva8u6BeIuW3hei5TP3yFDlqasdM4KoGOXwTFuaPxNsAN
         DY2tWQHDb3vJWWdVY/Da9J1uHTtHHG6Bq9beVPTu4KBte+MaaDpAoEV18xYPpKJ//+a+
         XE+yJ+Bm/OlC0q/zMUCfSMHLM+mVenkFK0DYMa8NdCx4SB+zmn8Rqo08qDvz4L/3nbK4
         4GOx9GO60t+FDWosEo4K/xD2eW+3bKgSbsG9D3EFtsH9gw9d6bVmfNdklb/Me/yqjt1g
         x1IQ==
X-Gm-Message-State: AOAM5308MvfwBYzmYmiE1yz4VgRFFLpALuEoUtoebLqLj7BoHzefx8gQ
        DPjdVGqfiqN08p6gp+9rQ1Zd
X-Google-Smtp-Source: ABdhPJzbc6VhIs6rZFW+FJ5RNuSh+cTm0jqcZ+453ict2PMd9f7Hf1zV7t5Qk99/vuZK4OG3BF3+Cw==
X-Received: by 2002:a17:90b:1b4a:: with SMTP id nv10mr4169969pjb.87.1638259502730;
        Tue, 30 Nov 2021 00:05:02 -0800 (PST)
Received: from thinkpad ([202.21.42.3])
        by smtp.gmail.com with ESMTPSA id lb4sm1753541pjb.18.2021.11.30.00.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:05:02 -0800 (PST)
Date:   Tue, 30 Nov 2021 13:34:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16()
 return instead of u16
Message-ID: <20211130080456.GE205712@thinkpad>
References: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
 <YaXSoLpIfrTh81/+@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaXSoLpIfrTh81/+@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey,

On Tue, Nov 30, 2021 at 08:28:32AM +0100, Krzysztof Wilczyński wrote:
> Hi Manivannan,
> 
> Thank you for sending the patch over!  Much appreciated!
> 
> A small nitpick, thus feel free to ignore it, of course: if I may, I would
> suggest the following subject:
> 
>   PCI: qcom: Use __be16 type to store return value from cpu_to_be16()
>

Will do
 
> Or something along the lines.
> 
> > cpu_to_be16() returns __be16 value but the driver uses u16 and that's
> > incorrect. Fix it by using __be16 as the datatype of bdf_be variable.
> 
> It would be "data type" in the above.
> 
> Not really a requirement to do so, but you could include the actual
> warning, as sometimes this is useful for reference later, as per:
> 
>   drivers/pci/controller/dwc/pcie-qcom.c:1346:30: warning: incorrect type in initializer (different base types)
>   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    expected unsigned short [usertype] bdf_be
>   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    got restricted __be16 [usertype]
> 

I usually do but as per Bjorn's comment I thought it is not recommended for PCI
subsystem (or maybe I misread his comments). Will add.

> > @@ -1343,7 +1343,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
> >  
> >  	/* Look for an available entry to hold the mapping */
> >  	for (i = 0; i < nr_map; i++) {
> > -		u16 bdf_be = cpu_to_be16(map[i].bdf);
> > +		__be16 bdf_be = cpu_to_be16(map[i].bdf);
> >  		u32 val;
> >  		u8 hash;
> 
> Thank you!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> Also, since I have your attention, it seems we have a number of unused
> macros in the qcom driver, as per:
> 
>   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_BDF_TRANSLATE_CFG            0x24C
>   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SID_OFFSET                   0x234
>   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE          0x16C
> 
> And also in the qcom-ep driver, as per:
> 

These defines are helpful for someone who wants to add some functionality or
even bug fix in the future. Since these controllers are not publically
documented, having these definitions helps a lot.

Thanks,
Mani

>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_BRIDGE_FLUSH_N           BIT(12)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MHI_A7                   BIT(7)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MHI_Q6                   BIT(6)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_SPACE_SIZE              0x358
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PLS_PME                  BIT(17)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_MSB_CTRL                        0x2c0
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_DEBUG                    BIT(4)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_L1SUB_TIMEOUT            BIT(9)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_DBI_BASE_ADDR_HI                 0x354
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_ATU_BASE_ADDR                    0x634
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SLV_ADDR_SPACE_SIZE_HI           0x35c
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_LTR                      BIT(5)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_DBI_BASE_ADDR                    0x350
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_SRIS_MODE                                0x644
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_MMIO_WRITE                       BIT(10)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PLS_ERR                  BIT(15)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_AER_LEGACY                       BIT(14)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_CFG_WRITE                        BIT(11)
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_ATU_BASE_ADDR_HI                 0x638
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:#define PARF_INT_ALL_PME_LEGACY                       BIT(16)
> 
> Are these needed, or would it be fine to drop these?
> 
> 	Krzysztof
