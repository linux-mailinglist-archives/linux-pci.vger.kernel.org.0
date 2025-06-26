Return-Path: <linux-pci+bounces-30796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFDAEA2E1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6993B3128
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE172EA15B;
	Thu, 26 Jun 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrJ1HCKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089997081E
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952521; cv=none; b=O9/TBKHU9PQ54COdzDplvUSmvbqG1chr1YILfJYD01DqDKNzSS0lJZ7tZEdNtkafSKokdVH2TKSnnGejin7CR2xbV6mYqDrPtAys8mgOZ1DhZDHY1WP25S4evrtXWQVYFGOn0+1EzepPzyKnE8LxD/AIFU9MfIzz4neo++QAQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952521; c=relaxed/simple;
	bh=6CdwFCxXo2kN7RDIzZgvCSNe441wFFhUIkA4OlmkGw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Dwldkgjjkfcsy86u369Wi1aKpEMo+LsVQmSGfwoB214BhAL+7pFg2yNUTE+P4dxFb3oZyeLr0HH8DxvR1rV21WyZktCbmMrrt5AADRMwHBA9G6s9QtvwnruE8GKZJr8fqgDOLDyBM3Nvn0YZa02hCRZLiCMrGwZ0FwkhE2+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrJ1HCKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A99C4CEEB;
	Thu, 26 Jun 2025 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750952520;
	bh=6CdwFCxXo2kN7RDIzZgvCSNe441wFFhUIkA4OlmkGw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrJ1HCKG/1ZWc2UJQCAG3a1Dibphb+SZeGrn9rA/+sKbMTvVtz8Xm+0NJUijtdSPI
	 Af7UbCBzTiBsI8barOse8wnQhooJrIdOKF+OSBuDhaPwSv0mN15v+9Dheh/xeC37H1
	 ygH4cLgI/Lt91yjUlzT4RqIwIouCZVw34w5/etFksQ6caaDw7rdcFbpgDq8AyCDhWy
	 44PS8PqLteMY2NlEunqDu/sjC18wXRA+PsG5Wh8pdKU+EGzuGkL65qGImtA5Ae3fPv
	 R8Y4cMz0LS94AnQwNOGQ9qZyV669oOWf6Q5AC3YlG8iNdqE+A/YIVqn2jkankWk7uS
	 Zm5RBQLbsOivg==
Date: Thu, 26 Jun 2025 09:41:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Message-ID: <aF1qRv0XlT4EDN-Y@kbusch-mbp>
References: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF08kFNy8qrI8LvD@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF08kFNy8qrI8LvD@wunner.de>

On Thu, Jun 26, 2025 at 02:26:56PM +0200, Lukas Wunner wrote:
> On Thu, Jun 26, 2025 at 12:20:48PM +0000, Jozef Matejcik (Nokia) wrote:
> > However, I think this can happen in any machine with 2 identical
> > PCI devices, because as far as I know, existing PCI drivers usually
> > do not assume that probe function can be called from multiple threads.
> 
> That can happen all the time and it would be a bug in the driver
> if it caused issues.

Wait, is that true? I thought that would only happen if the driver
indicated probe_type PROBE_PREFER_ASYNCHRONOUS. The default appears to
still be the same as PROBE_FORCE_SYNCHRONOUS.

