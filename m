Return-Path: <linux-pci+bounces-24013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4AA66CA2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F08F3AF2D0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B071F872B;
	Tue, 18 Mar 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKqK1dU7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF41EF369
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283987; cv=none; b=r7TlG3k9ZEMY/2lhXbVqUudKF7ZagHEyu4evqIauHfypqgZRpUU4TBHAavUpgoDHyAIEEndtSZ/Rn/yeVU2tfqdq0U9upoh0ZHxxmPLGS4pRzGljqknhx2AEIyjdD+caCXCUJf4tPE0Thcq60Ou7tzpzML2wmR/fT6XgIYzLQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283987; c=relaxed/simple;
	bh=LvywzN1RBsv3mdA4STwvBcFAP/jhi6wX7UwEJ79LVdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agIFHS/+aRnnxnYM8wUgGJkxDlSONIEoXC8Y1sZ2jSiGjiO/MmPxy65c7zGvgtyLG78mCF2urd/+LLodaTnF+NvKv+2nakMpPpu5hLQ4Hu9j9LtQLm7pR0LUlXlCT6OaVV615mr5g2t1zeg5s+N1HYJv4wI/46ScqQkkShGyblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKqK1dU7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22580c9ee0aso91046235ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283984; x=1742888784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/5KVGOst+i3EqYlF+Sx7sAtMWBsKlTUEKDgYGkLY1j4=;
        b=GKqK1dU7X3dkWLgRrNObHATUGX/K3vSyw0fjqLWL5TmdobHQJ4wDYuUIkKjdeQBIz7
         cnNyXy/i0jkH7OaJvd9NvZmYzlz+k25HaiRVM6hxL29FqcDSKZVca5Cc0d/LksSpJ05k
         FWt6CWtqJdMG0YxjoCYRqqx7Zu2yH3xj9/70FX979wmMIMt+zeHOKheEZBQ28jweTck6
         uHDq06s6+q8fsIESdD/9+MnDb/MKlziXHG/7rKSNxKmahxpMchfDB2IOK52X6Qakx5c9
         XdcSg6MJelmtbI+knx+qY33TzEOXm50OKQ+5/NWCxemmbjYl65Kt83IuL9Me2SifS5Hg
         OPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283984; x=1742888784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5KVGOst+i3EqYlF+Sx7sAtMWBsKlTUEKDgYGkLY1j4=;
        b=AZQ+N28Kj67aBeDdqZteE/hmqyME241zV0zwuqIgt4Zyf+uFXUXTi/g6FzB1/kmr8q
         mgWC8H42NqUKHTV0FJlYckIpIis9UC+7Qu9Yi2yeJAXW+JrYtJIp4fmZnZJA1oxz9LbT
         mjQh1UOPA1bV48C2b0qoOVclbynFJXJ97bZkzHRHpbSuJ7Xii8JsNSNzaeEbsjyJFMVJ
         hjfy44w2QHnbOMpMrdz7IsVymvL28J7VWOPYahcvC4RhOjDFWyuttTMifcp6bzdHt/HP
         aEefMa1FQ1kJ2THze9lNLP/J175LnOKwMH4uYgtO85mCxBXiT0RXCbXa+PH7viWmCAP+
         OvJA==
X-Forwarded-Encrypted: i=1; AJvYcCX9De2ehSE0ClGsedEOQPUsSwOt7/F5sXtu8iParB0eLIp9VdJUU1CbuYR5RJt3fq7d2jzrGLWYZJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BlTJc6xF+MIqfGHyI0DbPl2/e/luOL3C1MrMhuI9sDk57TFe
	AGELw998dcVdOPL98G2TXuncrYMH1cTBvxri+Qbr6YOLzhhqCn9TBK9Ra/j8Sg==
X-Gm-Gg: ASbGnctGCFyH3YO2TtDLaU4IVcTKUVDdWOk8W9ZpYw1aL3eP+Ob3Nc5B1a4MtDSmjbd
	RU81k+JbbvVFRYwYylPTA+kiqIUOQgSMYTjwbOv1dC3cldAStsCunBSULOBQR0w0VXEoxKfSWwh
	8VgAdrgEy+pVOSulQrt+ZANVqq8HgBkX8cnGPqVSPGrdAbVZwULGkU74uAuQ7or+CR1KxbSc456
	KWDoLSxvbgI/gOJi2Bart+eG2TWO190bt3d8ejj1le4mtZ2Ql/tg/EiBBiKKL1nCmixTJa/IEup
	ppKleMUF0b+8IHiblxivuJD6+AovDWOphJykGdhJbZeah+ZbU2t819AZCK9PF6YD1Oc=
X-Google-Smtp-Source: AGHT+IGk7Wbvv+p+ljwVovByJjOFoHfppHTP1+cVpoZmuorSMChPEuewTXvxnqB++I9G1ZambQYJAA==
X-Received: by 2002:a05:6a00:2309:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-73722382f9bmr19932531b3a.14.1742283984406;
        Tue, 18 Mar 2025 00:46:24 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b3de4sm9153147b3a.179.2025.03.18.00.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:46:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:16:18 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <20250318074618.tqbnr7nv665fk25n@thinkpad>
References: <b425a7c7a7d6508daf23fe7046864a498029a7ac.camel@pengutronix.de>
 <20250313160648.GA736867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313160648.GA736867@bhelgaas>

On Thu, Mar 13, 2025 at 11:06:48AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 09:54:25AM +0100, Lucas Stach wrote:
> > Am Mittwoch, dem 12.03.2025 um 10:22 -0400 schrieb Frank Li:
> > > On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> > > > Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: 2025年3月11日 23:55
> > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com;
> > > > > > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > > > > > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > > hardcodes
> > > > > > 
> > > > > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > > Sent: 2025年3月10日 23:11
> > > > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org;
> > > > > > bhelgaas@google.com;
> > > > > > > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > > > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > > > > > imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > > > > hardcodes
> > > > > > > > 
> > > > > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > > > > Use the domain number replace the hardcodes to uniquely identify
> > > > > > > > > different controller on i.MX8MQ platforms. No function changes.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > @@ -41,7 +41,6 @@
> > > > > > > > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > > > > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > > > > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > > > > 8)
> > > > > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > > > > > 
> > > > > > > > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > > > > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > > > > platform_device
> > > > > > > > *pdev)
> > > > > > > > >  	struct dw_pcie *pci;
> > > > > > > > >  	struct imx_pcie *imx_pcie;
> > > > > > > > >  	struct device_node *np;
> > > > > > > > > -	struct resource *dbi_base;
> > > > > > > > >  	struct device_node *node = dev->of_node;
> > > > > > > > >  	int i, ret, req_cnt;
> > > > > > > > >  	u16 val;
> > > > > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > > > > platform_device *pdev)
> > > > > > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > > > > > >  	}
> > > > > > > > > 
> > > > > > > > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev,
> > > > > > 0,
> > > > > > > > &dbi_base);
> > > > > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > > > > -		return PTR_ERR(pci->dbi_base);
> > > > > > > > 
> > > > > > > > This makes me wonder.
> > > > > > > > 
> > > > > > > > IIUC this means that previously we set controller_id to
> > > > > > > > 1 if the first item in devicetree "reg" was 0x33c00000,
> > > > > > > > and now we will set controller_id to 1 if the devicetree
> > > > > > > > "linux,pci-domain" property is 1.  This is good, but I
> > > > > > > > think this new dependency on the correct
> > > > > > > > "linux,pci-domain" in devicetree should be mentioned in
> > > > > > > > the commit log.
> > > > > > > > 
> > > > > > > > My bigger worry is that we no longer set pci->dbi_base
> > > > > > > > at all.  I see that the only use of pci->dbi_base in
> > > > > > > > pci-imx6.c was to determine the controller_id, but this
> > > > > > > > is a DWC-based driver, and the DWC core certainly uses
> > > > > > > > pci->dbi_base.  Are we sure that none of those DWC core
> > > > > > > > paths are important to pci-imx6.c?
> > > > > > >
> > > > > > > Thanks for your concerns.  Don't worry about the
> > > > > > > assignment of pci->dbi_base.  If pci-imx6.c driver doesn't
> > > > > > > set it. DWC core driver would set it when
> > > > > > >  dw_pcie_get_resources() is invoked.
> > > > > > 
> > > > > > Great, thanks!  Maybe we can amend the commit log to mention
> > > > > > that and the new "linux,pci-domain" dependency.
> > > > >
> > > > > How about the following updates of the commit log?
> > > > > 
> > > > > Use the domain number replace the hardcodes to uniquely
> > > > > identify different controller on i.MX8MQ platforms. No
> > > > > function changes.  Please make sure the " linux,pci-domain" is
> > > > > set for i.MX8MQ correctly, since  the controller id is relied
> > > > > on it totally.
> > > > > 
> > > > This breaks running a new kernel on an old DT without the
> > > > linux,pci-domain property, which I'm absolutely no fan of. We
> > > > tried really hard to keep this way around working in the i.MX
> > > > world.
> > > 
> > > 8MQ already add linux,pci-domain since Jan, 2021
> > > 
> > > commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> > > Author: Peng Fan <peng.fan@nxp.com>
> > > Date:   Fri Jan 15 11:26:57 2021 +0800
> > > 
> > > Only missed is pcie-ep side, which have not been used at all boards dts
> > > file in upstream.
> > 
> > I wasn't aware of this. 2021 is quite a while ago, so I suspect that
> > nobody is going to run a new kernel with a DT this old. I retract my
> > objection.
> 
> Sounds good, thanks, Lucas.  We really do want to avoid breaking old
> DTs, so I appreciate your highlighting of it.  Even if we believe none
> of them will break, I think it's worth mentioning the
> 'linux,pci-domain' dependency and the commit that added it to the
> .dtsi in the commit log.
> 

If there is a dependency, then it should be added to the binding. Only that will
ensure that the DTs will have the dependent property present.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

