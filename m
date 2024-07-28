Return-Path: <linux-pci+bounces-10882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BBE93E5F4
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA88B1C20B25
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E95028C;
	Sun, 28 Jul 2024 15:41:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12554F215;
	Sun, 28 Jul 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181281; cv=none; b=DhWsXTUAg4XumKQZC9HSGKl0ruXhL+HE3lsH0btpmMCIxuudSyI00nWM/jTQ4veVo7/3Gt4AwaYEUEHThG13Jr3PEomp2E5XT31Qf5GY56nwjRsvqIZtGVQaZ6je9oUssvVFCdUPeuI+Rz10+Xq7d+e1zplCKl4gpoMhhNgknfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181281; c=relaxed/simple;
	bh=ksdJ4pIbuBBrLnAd1xHGxqIcxA26yp0jMfuzneHZk5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ5NysgqK8JN739ab/IsId1KaNOAHd1ffMwK9Im87BPiwLuJAw1WYxACEbhYeXuVSjYCaWJSOwQ3XWSSTyLd5RLsKatfvS3fLRkyYxBLVVQfCyAqHlTWl0cZzowKMTReFJeSBb7n4tYQLWQ9ebheqBZzthsfBgRAe4R9BoIkwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4A5B8100DA1A1;
	Sun, 28 Jul 2024 17:41:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 15E73357A53; Sun, 28 Jul 2024 17:41:09 +0200 (CEST)
Date: Sun, 28 Jul 2024 17:41:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZqZmleIHv1q3WvsO@wunner.de>
References: <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de>
 <20240626085945.GA1532424@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626085945.GA1532424@black.fi.intel.com>

On Wed, Jun 26, 2024 at 11:59:45AM +0300, Mika Westerberg wrote:
> On Wed, Jun 26, 2024 at 10:50:22AM +0200, Lukas Wunner wrote:
> > On Mon, Jun 24, 2024 at 11:58:46AM -0400, Esther Shimanovich wrote:
> > > On Wed, May 15, 2024 at 4:45???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > Could you add this to the command line:
> > > >   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> > > >
> > > > and this to your kernel config:
> > > >   CONFIG_DYNAMIC_DEBUG=y
> > > >
> > > > You should see "... is associated with ..." messages in dmesg.
> > > 
> > > I tried Lukas's patches again, after enabling the Thunderbolt driver
> > > in the config and also verbose messages, so that I can see
> > > "thunderbolt:" messages, but it still never reaches the
> > > tb_pci_notifier_call function. I don't see "associated with" in any of
> > > the logs. The config on the image I am testing does not have the
> > > thunderbolt driver enabled by default, so this patch wouldn't help my
> > > use case even if I did manage to get it to work.
> > 
> > Mika, what do you make of this?  Are the ChromeBooks in question
> > using ICM-based tunneling instead of native tunneling?  I thought
> > this is all native nowadays and ICM is only used on older (pre-USB4)
> > products.
> 
> I think these are not Chromebooks. They are "regular" PCs with
> Thunderbolt 3 host controller which is ICM as you suggest.
> 
> There is still Maple Ridge and Tiger Lake (non-Chrome) that are ICM
> (firmware based connection manager) that are USB4 but everything after
> that is software based connection manager.

Even with ICM, the DROM of the root switch seems to be retrieved:

  icm_start()
    tb_switch_add()
      tb_drom_read()

Assuming the DROM contains proper PCIe Upstream and Downstream Adapter
Entries, all the data needed to at least associate the PCIe Adapters
on the root switch should be there.  So I'm surprised Esther is not
seeing *any* messages.

Do the DROMs on ICM root switches generally lack PCIe Upstream and
Downstream Adapter Entries?
What am I missing?

Thanks,

Lukas

