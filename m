Return-Path: <linux-pci+bounces-1364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4DB81DD90
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 03:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DB11C21563
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 02:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FA7F6;
	Mon, 25 Dec 2023 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQzofmeQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1387F1;
	Mon, 25 Dec 2023 02:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BFFC433C8;
	Mon, 25 Dec 2023 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703470879;
	bh=uV/9bDfqdY3ZYOh2EW+ZpI9iEZqLw0XhMp6GAnVEYKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bQzofmeQbLAUODrezsFJGfCroUm2mDiRs5Fz0vSmNZUT0abw2+NP4UYLW8TzFfd6i
	 Uc1F04zgVw3zxYjeNFL2p12plv51f8dDlMzj/Pc9LbvDGORfXlB8/6nexJpR8b+uun
	 KJ7eiqprpJ6WmZ4rb8saxMlwgLK8VQRyii6NPaS3yJ3TIfReC38/Jiann2/CVDIAup
	 pLJ2xXRqGTt59H7jIKqI/0KpiCqxwKJ0ZeW8bKFs1tLKJpoRpyBmp3+4qGmZJPguyt
	 s7pmOu6dJYnxqcCQf1+F5UGMYCMtIkOcIhcjo2m5+3Wt1+rBTzh9v47eWXG5Zzb7s+
	 cFlU4LdyslXLQ==
Date: Sun, 24 Dec 2023 20:21:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, lukas@wunner.de,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 2/4] iommu/vt-d: don's issue devTLB flush request
 when device is disconnected
Message-ID: <20231225022117.GA1416989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6dedb35-4d2c-49a6-9d5a-e7f573ef3787@linux.intel.com>

On Mon, Dec 25, 2023 at 09:46:26AM +0800, Ethan Zhao wrote:
> On 12/25/2023 6:43 AM, Bjorn Helgaas wrote:
> > On Sun, Dec 24, 2023 at 12:06:55AM -0500, Ethan Zhao wrote:
> > > ...
> > > [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
> > > [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
> > > [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
> > > ...
> > > [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
> > > range: 0xffffffff80000000-0xffffffffbfffffff)
> >
> > The timestamps don't help understand the problem, so you could remove
> > them so they aren't a distraction.
> 
> Lukas said he see the qi_submit_sync takes up to 12 seconds to trigger the
> watchdog.

OK, so the timestamps told us how long the watchdog tolerates.  I
don't know how useful that is.  I suspect that's not a fixed interval
(probably differs by watchdog and possibly user preference).

> > > Fix it by checking the device's error_state in
> > > devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
> > > request to link down device that is set to pci_channel_io_perm_failure and
> > > then powered off in
> >
> > A pci_dev_is_disconnected() is racy in this context, so this by itself
> > doesn't look like a complete "fix".
>
> A quick workaround.

Call it a "quick workaround" then, not a "fix".  I'm personally not
usually interested in quick workarounds that are not actually fixes,
but the IOMMU folks would be the ones to decide.

Maybe this is more of an optimization?  If patch 4/4 is a real fix (in
the sense that if you disable the watchdog, you would get correct
results after a long timeout), maybe you could reorder the patches so
4/4 comes first, and this one becomes an optimization on top of it?  I
haven't worked though the whole path, so I don't know exactly how
these patches work.

> > > pciehp_ist()
> > >     pciehp_handle_presence_or_link_change()
> > >       pciehp_disable_slot()
> > >         remove_board()
> > >           pciehp_unconfigure_device()
> > There are some interesting steps missing here between
> > pciehp_unconfigure_device() and devtlb_invalidation_with_pasid().
> > 
> > devtlb_invalidation_with_pasid() is Intel-specific.  ATS Invalidate
> > Requests are not Intel-specific, so all IOMMU drivers must have to
> > deal with the case of an ATS Invalidate Request where we never receive
> > a corresponding ATS Invalidate Completion.  Do other IOMMUs like AMD
> > and ARM have a similar issue?
>
> So far fix it in Intel vt-d specific path.

If the other IOMMU drivers are vulnerable, I guess they would like to
fix this at the same time and in a similar way if possible.

> > > For SAVE_REMOVAL unplug, link is alive when iommu releases devcie and
> > > issues devTLB invalidate request, wouldn't trigger such issue.
> > > 
> > > This patch works for all links of SURPPRISE_REMOVAL unplug operations.

> > It's not completely obvious that a fix that works for the safe removal
> > case also works for the surprise removal case.  Can you briefly
> > explain why it does?
> 
> As I explained to baolu.
> 
> For safe_removal, device wouldn't  be removed till the whole software
> handling process done, so without this fix, it wouldn't trigger the lockup
> issue, and in safe_removal path, device state isn't set to
> pci_channel_io_perm_failure in pciehp_unconfigure_device() by checking
> 'presence',  patch calling this pci_dev_is_disconnected() will return false
> there, wouldn't break the function.  so it works.
> 
> For suprise_removal, device state is set to pci_channel_io_perm_failure in
> pciehp_unconfigure_device(), means device already be in power-off/link-down
> /removed state, callpci_dev_is_disconnected() hrere will return true to
> break
> 
> the function not to send ATS invalidation request anymore, thus avoid the
> further long time waiting trigger the hard lockup.

s/safe_removal/safe removal/ (they are not a single word)
s/suprise_removal/surprise removal/ (misspelled, also not a single word)

> Do I make it clear enough ?

Needs to be in the commit log, of course.

> > > Tested-by: Haorong Ye <yehaorong@bytedance.com>
> > > Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> > > ---
> > >   drivers/iommu/intel/pasid.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > > index 74e8e4c17e81..7dbee9931eb6 100644
> > > --- a/drivers/iommu/intel/pasid.c
> > > +++ b/drivers/iommu/intel/pasid.c
> > > @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
> > >   	if (!info || !info->ats_enabled)
> > >   		return;
> > > +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
> > > +		return;
> > > +
> > >   	sid = info->bus << 8 | info->devfn;
> > >   	qdep = info->ats_qdep;
> > >   	pfsid = info->pfsid;
> >
> > This goes on to call qi_submit_sync(), which contains a restart: loop.
> > I don't know the programming model there, but it looks possible that
> > qi_submit_sync() and qi_check_fault() might not handle the case of an
> > unreachable device correctly.  There should be a way to exit that
> > restart: loop in cases where the device doesn't respond at all.
> 
> Yes, fix it in patch[4/4] to break it out when device is gone.

