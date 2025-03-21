Return-Path: <linux-pci+bounces-24415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16BA6C58E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150317E10B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4419231A37;
	Fri, 21 Mar 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM66dTVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD981E51FF
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594380; cv=none; b=ZZ1+3L5oT1lCbG3XxRlUtJ7SAfW3UELS66d7TyPiAg6ewXCt4QXoCBjClVpObgSfJVCN+K+pjwlZ7oJZm+SPzL4U61eHn9whzGdSCPo2i5FLS5Qf58qq3zJ40R3NFSNDvlIJDAOwLb06Vim0j4c4FCQqHyFQwKqnc84ZwI4DAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594380; c=relaxed/simple;
	bh=n1nWlc2bQ5MRB7rW8pyqi+QIIEJq1D0GaRdmiBdTUQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R8+NDnLDD0qhEYz1Uhsj1bLOALJju0bF9geU3lrI5XAZ69B+S+ejVSO5m3p9GRjQJjs9iAdQ207CMqjDs3NGaCGOt2m1jhodkXvIBBQPwUWkZ/FtY6MXwH7UNK/H6jfiUCbV7d9uOry+P+o4zxIHDIv3x+9Wz6wsOlj5Wo4vUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM66dTVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC1C4CEE3;
	Fri, 21 Mar 2025 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742594380;
	bh=n1nWlc2bQ5MRB7rW8pyqi+QIIEJq1D0GaRdmiBdTUQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aM66dTVtRpnUnwQQDFsz/Hg2OMl9P6gIL8xYz2QHDXB16wIdHizYh2iGqBNbgjYf5
	 KWrXFFAi00iedIOG4XnMhQmrbaSXi4sqzAc80RfVhyjHnwCTRLpEW3koXN4LJ5j69j
	 XqLbapofCRgdOTtAXixfr3fWhLzFA4mX0g3Yy5ifnVp7oD7QEiTfRwd7EtCTzwI0Qn
	 6LLHDGCM57nr3VhqG3hEFtn++37xl7jFBfTlNvPvsn/vBW+AxdUYdTuNUEhecfmvfP
	 5jSC5ky7OGPyoeKGiEtzxF8HPx2O372N3RmGoFfNM5V2QyPVZ3zy7IjdpfMy9BKKWb
	 nM082PI8en5Ig==
Date: Fri, 21 Mar 2025 16:59:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250321215938.GA1170366@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfd75767-7743-47d7-939e-f0c5204ee647@linux.intel.com>

On Fri, Mar 21, 2025 at 02:47:36PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/21/25 12:24 PM, Jon Pan-Doh wrote:
> > On Thu, Mar 20, 2025 at 6:00 PM Sathyanarayanan Kuppuswamy
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > > Should we exclude fatal errors from the rate limit? Fatal error
> > > logs would be really useful for debug analysis, and they not
> > > happen very frequently.
>
> > The logs today only make the distinction between correctable vs.
> > uncorrectable so I thought it made sense to be consistent.
> 
> You're right. From a logging perspective, the current driver only
> differentiates between correctable and uncorrectable errors.
> However, the goal of your patch series is to reduce the spam of
> frequent errors.  While we are rate-limiting these frequent logs, we
> must ensure that we don't miss important logs. I believe we did not
> rate-limit DPC logs for this very reason.
> 
> > Maybe this is something that could be deferred? The only fixed
> 
> I am fine with deferring. IIUC, if needed, through sysfs user can
> skip rate-limit for uncorrectable errors, right?
> 
> But, is the required change to do this complex? Won't skipping the
> rate limit check for fatal errors solve the problem?
> 
> Bjorn, any comments? Do you think Fatal errors should be
> rate-limited?

I'm inclined to not ratelimit fatal errors unless we've seen issues
with a flood of them.

Bjorn

