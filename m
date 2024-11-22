Return-Path: <linux-pci+bounces-17228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A849D64A7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 20:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5383B283267
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A01D7E28;
	Fri, 22 Nov 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZDZT8a4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5F158DA3;
	Fri, 22 Nov 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304591; cv=none; b=UB2wdVNOAkqv/DCiTNvJ9rHFvvasJiaiFDnw/FElGcOO+uvRC0Xbb1fXftneq4qRFxmOFHOCbJ7s2MFHAizLnwb5R1Nl/2QbjUH0huaGRSqOC7P1VWnc3vR0jst0F+gHK0aqHDZdcxHDOAx14w/Na9JiTswzjFJCmr5nItNc5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304591; c=relaxed/simple;
	bh=/TIiTo6aiG1HaE3NLyCTytKHWSq3kTXteNNE8a+vUqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWozaBL3/RKBpdzKUv99CTqEV+EtkqfmeLWZUR/Hs1c5cTZHFua3C1xPZwb4JxtWEulkz7KSZGmQXgvELDkG1mu2I63Ma1S5+9VJczdiUX3ayhavCDFaqAoPVoiCRn3SappiMKQaMK8a2QBp1Z+hdqQEbF0zZFYVI1Dr8pqXDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZDZT8a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DEEC4CECE;
	Fri, 22 Nov 2024 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732304590;
	bh=/TIiTo6aiG1HaE3NLyCTytKHWSq3kTXteNNE8a+vUqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZDZT8a4bQJbljENBmawqwStZT6k2l2i1qgcJe2U5Q9KECabOmXUbEOts4zRte5AI
	 +iHbhsH7CusmDEFsWSL4qZD7ZdT34omju98KTvotqtJv9gFe92YQy/aK+Nl4Sulrk3
	 UTpqc15JnnERWgb9e2yEOVWAJnKAt2rFef4v3fdv+12YtaSVw3RJaX99M17z3M0LuF
	 E8DmoQyIz+B02mF16CKSnOnmlp2GRyEldpWG2xD4Q1hQsd4jYbVFi85b+yhWSthMeX
	 wNOJT2zc9B+VxzUWxUUN9osLlZdDTP/e/PTmtYs20sk7vG6hbL0nTsAph5rJVDwDoI
	 0P8CSv5UAN43Q==
Date: Fri, 22 Nov 2024 21:43:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jean Delvare <jdelvare@suse.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241122194306.GC160612@unreal>
References: <20241121121301.GA160612@unreal>
 <20241121224142.GA2401143@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121224142.GA2401143@bhelgaas>

On Thu, Nov 21, 2024 at 04:41:42PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 21, 2024 at 02:13:01PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 21, 2024 at 01:01:27PM +0100, Jean Delvare wrote:
> > > On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:
> > > > --- a/drivers/pci/vpd.c
> > > > +++ b/drivers/pci/vpd.c
> > > > @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> > > >  	if (!pdev->vpd.cap)
> > > >  		return 0;
> > > >  
> > > > +	/*
> > > > +	 * Mellanox devices have implementation that allows VPD read by
> > > > +	 * unprivileged users, so just add needed bits to allow read.
> > > > +	 */
> > > > +	WARN_ON_ONCE(a->attr.mode != 0600);
> > > > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > > > +		return a->attr.mode + 0044;
> > ...
> 
> > I still didn't lost hope that at some point VPD will be open for read to
> > all kernel devices.
> > 
> > Bjorn, are you ok with this patch? If yes, I'll resend the patch with
> > the suggested change after the merge window.
> 
> Reading VPD is a fairly complicated dance that only works if the VPD
> data is well-formatted, and the benefit of unprivileged access seems
> pretty small, so the risk/reward tradeoff for making it unprivileged
> for all devices doesn't seem favorable in my mind.
> 
> This quirk seems like the least bad option, so I guess I'm ok with it.

Thanks a lot.

> 
> Bjorn

