Return-Path: <linux-pci+bounces-35245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A95B3DD9C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A771881A88
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3673043B7;
	Mon,  1 Sep 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3/8nzZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D183043AF;
	Mon,  1 Sep 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717677; cv=none; b=hj2fyGORaAZ3uuJTMgfHWv56e7MSpVayGJAcJRldYKGzd93w943JTaZ/lzY006RDdKQeN7tpUsZ4WHV01VO72qYY7uCliWMGpzjQWr3tNY3qPiR7rPnwi+eHpPwjaK7JLt13nb85veX8Mz9BGiWQZxMkFeBOI9yB9JKCUPAMNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717677; c=relaxed/simple;
	bh=IAfk7MiM6ZureLT/NRsislxKUb4CkmaAnViuxYmCF9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDsLkr2gyeNQcDBwfNsTy33aIlpS2lYHp8yfRF7SXOXYCQ20iZ+HzW7m17sS0ocGflxkggXKtM2MdbDZ7woF394fjAVkvwpZzWaB/Pjf1J+5KmJKbc9ZRocT+UqBB7EZ06YAGPNnxjdmBFF1A4xx4TgoyhTQGNTw7J6J20gLXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3/8nzZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742A0C4CEF0;
	Mon,  1 Sep 2025 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756717677;
	bh=IAfk7MiM6ZureLT/NRsislxKUb4CkmaAnViuxYmCF9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3/8nzZppnFxXy7WAvIbrWgBBAoUyIfB8Nov/H6pfpZBZ6X/KQQfkcrqe5+mIIxUw
	 YSNPODa63IFj/khA3ISpKV6DTKM7f5EVqebtvUihbLK25vzBdlSPLzZL5mAGSABMAq
	 QErlFZooKeNkl8vGWbSZlIdivttz9jX+FDCJ2Ngab1iik1QbEWdcfdAdo64g8Oqao8
	 lG7Lugvaa5K1QKyQuWz0XjVkalgv5NhXKo/7GJVEd6zCYyb+rdNJarJezReRxvlsHg
	 MweH7Gi4TCNC2C9IvFwZa+zUpOEcNk2EB9jmQYQJIusV3nI1qkGRDJDo6m5UqvuOcs
	 T7i0QG+qvP5NQ==
Date: Mon, 1 Sep 2025 14:37:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com, mmareddy@quicinc.com
Subject: Re: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
Message-ID: <3ta7bnde5xiltawvyhaimllmio4nrknhyfcfjsq4mh4ztbr637@dcjmfhi7se6m>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>
 <ymsoyadz2gkura5evnex3m6jeeyzlcmcssdyuvddl25o5ci4bo@6ie4z5tgnpvz>
 <3cbe6692-2ada-4034-8cb2-bc246bca5611@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cbe6692-2ada-4034-8cb2-bc246bca5611@oss.qualcomm.com>

On Mon, Sep 01, 2025 at 12:25:58PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 8/31/2025 5:18 PM, Manivannan Sadhasivam wrote:
> > On Thu, Aug 28, 2025 at 01:04:23PM GMT, Krishna Chaitanya Chundru wrote:
> > > External Local Bus Interface(ELBI) registers are optional registers in
> > > DWC IPs having vendor specific registers.
> > > 
> > > Since ELBI register space is applicable for all DWC based controllers,
> > > move the resource get code to DWC core and make it optional.
> > > 
> > > Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h | 1 +
> > >   2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > >   		}
> > >   	}
> > > +	if (!pci->elbi_base) {
> > 
> > Why this check is needed? Are we expecting any DWC glue drivers to supply
> > 'dw_pcie::elbi_base' on their own?
> > 
> I was following the same way that existed for for dbi_base, where we are
> allowing DWC glue drivers to supply if they had any different approach
> like ./pci-dra7xx.c driver.
> 

That's because the glue drivers were using different dbi resource name in DT.
But for ELBI, we have so far seen only 'elbi'. So there is no need to allow
override.

I will remove this check while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

