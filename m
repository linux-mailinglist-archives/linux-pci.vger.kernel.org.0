Return-Path: <linux-pci+bounces-31079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB804AEDF70
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034CE18915FE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748502749DF;
	Mon, 30 Jun 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giL3aaWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7B2BB04;
	Mon, 30 Jun 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291053; cv=none; b=GYAxq/s1x80meOa6WTcUQ0HiAIQmSOlTfmV0SyUFbY2mQijP5UoMIsyFvAjhiuA6LaD5wemS9F6C1zFXtlEW6mmOEybj8SHHVY29npLlr2PPQ18L8UBS/TK971qAM3+NdkWIKvafRrcQrsw4Rop2xAy+YvAq4F8pNPF0nemP4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291053; c=relaxed/simple;
	bh=Yg/KzCdtEpJxguCdji3ntihiUuCF+1elyJ/tBmEWpsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMgcKapIYPo76t059h+XbSQUFQMvRA6t+/OfRcv+QhcalUV5a56ldIDbK5myUCYZC2G2atEC4eMtiSu2qEoo9H8tPa5+tKUqoFCAiyq7daFY8hrPd50kqL/suFJ6Gkm2bLSiwg/I4ZRvmaY0rj3UAnogIgfriq2EZuv1BUTfq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giL3aaWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AEAC4CEEF;
	Mon, 30 Jun 2025 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751291053;
	bh=Yg/KzCdtEpJxguCdji3ntihiUuCF+1elyJ/tBmEWpsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giL3aaWbgZ9UXVdtQe1qiWlJZKz4q5AI/YQDq1MSSkyFRZk25JFcWsl8DAUdjvAKY
	 ma/qsIxsIOWoJfc1FXaYCZT6zrJe0YDwdOw8ajtBsKzrqi4kedmAmeZgSjmm4kodaN
	 eG3h+USe2KiWp0MpuV7P4ZV4HWXh8IsVCcQCZV4Jn14/E8W02vZdzOp8/7FI+T20QA
	 WKSZCXMMR9oT9Jmkxb9dTmacyD+DCV4f/UORqkBNChnYZmJkucPKZ/O2BTki7WcBLV
	 CQ4EFJREtiF1FEPmNrGZZ2RSp+8638ggGZuzZmJfFT+eflxXGlv+rkpy1O9jG09nTg
	 dFmoxb42felwg==
Date: Mon, 30 Jun 2025 07:44:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <aGKUqsudjfk8wCHI@kbusch-mbp>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Jun 30, 2025 at 04:07:55AM +0000, Parav Pandit wrote:
> 
> > From: Keith Busch <kbusch@kernel.org>
> > Sent: 30 June 2025 05:10 AM
> > 
> > On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> > > On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > > > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > > >
> > > > 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.
> > >
> > > I see. What other way is there to prevent dev->driver from going away,
> > > though? I guess I can add a new spinlock and take it both here and
> > > when
> > > dev->driver changes? Acceptable?
> > 
> > You're already holding the pci_bus_sem here, so the final device 'put'
> > can't have been called yet, so the device is valid and thread safe in this
> > context. I think maintaining the desired lifetime of the instantiated driver is
> > just a matter of reference counting within your driver.
> > 
> > Just a thought on your patch, instead of introducing a new callback, you could
> > call the existing '->error_detected()' callback with the previously set
> > 'pci_channel_io_perm_failure' status. That would totally work for nvme to
> > kick its cleanup much quicker than the blk_mq timeout handling we currently
> > rely on for this scenario.
> 
> error_detected() callback is also called while holding the device_lock() by report_error_detected().
> So when remove() callback is ongoing for graceful removal and driver is waiting for the request completions,
> 
> If the error_detected() will be stuck on device lock.

But I didn't suggest calling error_detected from report_error_detected.
Just call it directly without device_lock. It's not very feasible to
enforce a non-blocking callback, though, if speed is really a concern
here.

