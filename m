Return-Path: <linux-pci+bounces-35272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD3B3E5DA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90AB164002
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E7338F35;
	Mon,  1 Sep 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1RK5aIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F343376BC;
	Mon,  1 Sep 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734307; cv=none; b=bwrG1FQ+0VYZh3G0dgRXsnYda8PCIP1qiQveCXKeba21rw/zqQw/ILpUSkyf+lY5C/aykeqtQhmfJPcyzZ7KoEUPmjXscnnLJyfsRc0Xv+2vnZjbxB54E+7BunpFev4IUHCjshZGLnH1TWbEWyPKxqA25u0L9keleJAsMeLJdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734307; c=relaxed/simple;
	bh=pt6AY0y015CdTaieE7iramjvzEFkNHijou1TJEbXBfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Frciul1FOT3WD50XPat3gu4EWME85y3lz7mqwjWZqr2GEaEB3z/zVWPjhlZI2PHmIIA4I+w1zT+8DCAmiLGjoLfuBlps0wOeyQbZVOc0YNNnVE9VO0Cnk7yrq6/fiFnlb0aPFRbq9bATKYZNxjs1ObZokLjY/hS/KJQTZeT9npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1RK5aIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075CDC4CEF4;
	Mon,  1 Sep 2025 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734306;
	bh=pt6AY0y015CdTaieE7iramjvzEFkNHijou1TJEbXBfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1RK5aIBq1HXviHh8ulRwz2GNsyLxi29Y3JU+97KLxPyFf5eJqwv1gu/q1iEpsllN
	 zriFT8QSPMvO1tBZIKd5uH+L0ysOtRby3lq24lJwVFAmhzbohPORSnzhRgbhZdhQCo
	 plYO9FfaR7a3XpijK+BVZD+Jlvq0f+HDLEGZ6aaBgluhQ+vy7KwvzhwFo3bPDuoOsI
	 NsitbUgs7/lKD0iZ0P0K4AEHBrdrd+rpbUrGbhqGEzUwXC/uhkeK9ZsitC52+81MVb
	 BtsKOPX2BswiJxeu1mlN0E0tG6jltxHPvZEqA+RSEL6YBnekcCPQHaZLdZ3LYHg9MV
	 VDq7xQPlXyiqw==
Date: Mon, 1 Sep 2025 19:14:56 +0530
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
Message-ID: <75ltyjxknqh44ku46dnmxfrqchcedvewf5fng2ukhmvrrqknyg@aogwxt5lfidc>
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

DBI is special because vendor glue drivers were using different name other than
'dbi' in DT. But for ELBI, all (both Exynos and Qcom EP) are using 'elbi' only.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

