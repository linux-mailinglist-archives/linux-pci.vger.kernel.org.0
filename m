Return-Path: <linux-pci+bounces-38915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86402BF76E4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321B0343CBF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C55336EF7;
	Tue, 21 Oct 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PniYtRQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9436B;
	Tue, 21 Oct 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061182; cv=none; b=SJe4OkWehLh0aWEkETRxli953oc7QdqDHZ5zVVlevKNruMLZRWG3/PiwyMe9bbZasyvX7EiHhVbM4DHckBhn4c2x562eGwrHloiQkWJ+B7fAVIGqIZeT2mQ1UlfI3Ezy8k3CNbe47R5yv5U2fS6bwat+qqb7FVUwvpuEw4UBSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061182; c=relaxed/simple;
	bh=W0p8yKBOrvMdn62s9c+gjIicRjtIrALhyyoPoabEaio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AsxT0MsX9ik2CaFvGM28limhcrn5jMn6dqMrGIrBZxuMw2imy/2ivchNXUpNQEa79eAmaNUvNskjHX08N+pYaUya9REbmtXNpbYYnBFX57DKkjyvLIZm7AnbqN15E+9j4DVlzmyN/i/yuBajwbexcQqymZ+CBSor1ynpal5EngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PniYtRQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681EFC4CEF1;
	Tue, 21 Oct 2025 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061181;
	bh=W0p8yKBOrvMdn62s9c+gjIicRjtIrALhyyoPoabEaio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PniYtRQBqYICq0hnLKFG2Bx/lH1zymTiPaTxPNp5xY1OG9o+vC4DTpekul9HuLqON
	 be1U8/T5RwnL+f38i6gGleTtu7d32+cY1J/+hYtn8YC7y1Wil4h2EShFTZv4CatMFl
	 btlC3eI7if0H13dibulg+/b5nqmi5EVmGlYnYWiyk1K8oiCpx0H2WylOcU1SqEd1yn
	 oHnP8bRRPS8zQeKbyIrG04FFKC+zaPIHvcHtG07BJIDLO1HLV+VI0jMlxSvPBaBlRu
	 N8BGWUgragKKHTpQHIH6FR6XLRObjMCKnwd2A3UMjLnnSylkAltze797WjwlsPf/fT
	 bZhq0LuWGv+LA==
Date: Tue, 21 Oct 2025 10:39:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251021153940.GA1191128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2wv7662f23seqtifn4zkud6xlecfhpeso4rn72syn6q2ts6sm5@cllw6gyv2xwx>

On Tue, Oct 21, 2025 at 06:05:07PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 21, 2025 at 09:31:32AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:

> > > +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
> > > +			link->aspm_default |= PCIE_LINK_STATE_L0S;
> > > +		if (link->aspm_support & PCIE_LINK_STATE_L1)
> > > +			link->aspm_default |= PCIE_LINK_STATE_L1;
> > 
> > Not sure if it is worth setting these states conditionally. Link
> > state enablement code should make use of the cached ASPM cap in
> > 'link->aspm_capable'.
> 
> I see the point now. Without the check, we falsely claim that the
> ASPM states are getting enabled. But we cannot be sure until the
> register write to LNKCTL happens, which will depend on many factors
> (own device capability, upstream/downstream port capability,...)
> 
> To avoid ambiguity, can we reword the log to something like,
> 
> 	"ASPM: Overridding default states %s%s\n"

I think aspm_support already includes the capabilities from both ends
of the link:

        if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
                link->aspm_support |= PCIE_LINK_STATE_L0S;

        if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
                link->aspm_support |= PCIE_LINK_STATE_L1;

