Return-Path: <linux-pci+bounces-4165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD786A3ED
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 00:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D32B23303
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09075645C;
	Tue, 27 Feb 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="greyH+L3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB155E4E;
	Tue, 27 Feb 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077551; cv=none; b=YGSaXvAN3FNRS+m/3TcFC25fOXBddDQ+J0GW0JC6ugd71S5iqPH+Y6OXsKQOwF4TJ8t9IDFxwIS9y/TmKN9P3Zim0zWeECKj0+D593peWh0KYpp0bAMupN30yHVIPnkkER8Ntk7IwBMSn2flNgFu+qIY28WhXR51zYrS/1MDUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077551; c=relaxed/simple;
	bh=O6+UnS3bLsjL5pNyUXDCbAPl4xMpk0nA+TMKK4jaoXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y01InDy5bkBZ0YfClsRNYSPcnAVYhRfIcrNfkKxsLnSD8RHaDE8fL3JnV8hxonLOMAu9V1lCR+dAgrNszVJGLVkcQZupDH+BfOPzcTCU/KN4Qnj8ebqmAyV19aow5OGQScr+jU7Np3zDSIHfed+9weTbAS+pWL3ffN4bGDxM5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=greyH+L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75E3C433F1;
	Tue, 27 Feb 2024 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709077550;
	bh=O6+UnS3bLsjL5pNyUXDCbAPl4xMpk0nA+TMKK4jaoXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=greyH+L3qEHDnxOvXzxOqlLwjNxO8sz+qQNeGm6LcfgprGm9wR7XlbhZczCNJWH2i
	 sjyLtQlGG3d9pWEd5ZHiqukMZT2y32JxG2RKSmUW0+Bft77noi8CtxlAyCn1VYiZD7
	 WL00CpH9xvjBX+ZPu9W9m1pTys9fO4Y3Vcapn7Ivy/+awVkYZfJyTFq0OGaD6h8Yhs
	 4ENeMWu68UJyHqrpbcJTonkzNRy8bhqfsuH1FEzXKJdRfGihX/hTB1E9fbegqx6LQa
	 reiC+2w+oA52agmLwL/bx2bJwK4W1cQ61Mrtw0vM63Pt34Q9l7gjl1Byp+NUei9jlo
	 Fn1EK8wiqxjwA==
Date: Tue, 27 Feb 2024 17:45:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v7 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240227234549.GA251722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227233636.GA250826@bhelgaas>

On Tue, Feb 27, 2024 at 05:36:38PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 08:18:04PM +0530, Krishna chaitanya chundru wrote:
> > QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > maintains hardware state of a regulator by performing max aggregation of
> > the requests made by all of the clients.

> > It is manadate to scale the performance state based up on the PCIe speed
> > link operates so that SoC can run under optimum power conditions.
> 
> It sounds like it's more power efficient, but not actually
> *mandatory*.  Maybe something like this?
> 
>   The SoC can be more power efficient if we scale the performance
>   state based on the aggregate PCIe link speed.

Actually, maybe it would be better to say "aggregate PCIe link
bandwidth", because we use "speed" elsewhere (PCIE_SPEED2MBS_ENC(),
etc) to refer specifically to the data rate independent of the width.

> > Add Operating Performance Points(OPP) support to vote for RPMh state based
> > upon the speed link is operating.
> 
> "... based on the link speed."

"... based on the aggregate link bandwidth."

> > In PCIe certain speeds like GEN1x2 & GEN2x1 or GEN3x2 & GEN4x1 use
> > same bw and frequency and thus the OPP entry, so use frequency based
> > search to reduce number of entries in the OPP table.
> 
> GEN1x2, GEN2x1, etc are not "speeds".  I would say:
> 
>   Different link configurations may share the same aggregate speed,
>   e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same speed
>   and share the same OPP entry.

  Different link configurations may share the same aggregate
  bandwidth, e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link
  have the same bandwidth and share the same OPP entry.

