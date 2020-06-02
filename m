Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734F71EC0B7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgFBRHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 13:07:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5342C05BD1E;
        Tue,  2 Jun 2020 10:07:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so13456506ejb.10;
        Tue, 02 Jun 2020 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=V/+GyojHTJmw9bNM7yNcM312FFXJq2IqXj9L0INWy7Q=;
        b=oUihOM2aArIzupffsfqXi1JfMuJRjqs3ARf07yCOOfjJhx4qfwVGnr8L9/mO59fxG7
         YkoiGX2HQF1N0bdzc/cIoLLF6N8ELK3bcnZ7sNlBInF/kF38+CiSP77QfXS6ocfJua7y
         WijyaTNFtN9g95rE2qp/MyO/TTe9toSOFHadtQ9Ihjl7hJB3gl66gyB4y0IvpcAbrS9R
         IKFmhmCZSR8GZrOlr1DF4idkY2RelTJp+zTW0dbX4cdRxuEC6F/c9+UGScIhG/JnTPGi
         zGuv3H9zSQHgDMos58H+FdGJiyfaCz9/r+iz/KjgBIlzRezO4zVw3PXeJcJ0fZGmOKwo
         gH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=V/+GyojHTJmw9bNM7yNcM312FFXJq2IqXj9L0INWy7Q=;
        b=bkABzHeV18DZiKhE7XA/M00/66QnLq7lYdreq4W+1LiaJQRvOyQhi1Xamen+3Qx+Dh
         MeMkfbndVIHhl3i6uXZen9BfAsA8P399loUUfYaMPk0hFQUq6qOKj4X5TGnJIEHQvKPD
         5VpB/Qw2ciobHdba+5EhpeCLBOcfDCeMb0q4A2NTqs24hFYwhblDb9tFGDuoLL9Vms+T
         0ICCDbLeyLHVLd24lMrI9WYUfkmm6pdE0t84zjnKcbNDpJ8wUYEMbxe7p4nC/ftJtCHx
         MC5QAPHUBK3J/qrEOSNQTT6yMhps2LiqrMylZMBGMEipMKgOKDPMq7IfsQg53uV4A0eN
         jCtA==
X-Gm-Message-State: AOAM532bxOeSZtladZkvS8xqqu/Ga9rcqLTrsmvEzeLfelo2fscMnmMu
        LPkly6Ux7HoE9bta7nfffWU=
X-Google-Smtp-Source: ABdhPJwtxv/ulcv2XTV5KKFBCd5AuSSVaD3Al4wFIOXiobGanl9V3pBfCUgu5FQsWlEVX8mmteKm5Q==
X-Received: by 2002:a17:906:5a99:: with SMTP id l25mr25266661ejq.235.1591117651146;
        Tue, 02 Jun 2020 10:07:31 -0700 (PDT)
Received: from AnsuelXPS (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.gmail.com with ESMTPSA id cx13sm1816868edb.20.2020.06.02.10.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:07:30 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200602115353.20143-12-ansuelsmth@gmail.com> <20200602163255.GA821782@bjorn-Precision-5520>
In-Reply-To: <20200602163255.GA821782@bjorn-Precision-5520>
Subject: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
Date:   Tue, 2 Jun 2020 19:07:27 +0200
Message-ID: <001101d63900$4c7aae60$e5700b20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQHL9MTNXAygDpahgIhhkQkgvfxVz6jaFSqg
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Tue, Jun 02, 2020 at 01:53:52PM +0200, Ansuel Smith wrote:
> > From: Sham Muthayyan <smuthayy@codeaurora.org>
> >
> > Add Force GEN1 support needed in some ipq8064 board that needs to
> limit
> > some PCIe line to gen1 for some hardware limitation. This is set by the
> > max-link-speed binding and needed by some soc based on ipq8064. (for
> > example Netgear R7800 router)
> >
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 259b627bf890..0ce15d53c46e 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define PCIE20_PARF_SYS_CTRL			0x00
> > @@ -99,6 +100,8 @@
> >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> >  #define SLV_ADDR_SPACE_SZ			0x10000000
> >
> > +#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> > +
> >  #define DEVICE_TYPE_RC				0x4
> >
> >  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> > @@ -195,6 +198,7 @@ struct qcom_pcie {
> >  	struct phy *phy;
> >  	struct gpio_desc *reset;
> >  	const struct qcom_pcie_ops *ops;
> > +	int gen;
> >  };
> >
> >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > @@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	/* wait for clock acquisition */
> >  	usleep_range(1000, 1500);
> >
> > +	if (pcie->gen == 1) {
> > +		val = readl(pci->dbi_base +
> PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > +		val |= 1;
> 
> Is this the same bit that's visible in config space as
> PCI_EXP_LNKSTA_CLS_2_5GB?  Why not use that #define?
> 
> There are a bunch of other #defines in this file that look like
> redefinitions of standard things:
> 
>   #define PCIE20_COMMAND_STATUS                   0x04
>     Looks like PCI_COMMAND
> 
>   #define CMD_BME_VAL                             0x4
>     Looks like PCI_COMMAND_MASTER
> 
>   #define PCIE20_DEVICE_CONTROL2_STATUS2          0x98
>     Looks like (PCIE20_CAP + PCI_EXP_DEVCTL2)
> 
>   #define PCIE_CAP_CPL_TIMEOUT_DISABLE            0x10
>     Looks like PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> 
>   #define PCIE20_CAP                              0x70
>     This one is obviously device-specific
> 
>   #define PCIE20_CAP_LINK_CAPABILITIES            (PCIE20_CAP + 0xC)
>     Looks like (PCIE20_CAP + PCI_EXP_LNKCAP)
> 
>   #define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT (BIT(10) |
> BIT(11))
>     Looks like PCI_EXP_LNKCAP_ASPMS
> 
>   #define PCIE20_CAP_LINK_1                       (PCIE20_CAP + 0x14)
>   #define PCIE_CAP_LINK1_VAL                      0x2FD7F
>     This looks like PCIE20_CAP_LINK_1 should be (PCIE20_CAP +
>     PCI_EXP_SLTCAP), but "CAP_LINK_1" doesn't sound like the Slot
>     Capabilities register, and I don't know what PCIE_CAP_LINK1_VAL
>     means.
> 

The define are used by ipq8074 and I really can't test the changes. Anyway
it shouldn't make a difference use the define instead of the custom value so
a patch should not harm anything... Problem is the last 2 define that we
really
don't know what they are about... How should I proceed? Change only the 
value related to PCI_EXP_LNKSTA_CLS_2_5GB or change all the other except the

last 2?


> > +		writel(val, pci->dbi_base +
> PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > +	}
> >
> >  	/* Set the Max TLP size to 2K, instead of using default of 4K */
> >  	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
> > @@ -1397,6 +1406,10 @@ static int qcom_pcie_probe(struct
> platform_device *pdev)
> >  		goto err_pm_runtime_put;
> >  	}
> >
> > +	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> > +	if (pcie->gen < 0)
> > +		pcie->gen = 2;
> > +
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "parf");
> >  	pcie->parf = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(pcie->parf)) {
> > --
> > 2.25.1
> >

