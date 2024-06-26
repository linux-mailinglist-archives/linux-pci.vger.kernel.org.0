Return-Path: <linux-pci+bounces-9275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40218917B5E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98222B24207
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE481534F8;
	Wed, 26 Jun 2024 08:50:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B8168493;
	Wed, 26 Jun 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391834; cv=none; b=giUbIg98b3hURn5KxdwbsbSQfUtu4Uho8fD4u7bnx7qNRHyxYQ22iXXD7JHTtCQIgN7AKwq/IeqPJcHspQ3W+bP7N5SG9POoniARwhO4sLOdzAn7C6itQDoRqbdTWQ4j9YZtdlCwnjz+2MIcrnxYbdBCJ0j28JVaQEvHcRxGTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391834; c=relaxed/simple;
	bh=MZFfzfAFfUgpvR7oa4k1bw16AjKnS6MP4CeDyZ0bsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHek/t7jjDCFcCuTrmr11X5p5a596VNTiKat6KH75fqJf0y3/Ai6GKzJqeAiy9NQxALeN22VfDXCZIKsux4w8XwOcsHmDyjfYCBApT/iaplLAP7K6f/4PDM0QPovUG4zWtgViluXjfrTKupgZKwjLQ4kEoGmSq1obuRGv9bMB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7B55C2800BB5F;
	Wed, 26 Jun 2024 10:50:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6971D208267; Wed, 26 Jun 2024 10:50:22 +0200 (CEST)
Date: Wed, 26 Jun 2024 10:50:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZnvWTo1M_z0Am1QC@wunner.de>
References: <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:58:46AM -0400, Esther Shimanovich wrote:
> On Wed, May 15, 2024 at 4:45???PM Lukas Wunner <lukas@wunner.de> wrote:
> > Could you add this to the command line:
> >   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> >
> > and this to your kernel config:
> >   CONFIG_DYNAMIC_DEBUG=y
> >
> > You should see "... is associated with ..." messages in dmesg.
> 
> I tried Lukas's patches again, after enabling the Thunderbolt driver
> in the config and also verbose messages, so that I can see
> "thunderbolt:" messages, but it still never reaches the
> tb_pci_notifier_call function. I don't see "associated with" in any of
> the logs. The config on the image I am testing does not have the
> thunderbolt driver enabled by default, so this patch wouldn't help my
> use case even if I did manage to get it to work.

Mika, what do you make of this?  Are the ChromeBooks in question
using ICM-based tunneling instead of native tunneling?  I thought
this is all native nowadays and ICM is only used on older (pre-USB4)
products.

Thanks,

Lukas

