Return-Path: <linux-pci+bounces-41162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D44C59813
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 314814EE2DB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423D359712;
	Thu, 13 Nov 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2K0SRC8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077273081D2;
	Thu, 13 Nov 2025 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058390; cv=none; b=PRjqxwiWjX15ls7ZmhFyw2IfNG84b1AAMOoA5TuVKL21lsCFTPw5/djf3cisM/dFqMPJJ2K96ouINqmg66f/m8gBrPZmTwM349i0lmVuPPylXXhLHBAoEoxPhP2whBLvTng7WyNeclPJjR4EnxJ8XvYr0WahvXURS6OgLPa9KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058390; c=relaxed/simple;
	bh=21AbBLpgy/u/7BPPSmQEYkJm+sdPArtMZJpHj/edoWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pjjASAJUTuYK+y8Tx81KmPbY3q7FpjMZkOuTZrL/wlEefOlgXbRUJDWmwYbb5IYpxcxtEI4Z/dFbLqdH4QZDTJBkm2CuW4j3QO2LZ0qqscnQ+rY8ZHl4m2VHxQZISA6agtPgWd0KJ8qDkdo+LpFRgAmtZd7tbRd0b/6Eir2Muqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2K0SRC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED10C4CEF5;
	Thu, 13 Nov 2025 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763058389;
	bh=21AbBLpgy/u/7BPPSmQEYkJm+sdPArtMZJpHj/edoWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V2K0SRC8XD9sL4OBxvrcney4oUNpmOtrJfv1Zjw27y5hpZJnncKBqD9xnG4C9lUXQ
	 15Va4I+QGi9DLfKnPG2jvILewC8w+6frXb8DfcLNQg98w4PNr/f9ljm38W++fP7C87
	 RjDOvxOslx2LJZaqBvEAombr+rgMWKMjaSV3CAIPrAiHVDgIrMJY6DURcfgYHFtHwv
	 sEQX227AiXJrZHg7et0R9L7ez0k60a4lMj4UfQg/UB7OtnPdntSzf/jAKH5wlTwltN
	 m2KSUMf32DXlUNR34/5h02xuGDKy4hh9gHx8VAwTmXBHNjleLPHDFfxbG3VbOfW6lJ
	 SurtAcj61VF0w==
Date: Thu, 13 Nov 2025 12:26:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Message-ID: <20251113182628.GA2295700@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176190080005.8740.2017130135799803682.b4-ty@kernel.org>

On Fri, Oct 31, 2025 at 02:23:20PM +0530, Manivannan Sadhasivam wrote:
> 
> On Tue, 28 Oct 2025 21:12:22 +0530, Anand Moon wrote:
> > Refactor the J721e probe function to use devres helpers for resource
> > management. This replaces manual clock handling with
> > devm_clk_get_optional_enabled() and assigns the reset GPIO directly
> > to the struct members, eliminating unnecessary local variables.
> > 
> > These patches have been compile-tested only, as I do not have access
> > to the hardware for runtime verification.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
>       commit: 59ba8c0981e73cb2bb70074be4ef46b4188424ea
> [2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
>       commit: 8895c0fc0671f38746ee1c02b728b126f7dbbf97

Moved to pci/controller/j721e so they're separate from the keystone
changes.

