Return-Path: <linux-pci+bounces-24420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E38A6C5F9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897193BDC14
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F422E3E9;
	Fri, 21 Mar 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgw2A5EO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD122CBE9
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596222; cv=none; b=g/SaX1a8OkVIkHB8p5Wyx94AHMiGL1JuY6qKYXdnv3O9VL8UfUziyIrj40iIS7LVV24XSMimbBeML2G2zBeDPkolMuzpbYYS8lshrxUng2BJsveprYYQxGgmK0PdBItnF/YtbI4yWSy9/Nr3hWKeGZgWAQG35n2A/lrQ6U10qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596222; c=relaxed/simple;
	bh=AnD8yspu1sudfER/tOjiOsTq3E77m1P8kwlhM+qW/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwp3kaD3WDQe3H0X3gIpsFNL4JxwnjrvA8+O4BcUIT2wAk76D2up5ULEtqn9qBRtVCgiTzEmNTOkdC9kc/eCHNMJ9VBt8qh+GlD1xWWDpTik/ZYP5ejLc7i9ZUtNaZ/zCB/pDZ3gKxFnE1Asf7PkLBVgfqk6ev6zsHWlIIDknm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgw2A5EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96233C4CEE3;
	Fri, 21 Mar 2025 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596220;
	bh=AnD8yspu1sudfER/tOjiOsTq3E77m1P8kwlhM+qW/rE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fgw2A5EO/MNHWGYT0bW9t68gCaRmyShAud1kVJ8e7G1hX2ZKXTk3LrtwZ5TbEn6ej
	 tKLC1vVGcoxY6vDSPrWrVgAqmBLI83ovugFOVacEssPLA8V0XgM6oZMJuNDNWNSyFD
	 IUo+u5btzExq5v3RN6BENQyZV/QSytBP1suIwNdBxHtnrwfKRxAIriyfVNQHYFxVCK
	 JB3SmHEOZW1hKc//mWDEpptmVQAFFqVWhVx/dcREAFAd/uYuYDdm8YA/6BWan06ahf
	 QCtZPpOiq8UQoLDKmfij9Xk6oziDVktDmGTOgISu1XZrexz/topAa5DS9NQLa57/gI
	 MhkuygKhJH0cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4627DCE0D1D; Fri, 21 Mar 2025 15:30:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:30:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <d267db19-88f1-4dcf-8a85-2a446d858d33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250321015806.954866-6-pandoh@google.com>
 <20250321220115.GA1170462@bhelgaas>
 <CAMC_AXX0PKDY1sqJKxCbUxLGB2-0uGG3Ytr3ess8d+8pv5TYiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXX0PKDY1sqJKxCbUxLGB2-0uGG3Ytr3ess8d+8pv5TYiw@mail.gmail.com>

On Fri, Mar 21, 2025 at 03:15:26PM -0700, Jon Pan-Doh wrote:
> On Fri, Mar 21, 2025 at 3:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > What did Sargun report?  Is there a bug fix in here?  Can we include a
> > URL to whatever Sargun reported?
> 
> Paul added Reported-By and Acked-By tags[1] for the series which I
> applied to each patch. Checkpatch mildly complained about not having a
> Closes tag for Reported-By.
> 
> Sargun/Paul, do you have a Closes/URL tag?

The URL of this email?

Perhaps more productively, I hope that we can run tests on this series,
but it will take some time.

							Thanx, Paul

