Return-Path: <linux-pci+bounces-16967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8D9CFF42
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E76B25B17
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA279F5;
	Sat, 16 Nov 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="f9poJhrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4OCLt9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8FD53F;
	Sat, 16 Nov 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731767567; cv=none; b=jRJPeOeJLJhx+4XiPBWwBAovmHeRR37aJFqaoQIOZ8Dyz1P5lPukdWznCYP7YrHzc+gWZbVVZ692ys2oNSU7ACvRXfZ6J3q3++jt3HT9fgtosWnb87YvyJR9Z9h6BpEfztLFa9WyQqjSzVQ9T44OaX/RAcGT85NnsAZ97m11LG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731767567; c=relaxed/simple;
	bh=Qf1YtplSqboVrrQeSa+gApRr86YTzv1m+laATy0yACw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahj1qaSove5I2wEdJ9u5gD3VD4qbYWn73DIW7zIY0qjmbVsu8HElfZA+XJS6GvNXP/1asp0VRXfRiUa3/taq2KQs6ogYERnYlIzOAdY/zlnjYp2HYBPmQlY7xEWbsVK73shGpQCgCR2LiGwtBMNrdf6s7CVnFXylywKqXt2sFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=f9poJhrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4OCLt9e; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E1A213801CA;
	Sat, 16 Nov 2024 09:32:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 16 Nov 2024 09:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731767563; x=1731853963; bh=MoWHSBImfy
	kRca31mkake2h91ckcx0gjiNgQduzFP54=; b=f9poJhrvgBmc+nEAuEnws3V3cG
	Fbf1oEbXoDgrP0dVvIUWlkKfBuDcFz68o8epnXPVsL8Y/iAJxHS8+fOanHrrPcCD
	mhuacUlbIc44xvXvnbgQXBe9HXrU8dbeDnjm3lX85twBSAbPlPVSyWx9kLNjXrhL
	4FGkDIfrDVMHqpBeLyYim2IS0DYiiKHGeB22ffLd0vHsfHUvAPNraaxj5kTTIcj8
	OOP6pBvsqumJPwjNcLE3XzH9i5YqTz8iwLc1PdLV9QudosqO0e9AYUnXEw1YzvFi
	pj7QpqnQt/qa5TG1Ka1vxAsspO4Rl6Y1eSGGMN5/3+/GW0B/L4u+aSm29Mww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731767563; x=1731853963; bh=MoWHSBImfykRca31mkake2h91ckcx0gjiNg
	QduzFP54=; b=Y4OCLt9ezShbISTXv+1QZudz9h8a59Z9UW9Q/gIA5alJrVKwnDR
	XQLJWtoI7D7UC/qLEtM29PwmeR36H7FztxMZvm14cBoanutWxlj9rvswhaQg+qHU
	VPSAQgy6QzlqtLfe4+6/2dnFUOHCV5EjagkxzhU5TA2eMzL1RdXXE2narLbfzsrI
	qc+hc2Y1wyCuj0M54p+H3cdNSoaLGye/+zJzE0BvyaaQc5lbseLNtSCxVN0hTfrU
	68fjmXDtBKL4QiXV1ZI0CTIg6rlJrr8yHR0yIHfMzX8k5rWTWY2VOBwy7xZrC9N8
	iSY8SfNlg1Fty+UuHv1znfqwhuvnWWqLYhQ==
X-ME-Sender: <xms:Cq04ZyOKji-4pI8hx6pJJltp96UBMvVKeSXu03m2TjRERmO4m2kpmQ>
    <xme:Cq04Zw9fBkoo8ZTJ8e5WR-17gDQGKi5dZsrwvIyVqzpOjVV-cwTzB3F2qflGjlT0I
    wWAhme2ajbXd4TC1ds>
X-ME-Received: <xmr:Cq04Z5RLUtk4ex1CG0bgSSiyI8L6FcKvej7ysYvU2vY0YIVbDj9dknqg25lHfOt20An9NI_nISMai61o3RITMhfnRUZdXeRrVe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecugg
    ftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudegtefh
    uedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedvjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghsse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Cq04ZyuSRMGiRDET4GjSh-DZWmojqbdLgnVCGsAb4YjTB_eEL7-cHA>
    <xmx:Cq04Z6eibCtRYLVxf16cOaPpU7CZ_SVNHp1L4mLhJq4RZLv_xjJnKw>
    <xmx:Cq04Z23nPVwBImd73lhnHE9rfcn1EoWrKLwniePvGneAiLX1gi5WHQ>
    <xmx:Cq04Z-8IYTVTJF2xfoXZcm9ukKQYMJcmPK1YaH1FkGx_nbZujxG_zA>
    <xmx:C604Z7NO8WXzVMxwZP3N3gLb0z4RYZF7dKTDmp4e0ysp-VB3n7Os-Yiu>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:32:41 -0500 (EST)
Date: Sat, 16 Nov 2024 15:32:40 +0100
From: Janne Grunau <j@jannau.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <20241116143240.GA1490760@robin.jannau.net>
References: <20241022213221.2383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:37PM +0200, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].

A rebase of the asahi driver onto this series still probes the platform
device and the driver works as expected.

Feel free to add
Tested-by: Janne Grunau <j@jannau>

We plan to import this series for the Asahi Linux downstream kernel
starting with v6.12 and replace the old rust-for-linux Device/Driver
abstractions with this.

Janne

