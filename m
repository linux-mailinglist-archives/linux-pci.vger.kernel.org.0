Return-Path: <linux-pci+bounces-24545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B92A6E008
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAF2188C16F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA113263C75;
	Mon, 24 Mar 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SENGSk+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD411E531;
	Mon, 24 Mar 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834488; cv=none; b=Hozsu+Ff7VB5mrRjW3X7rkvzvE1+b5FfM2mAEN67+qq9DHeVXYntd2/11qJBImzmeynvnZX1IB0kbKh/SeWKTqlTwrHqYva6zbzuGdIpa04NDj6R7F5Xhzhwk67upQ5GzIJavvng5BrntUbgn25WH57Pk+is1iyhVogqysGBAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834488; c=relaxed/simple;
	bh=04kfgYIzADto3t7bsBZLbAym6L+z8rL/NeALURMHoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qbzyxb0rQJjvJfvzA0LkIrOyH+YFLGVl2cOkDDT8GpQfkVISVerWfFfq9RLCKzpVww8YVE0gvYp0JW0cVsfZqQoooYk3txQbvQBlhVr6sHVdMaggvv9bh0LWddMl0mDbQhriO94umOR7giHYt29veOevJwo0T58HKsOfANZjDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SENGSk+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11A8C4CEEA;
	Mon, 24 Mar 2025 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834488;
	bh=04kfgYIzADto3t7bsBZLbAym6L+z8rL/NeALURMHoWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SENGSk+bE6nHZx+U4geFQTVl9bzNPaXLTy5mnB4G0Y2i+JlB+Ld8KqXEnXsY9Kexa
	 DbfQg+lwSi3zUDGqVRr6BRSjPKEZggIfLs0860jlWWkiphE9UlMmpkXYpRIk/y5Bpu
	 CVkQuPzmcwG+WUz77rFQM/yeYTSDCfXh4s2GPmMXnF9zyb4whXfRGJ9rwgU79VlV93
	 CkNKDHqEpiW0V/wwTURlYgdvdUqmiqHhzVUI3JdDaxdhjQEcB7lxZItgJp+y8689Vj
	 X89zxKRyF+rtrB+F3dyld/C363PHGUDtSSRo7HoIaVCjcpJCD0XuW/S5EtunwQWeP2
	 huKhUAQ6ibwUQ==
Date: Mon, 24 Mar 2025 11:41:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
Message-ID: <20250324164126.GA1252202@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <005837ad-e7dd-85c8-b0d3-ce5aa0257354@linux.intel.com>

On Mon, Mar 24, 2025 at 01:00:33PM +0200, Ilpo Järvinen wrote:
> On Fri, 21 Mar 2025, Bjorn Helgaas wrote:
> 
> > On Fri, Mar 21, 2025 at 07:07:47PM +0100, Lukas Wunner wrote:
> > > On Fri, Mar 21, 2025 at 12:09:19PM -0500, Bjorn Helgaas wrote:
> > > ...

> > > >   - It's annoying that pcie_enable_interrupt() and
> > > >     pcie_disable_interrupt() are global symbols, a consequence of
> > > >     pciehp being split across five files instead of being one, which
> > > >     is also a nuisance for code browsing.
> ...

> > > The only reason I've refrained from making major adjustments to this
> > > structure in the past was that it would make "git blame" a little more
> > > difficult and applying fixes to stable kernels would also become somewhat
> > > more painful as it would require backporting.
> > 
> > Yeah, that's the main reason I haven't tried to do anything either.
> > On the other hand, the browsing nuisance is an everyday thing forever
> > if we leave it as-is.
> 
> I get half mad every time I need to browse code under hotplug/. I even 
> started doing:
> 
>   cat ./pciehp*.[hc] | less -S 
> 
> ...to workaround the constant need to jump between those files. I 
> certainly would like to see the split gone especially between ctrl and 
> hpc.

I would definitely take patches to consolidate pciehp and maybe
acpiphp.

The other drivers are annoying, too, but I'm not sure it's worth the
trouble since they're rarely used and updated.

> Can't git blame be given -M -C to deal with this? Or are those truly lines 
> that were introduced by the consolidation commit?

I'm so git-illiterate that I habitually just search "git log -p".  
"git blame -M -C ..." would probably be much more effective.

Bjorn

