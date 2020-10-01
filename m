Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749427F92D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 07:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJAF5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAF5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 01:57:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B40C061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 22:57:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l18so1395700pjz.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 22:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kiX+HcnWEaQ/frOzIoE2M7foTxs3fyHoDiIV9RqEj4g=;
        b=UyLt6mK8U5anWM0yWYfYHgN8KUllVC8Z+S8rujEtdgKN+E6GSCjt5ku5WHt1L5Rvg2
         XR7LDStBwn4bXnz7u11QrOJrfHrScCKZcbMtxlX4iZXIbumru1lGOGssooubUMqJHtGt
         WtYRf0OaMywrwlte/hSSyrRN+6Dnl2TmntSsowHISo1Hsw7eZ+blFd7hnE9J/Pq8pxZm
         AuF939JUdGxbUUiGe2VeYtCA59N6wii4ALylbRdt3tQGuga6G0pGrxVed1+rRjKgSis8
         G1qLzrDQj+CpGgfcx02NcbbBOTnk8gX/72KKgURqge8roKLtKCgbT0VmAO+/Byaeimn2
         lSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kiX+HcnWEaQ/frOzIoE2M7foTxs3fyHoDiIV9RqEj4g=;
        b=G2tI1edJYuYefBQYUy7FgsbtKDwgz+xq7KZMWUowjh+Ki2Sv5VoskBXCsipiRA3HjD
         loIwM14v+9sNzsRHaL/RusgPJvV2vnEpa2KEOKdrhmkzHtWoXXcNJP5ShhKzdwWBuRXm
         g+qb50jT6HUuUymxEc+RyNeOlBi6CBd/v/BNj/A1STTTTOUQM1/RsEPYYVTVXOxNMd9K
         UToT/z9t7T+XQHgO7d7jTYAH7dkh/H16eQkBL87xle5lH5SiBkVHaG/E9auFLzdgwyuK
         uvdyf1ATifuOZwvOJrxO4spAkPiQylHeUhwPPYFvDAmqyo6CIGTofNWXBTjT/9TjXRFO
         kV1w==
X-Gm-Message-State: AOAM531sLU7won8Fswy5tucPYDFOQx9Rv/1UnC9XjiuCm4G9TE+QawBE
        VykkkqKnm4xj5UeHwl/gYjdP
X-Google-Smtp-Source: ABdhPJxheAicHAZx58yBCUFoYDzimhPjr2e22zKPIuj3vDiczyWS1xLAJgsp3NExq3YfGP4PMoSn+w==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr5587657pjq.40.1601531866063;
        Wed, 30 Sep 2020 22:57:46 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:188:5adb:1423:88c1:4321:a364])
        by smtp.gmail.com with ESMTPSA id 36sm4129742pgl.72.2020.09.30.22.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 22:57:45 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:27:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add support for configuring BDF to SID
 mapping for SM8250
Message-ID: <20201001055736.GB3203@Mani-XPS-13-9360>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-6-manivannan.sadhasivam@linaro.org>
 <507b3d50-6792-60b7-1ccd-f7b3031c20ac@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507b3d50-6792-60b7-1ccd-f7b3031c20ac@mm-sol.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stan,

On Thu, Oct 01, 2020 at 12:46:46AM +0300, Stanimir Varbanov wrote:
> Hi Mani,
> 
> On 9/30/20 6:09 PM, Manivannan Sadhasivam wrote:
> > For SM8250, we need to write the BDF to SID mapping in PCIe controller
> > register space for proper working. This is accomplished by extracting
> > the BDF and SID values from "iommu-map" property in DT and writing those
> > in the register address calculated from the hash value of BDF. In case
> > of collisions, the index of the next entry will also be written.
> 
> This describes what the patch is doing. But why? Is that done in the
> other DWC low-level drivers or this is qcom specialty?
> 

AFAIK, only some NXP SoCs deal with similar kind of mapping but right now
this is a Qcom only stuff.

> > 
> > For the sake of it, let's introduce a "config_sid" callback and do it
> > conditionally for SM8250.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |   1 +
> >  drivers/pci/controller/dwc/pcie-qcom.c | 138 +++++++++++++++++++++++++
> >  2 files changed, 139 insertions(+)
> > 

[...]

> > +
> > +/* sid info structure */
> > +struct qcom_pcie_sid_info_t {
> 
> why _t postfix? Maybe qcom_pcie_sid ?
> 

Just to differentiate the struct name and its variable. But I can
remove the _t suffix.

> SID - Stream ID ?
> 

Yes! Will expand in commit message also.

> > +	u16 bdf;
> > +	u8 pcie_sid;
> > +	u8 hash;
> > +	u32 smmu_sid;
> > +	u32 value;
> >  };
> >  
> >  struct qcom_pcie {
> > @@ -193,6 +208,8 @@ struct qcom_pcie {
> >  	struct phy *phy;
> >  	struct gpio_desc *reset;
> >  	const struct qcom_pcie_ops *ops;
> > +	struct qcom_pcie_sid_info_t *sid_info;
> > +	u32 sid_info_len;
> >  	int gen;
> >  };
> >  
> > @@ -1257,6 +1274,120 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
> >  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> >  }
> >  
> > +static int qcom_pcie_get_iommu_map(struct qcom_pcie *pcie)
> > +{
> > +	/* iommu map structure */
> > +	struct {
> > +		u32 bdf;
> > +		u32 phandle;
> > +		u32 smmu_sid;
> > +		u32 smmu_sid_len;
> > +	} *map;
> > +	struct device *dev = pcie->pci->dev;
> > +	int i, size = 0;
> > +	u32 smmu_sid_base;
> > +
> > +	of_get_property(dev->of_node, "iommu-map", &size);
> > +	if (!size)
> > +		return 0;
> > +
> > +	map = kzalloc(size, GFP_KERNEL);
> > +	if (!map)
> > +		return -ENOMEM;
> > +
> > +	of_property_read_u32_array(dev->of_node,
> > +		"iommu-map", (u32 *)map, size / sizeof(u32));
> 
> iommu-map is a standard DT property why we have to parse it manually?
> 

So right now we don't have a way to pass this information from DT. And there
is no IOMMU API to parse the fields also. We need to extract this information
to program the hash tables (BDF, SID) as the mapping between BDF and SID is not
1:1 in SM8250.

Perhaps I can add this information in commit message.

> > +
> > +	pcie->sid_info_len = size / (sizeof(*map));
> > +	pcie->sid_info = devm_kcalloc(dev, pcie->sid_info_len,
> > +				sizeof(*pcie->sid_info), GFP_KERNEL);
> > +	if (!pcie->sid_info) {
> > +		kfree(map);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Extract the SMMU SID base from the first entry of iommu-map */
> > +	smmu_sid_base = map[0].smmu_sid;
> > +	for (i = 0; i < pcie->sid_info_len; i++) {
> > +		pcie->sid_info[i].bdf = map[i].bdf;
> > +		pcie->sid_info[i].smmu_sid = map[i].smmu_sid;
> > +		pcie->sid_info[i].pcie_sid =
> > +				pcie->sid_info[i].smmu_sid - smmu_sid_base;
> > +	}
> > +
> > +	kfree(map);
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
> > +{
> > +	void __iomem *bdf_to_sid_base = pcie->parf +
> > +		PCIE20_PARF_BDF_TO_SID_TABLE_N;
> > +	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
> > +	int ret, i;
> > +
> > +	ret = qcom_pcie_get_iommu_map(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!pcie->sid_info)
> > +		return 0;
> > +
> > +	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
> > +
> > +	/* Registers need to be zero out first */
> > +	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
> > +
> > +	/* Initial setup for boot */
> 
> Could you elaborate more what the code below is trying to achieve. Is
> that connected to bootloaders?
> 

No. This is trying to program the hash tables for initial boot but I think this
doesn't make sense here as it will be done all the time. I'll just remove this
comment.

Thanks,
Mani
