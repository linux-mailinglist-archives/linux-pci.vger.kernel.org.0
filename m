Return-Path: <linux-pci+bounces-24419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78849A6C5CC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FB17A901F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842354A0C;
	Fri, 21 Mar 2025 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJaHBYQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A28E7
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595409; cv=none; b=DcuMo7JReRfR0wjTNhdFNXJ5c3ey3p2ASej80eoJCPjflGN0EYCxg1PDFBYmZu9J93J3BI3n32iSmrnoU8/n+FVZ7H8kMO5QJ9eFs1uckTRXDvgJ2JMeUWlPBAcZloiqbEoLX+cfVhl4W/6jgYRDakpFXtrKbojPL+2umrkSn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595409; c=relaxed/simple;
	bh=Nh/fn5g5UzB3bD0BFUck5TrJn8YhcCybrx0ypjr9+jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKyo8ffXOuXfhN4rV4YmsjkKVRtIm0EHfIH8LNT14QcibMEp2EQjRlVMBtlz95XAbv0ga7SYP0UJAV7f6yaeDXfJBTdBYu/q2QoAUsCaFgPBhjaCrIJaa7y6XIdDlqxZQ0v0T6nljBI6xLlkO/2YVl8xGnvaf5Nf/yPVUMvv1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJaHBYQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3004C4CEE3;
	Fri, 21 Mar 2025 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742595408;
	bh=Nh/fn5g5UzB3bD0BFUck5TrJn8YhcCybrx0ypjr9+jw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fJaHBYQvQ8c4A3k3dXzIsTZ99XkF705xbO0JK9xYYE9DLwjtTLSiNF6MyXt2ZzR6v
	 jc+d4bp6sV88RuDZRXO4DLJyk6inAT6wdRamio1e4pOvQLbRjdIRolgkdUlCuNM/sT
	 oZg3x4IDdjuda+lsVWZ8ETZSib4BLWS6ZSQQiHDOYi1feUEp9BqiUszLBG0CcwB7K2
	 pEmCJ3ebVRsnghoyIgM8j6mgPmqygOfrzkubZcCO8m2IQez4MOjWWndL15Quflzigy
	 q8U7LoJz4PHm3trsxanFWID5gjFmMFpEkmHSyJD7W39+fS7/BJMQnjjGMwkQbpzXKJ
	 lOZ6JwlBwVlRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72287CE0D1D; Fri, 21 Mar 2025 15:16:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:16:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <9c62d088-36b3-4311-9e53-d7cf87cf3393@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250321015806.954866-6-pandoh@google.com>
 <20250321220115.GA1170462@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321220115.GA1170462@bhelgaas>

On Fri, Mar 21, 2025 at 05:01:15PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 20, 2025 at 06:58:03PM -0700, Jon Pan-Doh wrote:
> > Update name to reflect the broader definition of structs/variables that
> > are stored (e.g. ratelimits). This is a preparatory patch for adding rate
> > limit support.
> > 
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > Reported-by: Sargun Dhillon <sargun@meta.com>
> 
> What did Sargun report?  Is there a bug fix in here?  Can we include a
> URL to whatever Sargun reported?

He reported RCU CPU stall warnings and CSD-lock warnings internally
within Meta, so sorry, no useful URL.

I did put together a series of hacks that fix the problem: (1) Disabling
__aer_print_error() entirely, (2) Disabling __aer_print_error() printk()
and sysfs, (3) Disabling only __aer_print_error() printk(), and finally
(4) Throttling __aer_print_error() printk().  Jon's patch looks to
cover my #4 plus it looks to allow run-time control of the throttling.
So my patch is strictly a stop-the-bleeding measure for Meta's fleet
while this patch series makes its way upstream.

I do plan to look at Jon's patch in more detail when he posts the next
version.

Fair enough?

							Thanx, Paul

