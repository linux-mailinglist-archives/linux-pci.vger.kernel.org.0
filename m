Return-Path: <linux-pci+bounces-39342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAEC0AD5E
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC174E7B76
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5C235358;
	Sun, 26 Oct 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkbdT0AL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEE224240;
	Sun, 26 Oct 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495983; cv=none; b=tLuMyL1Kut+XrvcwpBJ2TVkKmZCanPxoHGwTdc/OKRTr0o8pA93L5MwsRSN2MzYSy9k0cZH9tvHTssyLMy2GQEruohv7Z1NdHBMJzy+lV6I/OAj8DlBlTNGWdZn44sKwRrtSCUBOC0DpSlIv2PmqQNRjBftSojJxgfmDOWs3qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495983; c=relaxed/simple;
	bh=KY2OlOpYRw2Sxa9zjg+L8vnU+0Um3jouZEZbFuk7wus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwz50HRSHnkhJy0EJXkuQg4Pg1SF4UHyaSQUNTq5j0KUKKpNDF+qOelQU8sGOqb634BO9MBA6+uYDIELq/EjnbgihwCkXIHmFF1USepBgjC3wJvisvg1GdV/x2i+7j+RA0tfCRwzAX98hCx7nZWcLlt5h3uSLn2S7MNg9W7WBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkbdT0AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2D6C4CEE7;
	Sun, 26 Oct 2025 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495982;
	bh=KY2OlOpYRw2Sxa9zjg+L8vnU+0Um3jouZEZbFuk7wus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkbdT0ALg+u+/cJwU+z8SzZzQWi8hgMfKjlvNLrnFVGdg1JouJpIxjr9uJyvTriBK
	 4gLhSreEXdT3XWXgConrc6tVPBBsK+O0NVlz+wpvSkjjqx/1+vzaUTriLGvAgyP+Zg
	 V0qSYNRMRr2VUUa4HvlqtPa5gy9xsizvYWlVbURZhnj8D/GQNtTAqmV7LN1gV6PAh3
	 8XTIyANBLitw2qs4BYRXyq2KTCA/TxMFSy+nnMO88RRIj9qtuqFTlsrn8S1xI+cUAL
	 RVssleKPQVHIuvzGumZIuy4wUYsbg8bbcFhX6koUXedTmaNKP4edud3cs2N9IR8WMr
	 ihk3VjnA7HqUg==
Date: Sun, 26 Oct 2025 21:56:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
Message-ID: <ufy5q3vx3zh26rjdv6mb36mvlpk2tmxuvluo7s5bykyl3elgh5@cqmjsgnwar6a>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
 <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
 <f0f1219b-672e-4793-8501-ea31e7cc9575@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0f1219b-672e-4793-8501-ea31e7cc9575@oss.qualcomm.com>

On Wed, Oct 22, 2025 at 06:37:41PM +0200, Konrad Dybcio wrote:
> On 10/13/25 12:53 PM, Krishna Chaitanya Chundru wrote:
> > PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> > the same frequency but differ in other characteristics like RPMh votes.
> > The existing OPP selection based solely on frequency cannot distinguish
> > between such cases.
> > 
> > In such cases, frequency alone is insufficient to identify the correct OPP.
> > Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> > frequency and level when selecting an OPP, here level indicates PCIe
> > data rate.
> > 
> > To support older device tree's where opp-level is not defined, check if
> > opp-level is present or not using dev_pm_opp_find_level_exact(). if
> > not present fallback to frequency only match.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> >  {
> >  	u32 offset, status, width, speed;
> >  	struct dw_pcie *pci = pcie->pci;
> > +	struct dev_pm_opp_key key;
> 
> You need to zero-initialize this, or it'll explode the second
> struct dev_pm_opp_key {} grows
> 

I've fixed it up while applying, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

