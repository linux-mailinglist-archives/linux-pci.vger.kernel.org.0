Return-Path: <linux-pci+bounces-20536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D861A21DDD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3B01886BEC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA89481CD;
	Wed, 29 Jan 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqZWOMa6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73762F42;
	Wed, 29 Jan 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157325; cv=none; b=FHhGsbl9zipG7Ux0m7ftwvPRjTEUsuFC7amZ9NlJZ8hAK9tsJP92CrIl0pODRx3ubyxqLhxNjjIUJNexiQaBh77QiSnHtmvRHYTqYorXxDPj3MKMqxZRjAn5comfacwui46BQS0kOAl3DRb5N1jyKtRlXztAenYnMSBM75SWr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157325; c=relaxed/simple;
	bh=dE0lsgSjq4wk0o7MP8rz5Jo7m5fcmyVktKNkz3zHsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hxJRYOC2EfE1POEJp4yOBpV97JWgOxM+69Iy/AnavJBLAiRf857cI3AwfNSR3NuCEkojQtudY5IUnBI/LDz9uNJfSX9VXiEB0j6fK4viTLaAA6KxPyCcJS/Cbd3/DkFBXUaA06ls2xZUtbAcHXFqV5ovL5klAumZ+26SiVCQrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqZWOMa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE94C4CED3;
	Wed, 29 Jan 2025 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738157325;
	bh=dE0lsgSjq4wk0o7MP8rz5Jo7m5fcmyVktKNkz3zHsZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hqZWOMa6ZL1bscQx1L8m6C56jziOWBnJArDsY11+mhGnyX5uXmGC0E80eJst57Hbx
	 r4qSCNBkneQ4tYvtNB4Ewcw3TEjRMIV3amFJd7RiebPbTq+CNsC2xPa1M0JSexNDBN
	 YEYRKsY8OAWvjbYuXz7TxaMnpnrayTBjS01sw2J0BZUzW4q3z/KH6goEWuO+LV6XyS
	 VC/NPUQ+iTcQZSb52f8voS3dHNjq0KPFLNl+xU3/BofWCK9mAPUoBGHlGHbAzd6jq1
	 ipliraRXQHamGVvYpM6PQ1ozCRK+SoK3BMIguJymRwxoH70yHAHxw5WqJxg3sLJJPK
	 hJ4yVWsecHVlg==
Date: Wed, 29 Jan 2025 07:28:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <20250129132843.GA451331@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22ad7276-624d-49fb-a2bb-1b7908318a4e@suse.com>

On Wed, Jan 29, 2025 at 10:17:20AM +0100, Jan Beulich wrote:
> On 29.01.2025 04:22, Marek Marczykowski-Górecki wrote:
> > On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
> >> The report claims the problem only happens with Xen.  I'm not a Xen
> >> person, and I don't know how to find the relevant config accessors.
> >> The snippets of kernel messages I see at [1] all mention pciback, so
> >> that's my only clue of where to look.  Bottom line, I have no idea
> >> what the config accessor path is, and maybe we could learn something
> >> by looking at whatever it is.
> > 
> > AFAIK there are no separate config accessors under Xen dom0, the default
> > ones are used. xen-pcifront takes over PCI config space access (and few
> > more) only in a domU (and only for PV), when PCI passthrough is used.
> > Here, it didn't went that far...
> > 
> > But then, Xen may intercept such access [2]. If I read it right, it
> > should allow all access (is_hardware_domain(dom0)==true, and also the
> > device is not on ro_map - otherwise reset wouldn't work at all).
> 
> The other day you mentioned (on Matrix I think) that you observe mmcfg
> not being used on that system. Am I misremembering? (Since the capability
> where the control bit lives is an extended one, that capability would
> neither be read nor modified when mmcfg is unavailable.)

If you're referring to the Configuration RRS Software Visibility
Enable bit, that's in the PCIe Capability Root Control register, which
is in the PCI-compatible config space (the first 256 bytes), not the
extended config space.

