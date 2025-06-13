Return-Path: <linux-pci+bounces-29681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE026AD8B85
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C0A188FCB3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377A275B0E;
	Fri, 13 Jun 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMMSuxdd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA275AEE;
	Fri, 13 Jun 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816162; cv=none; b=NdqiKGbYLo/3jdrHiuu5VacxNnZAylRYcquIk2WCIl2+XILwii4L+sh/jiw6WdbkD5h7BMSN4P6qjk4lEvnqAII24F9Xlk9eaOtoLbTLh07kxZ3puPudfrLp2fizSrM3nEMDrfmbILBoJVlF7Zh83ta0dtRmGU4HB2MBDHqS3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816162; c=relaxed/simple;
	bh=ptGTEPBzKTgt1ZhqPyNpeoZedjh8jWlmRyimJ1J8KLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfaxO2shaOSrFtB70FIJSe6QG4VdH/caTuaJdUZiOxwuWrHdgURk0BpfdAfCJSF/NVPbxxlGLUf3raVuaPqDG3sUPk1owXQOscXyc/c9bNRG+Uw9lXaR97dfmQ9/9mzcVUWuXsfc9oQ8TIML2KPuhkvFNO7LuxvEcZAEA0w3BiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMMSuxdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F020C4CEE3;
	Fri, 13 Jun 2025 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749816161;
	bh=ptGTEPBzKTgt1ZhqPyNpeoZedjh8jWlmRyimJ1J8KLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMMSuxddTOfmauhNg/0g0BI1pAdFxkmvRmdp16nYt+eCKgofcaDi554ZX33qI0zg/
	 B+ZRbCW6wJz0E4DvIGxM74cGyybSIbfSPMif7vjGK40ycH+xoj8BXgkvsep0V0Io2G
	 Zr2lXmtSoLqDeEscu4xqxJNBcPdOALqCMTVui6csvVDZATBx8XRInRFy3VVSIfEc5J
	 lJsBYJeLJA0TMga7b5QICwKlWTybqsM01Mp8MkjErGHWRXaCc4SM3Qe4Zk8G9+Y4IG
	 dPAKk1lY4KbwLTEzmCgJc4iCV9+dTPvtnIRNmWUjGXgL9mGHwNU+26KluzWe9g7J6j
	 f5GWHqa2+NwOg==
Date: Fri, 13 Jun 2025 14:02:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for
 register bit manipulation
Message-ID: <aEwTXVZI0wvRvgil@ryzen>
References: <20250611163057.860353-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611163057.860353-1-18255117159@163.com>

On Thu, Jun 12, 2025 at 12:30:57AM +0800, Hans Zhang wrote:
> DesignWare PCIe controller drivers implement register bit manipulation
> through explicit read-modify-write sequences. These patterns appear
> repeatedly across multiple drivers with minor variations, creating
> code duplication and maintenance overhead.
> 
> Implement dw_pcie_clear_and_set_dword() helper to encapsulate atomic
> register modification. The function reads the current register value,
> clears specified bits, sets new bits, and writes back the result in
> a single operation. This abstraction hides bitwise manipulation details
> while ensuring consistent behavior across all usage sites.
> 
> Centralizing this logic reduces future maintenance effort when modifying
> register access patterns and minimizes the risk of implementation
> divergence between drivers.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

No cover-letter?

Usually for things like this, it is nice to see the diffstat,
which is usually part of the cover-letter.


Kind regards,
Niklas

