Return-Path: <linux-pci+bounces-32341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A1B080C7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDECE4A2DFF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE12EF280;
	Wed, 16 Jul 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqwE2//n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288871D555;
	Wed, 16 Jul 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706741; cv=none; b=dbANFb8qlWlgmmt0X0zYdEh+UbdKZm9O5dx5CcBlitQDSj4AiJbi01I4J06yBXbPNMLqfss9VN7cxOyOAWDut4XELyE0pYsh52cdZVbxxTCELNB32oQ9o7j+kwl0mKbo87+BFeat6/E8M1yte2Ckf5nDtVs0bV6oxMyZfCkXH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706741; c=relaxed/simple;
	bh=0dkzby8hdqpTEYrx4v2fUKiDbSXRJB+rFnnph5DXf3g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=t5OgIdCfRjq82VAY7/nuwizbFVZD0Zb2wx8jHui+1LSV1KpOuaUE2qIRxTnZM8r4ECsROL7sv0VVxmmUnZ2vehIlaXVbnR/ixcw+TLzXf+dFmEnqgBf6H+Y575d0XOuHSWJ6LeQLcinQed9guBdIsN4LhLaJmDmRbZQ66rf3i5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqwE2//n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD12FC4CEE7;
	Wed, 16 Jul 2025 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706741;
	bh=0dkzby8hdqpTEYrx4v2fUKiDbSXRJB+rFnnph5DXf3g=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=CqwE2//naBbFY3iq8URW16L5jkKdga66bMIFfNFJFVFELk9jFQxPzIYH096mnzp1T
	 bDP6tpnsGjbhmqoo1glEZ4q0De3URCBal6mFYFPJun73I00ur8MFJKUGUDsIq2YDLg
	 OdKofq7lr/+iStgHZ1YjNqcgp5RFJSpDrx3c/PRNGPmuqOEAzkAFwZuyJ4iGOgfCXV
	 bLdyRtMkhCf73MrLZttJbYugKxm4cerwA8WM004sJu+BOyeaB55p6/8Wnqs/K1t9GQ
	 4D53TWom2O0uLGuT4+1JiGDDzWhWNCC4kKh+LwF85bhGhOZs2uPWSW5eLQlS1mqPiq
	 YVZINSp0ugotQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 00:58:53 +0200
Message-Id: <DBDUOLUZTQND.3B3B677YYKFSX@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 0/3] rust: Build PHY device tables by using
 module_device_table macro
Cc: <alex.gaynor@gmail.com>, <gregkh@linuxfoundation.org>,
 <ojeda@kernel.org>, <rafael@kernel.org>, <robh@kernel.org>,
 <saravanak@google.com>, <tmgross@umich.edu>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <david.m.ertman@intel.com>,
 <devicetree@vger.kernel.org>, <gary@garyguo.net>, <ira.weiny@intel.com>,
 <kwilczynski@kernel.org>, <lenb@kernel.org>, <leon@kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250711040947.1252162-1-fujita.tomonori@gmail.com>

On Fri Jul 11, 2025 at 6:09 AM CEST, FUJITA Tomonori wrote:
> Build PHY device tables by using module_device_table macro.
>
> The PHY abstractions have been generating their own device tables
> manually instead of using the module_device_table macro provided by
> the device_id crate. However, the format of device tables occasionally
> changes [1] [2], requiring updates to both the device_id crate and the cu=
stom
> format used by the PHY abstractions, which is cumbersome to maintain.

Applied to driver-core-testing, thanks!

