Return-Path: <linux-pci+bounces-20325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E7A1B2C3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6739D18862DA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332B219A81;
	Fri, 24 Jan 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN45VQ0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B4219A80;
	Fri, 24 Jan 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711409; cv=none; b=OKEk+37+jw/N9kXOG4jM4g9JgYmgxS374q44lGj0p6ixjPeN844rwss+zsrD9fznDl0iGixOn94uel4EIhaRe9tEHGAUCnR1fp5S/moJoLlMvkymFzwHZT1gBRnj3VUzD/ZQKvnWhargcXnmQoUb5P+xr4jJG/C0vuKgL6YURn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711409; c=relaxed/simple;
	bh=paiwEemACLboxuhXkc9atWcC/vkc9CreQx/qAH5ctVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxWPMa9qYWSLUvTCTcaRodPiGBMwKYperFY0Q6yijP2R0EH7AoM+oBhX9h6ta+WAl/sGeIM3XEa3ywc+NHQt2TPyip2LY106PGKLECJLt685lZUrfVJwNiZjEHn99RaxwB56iJ03Vgu9cnLv+xzfl7WlInsqAkQG5sUWmtozi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN45VQ0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26864C4CED2;
	Fri, 24 Jan 2025 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711409;
	bh=paiwEemACLboxuhXkc9atWcC/vkc9CreQx/qAH5ctVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pN45VQ0Rc4zIKxXq+UqwyVTilgXlc5TA1gFL7ricIgR+d/Uvr4GqZ9nLMml/W9YNG
	 2aCX3Vv0UsYERoJ2KaMQI+I137G6Q33qnHRohGhTJ45xBUZRFDqxuA72M6b6rksGSv
	 YtQWRB/gzBgokZbmbPbJTq2DURcPxs+oLvy+2QUonWokcw7+0ZAsW2r6BdP+Lkv9a+
	 AmL6nTL97W66xooJJI5676rUZmd49LeIyMf/E8PPv9CZiOeB4uGKOdRmPq1ZZmh+I2
	 OFfpd2OlxQ37YsAhpq907aNIhinsgooj5cD8yZZkRYB6tfveQW1N+A9UGlq+ApBI4i
	 T8sE0Y43Dgd4w==
Date: Fri, 24 Jan 2025 15:06:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v3 3/4] PCI: dwc: Reduce DT reads by allocating host
 bridge via DWC glue driver
Message-ID: <20250124093635.hemydca7d7zeajaa@thinkpad>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-3-cd84d3b2a7ba@oss.qualcomm.com>
 <20250124061828.ncycdpxqd6fqpjib@thinkpad>
 <6e35eea5-2c7b-5d71-f39d-f9196a3c1b76@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e35eea5-2c7b-5d71-f39d-f9196a3c1b76@quicinc.com>

On Fri, Jan 24, 2025 at 01:56:25PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/24/2025 11:48 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jan 21, 2025 at 02:32:21PM +0530, Krishna Chaitanya Chundru wrote:
> > > Allow DWC glue drivers to allocate the host bridge, avoiding redundant
> > > device tree reads primarily in dw_pcie_ecam_supported().
> > > 
> > 
> > I don't understand what you mean by 'redundant device tree reads'. Please
> > explain.
> > 
> In dw_pcie_ecam_supported () we are trying to read bus-range to find
> maximum bus range value. devm_pci_alloc_host_bridge() is already reading
> bus range it. If we move devm_pci_alloc_host_bridge() to start of the
> controller probe we can avoid reading the dt and use values stored in the
> host bridge.

This is the exact information you should put into the description. Do not assume
that the readers will have the background.

> This was recommended by bjorn in the v2.
> 

Then you should add 'Suggested-by' tag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

