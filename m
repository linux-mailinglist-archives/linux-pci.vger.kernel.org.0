Return-Path: <linux-pci+bounces-38390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26FCBE5306
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B981AA130E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02C26CE0F;
	Thu, 16 Oct 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfT/hDCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5727EC80
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641810; cv=none; b=oILClXQvsLKIi5F8TcaIKmIanpm7KS6ovRaCYUj0u6AqrElJ7VL7RdT/Jdt/LGIPhP4BWzetAoFAoMHtn6XTjOavfnyO1uC4e+CHwAxLxQtZKUP0X+zmlqN0fy8kBHLuxy2fXuC5aiTfgNU3mFoq45f82dBz572mtu3pK3ET/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641810; c=relaxed/simple;
	bh=Bvll1JDv8UDKWUmItfMZe3bIYzOE6ZRKw2NlHMaNBuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VFDXJijH4i8vnmiiwGAqHEw/EO+BU8eBTIihv0dc/W/eYdP7Gz9yys6knlt58FaUc3hJ5LuDgP3agc/0h8KvjRE6GKDBMVrFzINIEzQ6/fPPT4KRfxJRuy563DzsW/TIfGQJDZUv+oTcoSqVWo0ddFKxDFNTuesMi6UGV/dDP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfT/hDCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B86C4CEF1;
	Thu, 16 Oct 2025 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641808;
	bh=Bvll1JDv8UDKWUmItfMZe3bIYzOE6ZRKw2NlHMaNBuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VfT/hDCSSUgM/A8gHcz8O0mW/MeNmjBUAzgXyqaA9al4C6chr3NHqK/6HDmvdvyqB
	 sok1k+QQ3bWO8ilkTsbJKQdRT3QehJUgVlj7aK7q6qL5TbSIAYWcNJ5pbOOZ6szwy0
	 GgSS9iRD1+NRhBBV/ud+IkpGVnKCdmOvr0mBLJn47QYl9G2s6iATVa15dgES9RS4XI
	 TGIsX+fCnG+wxBbKUAe4SAm8vNnWIxJrELvHMCH2iIjwLfKbpiD8/srQEWWoiRWfao
	 4CGVdyiFj+l4VPpGOqPgGymxZg9g+WSBiqMht1rCUoGgKozgTBVmGpjlQ/Ey//aAjM
	 hfvLUghGlCEEw==
Date: Thu, 16 Oct 2025 14:10:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bjorn@helgaas.com" <bjorn@helgaas.com>,
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [Bug 220658] New: [BISECTED] PCI MSI patch causes boot crash on
 HP Spectre x360 Convertible 14-ea0xxx
Message-ID: <20251016191006.GA995826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6267810FFB290004E2DC2958BEE9A@IA1PR11MB6267.namprd11.prod.outlook.com>

On Thu, Oct 16, 2025 at 06:58:55PM +0000, Brandt, Todd E wrote:
> I tested the linked patch and it appears to boot, the system is fine. Thanks! I'll update the Bugzilla with the fix patch.
> 
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>     Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>

Thanks, Todd!  Already had your Reported-by, also added your
Tested-by.

