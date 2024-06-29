Return-Path: <linux-pci+bounces-9432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B447591CB81
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C868D1C218AA
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B941D54A;
	Sat, 29 Jun 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UM9dRey6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D583D69;
	Sat, 29 Jun 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719646224; cv=none; b=YQBQ1vtGEu5s7bJJ2eRi0wm7dz/BanJqHcxXNuJcM79Uxr43/p4ocmqB5OeDRSTCrMzWX+3cGCjalj1SirADv+HcQ4HcVmqbkoJw9Ix1dk8j1EQNyJ05uDFYSyAv4D1TUTYz8A5yZlux2PFt38sIRw2gVFHll4VxVxE86rqHtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719646224; c=relaxed/simple;
	bh=QL/ulRF3WQDUZh0765KisZheh8Z7kRGyVfR1QZjKE0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGOFLMOjRQwAWy5H0DQ9wazTj03jeqbashuC//3heyamxT0lP+TcPzof36IAEOqMLJYGFAxQ05BS+GD32nYsZO7jz4RBVxE/t63V91NEKQpdsgsA/Jxztdb5ihnwuseJSqimaYQgNvmGrFQzsLplihtlyCb6WGdLaaWG9MZp3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UM9dRey6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719646213;
	bh=QL/ulRF3WQDUZh0765KisZheh8Z7kRGyVfR1QZjKE0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UM9dRey6OYS6I3j0jXoaVgyR3dKW8lp+23A2Qys7IHzs8rnBzw8pe5v9kofWowwyN
	 sXYtVBTn9XUe4WUNNwdnK0jJw5y3JceECvcCT9Hg3NR+7T6V1tdEidNZUbk2p68i80
	 w9G67/N3wkquXFKoJNlOQdJLTpKnguw9fexo8LNYoTxlZG2qeina5jRGev7VitRAxt
	 GdItJ2E5xwsjsxCk08Z5LuGMoa66fyQ8QzJ/ZmMJNMaBhciqUrEuSit2i9l3CJVKzy
	 BCsCOHSOIYyzAxMHmQnP+/iTX4+lQzjgfm/dtPIdgccequb6lcRYgTAHhmTieUCXWS
	 1e2HoFl80vQpQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WB3qS5J2Zz4w2P;
	Sat, 29 Jun 2024 17:30:11 +1000 (AEST)
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
In-Reply-To: <76a154af-bd69-44f4-a6d8-e569b0890878@raptorengineering.com>
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-2-krishnak@linux.ibm.com>
 <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
 <87msn5llkv.fsf@mail.lhotse>
 <76a154af-bd69-44f4-a6d8-e569b0890878@raptorengineering.com>
Date: Sat, 29 Jun 2024 17:30:10 +1000
Message-ID: <875xtskxz1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shawn Anastasio <sanastasio@raptorengineering.com> writes:
> Hi Michael,
>
> On 6/27/24 11:48 PM, Michael Ellerman wrote:
>> Was the panic reported anywhere? So we can link to the report in the
>> commit.
>
> It was indeed -- here is the link to the thread from last December:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2023-December/267034.html

Thanks.

cheers

