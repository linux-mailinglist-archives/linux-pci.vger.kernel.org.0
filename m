Return-Path: <linux-pci+bounces-4347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C749C86EA05
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2079CB2A16F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0773C3BB21;
	Fri,  1 Mar 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4dmb6uL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADE3B796;
	Fri,  1 Mar 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323243; cv=none; b=SpHHSfkTLUSjaaD+pVOsWVJN80xIX4nv4TxIQvb1Nn3kUbNIKgS5GdvxpK8wWJ/2Qce3q3KmwObOWGk/n6EL8/9NERSsellEZRSgZyMEQo9kSkVeH58LjlV/1DJQPN6vc5iirno5Ry7hxxJA/BsriUtGLwdtyKhUND6ZvPPvKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323243; c=relaxed/simple;
	bh=tkPfYz4dqfaAlFLOY/DLcTiVqpMCMMgd9r4KzTAlmo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ju9urPOwECkGNrCgMaYOWFWj1mxd+GJjatqb5+Z+uQtV7yY/sH//m7qnD+cMIMwp+SvVfpClL6O6R36lJIxpI80t3ZQE+pf/lpFg4salUEC4DyErKw7boBg6j9iFSiy0fRiqT1wL40I0hiSg5/MljNd2UmDshk69Ycm4EiULPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4dmb6uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E7C433F1;
	Fri,  1 Mar 2024 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709323243;
	bh=tkPfYz4dqfaAlFLOY/DLcTiVqpMCMMgd9r4KzTAlmo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I4dmb6uL5oZ7jN5mVc1lq2HaCe04G/zhlwTmclLdpOcN8cYliO3vVRcj1ci4De4vh
	 cnfqZ8PGmi/vMmMGmT5JvOUyQSifd/XWEtQIiu1cK69e1RYXYx0Tc6yQe76T6dCKVF
	 Mgn8jw/v7wHnIxm0tyC8FihmR6nL9Uc8qkiPCbWNO0gQD4xgjPsMViyWjQ05pgyCgL
	 J315K5PD4QJ4yTzxaTX7SenZsAdGQxrHIxKIePUCXhuRKsqaV0aujLpco2QvUnT4zt
	 7JukBPFCqJbOLh4l5vcyfHrgtK0lw00n89MZQUFqQWhH2C7+B0OZ+72VzgOYCeQZY+
	 C74oyXFyNNoVg==
Date: Fri, 1 Mar 2024 14:00:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 2/3] PCI: dwc: add equalization settings for gen4
Message-ID: <20240301200041.GA405674@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301051220.20917-3-quic_schintav@quicinc.com>

On Thu, Feb 29, 2024 at 09:11:35PM -0800, Shashank Babu Chinta Venkata wrote:
> GEN3_RELATED_OFFSET is being used as shadow register for generation4 and
> generation5 data rates based on rate select mask settings on this register.
> Select relevant mask and equalization settings for generation4 operation.

Please capitalize subject lines to match history ("PCI: qcom: Add ...")

s/GEN3_RELATED_OFFSET/GEN3_RELATED_OFF/ (I think?)

I wish these "GEN3_RELATED" things were named with the data rate
instead of "GEN3".  The PCIe spec defines these things based on the
data rate (8GT/s, 16GT/s, etc), not the revision of the spec they
appeared in (gen3/gen4/etc).

Using "GEN3" means we have to first look up the "gen -> rate" mapping
before finding the relevant spec info.

Applies to the subject line, commit log, #defines, function names,
etc.

> +void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);

Warrants a one-line comment about using "GEN3_..." in a function named
"..._gen4_..."  (But ideally both would be renamed based on the data
rate instead.)

> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> @@ -9,10 +9,29 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +#define GEN3_EQ_CONTROL_OFF			0x8a8
> +#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK        GENMASK(3, 0)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE   BIT(4)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)

Are these qcom-specific registers, or should they be added alongside
GEN3_RELATED_OFF in pcie-designware.h?

> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_VAL   0x5
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_VAL  0x5
> +#define GEN3_EQ_FMDC_N_EVALS_VAL          0xD
> +#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
> +#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
> +#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14

> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -438,6 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> +	/* set Gen4 equalization settings */

Pointless comment.

> +	if (pci->link_gen == 4)
> +		qcom_pcie_cmn_set_gen4_eq_settings(pci);

> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -263,6 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> +	/* set Gen4 equalization settings */

Pointless comment.

> +	if (pci->link_gen == 4)
> +		qcom_pcie_cmn_set_gen4_eq_settings(pci);

