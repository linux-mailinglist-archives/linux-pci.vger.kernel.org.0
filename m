Return-Path: <linux-pci+bounces-20542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F8A21FA5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849731639B2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA51B4153;
	Wed, 29 Jan 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjJriJO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B514A635;
	Wed, 29 Jan 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162223; cv=none; b=S+rGZZ6jGMHABj49HDhVEPOrW6Sj6Y+bLrrNSDA1H44L2yEuAmDmo8Tm7KcGMYACVUwf/iIorm6stU2HrD62h1Iv/GN67XV/h5S2uJsJZJHxrywc7kxH7NF3x/al5YMhnzhTu0SWHWbohYBacCjLDAzqdIin3kocdvZQDsZDSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162223; c=relaxed/simple;
	bh=Yulc6gJaTzGVoS9ctTWsVTmw0HAG9Y+R9cKgd4fepeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZpYdHnkBZZcEycTWLruZZa6a4cS/xEGRVv24rKkLQSEhy9TClctIZPlrfhe8/YlDepnfQ1mfUDgaygsX8MkIQD3BqsXvTg6FSqchyskZOUqv8zc6KfaWZRT+U07u63sthbFLSZbbvWHAhG7Ex7U2tPnb3eUmPG6kLGCWb0vqg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjJriJO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA68C4CED1;
	Wed, 29 Jan 2025 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738162222;
	bh=Yulc6gJaTzGVoS9ctTWsVTmw0HAG9Y+R9cKgd4fepeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OjJriJO65H3ftNFlkfAjt2ManhpLdvdPy3FlOlQ4vyK0XIdBe47wDizeToGtuHSiF
	 7LFWxyVWq9wGi/VsxMyoaZXkRTPtsXlcE8V0HrM7S9709NJM07bP6/aOtBBclwwBr3
	 FGnSwDrNI4TW7cFrnVH5gImtdBKqXdVkQaJXEcjNOyftS4Mjh4kCY9qy2yFv+zYq6u
	 DFqUwR3UBBFzu9ZLwhmFlMAzdCe8MOi//Amfhhkn/2uOJ9OPpl+GrFqyflBRjnURLb
	 7BBxtn4QMCUHmrOvgO/zBA8bGyf0SgzhC94Qm3rDdlHK86R6ExitPGSEsRqsa10Sa9
	 sgX1jF/eyk0kQ==
Date: Wed, 29 Jan 2025 08:50:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <20250129145019.GA459546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841e1793-4635-4f06-b0c9-37530215c08b@suse.com>

On Wed, Jan 29, 2025 at 02:52:33PM +0100, Jan Beulich wrote:
> On 29.01.2025 14:32, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2025 at 04:47:28AM +0100, Marek Marczykowski-Górecki wrote:
> >> On Tue, Jan 28, 2025 at 09:40:18PM -0600, Bjorn Helgaas wrote:
> >>> I guess the code at [2] is running in user mode and uses Linux
> >>> syscalls for config access?  Is it straceable?
> >>
> >> Nope, it's running as the hypervisor and mediates Linux's access to the
> >> hardware. In fact, Linux PV kernel (which dom0 is by default under Xen)
> >> is running in ring 3...
> >>
> >> But I can add some more logging there.
> > 
> > So I guess the hypervisor performs the config access on behalf of the
> > Linux PV kernel?  Obviously Linux thinks CRS/RRS SV is enabled, but I
> > suppose all the lspci output is similarly based on whatever the
> > hypervisor does, so how do we know the actual hardware config?
> 
> The hypervisor only intercepts config space writes; reads, particularly
> when going via mmcfg, ought to be unaffected, and hence what lspci shows
> should be "the actual hardware config".

FWIW, on x86, the first 256 bytes of config space for domain 0 uses
raw_pci_ops even when mmcfg is available (see raw_pci_read()).  This
normally means IO ports 0xcf8/0xcfc.

