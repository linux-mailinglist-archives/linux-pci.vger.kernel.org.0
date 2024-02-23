Return-Path: <linux-pci+bounces-3956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C186201A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 23:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1501A287514
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90B146E6D;
	Fri, 23 Feb 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsZPHsz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C491419B3;
	Fri, 23 Feb 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728867; cv=none; b=LNp27+1yk39CtK8YfBtfDiaoiUtXXKc7yFGxyy/Zl9PMxwZ4pYxDhns932T4Tcwd5PEh6id9lN6hsMwoihiiUYKNOn26+49Zs2dVbikKKIHeSL9fp8gBVYHJMC2dW+H+QUNyZtrf0Km2bX4R9uMivot0beWUa40VwS/JBDsSs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728867; c=relaxed/simple;
	bh=0NSUedbjyUk5R7hCcVkUZdvNMS/jzvFh6DRYgWh6R8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sWLpSJihS8iibk9jpLNm7bSXecBhq2jioPyTzYD5E4UoY26hGHFHAC8905A2940t8HIbHimZmHKdj+80LFSMD65A7+CCvzO7bchFpdT8hEAIXbOAJ8jnwGDV0R1pUiJxOArAyolhVXbnQcoLCI7U5QsUqHAbeebw10QgH6844Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsZPHsz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C20C433C7;
	Fri, 23 Feb 2024 22:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708728867;
	bh=0NSUedbjyUk5R7hCcVkUZdvNMS/jzvFh6DRYgWh6R8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YsZPHsz5raerQE80c8dON9WhwjgnZnIGP/CdqHiR1h6RPx/Hkh44I+f91o0jhk7YG
	 BrGNkJ9pKYgdC1yhLs9XycYQUqdZsKvjMuRDJP6Q31eySEYOGTZ1Fqz2ppsjHcmrbc
	 UokZK/Ozi4TcwTfHV12hPMreJD5ha5pVFPGW9AtbseYWUrzmVwaX4wiJldsbPpiDbK
	 HkGt/ointiIK+uT9jhDrVZ5kPeJn0fC19ztaqVy0IqfA4gFk0+H51IwRCvvvWJ756+
	 yAVZItBMOnxXTUreSGnyOn+vY9PBRhiwL2ircyGdIoihcqcpGtwF2Elrkv1e8iQInp
	 8pTiumOHJUagA==
Date: Fri, 23 Feb 2024 16:54:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20240223225425.GA103870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708697021-16877-2-git-send-email-quic_msarkar@quicinc.com>

On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that there no cache coherency issues exit
> for the addressed memory on the host i.e., memory is not cached. But
> in reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.

s/that there no/that no/
s/exit/exist/

Forgive my ignorance here.  It sounds like the cache coherency issue
would refer to system memory, so the relevant No Snoop attribute would
be in DMA transactions, i.e., Memory Reads or Writes initiated by PCIe
Endpoints.  But it looks like this patch would affect TLPs initiated
by the Root Complex, not those from Endpoints, so I'm confused about 
how this works.

If this were in the qcom-ep driver, it would make sense that setting
No Snoop in the TLPs initiated by the Endpoint could be a problem, but
that doesn't seem to be what this patch is concerned with.

> And worst case, if the memory is cached on the host, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.

s/intruduce/introduce/

Bjorn

