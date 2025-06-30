Return-Path: <linux-pci+bounces-31090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF769AEE514
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9AB3B0322
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AD28DEEE;
	Mon, 30 Jun 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/nwG1sS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8F19C553;
	Mon, 30 Jun 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302659; cv=none; b=mUsB37WKGIvP+WAaS8R5MB2Mr8TpZhsWNXTiqfikiucXLdQ7GIGcTjOep6ZM7kAEezNfrGEDzn/+8epgtJrOAXMEhn68jjk8MFWrKC16MQVpaL+GYodED2i5NB/JyL1GpKi7ERKobAsoPbfDBOdZZYfY9B7dzeckPjg4oOZdV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302659; c=relaxed/simple;
	bh=BYzwfNeMyLadDmlkGi40pAN2Kw8jUSgmaBSLc8Pmba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta8c6U8h2oP39Uz7iaC5W8Q9SJKUqsFqUAg51PucTtS9SHEa0PxLxjC4eoWadL4IjCg5iDsA1XyUqaWt/Xz5Y4iQ+ohGay35q6A8cZNsCGtqsBJAeFeWA2zHdRC3RC3qDrAlEpDUbqjbXOR7wXmxIEwQWfbnx8tZHFl/eO7aEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/nwG1sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DEFC4CEE3;
	Mon, 30 Jun 2025 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751302657;
	bh=BYzwfNeMyLadDmlkGi40pAN2Kw8jUSgmaBSLc8Pmba0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/nwG1sSq5cwFP2aQ8tj8/fjmiyaJ815gZAtX3QhrLL/vQ4zRHDBv1JIjDGw0JO1v
	 dc5A+/QkHIHbOQlQXvSrGuuWb535D7HTMg2TAUASr/X72KOK/jkLCNh/EGT0Hr+x7Q
	 JKLHyP41eWrAAXp+OzIKs2ngnseETZAYw8DzftTBUsN5fI4MELpz+xDRTrQfngQZRu
	 +0UzLEaW8nbIMpXFNC++A2u3LnCE9uEP4kNt2PoRYifU7o9PAJweqIXd3g+uDLaB19
	 X+0GzakVLcf8jCY/xAZ3UdYOIrG4QBgbE6K4+P4VneMtalak03pSOnMwzNPHbxbg35
	 G8ZrPK5r4v0Ag==
Date: Mon, 30 Jun 2025 10:57:35 -0600
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
Message-ID: <aGLB_8SFF1Cw95MZ@kbusch-mbp>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGKUqsudjfk8wCHI@kbusch-mbp>
 <CY8PR12MB7195583E429203129577B51ADC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195583E429203129577B51ADC46A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Jun 30, 2025 at 01:52:26PM +0000, Parav Pandit wrote:
> > 
> > But I didn't suggest calling error_detected from report_error_detected.
> > Just call it directly without device_lock. It's not very feasible to enforce a non-
> > blocking callback, though, if speed is really a concern here.
> Yeah, it would better to either always call a callback with or without the lock.
> In some flows with lock and in some flows without lock would likely be
> very bad as one cannot establish a sane locking order.

On closer look, my suggestion without the device_lock may be racy, but
using the device_lock prevents the notification that needs to happen.
Hm, not as easy as I thought. :(

