Return-Path: <linux-pci+bounces-16003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B69BC00A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28801C21397
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF31FCC6B;
	Mon,  4 Nov 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC3JS3Ul"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C521FCC6A
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755697; cv=none; b=ndC9hIId8MXCamzLRhm1OkDCAn7lgdHFjpaYAzcmPcJUl3enFZ1UBUMAxJCt1QLQ0c0ZSEKsywBkVA+a5RPw1L17wEXTDY/e7AwclCrGq+7C+Ve7c1c2qygRqbrTj5ntrtqAs24Hm+knN8qnMul8h0IxC+sfCJteN4UXisBsyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755697; c=relaxed/simple;
	bh=/S4LE3Vsiywf+o87Cqkss+qI4/CpeyQQfHXs6COFu8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baOumm2QqV9+XBvO0S7dQlA9ObfzlTyiJi2enPpD2dXzKtb53geHnbAG0ZzYPoRwXh/zlP/t+n+F5RQcLtRslndEzxeRY9g8GuGSgHxemDCui/Gd3Q1vcFnZCTEmBv2nzeESACOjKdJWVG/JQgGFug67qrHS8KIYTJUpA5Kq29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC3JS3Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7179DC4CECE;
	Mon,  4 Nov 2024 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730755696;
	bh=/S4LE3Vsiywf+o87Cqkss+qI4/CpeyQQfHXs6COFu8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NC3JS3UlwzmLhE/Y6ZxjGoFwCKZP8FVLdc3dRfEJHuQyNb1p25nBbnRgb0sRM543x
	 myhUL930VUzxIGr4151HkI16JQzdrZDE2v+9StbcIAIcSNRrsW0Prs1yBe6vY9ivwI
	 XbRwBE9LS6zCmPmreJJK+CRN+dXrjnl9uc23lPmY2QPRHjMAPyrA0V03GKdqadA938
	 J9dPDOKAyUVuTylK395Vn6c5PsyeEQoPgPOWOBCHOqSt7TQI+9uyeBJcp6CLfplJ+y
	 tWPovSmZIrl1QwQORVhG8JtWzkAaVx6b+IXshdyZswlHrKWahRe/BrhP24NjVFfRwE
	 LojN4k/uyimRA==
Date: Mon, 4 Nov 2024 14:28:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, ameynarkhede03@gmail.com,
	raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <Zyk8bvQZou-stmrW@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>

On Fri, Oct 25, 2024 at 03:27:54PM -0700, Keith Busch wrote:
> Resetting a bus from an end device only works if it's the only function
> on or below that bus.
> 
> Provide an attribute on the pci_dev bridge device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> action.

Hi Bjorn, just want to check in. Do you have concerns remaining for this
feature? 

