Return-Path: <linux-pci+bounces-40882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B469C4DA82
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BBD4EF289
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF83054C3;
	Tue, 11 Nov 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOUxslbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72B239E70;
	Tue, 11 Nov 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863603; cv=none; b=Bq+sd1in+i7lmvPMw1913qjoBFuGpQG3kcCX8IRenjOikcGZBURm36s8Fcplj4ADMbEZnwEhm0D16DBQzAw1Zs/YORQmVAbHud9Xk2BURV1clGMZ8i5zE1XbckV7kdVX2ga5z26VRQbrHP02ejVeszzkR749nDMZbCsd72IUOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863603; c=relaxed/simple;
	bh=fw4bBM14g4kHXLxHnq+oCuA8+A4FD4yo4UWJLbL05fE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JNIsvcXtp8f7wK7w6IYKshd6YR+S7+GUHCcsdSpYujIPkPAMpEBw10FELbN+PbwuOFRbQ5S7DoXDSRbHYv6GPjFHUZo1KvP0GF3+V+HWY4ziSvwUOLltotjuB2bcDBIC5XWwYDun8KFTcSJp4TyykRTWR7hUh5+iGZ6O/va4Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOUxslbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31C4C2BCB1;
	Tue, 11 Nov 2025 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762863603;
	bh=fw4bBM14g4kHXLxHnq+oCuA8+A4FD4yo4UWJLbL05fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DOUxslbsCSH498vEuLR+iHlaDZ8WU5xeGprTHuH6M0tZYMLRUKY2wmjvziY09guPY
	 h/PIEjXW6VAKPzJ88uiyJvC1/3jeefbQcFw6HAtPMyXuCvh8b2onP7SyMa64PRjmyP
	 L6SbFpbmYsZpavVGEllVQLB8+vwxUNLmp/6bt2O7is7Iqw4GqwfMelA9NsWehCgA/H
	 kyLHceRkVzEBRJGMHBZoM9ntLviKIgTiRmHNTVJ4L266pP3kxMp4meUZ2crhGBgPwp
	 TJ+5B77w8hRofDlgzjbqSA6QKSmHVmxPdxEgjSf9BXH74HbcgExTqLGjQcDLIrzGUw
	 k0QHh/PwrZkag==
Date: Tue, 11 Nov 2025 06:20:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	debian-powerpc@lists.debian.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251111122001.GA2168158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41d2ca1-fcd9-c416-b111-a958e92e94bf@xenosoft.de>

On Tue, Nov 11, 2025 at 06:15:20AM +0100, Christian Zigotzky wrote:
> On 11/07/2025 06:06 AM, Christian Zigotzky wrote:
> > On 11/05/2025 11:09 PM, Bjorn Helgaas wrote:
> > >> I tested your patch with the RC4 of kernel 6.18 today. Unfortunately
> > it
> > >> doesn't solve the boot issue.
> > >
> > > Thanks for testing that.  I see now why that approach doesn't work:
> > > quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
> > > updates the permissible ASPM link states, but pci_disable_link_state()
> > > only works for devices at the downstream end of a link.  It doesn't
> > > work at all for Root Ports, which are at the upstream end of a link.
> > >
> > > Christian, you originally reported that both X5000 and X1000 were
> > > broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
> > > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
> > > platforms"), but I would love to have confirmation of that.
> > 
> > Hello Bjorn,
> > 
> > I will enable CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT for the RC5 of
> > kernel 6.18 and test it with the X1000.
> 
> I tested the RC5 of kernel 6.18 with CONFIG_PCIEASPM and
> CONFIG_PCIEASPM_DEFAULT enabled on my X1000 today. Unfortunately the boot
> problems are still present.

Thanks.  Can you post a dmesg somewhere so I can see what the relevant
device IDs are?  Can be with any kernel, doesn't have to be v6.18.  We
need the Vendor and Device IDs to add a quirk.

