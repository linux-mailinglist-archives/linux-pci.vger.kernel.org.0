Return-Path: <linux-pci+bounces-9393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD991B5CF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 06:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D09281FBB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80410224D2;
	Fri, 28 Jun 2024 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="D8GdUb3r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504467FF;
	Fri, 28 Jun 2024 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550092; cv=none; b=u6P1ynsoR7SnptLdq/zyqO6Gykhf09ucYbePdvC8jDmWtx4YAmH8xE8WkXwHM1l+NdLyxKpFwyqMwymhvFMWgjqMGR6B8Gs+L9PbROiP1epNQuNK0MWGz7GfzfKt0xdvX3zTNCrZLRa1J2rNNP6a3xP+GYc6PJ5iBflRo0c3YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550092; c=relaxed/simple;
	bh=HfYfwremNs7nyB+emuM1KJ5DCt7NL31plk/0m7Qnyd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGB1uFBrr1SAgEAOXTjBcFdMbvLz4PkouBYnC/v6aW940UCyCsm7F2v/tQBVgn+p1lvVqR7i5y1qbe/9r1+V7TSo+Sz5tswdXuTQz2VKc4V8JeSJgvciwUd9P1jpKxYVo/5VDZKqWmY2Jy96kQhfbeRRaGgaZBvX/YkPc8eN5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=D8GdUb3r; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719550082;
	bh=ICrtbbo/Rr3JpMXpVIu+Axfy69UgjoXGiFz4s0/41Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D8GdUb3r1uENTAKRfM/6e4uiLkma/tmvuCMcEziFWml1iJ9NSIkF8iODVW/zO+MpZ
	 nHKkdDALkcTi/1cAKbebm9g4wQ3cFqTOlmbVkKFMLVHbvGiWI5LP0Lx+AxBKBFmaiB
	 6+Se2tDamzLCxjRZyi073lfiTZWycz/kK0SGDpuOAlFv4/75LEIpuwt2hE9v99sKVW
	 lwHaFmirr6klc39ufXRUAqlScOe5BAZtDKqA82rbGHcD/fKeAsQMKV3iJoI8SNO7Ty
	 NMgTYbN4J9lnbnTrcrRGgZTpKCAy7v8lVlshvJFZii9f0LyUwX082zCVzAr2/4Y0cS
	 CHqHD8sU9B5YA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9NGn67r6z4w2N;
	Fri, 28 Jun 2024 14:48:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shawn Anastasio <sanastasio@raptorengineering.com>, Krishna Kumar
 <krishnak@linux.ibm.com>, npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, bhelgaas@google.com,
 tpearson@raptorengineering.com, oohall@gmail.com,
 brking@linux.vnet.ibm.com, mahesh.salgaonkar@in.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
In-Reply-To: <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-2-krishnak@linux.ibm.com>
 <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
Date: Fri, 28 Jun 2024 14:48:00 +1000
Message-ID: <87msn5llkv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shawn Anastasio <sanastasio@raptorengineering.com> writes:
> Hi Krishna,
>
> On 6/24/24 7:09 AM, Krishna Kumar wrote:
>> Description of the problem: The hotplug driver for powerpc
>> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
>> hot-unplug/disable the PCIe switch/bridge from the PHB.
>> 
>> Root Cause of Crash: The crash is due to the reason that, though the msi
>> data structure has been released during disable/hot-unplug path and it
>> has been assigned with NULL, still during unregistartion the code was
>> again trying to explicitly disable the msi which causes the Null pointer
>> dereference and kernel crash.
>> 
>> Proposed Fix : The fix is to correct the check during unregistration path
>> so that the code should not  try to invoke pci_disable_msi/msix() if its
>> data structure is already freed.
>> 
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Gaurav Batra <gbatra@linux.ibm.com>
>> Cc: Nathan Lynch <nathanl@linux.ibm.com>
>> Cc: Brian King <brking@linux.vnet.ibm.com>
>> 
>> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
>
> As with v1, I can confirm that this patch solves the panic encountered
> when hotplugging PCIe bridges on POWER9.

Was the panic reported anywhere? So we can link to the report in the
commit.

cheers

