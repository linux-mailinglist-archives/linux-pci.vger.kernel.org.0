Return-Path: <linux-pci+bounces-7484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C68C6308
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A01F216E8
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C434E1A8;
	Wed, 15 May 2024 08:47:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256D4F1FE
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762820; cv=none; b=uQyjHYC3hG8L93fp4w/fHyVL7gboesTVVv4Xnw9p5L+5PTeN9P8knaEHSa8BBxxzoPZ7V1Cd9odpOu3r0ZFv9c1gx+2+Et/unR3zBWNHgQ5aek5t46qT4Xvo9p1q8KTmL/3Q4ZT/oIZ4FZuLmWUbi6TfEf6jnLLrTgUhDk1e6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762820; c=relaxed/simple;
	bh=am/CRh+vIDjKPn6YUOYieZmVhdNdtcYHXu+/HQwr3os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afoe1QSnNA1rHIq9Euri7Yk4pfOSEuxB9Mu+XA3iGpEoCICN7IP1x6NRSQ1KtXa7FzAevJYTdPHs7/KDpYwg8p3s6c3IyHkqNqj8KIqlnpijpo/yGdabipsj24q9SVLjX8VUEsCi57YyeEFnUyuUn9yXTrHRyn7mkXJxYALx9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 011F0101E6807;
	Wed, 15 May 2024 10:46:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A0F1C1F564; Wed, 15 May 2024 10:46:47 +0200 (CEST)
Date: Wed, 15 May 2024 10:46:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "scott@spiteful.org" <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <ZkR2d0xp9q90bgLx@wunner.de>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de>
 <ZhapFF3393xuIHwM@wunner.de>
 <7cd910060f3d4951ac0edd92910a55c2@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd910060f3d4951ac0edd92910a55c2@realtek.com>

On Wed, May 15, 2024 at 07:31:05AM +0000, Ricky WU wrote:
> > I tested this patch and the result looks good, but if the two SSD has
> > same VID, PID and capacity it still has problem.
> > So I think add S/N to compare is necessary if it can do
> > 
> > And I also tested SD7.0 card the result is same with M.2 SSD
> 
> May I know the related patch has upstream schedule?

Sorry for the delay, I've been stretched a bit thin between
PCI device authentication and solving a Thunderbolt issue.

The merge window opened 2 days ago and it doesn't really
make sense to submit something until it closes and v6.10-rc1
is released on May 26.

I intend to rework this patch based on your feedback and
re-submit shortly after the merge window closes.

Thanks!

Lukas

