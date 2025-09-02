Return-Path: <linux-pci+bounces-35336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADFB40CA3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCEA483611
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351692C11C9;
	Tue,  2 Sep 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrC8IFSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114393594B
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835953; cv=none; b=DoxAedDT1e/6v0MkHdsTk8LEGUh/zYuRdiqk3I0SnL5OIeaK63nYJBBThuzVSTGxRV4yterToZp4Ap/Q6lFO1L7HV/0vd3xtN8hHT7G7qs3Tzmlopnsld/YEYmEjc+n3vHrpFHopU4l1PuUkvX+zPNcS3eEiPfDFf5mw1SdUht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835953; c=relaxed/simple;
	bh=1cDDLYwNMNRUHQHN5kr48FfOWVX7l2DH/qKDgh5ojfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bih8dHuX2DPpru6pOSDRoRggJfyvXg8jNRhjlnzagp/XNo5naAerdG2Lt+8Ri/pELGrSPrdw2KsjjB273vvB+BkaBUcddFhiqc90n8lJrOeQdy20F1vnyA2qNEK1OAhUyKfwEAER2BvVGalYTQgKA3xN7w9aWV8+mH+j8P5apM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrC8IFSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B896CC4CEED;
	Tue,  2 Sep 2025 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835952;
	bh=1cDDLYwNMNRUHQHN5kr48FfOWVX7l2DH/qKDgh5ojfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrC8IFSK7sb6AZMYuu7G+KtADyx2e6Dg49v5c91tfZPEq6lb2bWElEg0dtROPxqYY
	 ErvJd+jgzMNZoUIALfsA/+KkmGjFP9n3EwbQCEbbOlSDR4BXEOMg1ru1/nGyCPvtwo
	 tXgd3I9mwhirXw3sBgOjupl+F+nh6ysWP6V1ex/ADCvSV53Oqw0avV1xaJ5ackG81K
	 Hrj+t0LQSCKiNcooT/Mlx2uI0HbyCFtjFMBjSm5F9QwUFDRuuxIE1eYAJ5UM3psV9B
	 LkUR6QxvVeFRCFLgHkniiiFL5cFy/oIwXSjIW5sMxblLJLYAPtBaqw4W7qGcjggXO5
	 w2P5l+Q4NrkQA==
Date: Tue, 2 Sep 2025 11:59:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciehp: sync interrupts for bus resets
Message-ID: <aLcwb0TA0rMtu2kI@kbusch-mbp>
References: <20250827224514.3162098-1-kbusch@meta.com>
 <aLRRh_4YhAZjWeEW@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLRRh_4YhAZjWeEW@wunner.de>

On Sun, Aug 31, 2025 at 03:43:35PM +0200, Lukas Wunner wrote:
> On Wed, Aug 27, 2025 at 03:45:14PM -0700, Keith Busch wrote:
> > Synchronize the interrupt to ensure the reset isn't going to disrupt a
> > previously pending handler from igoring the reset's link flap. Back to
> > back secondary bus resets create a window when the previous reset
> > proceeds with DLLLA, waking the pending pciehp interrupt thread, but the
> > subsequent reset tears it down while the irq thread tries to confirm the
> > link is active, triggering unexpected re-enumeration.
> 
> Help me understand this:
> 
> I think what you mean is that pciehp_reset_slot() runs and the
> Secondary Bus Reset causes a spurious link change. So pciehp_ist() runs,
> waits for the reset to finish with pci_hp_spurious_link_change(),
> then calls pciehp_ignore_link_change(), which tests whether the link
> is active again by calling pciehp_check_link_active().
> 
> And you're saying that at the same time, pciehp_reset_slot() runs,
> performs a Secondary Bus Reset, thus brings down the link,
> confusing the concurrent pciehp_check_link_active().
> Did I understand that correctly?
> 
> I don't quite see how this can happen, given pciehp_reset_slot()
> acquires ctrl->reset_lock for writing and the same lock is held
> for reading for the call to pciehp_check_link_active().
> 
> Moreover pciehp_ist() ignores the link flap in the first iteration
> (it clears the flags in the local variable "events") and if
> pciehp_check_link_active() would indeed fail, then the bits would
> only be set in ctrl->pending_events and a rerun of pciehp_ist()
> would be triggered.  That second iteration of pciehp_ist() would
> then find the PCI_LINK_CHANGED flag set and ignore the link change
> (again).
> 
> So this should all work fine.

Hm, I think you're right. We are definitely seeing pciehp requeue itself
with the link/presence events that we want to be ignored, so we're
getting re-enumeration when we didn't expect it. I thought the
back-to-back resets that we're causing vfio to initiate was the problem,
but maybe not. I think the switch and/or end device we're using have
some unusual link timings that defeats the pciehp ignore logic.

