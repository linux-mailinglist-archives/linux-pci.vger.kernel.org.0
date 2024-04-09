Return-Path: <linux-pci+bounces-5947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD8089DD7C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEF81C21DEE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA5130AE5;
	Tue,  9 Apr 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bufi6t6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B130ACF;
	Tue,  9 Apr 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674837; cv=none; b=Q/BUXvt83E2frSCcmVGXsnlh1QBNvkGFZrC+AUWSihFkPKDaRf4aGTT6ZGJ3xVdtOIpZdFbvR/v4550QLdFzbn0l6KZZFO+Q3rRFFSUFUMFdi4X9Ts33V950XTbR+n3vrsvEcIKPxcd9nzVSfg30PlhKJxuCng7rzY63J4kZSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674837; c=relaxed/simple;
	bh=2O+kuuNMa47rDZxWC/YcYiF8QgJcY+wcgtk/8+mhX78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nedpl1MpS+OpnYRlQ3xF8DfewgytLUkiyLUwdrqie7EbDn+TSrFPziwPp9G2SdDBiMaG9tDsTGot8ygyL9cjvW4m/5tcYzgv1VfHDnOG7TdMOB9HFyUlgZNMCZJjZiFTqhXIVI4EJVWegXqR43BMJBMSf0lUXSwodF9kRuxiscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bufi6t6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCEAC433F1;
	Tue,  9 Apr 2024 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712674835;
	bh=2O+kuuNMa47rDZxWC/YcYiF8QgJcY+wcgtk/8+mhX78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bufi6t6L3GC8+V4yLWMY+1s8TBa/m84mIT5KnLSpee1y6ywdxV9U1xoE/EcWozpGE
	 lcE++pyIoy8OQVsU5+How3Jz3bsMaaqU9ASOzN1Inyohm5qWNNKcR9HlMmwV2tKqc8
	 mGz/Yz+KaNioW5R7Ik2AO07Hr2G8mPx4XrRO21FyWUZVMaON4bZKXytZrervuXvnVY
	 MCSTPS+BRTaMwX24FsEhULDfMJtrcf2A1lSRmZPe/5ndszbpTBRzdVelnqmJF2qceE
	 yHuOd8sHrQ1Mnm88fIvbQcqTIxytaEr3Vp9H1pnZkqZK8/eNcoWrs0jqcoDkque76E
	 yKkK9BwZal2UA==
Date: Tue, 9 Apr 2024 10:00:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Message-ID: <20240409150033.GA2075977@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409145933.GA2074336@bhelgaas>

On Tue, Apr 09, 2024 at 09:59:35AM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 12, 2024 at 05:05:57PM +0900, Kobayashi,Daisuke wrote:
> > This patch implements a process to output the link status information 
> > of the CXL1.1 device to sysfs. The values of the registers related to 
> > the link status are outputted into three separate files.
> > 
> > In CXL1.1, the link status of the device is included in the RCRB mapped to
> > the memory mapped register area. This function accesses the address where
> > the device's RCRB is mapped.
> > 
> > 

Sorry for commenting on v3 when you already posted v4.

