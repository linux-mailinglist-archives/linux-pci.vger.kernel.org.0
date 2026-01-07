Return-Path: <linux-pci+bounces-44153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12CCFCCA8
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F8030AB954
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C392F8BF0;
	Wed,  7 Jan 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMcqDCg2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BE2F7AD6;
	Wed,  7 Jan 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777006; cv=none; b=VrbK4eO8pRkiNKg5rpBDDBHlm9tIvndxGVGfwxRHksal2qPLRKp4XJPwwiPJ2OrVd9DPCukgDkSE8D33ATe/7vcgvsZXk8I7krsYebWXTLi7KWBU0J76XiZSYhiPJmOaSv/4PhUperevG7X7oqp3xhW/PHOvquYkmV6cgR5YUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777006; c=relaxed/simple;
	bh=CLU7h6GTmvkTvI4qcivecszlrj+5fUOJKd0rlj5almg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUT7H9XT5tU7AFi1IciSvk1khhCKZA2qA8UiAr9B7CYwZZMiiIgDFY21FJ43voTcCz6sMSzMlNws7ZLD58Ngj/NQQ+QvZqZV7hK07Xe7rtqRQ+bg8SIyeRFMM0OJaeV//0+HdEmm74NS7HYj7YPU2ToTnsHnkBqZRTEeXwNUixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMcqDCg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF3FC4CEF7;
	Wed,  7 Jan 2026 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767777006;
	bh=CLU7h6GTmvkTvI4qcivecszlrj+5fUOJKd0rlj5almg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMcqDCg233RFlkUMiBABvk7KLxZ8WTr66k1plNJWoEJ7RFLvThISlsMkKhwc6X5pi
	 LPIqqcD33lWtYCYgrb79w8pwY9lXtyHIpO3DihhFcK1qC8C55zOM/RJLPqk3QwAb3k
	 kKQQTdt079gk5THLstZFolZ+kuFni2ID2rf1M/5Xi3go8UkACHOGZQQruNlt4cctTK
	 7tYS3pHoD0PiUjucxfP73YlnL3qmqof8i/ZYWp1f1P0EmUTXVBklFJGS/i6U0d2YHI
	 P+pjNuV3jQuroEIsvx4eHHP5FInghOCQeogFtSrmotpmIKk2iWf2o3NAKRP/CMVmAm
	 vGea6aGqPmk5A==
Date: Wed, 7 Jan 2026 14:39:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 3/6] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Message-ID: <gtgvh7bxfsm7xoigg7tiqs7n42gnfbxsa4aqxtupqnr6ihxswn@gk7dcw2zbh7x>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-3-9b5f3c72df0a@oss.qualcomm.com>
 <af7be4b3-93a0-4fb0-aa36-cf62d13c0579@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af7be4b3-93a0-4fb0-aa36-cf62d13c0579@rock-chips.com>

On Wed, Jan 07, 2026 at 04:38:14PM +0800, Shawn Lin wrote:
> 在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > If the link fails to come up even after detecting the device on the bus
> > i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
> > dw_pcie_wait_for_link() should log it as an error.
> > 
> > So promote dev_info() to dev_err(), reword the error log to make it clear
> > and also print the LTSSM state to aid debugging.
> 
> LTSSM might still be changing, so not sure how much value it would be
> to print it at a singal moment, but anyway
> 

It is very unlikely that the LTSSM would be changing after the 1s timeout.
Printing the state will allow debugging the link up failure.

- Mani

> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 87f2ebc134d6..c2dfadc53d04 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -776,7 +776,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   			return -ENODEV;
> >   		}
> > -		dev_info(pci->dev, "Phy link never came up\n");
> > +		dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",
> > +			dw_pcie_ltssm_status_string(ltssm));
> >   		return -ETIMEDOUT;
> >   	}
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

