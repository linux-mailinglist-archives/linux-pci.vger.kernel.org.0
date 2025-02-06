Return-Path: <linux-pci+bounces-20805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DFA2AD36
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B26C3A6F7C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF01F419B;
	Thu,  6 Feb 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0jqkoAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F91F418B;
	Thu,  6 Feb 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857765; cv=none; b=a/+6HAzn/rkBxJ7/oN7P2NmH8wylD5KBrRY0Y/hBcarazJPha64rKjdishvcaD5EdH8ta3PTs9+/tO7VLWNBS1gaNPnwbLBWBshnSCSoefy1ohSUVJ6GrlXoDsvGiCw2ksKIX3CcYswI40cBji9MiAK8ZuGEP5ZaXMf1BHInuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857765; c=relaxed/simple;
	bh=x2gpS+dhI9K78ESB6TIOUjl5kGdcJeTQlkc7ugTmD8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eoYJrTCTP3M7Q3AnV+/kyF7kBf7JuyiJBiSEIwDqWgXtjWeKyi3eLbD6cKpjV+UAl1ySN3qGtv5RE2KK6aFZMsdNYKOP6Ljm8qkvKQYSvkj0nAR0HrzYk2QDbDHYvoWaRJ2//VdqZUJJLcibvbIc9WesQjcbdzOYi244AaL1Hkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0jqkoAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A70C4CEDD;
	Thu,  6 Feb 2025 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857765;
	bh=x2gpS+dhI9K78ESB6TIOUjl5kGdcJeTQlkc7ugTmD8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I0jqkoALn105vNr6UekMx9bp4Yqy6RNwxreb6YwQCm1EkdfON9b4CUgmSsxPxZg3I
	 p9QiBLC233isUkmx0OR3+Lkoxv3GNPZrCxrZufzXgWOu3r/OCbZ+/nOqOPeTYsnqdO
	 z34KWJMCxAJRtWF/nc0l36XUpK5jV1KrB/YUGb0r1FfAIAWhZWrJJwJuTO72RLlKZl
	 H3lR7XCtidM3qhwpdnTxmBNGKbJ9OOR/CPln+kTQMRdwyPWDBqzIaJ0/5BS9sPrUGu
	 RgJj/PYWGqr6ll4sTxy4lLmQNzlSBD7GvrxlNvN8SobxPPdOvGIuWL46XkptPVSvrZ
	 4sIdM1+Al0wmg==
Date: Thu, 6 Feb 2025 10:02:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <20250206160242.GA985980@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6Rz1o3CnnuUiaoI@macbook.local>

On Thu, Feb 06, 2025 at 09:33:26AM +0100, Roger Pau Monné wrote:
> On Wed, Feb 05, 2025 at 09:17:31AM -0600, Bjorn Helgaas wrote:
> > Please run git log --oneline and match the subject line capitalization
> > style, i.e.,
> > 
> >   PCI/MSI: Remove ...
> > 
> > But it doesn't look like this actually *removes* the functionality, it
> > just implements it differently so it can be applied more selectively.
> > 
> > So maybe the subject should say something like "control use of MSI
> > masking per IRQ domain, not globally"
> 
> What about:
> 
> PCI/MSI: convert pci_msi_ignore_mask to per MSI domain flag
> 
> Which is slightly shorter?

Much better.  Also capitalize "Convert".

