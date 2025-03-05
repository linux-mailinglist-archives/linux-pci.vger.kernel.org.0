Return-Path: <linux-pci+bounces-23020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65289A50EA9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B02716C28F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 22:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D81FECCC;
	Wed,  5 Mar 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/o9Gry4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DF4A33
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214143; cv=none; b=K2cvGjVEHQ2HqKLIt/N66bVLcbSKCrldke0fZvfO1/LbOm95Jh0YUs3DbaET8OptsSz0iRx7r5b6w+l1OxdSrYIDIsRRHYCjF6TWZRwj0/5o/k0tuOH3aVLEnULemG6fJOPOYdYvUxe2X97nP78W2ByfXeBw8aI1XFW1cQUF8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214143; c=relaxed/simple;
	bh=olp3rPzdQugR0usIXpFTnlFahIvtv0OfeJQdt/qpw0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pL/os/7Y2sxK4rGL5NNddhB/IU/KcgZxKW4RnoSesbU2DwaQrv+oHvAxT7ZNHrLV+ZTDUG9RS3ETXF8ziUucfDekekjw64WSVo8UEqREDiWXgUBMCXq5GX7OF/gAgdmtEkHIcAqdcRu+3QEXmD1X2vGAIQvdzbKiMR4F0DYVinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/o9Gry4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7B7C4CED1;
	Wed,  5 Mar 2025 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741214141;
	bh=olp3rPzdQugR0usIXpFTnlFahIvtv0OfeJQdt/qpw0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s/o9Gry4p/QoaPd8yF7EFT8ek+wCFWcwXJ2WvnBnSx3bCJMSF3usTEEdCFp8/Xpc3
	 g2s4UBVsV1b1rhUkkw5kG1mVED8VC5Dh2g3dicsvnSR7x6jpiLyV32Z36THWonywD4
	 hp13dzmpw2Bh0ueC17RFOSjXeAEFR0Gi5m9kWEySqDNQpDeKlkDiyY/msnCHQzzIpV
	 2YJppdbVFc8DmqfVxKPFYHBbHrK5OwXqvQ4w1QmtGbSmBCF5qfQPZfO3B9bu1JLL7O
	 NgAO75PpZ4yFpsEX92xTg5zPFofkEicBWeIcNlxu4xKi4QkQUNZuD7HcxtueNkPDUm
	 9NBi35gxPaBRw==
Date: Wed, 5 Mar 2025 16:35:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
Message-ID: <20250305223540.GA312467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXUqLYb=qr+EW0WeKq-NW7wQwNNi14Kc5k-6XmtXNiC18w@mail.gmail.com>

On Tue, Mar 04, 2025 at 05:04:21PM -0800, Jon Pan-Doh wrote:
> On Tue, Mar 4, 2025 at 10:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > It's true this is redundant information, but that e1000e device may
> > no longer be accessible.
> >
> > In that case, I think aer_get_device_error_info() would probably
> > return 0 because config reads would all return ~0, and
> > PCI_ERR_COR_STATUS & ~PCI_ERR_COR_MASK would be 0, so
> > we probably wouldn't see the e1000e messages at all.
> 
> Wouldn't we have larger issues if the device is no longer accessible?
> Would a log suffice in that case (i.e. when aer_get_device_error()
> returns 0)? Something along the lines of "{device} is not accessible
> while processing (un)correctable error"

It's quite likely that a device is inaccessible after an uncorrectable
error.

DPC takes the link down automatically for uncorrectable errors, but I
don't think aer_print_port_info() is used in that case anyway.

Documentation/PCI/pci-error-recovery.rst mentions other cases where
the affected device is disconnected.

If the purpose of this patch is only to turn this:

  pcieport 0000:00:04.0: Correctable error message received from 0000:01:00.0
  e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link
Layer, (Receiver ID)
  e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
  e1000e 0000:01:00.0:    [ 6] BadTLP

into this:

  e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link
Layer, (Receiver ID)
  e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
  e1000e 0000:01:00.0:    [ 6] BadTLP

I don't think it's worth it.

I guess the problem is that future patches rate limit the e1000e
messages, and we really need to rate limit the pcieport message using
the same e1000e ratelimit_state.  We do know the Requester ID of the
device, so maybe we could look up that ratelimit_state?

