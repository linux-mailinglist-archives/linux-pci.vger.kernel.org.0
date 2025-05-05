Return-Path: <linux-pci+bounces-27189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D3AA9AEE
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8245A017C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485419DF60;
	Mon,  5 May 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dePFR/1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A22EEC3
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467029; cv=none; b=S4dtRGUb6RFQxt5ioTwAvOJ1bd29M30tdrUiZXW+jCzTyVag8K5m6Mjn/8xp6CBzuX4Ee8C+aAxokU2eA555wh685KOj5CiXIkD3NfdMmOYX2kO9rXWTi2AByvw9g0WDQXtQDjeO8noUi3FXHANWEvaRdlMUFY7MfkU1P3+l36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467029; c=relaxed/simple;
	bh=v/CDH8G13+1LiLPFR5nXse7cJr3H+czbw3aPIGZwc+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KTaSD41XZ6BxOARaVRBrYHWKaBRBgQ9l2TyH8VIiTpsJ+Du+7ZVd3tGNoDgK7YdLfh1jwgV8vQ2g16Ic1yzree9w+JRM+p2lMsRzpg12h80+bpqU2mA9kkIpKVh+6vDduRCDKUavQfhf7QLyDRyFxTD2rf0pRo2rh9IkgbdlPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dePFR/1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1EAC4CEE4;
	Mon,  5 May 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467029;
	bh=v/CDH8G13+1LiLPFR5nXse7cJr3H+czbw3aPIGZwc+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dePFR/1BhrI541wYU56u+d4uX8KegBEy24HCqjHJcTK2QNAcUtrVl2ugz0s6PAeD7
	 JXAp6i6C4T8YbgAfAJtZHAkDvp745GIhABn+V0ueudtkf/HXXKyBHm28vuI+BF7+v9
	 zbVpKDYb5gIOKzcjlV9iXQvJ4qOUyYcUf/sccl4K01JJjijPe2qkFLW0K8mPb07r68
	 Ql9O3tnA3LEfvdxU/VixT0xwZwss3v6vOuI5hsEuTn6BkYT/U/bwMjZ+EwNW8rTtS4
	 kOeGc8U6Hvw4MjEVKJVaOF0ea9Q/S6thqqLKtMtqO36QwiNPO1yyBxyvoXxVNldtRc
	 XXlhDazwMN9Qg==
Date: Mon, 5 May 2025 12:43:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 1/8] PCI/AER: Check log level once and propagate down
Message-ID: <20250505174347.GA985743@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0c7147-325a-43b8-907e-f21b4fb78bee@oracle.com>

On Mon, May 05, 2025 at 11:30:58AM +0200, Karolina Stolarek wrote:
> On 01/05/2025 23:43, Bjorn Helgaas wrote:
> > 
> > I'm (finally) getting back to this series because it really needs to
> > make v6.16.
> > 
> > It would definitely be nice to determine the log level once instead of
> > several times, but I'm not sure I like passing "level" through the
> > whole chain because it seems like a lot of change to get that benefit:
> > 
> >    - it changes the prototype for __aer_print_error(),
> >      aer_print_error(), and aer_process_err_devices()
> > 
> >    - it removes the info->severity test from aer_print_error(), but
> >      leaves it in __aer_print_error() and pci_print_aer(), which need
> >      it for other reasons
> > 
> > All these functions take a pointer to a struct aer_err_info, and if we
> > want to compute the log level once, maybe we could stash the result in
> > struct aer_err_info, similar to what we did with ratelimited[] here:
> > https://lore.kernel.org/all/20250321015806.954866-7-pandoh@google.com/
> 
> I think that would be a good compromise between these two approaches.
> 
> > I'm rebasing this series to v6.15-rc1 and will post a v6 proposal
> > soon.
> 
> Do you plan to include changes suggested in the thread or just rebase the
> series?

Yes.

> Also, it's still unclear to me how to approach the sysfs patch, both in the
> context of the ratelimit refactor (which, some of it, is in the next
> tree)[1] and the value that should be exposed in the attribute. We have
> control only over the burst but not the interval. When we deal with high
> rates of errors, we may want to increase the time window to see if the flood
> is out of ordinary or is it constant.

Unclear to me, too.  Might have to revisit that.

> [1] - https://lore.kernel.org/all/b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop/
> 

