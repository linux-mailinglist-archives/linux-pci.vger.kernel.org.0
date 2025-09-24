Return-Path: <linux-pci+bounces-36839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D249DB98C94
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05CE19C72FA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95404275B01;
	Wed, 24 Sep 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdNDeoVE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFA2248A5;
	Wed, 24 Sep 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702093; cv=none; b=fpXZVagucqCeRyRPRbEVJLDxqCsO3GxMORTl13cSTXQOgLgxBSJ6wtW4h39Gm66zdbQDsKuo4hnF13B9lgVCTkQNBGSn/sx0TEOlWxEMK+T92/Pu8b9wRwk18qvYPBf6d2CmaluHylSDqddVsJLf7YUalRz38jrpbZYj6YvZMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702093; c=relaxed/simple;
	bh=UI+LGXvxoHRFGbjRfV+A4wqbLa/YUdmYzLCl0Mrv0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1h94fNjY6S1yVx8p/38lLIoszWq7yH1RKKPyggzZhuOLOAxPRuZnQLu1/qZDeW7qx0YCTU7Qj0G2qISanpgjCJJSRXNobo5KICKah97YUBIn3z1c+1J1kXnzoZlJP5gJXjkHDfvifzWuMCb99ITqq4MmWx98XSPt1lSvvVvMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdNDeoVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8002C4CEE7;
	Wed, 24 Sep 2025 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758702092;
	bh=UI+LGXvxoHRFGbjRfV+A4wqbLa/YUdmYzLCl0Mrv0Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdNDeoVE/eb0pX3zlIW+r0D/iJ1u1izTyWJVH1EXYvZPgiHzWc+6AZU8CEmm9zQzV
	 3l64jhAX6o1C99QhPNd7M8s0Uix4UOzlEjY5aduo7SeqpjrOYdv5M+6+cplfWCST+w
	 cqvaus5s6BYwL8QxymBDRpBCOtcPUw60MYQjhbT93BV5/bJA6HEBX8tCODGwkGb5ht
	 KTd9VpdvQY/4D840ogT/fvlgjOwDRg8aLdfiIVYcJ5HBbLrpyrIlQWvbjBnhcMpL0u
	 uAiyytgPNT3B3LlZ4A2J2HijqAFLR5/zPGFmbVjLxVhQvVNUufkkM5lLzBvWQ+R529
	 hEto4nJZYSqGg==
Date: Wed, 24 Sep 2025 13:51:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, 
	iommu@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
 <20250923162139.GC2547959@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923162139.GC2547959@ziepe.ca>

On Tue, Sep 23, 2025 at 01:21:39PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 09:07:49PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > This issue was already found and addressed with a quirk for a different device
> > > > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > > > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > > > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> > > 
> > > This is a pretty broken device! I'm not sure this fix is good enough
> > > though.
> > > 
> > > For instance if you reset a downstream device it should loose its RID
> > > and then the config cycles waiting for reset to complete will trigger SV
> > > and reset will fail?
> > > 
> > 
> > No. Resetting the Ethernet controller connected to the switch downstream port
> > doesn't fail and we could see that the reset succeeds.
> 
> Reset it by up/down the PCI link?
> 

We did both FLR (dev/reset) and SBR (bus/reset_subordinate), both succeeds.

> > Maybe the bus number was still captured by the device.
> 
> Maybe, but I don't think that is spec conformat behavior.
> 

This device is not spec conformant in many areas tbh. But my suggestion would be
to follow the vendor suggested erratum until any reported issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

