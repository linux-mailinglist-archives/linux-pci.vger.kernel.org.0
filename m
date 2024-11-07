Return-Path: <linux-pci+bounces-16246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3F9C097B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B318B284E38
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379A212EE0;
	Thu,  7 Nov 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qND1QVkc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33DDDBE;
	Thu,  7 Nov 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991583; cv=none; b=nRHozvaFsS3incN1QHJkL0QDsw2MZ5BmDi4v3JUiJqRUC5Xi/77y0FjNDfgWnrl9S1BnjnHBWDNvFJEOjXsdKpq4xlAfzQiZB9bFIdHwhb3Li/R+k1HE6KnP9uhz2+R21SJb03I0+kVISL119yt4NPntGwv1SlFRHes+eGw01OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991583; c=relaxed/simple;
	bh=0uZRH9no1sDMwn1zq/WxGdvCuQAjLUJEK0XIIj3xt+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AAM7y7rRFRdfnZenh9VJIIqAkK18ceHScFJUyExa11o+FhxlG87UV+koLQurFh50m+ThVvZ1uzNrlFYFKuSl4Z4KbZachkoVM1R88TtOJanJCtW7W5e7rxdTVJC7ph64Ndx037uGzLPUxlLA3vwxjbG9fCRz+2AcHsmL4S674rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qND1QVkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89A7C4CECD;
	Thu,  7 Nov 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991582;
	bh=0uZRH9no1sDMwn1zq/WxGdvCuQAjLUJEK0XIIj3xt+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qND1QVkch2tu6qrqQ6YNdRUw2hf8r9HSt65E0Z2xbzy8I8LgG9uwNTJm8Gs6rHvFW
	 Wr8YymkshkkrnML224h6HWmS/k1poxNnvH/XY+clYrcIxly8m2pe2aCiJMcxVyHuCn
	 j/Vh848GmF2i50XEtR5VWS+dxT2zjhKr43gaQKHrEhN7QjXqfe4il6Wp4sPwEErTW/
	 UbyxHx48SJtdKUWloF8LG1KmIG7pfdWDeBjGsfXAVx63iNEIHgtYfmtNnpRUT9/cmh
	 wgiycfUzDtzwWC3tAoVy/Dk8C0u7rZP9O1N9Pcd3VY/vVAb6pSyvOvS5DbqLg/AkVZ
	 2OmqvqLiw/hJw==
Date: Thu, 7 Nov 2024 08:59:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Message-ID: <20241107145941.GA1613712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4df22e-3783-4081-b57b-ac03cd894cb5@app.fastmail.com>

On Thu, Nov 07, 2024 at 01:31:44PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 5, 2024, at 18:26, Leon Romanovsky wrote:
> > On Tue, Nov 05, 2024 at 09:24:55AM -0600, Bjorn Helgaas wrote:
> >> On Tue, Nov 05, 2024 at 09:51:30AM +0200, Leon Romanovsky wrote:
> >> > On Mon, Nov 04, 2024 at 06:10:27PM -0600, Bjorn Helgaas wrote:
> >> > > On Sun, Nov 03, 2024 at 02:33:44PM +0200, Leon Romanovsky wrote:
> >> > > > On Fri, Nov 01, 2024 at 11:47:37AM -0500, Bjorn Helgaas wrote:
> >> > > > > On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
> >> > > > > > On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
> >> > > > > > > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> >> > > > > > > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> >> > > > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> >> > > > > > > > > 
> >> > > > > > > > > The Virtual Product Data (VPD) attribute is not
> >> > > > > > > > > readable by regular user without root permissions.
> >> > > > > > > > > Such restriction is not really needed, as data
> >> > > > > > > > > presented in that VPD is not sensitive at all.
> >> > > > > > > > > 
> >> > > > > > > > > This change aligns the permissions of the VPD
> >> > > > > > > > > attribute to be accessible for read by all users,
> >> > > > > > > > > while write being restricted to root only.
> >> > ...
> >> 
> >> > > What's the use case?  How does an unprivileged user use the VPD
> >> > > information?
> >> > 
> >> > We have to add new field keyword=value in VA section of VPD, which
> >> > will indicate very specific sub-model for devices used as a bridge.
> >> > 
> >> > > I can certainly imagine using VPD for bug reporting, but that
> >> > > would typically involve dmesg, dmidecode, lspci -vv, etc, all of
> >> > > which already require privilege, so it's not clear to me how
> >> > > public VPD info would help in that scenario.
> >> > 
> >> > I'm targeting other scenario - monitoring tool, which doesn't need
> >> > root permissions for reading data. It needs to distinguish between
> >> > NIC sub-models.
> >> 
> >> Maybe the driver could expose something in sysfs?  Maybe the driver
> >> needs to know the sub-model as well, and reading VPD once in the
> >> driver would make subsequent userspace sysfs reads trivial and fast.
> >
> > Our PCI driver lays in netdev subsystem and they have long-standing
> > position do not allow any custom sysfs files. To be fair, we (RDMA)
> > don't allow custom sysfs files too.
> >
> > Driver doesn't need to know this information as it is extra key=value in
> > existing [VA] field, while driver relies on multiple FW capabilities
> > to enable/disable functionality.
> >
> > Current [VA] line:
> > "[VA] Vendor specific: 
> > MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A"
> > Future [VA] line:
> > "[VA] Vendor specific: 
> > MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A,SMDL=SOMETHING"
> >
> > Also the idea that we will duplicate existing functionality doesn't
> > sound like a good approach to me, and there is no way that it is
> > possible to expose as subsystem specific file.
> >
> > What about to allow existing VPD sysfs file to be readable for everyone 
> > for our devices?
> > And if this allow list grows to much, we will open it for all devices 
> > in the world?
> 
> Bjorn,
> 
> I don't see this patch in
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next
> So what did you decide? How can we enable existing VPD access to
> regular users?

I think it's too risky to enable VPD to be readable by all users.

Bjorn

