Return-Path: <linux-pci+bounces-9408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD7291C67F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858351F2453E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A06F2E3;
	Fri, 28 Jun 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="J9J+1Jcl"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F254662;
	Fri, 28 Jun 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602561; cv=none; b=BcWVqaMrJeAf0TYxNlMO72EqUMOpdS1ZyZ/yrwLg8sYClv46NHiyhPnAxy3GD3cURstoBfMStC0S+3oSeiW4nVkkHgoea8q3yBmz+nIvK9zWyAwBOUxnR+qvSnd0OkXpUJcNhuDdQuwQoTN33OMHs7oU1YiVWtSmCO8t0Q4UC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602561; c=relaxed/simple;
	bh=z9mwhIs7kc5ThmyZamPZWNRPp29xwFYri3CgZHaAnt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4xSVTF3edqSR7rHLHsaq9PwEf+TBB+1U0QCf3DtmJrbUhBSOyQtpmVp+EzAU4PXTkT0NE/m0WFUL3DtBndEXvssBCDc3aXqNla2xifPOt6EVT00H30jvP8n4x9udId4+aS1edqEIWvXnndg+yqHF/ZvCbVSlOTIU66XUJDOQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=J9J+1Jcl; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A770382856E8;
	Fri, 28 Jun 2024 14:22:30 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kYq99xce2zDs; Fri, 28 Jun 2024 14:22:29 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 115648286190;
	Fri, 28 Jun 2024 14:22:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 115648286190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1719602549; bh=z9mwhIs7kc5ThmyZamPZWNRPp29xwFYri3CgZHaAnt0=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=J9J+1JclBTJ2JMplLLSn6P2AZQmJk9+zTeu+RAjbOgezjH2sSX7mv6yITqatH04Hv
	 JP5sFJYpklwrhsCIL95tMrvuUwA3jPDM2BRVpGpIPGvZMsM9E9jGpZji6rkGSu4DoR
	 GqQ5yhrks6pa3K+yYhNET+4WhehhSoo0/XrVb6UU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VDjqBFv6Fbqf; Fri, 28 Jun 2024 14:22:28 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id 9D62982856E8;
	Fri, 28 Jun 2024 14:22:26 -0500 (CDT)
Message-ID: <76a154af-bd69-44f4-a6d8-e569b0890878@raptorengineering.com>
Date: Fri, 28 Jun 2024 14:22:25 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
To: Michael Ellerman <mpe@ellerman.id.au>,
 Krishna Kumar <krishnak@linux.ibm.com>, npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, bhelgaas@google.com,
 tpearson@raptorengineering.com, oohall@gmail.com, brking@linux.vnet.ibm.com,
 mahesh.salgaonkar@in.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-2-krishnak@linux.ibm.com>
 <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
 <87msn5llkv.fsf@mail.lhotse>
Content-Language: en-US
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <87msn5llkv.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/27/24 11:48 PM, Michael Ellerman wrote:
> Was the panic reported anywhere? So we can link to the report in the
> commit.

It was indeed -- here is the link to the thread from last December:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2023-December/267034.html

> cheers

Thanks,
Shawn

