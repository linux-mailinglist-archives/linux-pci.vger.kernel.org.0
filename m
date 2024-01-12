Return-Path: <linux-pci+bounces-2117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCD82C3F1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFBC1F24192
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8877631;
	Fri, 12 Jan 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz0yp4T3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F477634;
	Fri, 12 Jan 2024 16:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A11C433F1;
	Fri, 12 Jan 2024 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078212;
	bh=l5fSgj+Gi5ykBYgS5TQAK8IZz/Rm0Gr+bg6Qn7vYmQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jz0yp4T34rc4eH6Dgxm3lyAlylBbl9Lw5WOn+o2+nd7QYglpti6RV7NxLIu4yBnbp
	 bhS6QWEWLIVNZSaKDtMJgoDt+aKLWvoiWguuXSgaGOAEiJazHtkzTY5Y7lHM8976su
	 dPVTpfX9tc4OpgGAqguc4nPzLLi9aKW/rHnIVw+32RGf07XYZQcIoPzfWRMk8vdp33
	 iPC8TL3xzZx+ypPC/sgn7GyqO+8ULN+TsehIn9cNveHgnBQzk1pucXtFsGR5O8eu7D
	 DMEs5RdBq2k/V0gutS3D9JdUOD7qXlzLCcfiV7AJZO79KzxPmS40TkGCQKooPAW7IU
	 tzTwMBcFpefGw==
Date: Fri, 12 Jan 2024 10:50:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240112165010.GA2271863@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:05PM +0530, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.
> 
> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.
> 
> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon GEN speed link is operating.

Thanks for this "OPP" expansion!  Maybe "GEN" is unnecessary in this
sentence?  And below, could be replaced with actual speeds?

> OPP can handle ICC bw voting also, so move icc bw voting through opp
> framework if opp entries are present.

s/opp/OPP/ to match
s/icc/ICC/ similarly (and perhaps expand once)
Also below in comments, etc.

> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> same icc bw and has frequency, so use frequency based search to reduce
> number of entries in the opp table.
> 
> Don't initialize icc if opp is supported.

Bjorn

