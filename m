Return-Path: <linux-pci+bounces-37268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFABADE7F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAE7189482C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44279309F15;
	Tue, 30 Sep 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sT22RYEy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA782F3C0F;
	Tue, 30 Sep 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246257; cv=none; b=Owd/L/btj6yNSdOSJyJUZDysyaL7UHO2lMV8pJCHnUiwb5PATMLuJgZNXSNsye7pjhEd77ON2JKzs3fbjBIjEWJeX7/UaytuCoUiNL7TVOwDhMWR4PyfqP1GjTuHMt1gYk3RHUauxYz15qd+WtvoHLRH6445/JmvU/G7RvTPMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246257; c=relaxed/simple;
	bh=eoy7Ttnc65ZE6yyi28DOKF3uigd36aUZ/ZQBcbSs7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Num7jGHG3JzhFqh9iDXOTbDbjBrTdNpnSdpL4oZY/ppAQZFPDWWgOOzqjgG0BH9kJqV3JdFOdsuSkeNdW0Z7OSSn5KaTG8S5kc3q120aHjvTpJ/O85WERuT7DkXCiDWrjt5KRuvnPP60vMAPuoP2GfdrkLXFPSp27cIVjHRWRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sT22RYEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5ECC116C6;
	Tue, 30 Sep 2025 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246257;
	bh=eoy7Ttnc65ZE6yyi28DOKF3uigd36aUZ/ZQBcbSs7EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT22RYEycAcVKgiaCkwHfmvX+lDtK5rLLAPFdv9NLcvT+c5plrgGH4ZQdF39inp3K
	 r32SGwBrMCxik8aur4WEXHsmMXw1fmaX07G9VMSZVn9Q0+JOI4SRGeVLmzo6nwefaW
	 wg1NZcpuay56YjEhvPAANTJlxdzNM/VESx0Y5rvM=
Date: Tue, 30 Sep 2025 17:27:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <2025093044-icky-treat-e1c3@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
>  include/linux/dev_liveupdate.h |  23 +++++
>  include/linux/device/driver.h  |   6 ++

Driver core changes under the guise of only PCI changes?  Please no.

Break this series out properly, get the driver core stuff working FIRST,
then show how multiple busses will work with them (i.e. you usually need
3 to know if you got it right).

I'm guessing you will need/want PCI, platform, and something else?

thanks,

greg k-h

