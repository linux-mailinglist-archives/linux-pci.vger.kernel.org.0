Return-Path: <linux-pci+bounces-5370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDF8914F8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C7A287ED9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068942079;
	Fri, 29 Mar 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Jsv3YhaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfbno9EB"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70ED64C;
	Fri, 29 Mar 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699449; cv=none; b=THk0omftkJe4+OlF+Plzpe3XZ/uma5A60mMVz63s1F7Lk3gNN5LbKOBiMpIlM7rErQaWZ9R7RpB7PLeyc0Tu4gD7m2Catbiun+Ew9Dlmw06wJErPu2KZkYF5wp7fSh7TjVM+0xlPCBrLNYO27In3GaFPqSQk4wiR3N87WbjqZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699449; c=relaxed/simple;
	bh=5JkguJ9tRyHDZYHEatENmOipPcAV210ArjFfEQihk0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML9w+YgL7ggxqZHsBNfYT/6FCYkYz5yssEu5I/dCtpKr4adD8PQKwupOItDUh4grX/MPA7MUwJtjyfvQOAIgtBCD20KE+THwO2uP8opA9yuRFoczV0Jhed8SqPZvfISpAhS83iRqfmDjtzDvR4M92MI9j1gvgWXMmS3+ShIMHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Jsv3YhaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfbno9EB; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5BEF918000B6;
	Fri, 29 Mar 2024 04:04:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 29 Mar 2024 04:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711699445; x=
	1711785845; bh=ANnxC5Ltf8crvgTrACaUhcyt5ac8W/yj/iYFIj0f9Nc=; b=J
	sv3YhaOp38/zjWHZElvpNVIa5jvZ+e99KT2Z+dAsePIcCrvSr9755rA3TguKi9B7
	a5PLpgn7TDZ8jPP2CYGS9x77K5O2CBTZIfIDtp1tTq8HzwyLI5PFQVqbWz2DxHyN
	Pjz7yAPzM/YLBg/6ymycQByysLZ7rXDKtBWKMCQWzd4vViAuzXTINuOnb42uy6/g
	4MMAgG3rl6GdKa1QWYpLizpAC1h9Q8t4VnNuUcoWps2Yz51mZFwmBKnpxXa1bOcI
	p7kXUO33gduUcNfLkAsGBrh71ZysPVSKh0/Y5fFQQiPhb4HDZCGECv+1ivsqpBhC
	n6F3edH8Y36jff3G+91Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711699445; x=1711785845; bh=ANnxC5Ltf8crvgTrACaUhcyt5ac8
	W/yj/iYFIj0f9Nc=; b=jfbno9EBjYyFTYu+Gw8jjM+f2P0uGgFz58xdoqPylfL1
	w3jJooiQvttfSRTdpkP6Sysep2ya0JIECGvg2Q6+VG2ndm7rNoPal5PvasDKTiaZ
	K5rhG4pNa8Ub9RDqqdChrINMZbXK6rfC4rlxwH6d3Xg2NGU7gmE2hH46hsGU9zsc
	WtqWidYdub2lpQLAIWgWPtmyfCyF5bg/+WqTeUOGlMReDjmqQ08jMAur89xJQrwK
	MhInBOhOhrI3XxqxM5hhBTPYIt9L57HF0PW9gS4CbHEnUTF9yy3b1ybrVZNxhmQ9
	VgQMgmsU4esJ3aT/omdKoWthkg7AusdJmAiFw6UEDw==
X-ME-Sender: <xms:9XUGZr28SBytj-5YvoFi3I7p7g_j5RG3-WXyrvyEhraQCQxCMWU9ww>
    <xme:9XUGZqFGvJBLLG5imNRtPdUzEP3fz0PcR_4QHrHzcuHyJllyJejTiERzX9ANNcRIl
    BvVNKExg0IWBrGTgrU>
X-ME-Received: <xmr:9XUGZr4Qa3lsYzKGukkws0WtLLfEIFR3f02JyJU6A4IEN6ZigbfF0IWvUS5OgDcVAYjbZt_XaxAqkKKhhee-scJV1PTOFwcpwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:9XUGZg1BrFu2NItNt4E3_s_uoF6N3h_vWkw64WPmdvrXJI0FANSE8g>
    <xmx:9XUGZuEkCUXb4UwDPRcr_GoX2QAwONNsP9VRz1i7031wMgUcm0FSRA>
    <xmx:9XUGZh92WTp5iBYU8WmvboPOvaf0RnwWsGFga8hteQ3KMP7OXxp-Zg>
    <xmx:9XUGZrm2aHHIhALUTsrpwp3-oBWECdNj3BFBjIHppONSmBzmGg-oIg>
    <xmx:9XUGZsakF7j5qbsF8S6bQhTu3HF1UBwGkKbAQBi4LsZ59ulanQGxfhLt8DU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 04:04:03 -0400 (EDT)
Date: Fri, 29 Mar 2024 17:04:00 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Edmund Raile <edmund.raile@proton.me>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] Revert "PCI: Mark LSI FW643 to avoid bus reset"
Message-ID: <20240329080400.GA231329@workstation.local>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, Edmund Raile <edmund.raile@proton.me>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux1394-devel@lists.sourceforge.net
References: <20240328212302.1582483-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328212302.1582483-1-helgaas@kernel.org>

On Thu, Mar 28, 2024 at 04:23:02PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e.
> 
> 29a43dc130ce ("PCI: Mark LSI FW643 to avoid bus reset") by Edmund was based
> on the assumption that the LSI / Agere FW643 has a defect such that it
> can't recover after a Secondary Bus Reset (SBR).
> 
> But Takashi Sakamoto reported that SBR works fine on this same FW643 device
> in an AMD Ryzen 5 2400G system, so apparently there is some other aspect of
> Edmund's system that accounts for the issue.
> 
> The down side of 29a43dc130ce is that when the FW643 is assigned to a VM,
> avoiding the SBR means we leak data out of the VM.
> 
> Revert 29a43dc130ce until we figure out a better solution.  In the
> meantime, we can use the sysfs "reset_method" interface to restrict the
> available reset methods.
> 
> Fixes: 29a43dc130ce ("PCI: Mark LSI FW643 to avoid bus reset")
> Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Link: https://lore.kernel.org/r/20240325012135.36861-1-o-takashi@sakamocchi.jp
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/quirks.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thank you for the revert patch, and I apologize for the delay in catching
up with the change. Please feel free to add me or the linux1394-devel list
to CC of these kind of changes.


Thanks

Takashi Sakamoto

