Return-Path: <linux-pci+bounces-9348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321A91A076
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9F1C213FB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6609446D2;
	Thu, 27 Jun 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ChAqsot"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D033EA76;
	Thu, 27 Jun 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473623; cv=none; b=ajiP6EL6DuYxG484aQsaVnChakJ9GzKYfa41uRsqIHBpQKoJEp4f3VumazU9ckPvoavgg3cERoPRLWsZqYQE7fcGHjPEeNBqm8UAXGAOSOVfuuK13tBwZiA9flmzjHx1xg74JdzCl7JvIHjzGSpuvqlEM7AqpJAelDFTHBwfBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473623; c=relaxed/simple;
	bh=AXkADuPMSoCGWGDjCF6MSGBYc1hPQN3qm0EvaCnyVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIzRM4OfmnXwlrQy3WNxPCSOtXN4yHZ4Hv/VQP3JslMR3WiWIM0xZDzS6LHlo5ExHmBrWLOBvbVA4UHX4zWY8wyPwa1cIGEfe/PG1WLqTJgage/THcA0j+s+wnWOR6D0LB7HT/LSgds2P5/iK21v0coilhdAV6n0xk89H7MLpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ChAqsot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E8EC2BBFC;
	Thu, 27 Jun 2024 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719473623;
	bh=AXkADuPMSoCGWGDjCF6MSGBYc1hPQN3qm0EvaCnyVcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2ChAqsotZOcEgcW4yEMpz/BzmiZX1vLBcZC0r7f5yZBjh+17sRobTd6XOuDjaVvzB
	 bQIeypo868/3JUC7hXEmb10acTtqecVuMDvWkjPhIVvZuFbRGyd/+71EE3hyvAOQMJ
	 uulv/A8YcSqUOtdJQzeB21raT6Js2xpcM6ImILz4=
Date: Thu, 27 Jun 2024 09:33:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <2024062732-correct-dwindling-b53c@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
 <2024062010-change-clubhouse-b16c@gregkh>
 <ZnSeAZu3IMA4fR8P@cassiopeiae>
 <5d7b22c7-de22-4a8c-a122-624afc3d12f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7b22c7-de22-4a8c-a122-624afc3d12f1@redhat.com>

On Wed, Jun 26, 2024 at 12:29:01PM +0200, Danilo Krummrich wrote:
> Hi Greg,
> 
> On 6/20/24 23:24, Danilo Krummrich wrote:
> 
> This is a polite reminder about the below discussion.

I know, it's on my TODO list, but I'm currently traveling for a
conference and will not have time until next week to even consider
looking at this...

greg k-h

