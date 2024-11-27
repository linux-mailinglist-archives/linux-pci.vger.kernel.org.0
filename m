Return-Path: <linux-pci+bounces-17411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C079DA73E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135A0163BA8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65F1F9EA7;
	Wed, 27 Nov 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssmrL2+5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3301B6D15
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708515; cv=none; b=njm/5US1WMj2jIEo0GwH7k9UOFRcBBlrI+kqB8o9klP+rlfXsjCjgpya0b3EDnvIjro/6wEObtvQcVr1bbYQ5kYuub0xthYKbFM22o7gnosN60eftV5nszmXaqESnZe0fLGuiCD+6fz33eEHufP+rqvx10fJrm4ACuhIIsXpPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708515; c=relaxed/simple;
	bh=bnVs4RGX8PcT5FRKrWnbr4Usf/K0Rl7/ugJZYdnOM9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKKSKlrneWd6f0G92PQbjvdBrVgm1Sh/iM+K3h/9GBU6VbfGjoyliJH83drUe4cAtfwhjnkvoLpYFHDYMyCk+Q+CRWLDnc/Y+iwSyaQj5A0p2nmrpB34YpmvVH6wdbHVMP18F6Ygpri+SFyPPnl9zZTeWmUupjxSB0yiENJGyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssmrL2+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0205AC4CECC;
	Wed, 27 Nov 2024 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732708514;
	bh=bnVs4RGX8PcT5FRKrWnbr4Usf/K0Rl7/ugJZYdnOM9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssmrL2+5UurK8aLyuBdcgzAcz3jTYpoxOWCmBGjSpT4/4n+7n8BrQT1lKQH5vrVog
	 BdQdBHtKrBSrV79DqnrFaK3P0pX+DBaBkiQ4VxTdeet+8TaleFK0SKfE7H2SP4s+T2
	 oqxhhG7ipoSRzmppIGT71pWh9TopHbOp7KVq+4tvFVAeSXvEPhCvR10/k5aqlZeRle
	 XxmptvCsOR0tFyD/+3jArSlGF02ZkGf3RxycFTo1H/X3tPXHImQId0Wh3IhEOAOriM
	 Lbmm3a5NHF++3TSGSPjJOMMcz6sVXE1WKJ85rYWoHdXYHWPQGVxSkwG96OueYeGw0F
	 UmaDxwAD7AOiQ==
Date: Wed, 27 Nov 2024 12:55:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <Z0cIns770dXwe0op@ryzen>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241126132020.efpyad6ldvvwfaki@thinkpad>
 <Z0cBFjK1WgSmg6k5@ryzen>
 <Z0cDZrHfU3jlfOgB@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0cDZrHfU3jlfOgB@ryzen>

On Wed, Nov 27, 2024 at 12:32:54PM +0100, Niklas Cassel wrote:
> On Wed, Nov 27, 2024 at 12:23:02PM +0100, Niklas Cassel wrote:
> > 
> > Once all EPC drivers have implemented .align_addr(), we could change
> > pci-epf-test.c to unconditionally set the CAP_UNALIGNED_ACCESS capability.
> 
> ...and it would also allow us to get rid of everything related to alignment
> in drivers/misc/pci_endpoint_test.c.

On futher thought, we probably want to keep that code in
drivers/misc/pci_endpoint_test.c, such that it can be backwards compatible
with pci-epf-test.c drivers that are old (before CAP_UNALIGNED_ACCESS).

So I still think that having a CAP_UNALIGNED_ACCESS is the best we can do.


Kind regards,
Niklas

