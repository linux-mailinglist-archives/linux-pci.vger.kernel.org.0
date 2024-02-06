Return-Path: <linux-pci+bounces-3167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8484BA77
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351F729074D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E7134742;
	Tue,  6 Feb 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzGuSZCb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B207132467;
	Tue,  6 Feb 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235260; cv=none; b=hn/bfRYvTo2v1ruo6LImrbM4PBnpF9OpHWMBrpkcfux2JPyuRPOscWf/adzz52VoUtDxMkbhwUhgI9wllc52Tv8FXuKg7jUDumLlkGc5g0xV4WsmTX25Da/Uu0rL9cx/41u2lFMP6RvPuiHvLGVLww2H4Ya3nv4AQmPdVDnzf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235260; c=relaxed/simple;
	bh=q4F9HRZC3/k/5ZfPWealPi7S3wYeh5bX932ooYmivMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uuydmu6u41uiDEXt0+d4ChjvsJNiL+S9T4qCL6ARItRQ+MOJpyFHST8nAmwMgTLo0F5xUgLKrlEynejFVJbrL8qYLyZen+4x99tYDsq/jX+XUJEaGYcpvkxO8L0FLUv3JN26Zl2McshaFuQYsfHvQsuDF45W08Zm0iLNFqo+2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzGuSZCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7D2C433F1;
	Tue,  6 Feb 2024 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235259;
	bh=q4F9HRZC3/k/5ZfPWealPi7S3wYeh5bX932ooYmivMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UzGuSZCbmzSoKXEMWh/F8QdgJpEERfXUcLfM+jumLtcm1nsl4fuELyFE4HTOCjuJC
	 SgYrahXXIk7SsWmOnOI9qtufvSpU/fCFepFBi+d7pJU6MehzM4VLWBWLSnQYHCpE39
	 jq1ENiHq6LAXVQLbn/F233+sFkvPRM1acfBzgkR3mSKxbH9mTVIYTe4gacP+f+lcyc
	 QkhG7S/tFmTlky8cU/FI19sv8FgX68jgN0jgsL5R16d8ArZgKDieEmqoJOLQn8JJc+
	 pNMzL77laFyDAHwan6/zEspust/EOUCL8DnM6muXcmzD16fuGORWygRF/Eoikl0EC1
	 Pv+6cl9QiO/vg==
Date: Tue, 6 Feb 2024 10:00:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux@endlessos.org
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
Message-ID: <20240206160057.GA866439@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72b9ef46-851b-3555-0a43-8da4d4ab0fad@linux.intel.com>

On Tue, Feb 06, 2024 at 02:29:12PM +0200, Ilpo Järvinen wrote:
> On Fri, 2 Feb 2024, Jian-Hong Pan wrote:
> ...

> > +out_enable_link_state:
> > +	/*
> > +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> > +	 * Section 5.5.4 of PCIe Base Spec Revision 6.0
> 
> I don't understand what are you trying to say here? Are there some typos 
> or grammar errors or something entire missing from the comment?

This is about the fact that per sec 5.5.4, "If setting either or both
of the enable bits for PCI-PM L1 PM Substates, both ports must be
configured as described in this section while in D0."

We can wordsmith this a little, maybe:

  Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
  PCIe r6.0, sec 5.5.4.

I look a little askance at having to do this separately from
pci_enable_link_state_locked(), but we can solve that elsewhere if
need be.

> > +	pci_set_power_state_locked(pdev, PCI_D0);
> > +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);

