Return-Path: <linux-pci+bounces-39860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76530C2284D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302163A8E8A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0282EFD9F;
	Thu, 30 Oct 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGvs4ccN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9D238D52;
	Thu, 30 Oct 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862089; cv=none; b=Fq1NzB9fXH0q52en+grKWl6kL3IVs2tlmO+I+p6VeYxP0uxrnh41ayyrefTiIC3dU7ACQkT1782gA3xqEGwbeKaI66Rd0LpGBKwH4RsWWh4eBSQGHFJnmcsYl+NzWcmCf1l5UesZXVivV1/sNMx6e8wa+RYL5DTTLIgKuGgfgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862089; c=relaxed/simple;
	bh=2UYgKHAUa8tAu2Cg780pewILJRO49LIbpn+Ign9y+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JJErGJhp5jJm26641GdZuuvXyTXkW9blnjNY/cgc1myZ/Ub3S2GCdOkseASZkJ0bZmmbQhytEDQKDKmGyVkVk9lIf3zJnRO1iwuwDdQrY8JKlWV27myprdLmCg0UOp3A5tf8bQk8WjcZrBGrnkKRQzm1dGWpvJiEoBASO6OP6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGvs4ccN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05734C4CEF1;
	Thu, 30 Oct 2025 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862086;
	bh=2UYgKHAUa8tAu2Cg780pewILJRO49LIbpn+Ign9y+fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jGvs4ccNoQWOujytIHVnHTm4muQdrGy0nofOj39XpqIu+Eq+J6hABnJ+AT5KhtGG0
	 TyM0n17fD3ki0rs2aNRFFrLJKSnRaHDhw+4ocnNa4L86vdABqIUHhURDkV/GlFO33+
	 8CILZsxeEF2r+52Y86/gtjSJ632e5NNuU/HeIp8dkYL5RS1LRcVUfGEz3eibYvrsET
	 2c8WfK3lDhEewsewJzYoqBURV3kyB3YRRxA9Yb0ZWU2JFWmUrt5SbfWcpNqvrR82Bx
	 3fVMf4/FdQvsVU5Gx51TliXXZHtQLRFVybEHg1HZIiM4Ww/k5n1t/2QW5GEKEqEyz2
	 j0BKqUz8qbgsQ==
Date: Thu, 30 Oct 2025 17:08:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <20251030220804.GA1655835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028224758.GA1539235@bhelgaas>

On Tue, Oct 28, 2025 at 05:47:58PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 04:01:16PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 06, 2025 at 05:00:25AM -0300, Val Packett wrote:
> > > On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
> > > > Bridge windows are read twice from PCI Config Space, the first read is
> > > > made from pci_read_bridge_windows() which does not setup the device's
> > > > resources. It causes problems down the road as child resources of the
> > > > bridge cannot check whether they reside within the bridge window or
> > > > not.
> > > > 
> > > > Setup the bridge windows already in pci_read_bridge_windows().
> > > > 
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > Looks like this change has broken the WiFi (but not NVMe) on my Snapdragon
> > > X1E laptop (Latitude 7455):
> > ...
> 
> > #regzbot introduced: a43ac325c7cb ("PCI: Set up bridge resources earlier")
> #regzbot fix: 469276c06aff ("PCI: Revert early bridge resource set up")

TIL that "#regzbot fix:" should include only the SHA1, not the commit
subject.

Also I think I should have used "#regzbot report:" to point to Val and
Guenter's original reports instead of "#regzbot introduced:".

#regzbot report: https://lore.kernel.org/r/017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool
#regzbot report: https://lore.kernel.org/r/df266709-a9b3-4fd8-af3a-c22eb3c9523a@roeck-us.net
#regzbot fix: 469276c06aff

