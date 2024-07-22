Return-Path: <linux-pci+bounces-10596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DA938E19
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9BBB21310
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696A16C861;
	Mon, 22 Jul 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9LlwmJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1C16C6B1;
	Mon, 22 Jul 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648120; cv=none; b=SOMj9rONI1S7oUZtPFDxGRtFYbtk/IKuIjMKsXxxO41UWcx29dkTtxPw251qpUDnpqDdSrmmfVo874WsnmJNs7SCv5YCPKRiJAbe0qccAM7+baomoBX4s0Xq8yZzr0C5r58w68hvIBtu8g6umwlGkQzFZwcuHi+ZaG/8ulzM2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648120; c=relaxed/simple;
	bh=DBjd/Zd395Xdm/ww2bc3JNLn30z2+FV1MkY+h8DEbMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBsfjouEIf8+8wbbY5Yj2zkKHVfY6hhZ7zM0Todq/EDwfDNytjGMc4Zy/ClqkKuW82q1mSolDDjQaV7ybCZUsTdLCArYI8pEXiKvBtYKuD+6Je4Otvs+1OtE5rNl7nxolFwHbhp+Wt736LTbVgY0klg0/dmIdgZXBbp/nx++0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9LlwmJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB68CC116B1;
	Mon, 22 Jul 2024 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721648119;
	bh=DBjd/Zd395Xdm/ww2bc3JNLn30z2+FV1MkY+h8DEbMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9LlwmJEWlbkoe849Z8X0FBzAAUopr5JDTK68vRXyE23g4rbtzhORqFyy6wcVZ/Oh
	 u1VQt3/nTYE5FvwL0bgM5j/Y0PgXsZ0QhWJ5+aSmqwEZ3BZ8bZYcVKNoC0YzN9mYhp
	 OlITjCbsNUAAn0fleOhS2VlpQpWP8B5ZuGawdnOs=
Date: Mon, 22 Jul 2024 13:35:16 +0200
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
Message-ID: <2024072201-earshot-surname-3654@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
 <2024062010-change-clubhouse-b16c@gregkh>
 <ZnSeAZu3IMA4fR8P@cassiopeiae>
 <2024071046-gaining-gave-b38f@gregkh>
 <Zo8-IZgJswTlyP8H@pollux>
 <Zp5BLRRwRBCP-QDv@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp5BLRRwRBCP-QDv@pollux>

On Mon, Jul 22, 2024 at 01:23:25PM +0200, Danilo Krummrich wrote:
> On Thu, Jul 11, 2024 at 04:06:25AM +0200, Danilo Krummrich wrote:
> 
> Gentle reminder.

It's the merge window, sorry, will be back after -rc1 is out...

