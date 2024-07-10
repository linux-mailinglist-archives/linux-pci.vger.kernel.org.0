Return-Path: <linux-pci+bounces-10072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9D92D162
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C161C23684
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A4190074;
	Wed, 10 Jul 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMjej+vm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2539189F26;
	Wed, 10 Jul 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613878; cv=none; b=p855eqjbPi7e4hB8DHsv0JD8RtDGIXpWnY7uFRaaqxKLmV8xyHk4z3VoYmfgVqDao0llhrwafI1bJwRUziXT5lP0Dl2eltfUcaQVDVnDJwS8+S0VbfoKiZKpoMGl0TdEI5tiNuXJ1nCr0uijqaf7SvkHT0uCvmlHe4AgfVNOT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613878; c=relaxed/simple;
	bh=snlE/mM+mgp/RDcYubsA7024pVIJBBJzpHzKyn0y0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R/4qWFugMJF8mlsGuz8BYIg3f0HxrZg9B6hHZlTuM0xv1B86Tp43ChV3K4gtu8eB9hQom5Bb5gzA5EPFic9pdwYOB+xNLg0/Azbn5th8vMHMkygtlz8rWLjf+eUaIx6KX8kuVbM7ji0o3szCl5T1c2hqiquoEiZcnVya6J/82OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMjej+vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B31C32781;
	Wed, 10 Jul 2024 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720613877;
	bh=snlE/mM+mgp/RDcYubsA7024pVIJBBJzpHzKyn0y0M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mMjej+vmUpM7I9BH0vnYE0nwzvX79yf3+/SLO4A9eOW+DMVAhO4qakpjctZBYDxZ3
	 7I0a9zUl1QjowjjIknkhg4/RKOK/yhbyh+TJHNuqFAfUiwi2rzOmnKj/J8Et4ecPqD
	 XmykTM/DUVocMiuHe+WhTufQMD3AeYUrm0VRGRGeU7c0oA27hfaCQNsOJucUYOh2Tg
	 u4aVzghOk/V/8zyWLff02qdbye9ud8rgKAN229nK1yXziR56CeUF7gbNuS+Ee1RVqU
	 5UhNu/ZnSMOfPElWtstqnedmC2EXNmXX7nqSkSqGb0R2UywDHppZVjvowha8X20Mk7
	 c81h7RrA9aeVQ==
Date: Wed, 10 Jul 2024 07:17:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v6 1/5] PCI: endpoint: Add wakeup host API to EPC core
Message-ID: <20240710121755.GA241182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-wakeup_host-v6-1-ef00f31ea38d@quicinc.com>

On Wed, Jul 10, 2024 at 04:46:08PM +0530, Krishna chaitanya chundru wrote:
> Endpoint cannot send any data/MSI when the D-state is in
> D3cold or D3hot. Endpoint needs to wake up the host to
> bring the D-state to D0.
> 
> Endpoint can toggle wake signal when the D-state is in D3cold and vaux is
> not supplied or can send inband PME.
> 
> To support this add wakeup_host() callback to the EPC core.

Wrap to fill 75 columns consistently.  Also applies to other patches
in series.  In some cases you may intend separate paragraphs; add
blank lines between in those cases.

s/D-state is in D3cold/D-state is D3cold/ (a couple times here, also
applies to other patches and MHI state)

s/vaux/Vaux/ to match spec usage.

