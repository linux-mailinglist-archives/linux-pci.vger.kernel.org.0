Return-Path: <linux-pci+bounces-43512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A6CD5493
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1819E301A1C5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0A30FF2F;
	Mon, 22 Dec 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ct5e2TCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D8310627;
	Mon, 22 Dec 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395039; cv=none; b=NkrBxLEqTtBqGCei3aav6EpU00D3WAJLQ50EHqusQzj0TtzpPjeootiQ93iSHYpyxHlMxYHNjXt/l++8u/S3ejX4uNwyVrF8SBvuKLa0/8IGG+j35olW41YooiaJMcNqPaGRO/8xt1mM0MI/qua24JZq9dPL3woo/h57KIeLNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395039; c=relaxed/simple;
	bh=haGYfWEE4ITTLcKZrPLgnQG4wcaylMYFMQEgW1F4h1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoSNr82Mg738xvHVY9gkuV4jitG5lY7ym8DocJESfDgxWUCrTdbrdpGCrC+m6AYspPcjJa71NwbOcv3vH9z8otWjHtDUxT/sUluh1A8IaSUsHOCsLFOfCeNOO9GjB2BGkRDkkhN4kLgjwqwEp0B5BDQW8YBPRTOiGZaBeu/E/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ct5e2TCT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bb
	DoEgPvTgvABo0pi1IsnoAMMPYLIP6q8/LQxErVjn4=; b=ct5e2TCTcqV3O20tRv
	77IsAnx1GzJtaVpI5DLC13TYYmaKc9fV47RG+7TG1hXURIz8ZUCj5GHpetlzPKYV
	2xDRypiCEqVVihfht7MH4Bhzuyqj2h7RUxhPvGdYtw9bZgZY7MFD+Lwsj5snWAfr
	V9w2JtdpDyygYt/YUoLMeQqHU=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3JqBFDElpDqiJJQ--.24692S2;
	Mon, 22 Dec 2025 17:15:50 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: dirk.behme@gmail.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	buaajxlj@163.com,
	dakr@kernel.org,
	gary@garyguo.net,
	joelagnelf@nvidia.com,
	justinstitt@google.com,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH] pci: provide pci_free_irq_vectors() stub when CONFIG_PCI is disabled
Date: Mon, 22 Dec 2025 17:15:49 +0800
Message-Id: <20251222091549.2333017-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5521e98b-e12d-4af1-adcd-2dc56863f90b@gmail.com>
References: <5521e98b-e12d-4af1-adcd-2dc56863f90b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgA3JqBFDElpDqiJJQ--.24692S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJw4DAw43Gw4UZw1DWFWruFg_yoWxXrbEkr
	sFkr4kWw1DXr1UGa1DtF9Ivrs0qFyDCF4F934jqF13G3W3Jw1fGan3Wr9xWw1aq3yxtrW2
	ka15A39xXF4IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUubyPUUUUU==
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbC5AfA4GlJDEebSQAA36

On 22 Dec 2025 08:02:44 +0100, Dirk Behme wrote:
> On 22.12.25 04:44, Liang Jie wrote:
> > From: Liang Jie <liangjie@lixiang.com>
> > 
> > When building with CONFIG_PCI=n, clang reports:
> > 
> >          ....
> >
> >  /* Include architecture-dependent settings and functions */
> 
> We have this from Boqun already
> 
> https://lore.kernel.org/rust-for-linux/20251215025444.65544-1-boqun.feng@gmail.com/
> 
> ?
> 
> Dirk

Hi Dirk,

Sorry, I missed Boqun's earlier patch:
https://lore.kernel.org/rust-for-linux/20251215025444.65544-1-boqun.feng@gmail.com/

It addresses the same issue. Please ignore my patch.

Thanks,
Liang


