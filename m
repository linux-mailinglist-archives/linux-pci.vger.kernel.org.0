Return-Path: <linux-pci+bounces-29524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C943FAD69EB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 10:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AB7179758
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 08:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255C72617;
	Thu, 12 Jun 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/sVmzIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FD1E487
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715610; cv=none; b=GBQaVr9Q/6cY6RzjwdUWbajnsVG3q+ZbArLwQqwyNCSSQ2UTevz59FriYzsyMvQ5iEoY3xB6qMa/H0Oj4BVCRXAxPNvV5pe/+wyZQqYqeSnqZrClNc4uFyOzdiFzWFq8FJKeuVBpIjZj1J2QAd+EaQOf+oIOuWyOG9zFwMfziKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715610; c=relaxed/simple;
	bh=TdHIrQM7FdODbPk+dNq9Sp9wIRR+g+G7AXTsjMH4T0I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hHPVyZyhqaR9mp3q568olBHBPZ2zd+vKxVNCvHvWUbC/8BMwV+LIKbfNAcEPiqPIWyRJgIq1hO9E2MurPRf2LfawB3kPC38eEcESXO/MvLNJ8YAd/775/JCraeIw51fJaIOF9UpJ3PMrHspKk/lhyb6lK0R2jVOPu8NFamDDA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/sVmzIX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749715609; x=1781251609;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TdHIrQM7FdODbPk+dNq9Sp9wIRR+g+G7AXTsjMH4T0I=;
  b=U/sVmzIXn1/ZtJ97Lu2l0tHLILPpYi15FKfLxj7TBBAwn045UayK4L8a
   nh9kUJZ66hlek0xljYXReyy/sqKhORCma+3Dj9PjX1eptY0uuENfR4SZE
   y7uPIxzR+D2SprYb/BD7Hqc9HRrKLPVr/uq32ahS5O3AJ1LspfDLlwVfn
   ZtUv/mIVY4SiAUSQTPFtrI2KDoGLg23elPYV+ATqP27MuHJlWjhd1QXIW
   p1VGvR/2x/jCwSgQEaxFTw294sPfVR/etnr6Iq1PWRc8lSZ4ELSwcPxmF
   uXWzQ2aUjFbotPK5JGtJ2jgJklHTvCN+tORlaasyslJuRO+lG94XjOW78
   A==;
X-CSE-ConnectionGUID: 37bs9gVARp+E1MDbE5PTrQ==
X-CSE-MsgGUID: uLPVyoNBQYydDuqj6ELZ5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55683574"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="55683574"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:06:49 -0700
X-CSE-ConnectionGUID: QZoNygF9QFCxlb2B93oFbw==
X-CSE-MsgGUID: FaCas7JTQ1OB6h4FVcJ3+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147433545"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.140])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:06:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Jun 2025 11:06:41 +0300 (EEST)
To: Keith Busch <kbusch@kernel.org>
cc: Manivannan Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@meta.com>, 
    bhelgaas@google.com, linux-pci@vger.kernel.org, 
    Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
In-Reply-To: <aEm6Nx6bSDvyouEy@kbusch-mbp>
Message-ID: <48d598a4-27e4-e1d4-a6a2-9dc1fec10b77@linux.intel.com>
References: <20250218165444.2406119-1-kbusch@meta.com> <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com> <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5> <aEmxanDmx6f_5aZX@kbusch-mbp> <reekyt4dm7uszybipm25xfxlksn5bm2cdpubx5idovxenpg44z@qcqs44xlevea>
 <aEm6Nx6bSDvyouEy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Keith Busch wrote:

> On Wed, Jun 11, 2025 at 10:41:33PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 11, 2025 at 10:40:10AM -0600, Keith Busch wrote:
> > > 
> > > No. I'm dealing with new devices being actively developed, with new ones
> > > coming out every year, so a quirk list would just be never ending
> > > maintenance pain point.
> > 
> > Sounds like you have a lot of devices behaving this way. So can't you quirk them
> > based on VID and CLASS?
> 
> What I mean by active development is that the timeout continues to be a
> moving target. A quirk only gives me a fixed value, but I need a
> modifiable one without having to recompile the kernel.

Hi,

Doesn't DRS/FRS address this such way that the device can tell when it's 
ready? So perhaps check if DRS/FRS is supported and only then make the 
timeout like really large?

-- 
 i.


