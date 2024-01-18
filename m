Return-Path: <linux-pci+bounces-2314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C48316B4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EF42826DF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD220B10;
	Thu, 18 Jan 2024 10:33:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7720B04;
	Thu, 18 Jan 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574027; cv=none; b=O6uP4jcAYT8WY/rnXCZH0aTjXTy6449m2gaE9gCpv1i4BLGLaBcSUXWxVgX6l6fe7aWBBPhsvKbzCxHOwD5EvCk0CRra9uCIPBTB2YZxH4vFANyDP65wvnLAMPItuVZ0IW6hXs021+64teB+MNhTBhe8pVbhn35fDq1eLn/aYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574027; c=relaxed/simple;
	bh=15DiUnnoqFmJQ1n4F5shd8NZfrPHdiR0aqhLgWlJuJs=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=eyQFJ88pLuZP5sl/dccs20JzopE7wrPn3QMqNjGSER0f/sM6kX/qPSrEe7qD7jp5zORf/rq3gnMRHGnV8tc9kaS+vhkHACdlca/jDyySIjeJobsS1J3Rnuf+fNYD0fnNxd6oQ12pl5aysN3R/NqEVHdns9zPHXll3x3nllRPmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9B90A28141EA3;
	Thu, 18 Jan 2024 11:33:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8FB0ECC6A0; Thu, 18 Jan 2024 11:33:35 +0100 (CET)
Date: Thu, 18 Jan 2024 11:33:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, treding@nvidia.com,
	jonathanh@nvidia.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <20240118103335.GA29974@wunner.de>
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
 <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
 <20240108141901.GA17779@wunner.de>
 <7345c2d2-5446-49a6-9ceb-0f1b9ee4ec18@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7345c2d2-5446-49a6-9ceb-0f1b9ee4ec18@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 11, 2024 at 07:14:54PM +0530, Vidya Sagar wrote:
> On 1/8/2024 7:49 PM, Lukas Wunner wrote:
> > On Thu, Jan 04, 2024 at 08:01:06PM +0530, Vidya Sagar wrote:
> > > On 8/1/2023 1:29 AM, Lukas Wunner wrote:
> > > > As an alternative to disabling ACS, have you explored masking ACS
> > > > Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
> > > > unmasking them after assignment of a bus number?
> > > 
> > > I explored this option and it seemed to work as expected. But, the issue
> > > is that this works only if the AER registers are owned by the OS. If the
> > > AER registers are owned by the firmware (i.e. Firmware-First approach of
> > > handling the errors), OS is not supposed to access the AER registers and
> > > there is no indication from the OS to the firmware as to when the
> > > enumeration is completed and time is apt to unmask the ACSViolation
> > > errors in the AER's Uncorrectable Error Mask register.
> > > Any thoughts on accommodating the Firmware-First approach also?

I'm sorry, I don't have any good ideas.

I just would like to avoid disabling ACS Source Validation because
it would diminish our security posture.

I guess setting the secondary bus number in the hotplug port to 0
isn't a good solution either because it would allow hotplugged devices
to temporarily spoof TLPs from devices on the root bus, right?

One option might be to have separate code paths:  If AER is owned by
the OS, mask PCI_ERR_UNC_ACSV on hot-removal, unmask on hot-add.
If AER is *not* owned by the OS, disable ACS Source Validation on
hot-removal, enable on hot-add, and warn loudly about the security
implications.

Another option might be to change error handling, i.e. ignore
ACS Source Validation errors if they occur before assignment of
a bus number.  And temporarily disable DPC.

None of these options look pretty.  I'm generally not a fan of
having the firmware own certain features.  The user experience
is better if everything is owned by the OS.  This is just one
more case in point. :(

Thanks,

Lukas

