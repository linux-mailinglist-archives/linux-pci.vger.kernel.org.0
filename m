Return-Path: <linux-pci+bounces-43005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B6CB9855
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5067A305E377
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DB2F3C13;
	Fri, 12 Dec 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkbFKrr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F411C860B
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563190; cv=none; b=mN0oTXdlT+WW3y8FryYBq4aeZwMyvbPeUwdc+xig9d0MXjWy1oyNbKGhaKhOippFzh7Igf+QJXS1EMgGaFeTCfqdWgj+gYYKFUcWam5Rc2rpm+fR5eEO7jpKMOFUECy+DRweOI9hFDvZyFtc2KM5I3TEgaJTHWippVMq94v73eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563190; c=relaxed/simple;
	bh=g5oq/pRqZF6ry3DMNp4QV4zCwz2XYreqSnyH+xkTHF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VvJbR73Ozzhfzb8Da1a4nqg6hApLrMU3MRZE9fDI3d4hZDbckmoKxFfqr7n9W9Dufh3pexGKCs6QSbh16HSBZUI9XN4L68aQG9k6r/O4JXElqzanCXM1CrWuTyhELcywUdVluWcrUvJ+UMGNFl2i7ddUQPZjamOGI34WMjgVsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkbFKrr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889ECC19424;
	Fri, 12 Dec 2025 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765563189;
	bh=g5oq/pRqZF6ry3DMNp4QV4zCwz2XYreqSnyH+xkTHF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FkbFKrr3hMvn2C5udZmdt12nfJL0C5wiFYPqCAsL+Az+eYgBbBAZvttHuGky7ny76
	 Y8RWgQl34kPKzDnK4osvCz2JW2oOhMA4x0ecEValnPCag5KFzL461SymkYN0PuNiZK
	 gD9BIhUvKnWHpo0W3uSIC8igjT8X4CqWtHAr4josQRbtl4i3vUAv7YeQfSWOCOTuFU
	 wlj1K7NCcjb05AoTRV+7CzkUXyqKuqK4gEVfRRTpnx9f8REyltP66MofPc2x2JdkQc
	 jS61NA3dQee8cb1kMRlsWyUImmrOLfXZKVXwYdGn8EXN59s60iOgEK3cUKl8CDkSqb
	 3iqmymAs/50eg==
Date: Fri, 12 Dec 2025 12:13:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 1/2] PCI: Introduce named defines for pci rom
Message-ID: <20251212181308.GA3649201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3fd2c30-91da-6202-f46d-23aa66f947f2@linux.intel.com>

On Fri, Dec 12, 2025 at 05:17:23PM +0200, Ilpo Järvinen wrote:
> On Fri, 12 Dec 2025, Guixin Liu wrote:
> 
> The subject still seems to have lowercase "pci rom" :-(.

We can fix that when applying.  The cadence here is crazy, no need to
post these so fast:

  Dec 09:  v5
  Dec 10:  v6
  Dec 11:  v7, v8
  Dec 12:  v9, v10

We don't add anything to linux-next until at least -rc1, and I'll be
on vacation until Dec 22 anyway, so there's no rush.

Bjorn

