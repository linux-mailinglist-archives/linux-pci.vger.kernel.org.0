Return-Path: <linux-pci+bounces-11394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7E949A45
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80E41F2299D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D814C5A1;
	Tue,  6 Aug 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q41VBHVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5A80043;
	Tue,  6 Aug 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980164; cv=none; b=BMaWi7AGkIBlQBHSwDrE9794RDiM2NJsNqtad3AJg8qI0DgjXkPmgoSMieuQU6KqyjgaLLgVuuhxsN5Gl6Dn+tG+kov4gpS0hf0pSqCOLWAGXJxtlTZV+uDPGFmrzjlkuBsu5p9hDUrb1UQtkUTfSAzylkw6ZD+FOHd9zp8U42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980164; c=relaxed/simple;
	bh=T8VAkq6+JkZfcm1MVqAaJkaSISBV2ORR9lhXYRiIiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HBDCE9yBbiBBShKLJLn99khoPYQvOKWm56Vj9DlhlAnWzberG+g1TrdzdRo2PzvYotNxGXf9AX9JkvX+LZzQKVL1DC4TkdaAXpSUgTb4xmmPKRd6nI1DHuwGC3xSMdhtN6+d5yTLUP7gWWzu3yO21bmEba1Dwwu4Dh/LxTh1DUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q41VBHVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EA7C32786;
	Tue,  6 Aug 2024 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722980163;
	bh=T8VAkq6+JkZfcm1MVqAaJkaSISBV2ORR9lhXYRiIiAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q41VBHVJvx2PKZvgG2Eh9xXpTloW/sNrKYl1U0Mtc8bPhUanKLrfu7tfCqgINi5yl
	 g0IgAWLU+fxyPuhhQI6W2wO3dhRN/EIumpY2s1tZZMvl4iVeM8cxe6WlOx996uqfPm
	 iMHqjzYhKokyjujhm3FV8UoZw89LOJS08HcRTBvZQtiLwt0AgYd0boO67FlFYobPYH
	 u7VGstvNdr6h8+JcLDnQLis+wvhbpUmW06Y1FYNepRBC5bC27obpNeQkzgrXiK45L0
	 7V1+otyahqkEHV/XjcPir0i1xhgkM2F5gi4WeHknLeG/qLhAZwRU4CYcJJv4LhauJf
	 CAbbq8+PxETXQ==
Date: Tue, 6 Aug 2024 16:36:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme =?utf-8?Q?Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: remove type return
Message-ID: <20240806213602.GA79716@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfZWns316GziuWbX-ZhO-xZm8rhssoC6tAdizGK1s3Ai+g@mail.gmail.com>

On Tue, Aug 06, 2024 at 05:54:15PM -0300, Guilherme Giácomo Simões wrote:
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:
> >
> > > I can see that the function pci_hp_add_brigde have a int return
> > > propagation.
> ...

> > The lack of return value checking seems to be on the list in
> > pci_hp_add_bridge(). So perhaps the right course of action would be to
> > handle return values correctly.
> 
> Ok, so if the right course is for the driver to handle return value,
> then this is a
> task for the driver developers, because only they know what to do when
> pci_hp_add_bridge() doesn't work correctly, right?

pci_hp_add_bridge() is only for hotplug drivers, so the list of
callers is short and completely under our control.  There's plenty of
opportunity for improving this.  Beyond just the return value, all the
callers of pci_hp_add_bridge() should be doing much of the same work
that could potentially be factored out.

Bjorn

