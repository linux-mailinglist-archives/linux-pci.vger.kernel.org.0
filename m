Return-Path: <linux-pci+bounces-3471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255218555BE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 23:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A271C21E9E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471C1419B2;
	Wed, 14 Feb 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxv8HS1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1E13EFF6;
	Wed, 14 Feb 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949702; cv=none; b=u+1utU3SMnRNu+pRmxCH+dgPQ26gKoBYJBoaoJSd71L46b/SsicUZmqVMrtZ3h/cYnhGGAUDH73E4jE2ih7qQXCMk6wvzFyTvm9WC3Kyn2RkoUHNpHehs8au73FXGByVkWtT1zRGSyKBkIyn6qoDgCBSs4ItsCAxoZTQfqflqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949702; c=relaxed/simple;
	bh=qbQIPkDF9enNBpDUcaaAm6aTN+NTrShN/xw24zMiJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gP9+/VWvDFEzmOxRoaWOWrkDBYNTaqqxKvmJ4C/N6mA8MdbD4Qov2N3Rs4eLhMEz3SXFfZcJ7eWaubitmFf8eHf740cdCRD2hxfdKnwOlY61/tnl+z1umcFD/H6eGV06lgfCdyk1pENN4bQvVB3VxAizqlMg11+8bo+YEB2rd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxv8HS1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D5AC433C7;
	Wed, 14 Feb 2024 22:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707949701;
	bh=qbQIPkDF9enNBpDUcaaAm6aTN+NTrShN/xw24zMiJqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cxv8HS1FjcAFAG6g4L5UUkAfOcC5oRq4VLve5CyWif/eJO7ftzpQYRp+ymW0bXA6c
	 r/c/183kvkTOMOCO+vfiey1KJA/OasI+2CsXImsX6p2aXkLFLlpyT5D3g/Ih4lcwfI
	 xQebTOgZ2QFP+Rv5vwXn4X5EhWPtAM+TX36D3ZWuA1y5MSeC86Znw3Qek8qMimRAz3
	 k0JstiTGweUcoNexA91Gkop+DjQ18SUhZYki3jjvz4NVH9SHl0umbVQpbGMCzuIQgK
	 fDHdVqafGYHKgedJL+ni+wpY5J5RDauoHmh+BUgHLf7UDjmVNIQRc/Fc3DnlWiz00U
	 BFMAuYP2AHd7w==
Date: Wed, 14 Feb 2024 16:28:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <20240214222819.GA1269395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26015e7a-5e3f-471c-aa98-46a0dfb4d155@linaro.org>

On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
> On 12.02.2024 22:17, Bjorn Helgaas wrote:
> > Maybe include the reason in the subject?  "Read back" is literally
> > what the diff says.
> > 
> > On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
> >> To ensure write completion, read the PARF_LTSSM register after setting
> >> the LTSSM enable bit before polling for "link up".
> > 
> > The write will obviously complete *some* time; I assume the point is
> > that it's important for it to complete before some other event, and it
> > would be nice to know why that's important.
> 
> Right, that's very much meaningful on non-total-store-ordering
> architectures, like arm64, where the CPU receives a store instruction,
> but that does not necessarily impact the memory/MMIO state immediately.

I was hinting that maybe we could say what the other event is, or what
problem this solves?  E.g., maybe it's as simple as "there's no point
in polling for link up until after the PARF_LTSSM store completes."

But while the read of PARF_LTSSM might reduce the number of "is the
link up" polls, it probably wouldn't speed anything up otherwise, so I
suspect there's an actual functional reason for this patch, and that's
what I'm getting at.

Bjorn

