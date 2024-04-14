Return-Path: <linux-pci+bounces-6222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828048A41D4
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02341C20AA0
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E02AE83;
	Sun, 14 Apr 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT07n4fN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA5224DD
	for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713090784; cv=none; b=dxQYtUMarHz9D3gMmZtSSUqSLy2nPwI3zArsuibtQICZft8e42Je/piQQu0q8fIL3Evn/xIU0mXrzUlNrH25gq3WX+Y/2gyrd/9svdIuBr6SNVO6pq/v2iF5BFEXChuFfTfovOezEYSqMblbXMwolwGvGu6DMCIpsWuA6iDAUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713090784; c=relaxed/simple;
	bh=GD2VZJ/Qqsxp3zuRDLUSfSvzp4vBjYYUvZyBFHVrN0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4rs7utUFy3Vtbhu5zLfoStWdMg385obfweiOBXDV7bjWStsXqYPwfc4N+QrcsHEFH9AShHuo4ejmghQOn5NaWHUZ4657j0QN3A8JjrOiG5576amQsWiP9kQc8N8kCbRiz3TAkdPyMQGWoIsH164FHRqvx59oaQkAsTt7BJedcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xT07n4fN; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23333ef4a02so1722411fac.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713090781; x=1713695581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezWv8Uk8r0iZzTSx1VI+aatOFO9g5HSxqsWTUv27XdY=;
        b=xT07n4fN2MXFmrGmyS6NquXlcu85iBt+fCszcf7oYJAyZittCaFBKXk5fb/XHlucQ8
         VD1frCRZknnC1V8pNk6YrfRB9oXGTi4AVxPvtTVogvD4bTL3NJjSOQMu0VDpUhCj+9Zx
         KXr8hfPmTfMT50fvft6EikXQzea7UudlqB+zW4gTfhSiiy1FiaN59dqcm0oRz85ZmgT4
         x6+6UxB/JRUsvh9d3PiN3alj4oOJcl+qPaKalwITnYsKXRjSWYSOzOM4xmIj3iyWfXu6
         +wUIYGWtIXe8mnrrFpQQBEEsn/vINEju6PLW0xTwRbZ8dtdbAIPpiPvi7W+a+EUHxsjc
         DF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713090781; x=1713695581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezWv8Uk8r0iZzTSx1VI+aatOFO9g5HSxqsWTUv27XdY=;
        b=Ge5pjEElKUOdH8WtqOoZjGAMhHXUWcKi9QYOp4vBoVN4kRoL3Eui7Y3013jaLeBnoJ
         exWLAL5eDqS+t3QsJJ1RhMYYk+L7UsAmwhNgszbxPcmd0sW6HdFDdN65y2xrcZUsiLVj
         m59yLDSGaMI6nvBIi1rTqTIBYa/cUqNyCM3RyCIvKsQIZgVPnvfVw10Wl0dk6eSmh1W+
         irDVW583mDDfUfBbv1sYWVqvKL0/e2ezKfuCdCbXi3wKFVQ80IqOQaj2T+XEk3aQJPOK
         ZcFE84+0oosWk+IGgGP9dHM3XGFShGa3A0CA432UpkzacZ5H08WZITC2IZQxFNFRHwoB
         uMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVX1pOpPycS6/NnBnoqLAmqyxiO40AG9f7hUIOPbl7naVg/RbOVppHdfAxWekv6mswl1gVDxzZgWvvwhIEWABm2mHoqU4Wx5oxV
X-Gm-Message-State: AOJu0YzGY55EXXcfUxlU0z8woaisHBSaGmLnNaPwhTHxxx75BVu5IRa7
	oTWyPOiSUWm6qdwR1LUuWRvIZu0SWI2GSLmDIn6SoWy0QtNoRRqp0JupefYrMw==
X-Google-Smtp-Source: AGHT+IGHvQOl59qxFzhWvb2JB596M3kORklxXhpjbwofS/WCy0scK/ufcS2lkNd5/pxWK7SME16DWg==
X-Received: by 2002:a05:6871:60f:b0:229:87f6:ee8a with SMTP id w15-20020a056871060f00b0022987f6ee8amr8649408oan.30.1713090781146;
        Sun, 14 Apr 2024 03:33:01 -0700 (PDT)
Received: from thinkpad ([120.60.136.171])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm5391418pfm.25.2024.04.14.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 03:33:00 -0700 (PDT)
Date: Sun, 14 Apr 2024 16:02:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <20240414103256.GB2294@thinkpad>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
 <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
 <20240405062426.GB2953@thinkpad>
 <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>
 <20240406040131.GC2678@thinkpad>
 <ZhQJD7GjRpDwa6jI@lizhi-Precision-Tower-5810>
 <20240412170548.GB19020@thinkpad>
 <Zhmi0XEUFMIO9OLx@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhmi0XEUFMIO9OLx@lizhi-Precision-Tower-5810>

On Fri, Apr 12, 2024 at 05:08:33PM -0400, Frank Li wrote:
> On Fri, Apr 12, 2024 at 10:35:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 08, 2024 at 11:11:11AM -0400, Frank Li wrote:
> > > On Sat, Apr 06, 2024 at 09:31:31AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 05, 2024 at 10:31:16AM -0400, Frank Li wrote:
> > > > > On Fri, Apr 05, 2024 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Mar 19, 2024 at 12:07:15PM -0400, Frank Li wrote:
> > > > > > 
> > > > > > PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off during system suspend
> > > > > > 
> > > > > > > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > > > > > > window. This space's size is 'region_align'.
> > > > > > > 
> > > > > > > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > > > > > > can trigger a PCI message, such as PME_Turn_Off.
> > > > > > > 
> > > > > > > Add common dwc_pme_turn_off() function.
> > > > > > > 
> > > > > > > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > > > > > > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > > > > > > exist.
> > > > > > > 
> > > > > > 
> > > > > > How about:
> > > > > > 
> > > > > > "Instead of relying on the vendor specific implementations to send the
> > > > > > PME_Turn_Off message, let's introduce a generic way of sending the message using
> > > > > > the MSG TLP.
> > > > > > 
> > > > > > This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> > > > > > at the end of the first IORESOURCE_MEM window of the host bridge. And then
> > > > > > sending the PME_Turn_Off message during system suspend with the help of iATU.
> > > > > > 
> > > > > > It should be noted that this generic implementation is optional for the glue
> > > > > > drivers and can be overridden by a custom 'pme_turn_off' callback."
> > > > > > 
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > > > > > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > > > > > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > index 267687ab33cbc..d5723fce7a894 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >  
> > > > > > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > > > > > +{
> > > > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > > +	struct resource_entry *win;
> > > > > > > +	struct resource *res;
> > > > > > > +
> > > > > > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > > > > > +	if (win) {
> > > > > > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > > > > > +		if (!res)
> > > > > > > +			return;
> > > > > > > +
> > > > > > > +		/* Reserve last region_align block as message TLP space */
> > > > > > > +		res->start = win->res->end - pci->region_align + 1;
> > > > > > > +		res->end = win->res->end;
> > > > > > 
> > > > > > Don't you need to adjust the host bridge window size and end address?
> > > > > 
> > > > > Needn't. request_resource will reserve it from bridge window. Like malloc,
> > > > > if you malloc to get a region of memory, which will never get by malloc
> > > > > again utill you call free.
> > > > > 
> > > > 
> > > > Hmm, will that modify the window->res->end address and size?
> > > 
> > > No. This windows already reported to pci system before this function. It is
> > > not good to modify window-res-end. It just add child resource like below.
> > > 
> > > windows is root resource, which will create may child when call
> > > request_resource.
> > >           bridge -> windows
> > > 		child1 -> msg
> > > 		child2 -> pci ep1
> > > 		child3 -> pci_ep2.
> > > 		...
> > > 
> > > Although you see whole bridge window, 'msg' already used and put under root
> > > resource,  new pci devices will never use 'msg' resource. 
> > > 
> > > If change windows->res->end here, I worry about it may broken resource
> > > tree.
> > > 
> > 
> > Hmm, I think your argument is fair. I was worrying that if someone try to
> > map separately by referencing win->res->end, then they will see access
> > violation.
> 
> It should be wrong if use it without request resource.
> 
> > 
> > But why can't you just allocate the resource using 'alloc_resource()' API
> > instead of always allocating at the end?
> 
> Alloc will start from windows (for example: 0x8000_0000). 
> 0x8000_0000 -> 0x8001_0000 will be allocated to 'msg'.
> 
> If ep1 want to get 1MB windows, 0x8010_0000 will return. There is a big
> hole between 0x8001_0000 to 0x8010_0000.
> 
> I just want to reduce impact to existed system. So PCIe memory layout will
> be kept the same w/o this patch.
> 
> There are not big difference between allocate resource and reserve resource
> for 'msg'. Just little better friendly for exist system.
> 

Ok. This sounds fine to me. Please add this information as a comment so that
everyone will be aware of the reasoning.

- Mani

> Frank
> 
> > 
> > - Mani
> > 
> > > > 
> > > > > > 
> > > > > > > +		res->name = "msg";
> > > > > > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > > > > > +
> > > > > > 
> > > > > > Shouldn't this resource be added back to the host bridge?
> > > > > 
> > > > > No, this resource will reserver for msg only for whole bridge life cycle.
> > > > > Genenally alloc resource only happen at PCI devices probe. All pci space
> > > > > will be fixed after system probe.
> > > > > 
> > > > 
> > > > I don't think so. This resource still belongs to the host bridge, so we should
> > > > add it back.
> > > 
> > > When add back?  It was reserved at bridge probe. When bridge remove, all
> > > resource will released. 
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

