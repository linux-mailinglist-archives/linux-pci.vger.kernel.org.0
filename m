Return-Path: <linux-pci+bounces-31648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4000AFBF87
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 02:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2423918820AE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6B1DF979;
	Tue,  8 Jul 2025 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfhaPboN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C171DE2A1;
	Tue,  8 Jul 2025 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936032; cv=none; b=eMOb9dEV1L1juLEJZAieK8MG1BGUs7JkUDaQQ+55ymWJH1eTglP5klRWyB/d388QEIw7EoKjo6HxCUYeV2NLOgPglvnxZB0JJrWeZGlYOG6kXecNOo/oFjcFi2IVVCgeybD8gU2S7e/Ry37HtQfpGnECW7if3OcJU8bUheWmWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936032; c=relaxed/simple;
	bh=R0Rfn1gEkb8zr7Hk0zFA6FBpDchse11EXzp7UHqe1KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnZhYeBYNgHYWzHH56Sm4YCrsZrLqPgCe6Z0R+PbTUVTuOS4phDLUg/IfzuhJJM8hRsx9WE8krffAfsKnMOF/sOttY7XLDOjMLWTZ7cv1RGld3H66YVJpON788fTqD1TNwn9Bgp4lO6IkYfEfRDXj5hXj7BvopzRPj9TePomOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfhaPboN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C99CC4CEE3;
	Tue,  8 Jul 2025 00:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751936031;
	bh=R0Rfn1gEkb8zr7Hk0zFA6FBpDchse11EXzp7UHqe1KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LfhaPboN/GUzDYTFs3wdrnabtQtZ59mk3Cnu+8ft2/TaJeQkzSAmDWCrWhoIrXJTQ
	 JZXJNSeI8EApVvkc5BnHnUSQevUY7R1eaR6aKcdnaVzKCTc3aGmr8Qy8Ko8zAsK8lA
	 PXUHy6UHpovhIdEnmZvC989QH9IwgwZeabXWr8POX9u3/VKmTLJ06LtuSiIm2Pq/So
	 PJKmyPkPap8EH3bGlptwNLdnkcB66yXGTAgWnxcvpfOjDtP12yrIFP0hur5uIWb3KG
	 9OmgytNzB3bLqDgjkUlBfDEEw1vSrQI6MocuhJDK/rIgL9BEtVlO1SjxovUlQGqjiG
	 BZ4OLpS+sQ9cA==
Date: Mon, 7 Jul 2025 17:53:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 ojeda@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
Message-ID: <20250707175350.1333bd59@kernel.org>
In-Reply-To: <20250704041003.734033-1-fujita.tomonori@gmail.com>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 13:10:00 +0900 FUJITA Tomonori wrote:
> The PHY abstractions have been generating their own device tables
> manually instead of using the module_device_table macro provided by
> the device_id crate. However, the format of device tables occasionally
> changes [1] [2], requiring updates to both the device_id crate and the custom
> format used by the PHY abstractions, which is cumbersome to maintain.

Does not apply to networking trees so I suspect someone else will take
these:

Acked-by: Jakub Kicinski <kuba@kernel.org>

