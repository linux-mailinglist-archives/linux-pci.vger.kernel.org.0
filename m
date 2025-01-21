Return-Path: <linux-pci+bounces-20190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E5A17EEB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C51F18826C4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45541F2364;
	Tue, 21 Jan 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+iqqr3t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB51F2C27;
	Tue, 21 Jan 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466487; cv=none; b=Ebb523xi3bsyZsc0O+/Rkiaq7mXDwo26fcPrjwgAkZKDndWG/Nt89g3Sh/ZVCh89+1TOi89+TrAJ/pVVx8HW6Tf/iVl6QBILeGOI9fe/3mQaKD0n3NCZr3mdN7IM2UPYtkL4got6vLKFn7dKMXG7U2x3dtIVyauPp0Mt6H81oJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466487; c=relaxed/simple;
	bh=1bMuTZFoWoA0iduATjRFPX5ecjUihC+lQ3BWZcc9jF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9c4c8Caw2WjCkJXTvd5bqZDYXfxuBzjRWV87U1qBkGpzwHCFBc6GkuFLm5CrUpByeQ37N1tVlVEcFw3fTjz24vx84s3Gb95d3NKBBtFDnoPQgdvfxrPdxzrKCaxzUt7jUCS6G7uuZTgq/UBXyaw8of41WOfSq8CTSncno8oECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+iqqr3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0127C4CEE0;
	Tue, 21 Jan 2025 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737466485;
	bh=1bMuTZFoWoA0iduATjRFPX5ecjUihC+lQ3BWZcc9jF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+iqqr3t9V7O7AglMTOqrogqcLFRq/Ttxc6HkCv5ZDLfYwDveBQGy9pf6nFwPqURu
	 Nsf9uQP4AmHn/2id+FTSx9SBzlXg+QtdPz3mXjGPhMCIDQbdmxQGQ8ZGTU9P670Ykg
	 plUaq8gD5MR/kfbRs3sB2q8TSq2KsE7XcfaHB+khdFb1l5yUURfKqhRlIuFLY5x6Se
	 VlY4l03aXppeeRWTOLrHSrU9RmqbDw1vJrDAkdAoXhjWKFChXiDSu8D1d6qFL7FIL3
	 AlysmN6wgyn+S6yfVX9SpIcdNmt1aiB8TA/UCNINsvufK94GsYgx7AetvCS8S7/Gix
	 WkW/xhv0sHDUg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1taEP3-000000005yb-3xY6;
	Tue, 21 Jan 2025 14:34:49 +0100
Date: Tue, 21 Jan 2025 14:34:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	rafael@kernel.org, ulf.hansson@linaro.org,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <Z4-ieduktJmnHukJ@hovoldconsulting.com>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
 <Z44llTKsKfbEcnnI@hovoldconsulting.com>
 <20250120152829.7wrnwdji2bnfqrhw@thinkpad>
 <Z4-eufq4M04XHjck@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4-eufq4M04XHjck@hovoldconsulting.com>

On Tue, Jan 21, 2025 at 02:18:49PM +0100, Johan Hovold wrote:
> After taking a closer look now, I agree that the underlying issue seems
> to be in PM core.
> 
> Possibly introduced by Rafael's commit 6e176bf8d461 ("PM: sleep: core:
> Do not skip callbacks in the resume phase") which moved the set_active()
> call from resume_noirq() to resume_early().

Scratch the last paragraph, I misread the diff, sorry.

Johan

