Return-Path: <linux-pci+bounces-9982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C692B08C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E05D1C216A1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D161474A2;
	Tue,  9 Jul 2024 06:50:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EF142E7C;
	Tue,  9 Jul 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507800; cv=none; b=sFeUVff6V7xtlsLOULfPLyiibBs2WeSIhmd2Fwc3zkDyFbU1yYReY5rIX+jxu8XDta+oA+s7JuUDJss+AahGB7HQYup8RYiqAfHdbjTf/zSsSzg58F9NwM4yLbNs/pVYnmZHJ3NeJf3igvtJai6QGsgJBDVzFaycj4Qnf3YMmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507800; c=relaxed/simple;
	bh=oK26MeuwQ1MFCnNuoz/pidSKdLW6v7Z0iBsPecYmL08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t0oR9KqguUO+uczjFZksvg4o4Z9zuZOZabYlhNw1x3ZIixsNtUu8cBsCHPuynSyAt6qb2PZDWXFAhDkcY04oTu6LqidXFcHLu4bepldHdPwGDk7YywecDOuKwsHVtTl7o5mRvGtWtNY/c0H/irjEGc7IWxp/o0zvp/CYIC9T5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJBSJ0k2hz4w2M;
	Tue,  9 Jul 2024 16:49:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, Krishna Kumar <krishnak@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, brking@linux.ibm.com, gbatra@linux.ibm.com, aneesh.kumar@kernel.org, christophe.leroy@csgroup.eu, nathanl@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com
In-Reply-To: <20240701074513.94873-1-krishnak@linux.ibm.com>
References: <20240701074513.94873-1-krishnak@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] PCI hotplug driver fixes
Message-Id: <172050773908.27948.6452109648223872879.b4-ty@ellerman.id.au>
Date: Tue, 09 Jul 2024 16:48:59 +1000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Jul 2024 13:15:05 +0530, Krishna Kumar wrote:
> The fix of Powerpc hotplug driver (drivers/pci/hotplug/pnv_php.c)
> addresses below two issues.
> 
> 1. Kernel Crash during hot unplug of bridge/switch slot.
> 
> 2. Bridge Support Enablement - Previously, when we do a hot-unplug
> operation on a bridge slot, all the ports and devices behind the
> bridge-ports would be hot-unplugged/offline, but when we do a hot-plug
> operation on the same bridge slot, all the ports and devices behind the
> bridge would not get hot-plugged/online. In this case, Only the first
> port of the bridge gets enabled and the remaining port/devices remain
> unplugged/offline.  After the fix, The hot-unplug and hot-plug
> operations on the slot associated with the bridge started behaving
> correctly and became in sync. Now, after the hot plug operation on the
> same slot, all the bridge ports and devices behind the bridge become
> hot-plugged/online/restored in the same manner as it was before the
> hot-unplug operation.
> 
> [...]

Applied to powerpc/next.

[1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
      https://git.kernel.org/powerpc/c/335e35b748527f0c06ded9eebb65387f60647fda
[2/2] powerpc: hotplug driver bridge support
      https://git.kernel.org/powerpc/c/20ce0c247b2500cb7060cb115274ba71abda2626

cheers

