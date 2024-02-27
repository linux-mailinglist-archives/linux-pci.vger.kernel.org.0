Return-Path: <linux-pci+bounces-4163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5786A3E6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1AB21FB1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68556B6A;
	Tue, 27 Feb 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLOFHpjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE556B71;
	Tue, 27 Feb 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076157; cv=none; b=i5RE2j8xz8dQcGVKp0Bolh76477+mwu2DGN6+Fb9XjhzPai8FDu9T4BwwB+9rCvQv6xOKPEInpW0HdtJ+nH5vCk4XflA1eb1zCCcF2EL6qtd0iPOCFaOZUTv16nqgRofekgAKjqsdXFeg0KpNxRlAKATt7FtHwqKvz4bO7UJOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076157; c=relaxed/simple;
	bh=LAf/7ZQIyaKEaPAbEIeoxEYJIciVBx9bL3fJcDzt+1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oYviBPWXVEtf+9TBcKZhd3ieyDMOIq4jVzJ7eU1zPJM1RznPCpGfYKssfpJgESsD4hLqm3ahmNbFGmAZOFu865j6xIJJRMWWROprXueoWCW3XVI3wIvIi9Vx+02OtJGL8Dj6JHxiLL9Zdmas07zXfxr98BOX/vTQNZoBeH7MHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLOFHpjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48D6C433F1;
	Tue, 27 Feb 2024 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709076156;
	bh=LAf/7ZQIyaKEaPAbEIeoxEYJIciVBx9bL3fJcDzt+1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CLOFHpjf9zIIqBZHK7Hh4NtlLW8Dbl11MFex2P55uBFSPYYxhpKfxPiwtstGfS8TM
	 AT0hKGyTH7/LkeG3Vji0fm+6k5p2fm97EPn1RDdNCL0RhUjHO0C4SRwI5jzVNBDa4n
	 9BEJqpuaqT8cyFtSNwdziRC/my23uyjpQnsblwMAyUPb1eFZ1reCkLJOc2kUV/p6wZ
	 geD6qLDTCrqxgJ+rYEaTOvRiMfLB58KNxTfEpUtxqvFuRQuIileNBuNDNVhNDXJ+9Q
	 AGJZ83+7M6UppXkIp3+AAhtNiA9uSgycA5Uv1Sl6XB1mtBQhV+1IkT07Ftt8BQ/V8a
	 pUtcaMqLLD9EA==
Date: Tue, 27 Feb 2024 17:22:35 -0600
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
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Message-ID: <20240227232235.GA251235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-opp_support-v7-3-10b4363d7e71@quicinc.com>

On Fri, Feb 23, 2024 at 08:18:00PM +0530, Krishna chaitanya chundru wrote:
> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> ICC(interconnect consumers) path should be voted otherwise it may
> lead to NoC(Network on chip) timeout. We are surviving because of
> other driver vote for this path.
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always.

Add blank line between paragraphs or wrap into a single paragraph.

Add space before open paren, e.g., "ICC (interconnect consumers)",
"NoC (Network on Chip)".

> In suspend remove the disable this path after register space access
> is done.

"... remove the disable this path ..." has too many verbs :)
Maybe "When suspending, disable this path ..."?

> +	 * The config space, BAR space and registers goes through cpu-pcie path.
> +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path all the time.

Wrap to fit in 80 columns.

> +	/* Remove cpu path vote after all the register access is done */

One of the other patches has s/cpu/CPU/ in it.  Please do the same
here.

Bjorn

