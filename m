Return-Path: <linux-pci+bounces-19267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE7A0101D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 23:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2293A1969
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167011BBBC8;
	Fri,  3 Jan 2025 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3x+k3Iu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B918F2FD;
	Fri,  3 Jan 2025 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942345; cv=none; b=t7Re9E9s1I/Zpcq1COLkobobH6jIj/Cg5+ieaNTAhJXex+prpsq6AWY+xlXrbgFlDIkSdZ/80C/eYdZiUojQKbYWodS9MbfN/W0hELqFbF/Z9Zq+5a6gxx1jk+hnX34lOHMfLtMcH+XJgrWVokqjU8Zjo/JrQXkEbzu+35esfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942345; c=relaxed/simple;
	bh=VMCbTk9/4FXZczIwaZzYBUW9+7uEZlm9haVYYvtz7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rCnLtnJE3Bnp4OmGU05OsitMkDbCYy682sSTu9o941SoJdXCsfQgFhOTwJlTM0MXz+DU1O0Tnb+vEtD9Je1rhn961ETYPCEsYDeBWdsMzyNXAGZ+OenJd3R7Vx4NsuaaPZBg9Zd6X9cJegcS8ErO2DP5SuasCVYcZduts4xuMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3x+k3Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BCEC4CECE;
	Fri,  3 Jan 2025 22:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735942344;
	bh=VMCbTk9/4FXZczIwaZzYBUW9+7uEZlm9haVYYvtz7D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V3x+k3IuUKTAa9PBZZu4GsSYf20jMwZTqWD//khDSypQj96l7Zlwxy4Q6lcNYPgKw
	 9paMvLLNR6fF3lx796x50PMGNfG++5FWjz8P3DL4v6m7oR7KH/Wdp6ntJz3RlmPLPw
	 t2ESptJWCK8dRtrsoJz2Biz8rum3mqf1sDuNN4NIl3yuCbFWv8wk47cOhRsqjKmwin
	 f+lH+VmLMiwZ4Cn1eVsPskyvEPqzst4uBaCgdgnbBSKEwqlbjo8TLBzCtrb/vgyeoM
	 ZeeQfK6Ku64wtbZF1+2fp6smTOsrETbAWjFCufTKweZ+6hCgiitZoLI/Qvz24+HM/u
	 UC3NuUljLIMqQ==
Date: Fri, 3 Jan 2025 16:12:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250103221222.GA10177@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103220200.GA9636@bhelgaas>

On Fri, Jan 03, 2025 at 04:02:00PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 01, 2025 at 11:15:09PM +0800, Hans Zhang wrote:
> > With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> > 
> > The return value of the `pci_resource_len` interface is not an integer.
> > Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> > overflow.
> > Change the data type of bar_size from integer to resource_size_t, to fix
> > the above issue.
> 
> Add blank lines between paragraphs.
> 
> Looks good to me.

Apart from the kernel test robot error [1], of course.  Obviously that
needs to be resolved.

[1] https://lore.kernel.org/r/202501021000.7Cwcopot-lkp@intel.com

