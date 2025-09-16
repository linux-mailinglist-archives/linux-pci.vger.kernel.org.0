Return-Path: <linux-pci+bounces-36270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A8B59C99
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3690932402D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5234573C;
	Tue, 16 Sep 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG7kRAD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304E18FDBE;
	Tue, 16 Sep 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038104; cv=none; b=HOKG/kGHW1qCG6KjO9S53CZ8Lgfkn7t5C4jXQJQ2mpvrfRo/3ZyFFh6rdNctwHH7MYyHSUNdra9nlpCO81Drzn5rYAIome6xt/sk6z0+ibQmn7zPYBOAnRkX0yD9z0GhWI2A4Wvr22f5iflE5deJu44PSgHB5QunOK/40p4/bmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038104; c=relaxed/simple;
	bh=CXYoSgaS63Y+/tc9C0ims5v3zXKHr5QTlAy7T/0nUAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MtcmJWJW/GYCbSNN6pUsqlXf248IYRClcd38JN2KsFdPpFUcMvQ7/2r0DzzmZyHkR0WImWztAP4ydo3hg3FMZ0POXemALOv15tjA9pk3PARBFP2WPpSOXCyR219NOj6gwyvXELuMhfeAvJ2iytpJgRMZ/LO1V/35aght9cmJ19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG7kRAD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE2DC4CEEB;
	Tue, 16 Sep 2025 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038103;
	bh=CXYoSgaS63Y+/tc9C0ims5v3zXKHr5QTlAy7T/0nUAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RG7kRAD2GJpzmsl/wG1YZ7hRD2r3vD8Br+jFsGVErbdEbb8BAozNa2ksZfx+apq6+
	 BW6ORKblBpSyrTNrw8LeV0oIlabHKfaq/4JEFd7goi9vPSq6MYTd56tN1gMldIpn0N
	 4vkLAwAK0nafaOQjWqSMKqWiwYjf4WHQMv8Sxxs6XPqymU4FjazCM+Uhbdl9LLtgCY
	 jAWTMGi+VRCykLD3OP/wVd+hwIx09ub9b6eMxxZyU33HYijgmytgKLd8MzmgXq2tuc
	 fCd0/olnaY7Ac/+ujskMpBW8KqvF8XABsRPFliHispKm/bqd6Oh/5I5wfEeP9w1SYp
	 c3eABWjikpTng==
Date: Tue, 16 Sep 2025 10:55:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Terry Bowman <terry.bowman@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 0/4] Documentation: PCI: Update error recovery docs
Message-ID: <20250916155502.GA1801539@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757942121.git.lukas@wunner.de>

On Mon, Sep 15, 2025 at 03:50:00PM +0200, Lukas Wunner wrote:
> Fix deviations between the code and the documentation on
> PCIe Advanced Error Reporting.  Add minor clarifications
> and make a few small cleanups.
> 
> Changes v1 -> v2:
> * In all patches, change subject prefix to "Documentation: PCI: ".
> * In patch [3/4], mention s390 alongside powerpc (Niklas).
> 
> Link to v1:
> https://lore.kernel.org/all/cover.1756451884.git.lukas@wunner.de/
> 
> Lukas Wunner (4):
>   Documentation: PCI: Sync AER doc with code
>   Documentation: PCI: Sync error recovery doc with code
>   Documentation: PCI: Amend error recovery doc with DPC/AER specifics
>   Documentation: PCI: Tidy error recovery doc's PCIe nomenclature
> 
>  Documentation/PCI/pci-error-recovery.rst | 43 ++++++++++---
>  Documentation/PCI/pcieaer-howto.rst      | 81 +++++++++++-------------
>  2 files changed, 72 insertions(+), 52 deletions(-)

Applied to pci/aer for v6.18, thanks, everybody!

