Return-Path: <linux-pci+bounces-14655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C309A0B64
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8697F28434D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2F2076C7;
	Wed, 16 Oct 2024 13:25:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA51C2325;
	Wed, 16 Oct 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085133; cv=none; b=aet9tcq/yfNTFDtYh2rPIvwF3F9kTulIF+xQBYw8tBJGMf2wiYcQ4y6lB481X6Cd1McgqluW2awLb+oWFBQvnW7XXXqZ2cb4fudoZAN2Pd2NiruZrR58Z9ffAdZWjxfrYqvFrm6Pf1rbXfWnZN5GvO4xZyWJ/JY1lm/pSAWMG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085133; c=relaxed/simple;
	bh=PTfg91UCXRQuEFbsQVtKFhSJ7Kvxu/UJrJD3aHiViZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTDEQWScFFrVMAZXty+rbcKLqczLj/xB5kuZKtOEjZJWIen2pVK0LIUmtc5dk9MDvKnG46QrTt3Ou81Mn+/PDX60IO4EoSK6ZToj8eINVw+MxAxIkDcNA5w5ybiOvG8ZyUu2kbM7ztk9PB4Xvnq6OTUpzGRctBIYXnhF4oQGtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTBW64fm2z6FGQN;
	Wed, 16 Oct 2024 21:23:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7230D140A77;
	Wed, 16 Oct 2024 21:25:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 15:25:26 +0200
Date: Wed, 16 Oct 2024 14:25:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
CC: Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<manivannan.sadhasivam@linaro.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <sathya.prakash@broadcom.com>,
	<sjeaugey@nvidia.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P
 links
Message-ID: <20241016142525.000013ca@Huawei.com>
In-Reply-To: <CAOHJnDv9XK3Pno4pk9bDA1SApnJ-oYmA83EndttpiFh4=i2mMw@mail.gmail.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<20240924155755.000069cd@Huawei.com>
	<CADbZ7FqUxAQFT0u7QQMuSKePRCEG2nWBzv=ECbSDGu+8WX8iAQ@mail.gmail.com>
	<20241004113933.00007ec4@Huawei.com>
	<CAOHJnDv9XK3Pno4pk9bDA1SApnJ-oYmA83EndttpiFh4=i2mMw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 15:10:57 +0530
Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com> wrote:

> On Fri, Oct 4, 2024 at 4:09=E2=80=AFPM Jonathan Cameron <Jonathan.Cameron=
@huawei.com>
> wrote:
> >
> > On Thu, 3 Oct 2024 14:41:07 -0600
> > Sumanesh Samanta <sumanesh.samanta@broadcom.com> wrote:
> > =20
> > > Hi Jonathan,
> > > =20
> > > >> Need more data that 'there is a link' for this.
> > > >>I'd like to see some info on bandwidth and latency. =20
> > >
> > > As you too noted in your comments, for now, we are only addressing p2p
> > > connection between "virtual switches", i.e. switches that look
> > > different to the host, but are actually part of the same physical
> > > hardware.
> > > Given that, I am not sure what we should display for bandwidth and
> > > latency. There is no physical link to traverse between the virtual
> > > switches, and usually we take that as "infinite" bandwidth and "zero"
> > > latency. =20
> >
> > For a case where you have no information, not having attributes is
> > sensible. If there is information (CXL CDAT provides this for switches
> > for instance) then we should have an interface that provides space for
> > that information.
> > =20
> > > As such, any number here will make little sense until we
> > > start supporting p2p connection between physical switches. =20
> >
> > As above, it makes sense in a switch as well - if the information
> > is available.
> > =20
> > > We could,
> > > of course, have some encoding for the time being, like have "INF" for
> > > bandwidth and 0 for latency, but again, those will not be very useful
> > > till the day this scheme is extended to physical switch and we display
> > > real values, like bandwidth and latency for a x16 PCIe link. Thoughts=
? =20
> >
> > Hide the sysfs attributes for latency and bandwidth if we simply don't
> > know.  Software built on top of this can then assume full bandwidth
> > is available or better still run some measurements to establish the
> > missing data.
> >
> > All I really meant by this suggestion is a directory with space for
> > other info is probably more extensible than a single file. =20
>=20
> Hi Jonathan,
> We will make the changes to add a directory for p2p_link related informat=
ion
> to be exposed to user. We will only populate the information related to t=
he
> inter-switch P2P links. Rest of the attributes can be added for devices t=
hat
> report them at a later stage.
> Please check if the directory structure makes sense to you:
> /sys/devices/.../B:D:F/p2p_link/links -> Reading this file will return the
> same
> information that is returned currently by the p2p_link file.
Sounds good to me.

Jonathan

