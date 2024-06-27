Return-Path: <linux-pci+bounces-9384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C193091AD73
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9DB2822CB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91021993B6;
	Thu, 27 Jun 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="tm27XbhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746E199E89;
	Thu, 27 Jun 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508114; cv=none; b=a0DJgDTmYOYPDnyQms0zu7hhW3CaIA+h7Pi9AMHDj/Ltb8AoRhMQudoUaK1BYBYwl3JCBS8QPyGb1v3X0IS2twk5dGVXt9Dho3y0ZW/y0CCE+KhxKUkfjipbx1qtyMTLALl9l4M700pXTex03uVRRqVi8iWirTx6+Wsv57dAXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508114; c=relaxed/simple;
	bh=gQjYhOI02FdcEBRinNKiAlBL2XjmR+KPxp9hT9vWYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijKjd7gEu65yIcJ3R9e/Hv+jxS2D6iYbbd5XmkXgBT0XXKeyFt2cz1gn4gYfXRCuJIuGO0ZrvwY2UJlE7TzqUTvDx0wJZiRYbf5aeaDT7BcHhbKRl/JNFJWXrN+B7AV6c0ERbVGQ6qlv1BOuuTNunvrVXcVrtccVWM3IJNjpjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=tm27XbhM; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3DAFB8284676;
	Thu, 27 Jun 2024 12:08:30 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XdB8CVZdFTUe; Thu, 27 Jun 2024 12:08:28 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BEE9D8286EE7;
	Thu, 27 Jun 2024 12:08:28 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BEE9D8286EE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1719508108; bh=7vozx5pnO3XeEM4yE1MwWuRfVdToNevzVg4mxSfCvKs=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=tm27XbhMcN3WAhiovueooUXESqDRJygPFvjey0yPzTGBNLnBlvOAaQQZNRgtfqHhj
	 vybHcwIWpDcvpBSdZAXa92+dyH8B10GyrcT3FSBaytfWcap2Z69m67d8Wbj7Ig9Z61
	 PvObo0h12TozzbGaSm+u0ledIX8Ng7XYHgt5wOZs=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jX-fwQJ2VSlB; Thu, 27 Jun 2024 12:08:28 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id EF00F8284676;
	Thu, 27 Jun 2024 12:08:27 -0500 (CDT)
Message-ID: <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
Date: Thu, 27 Jun 2024 12:08:27 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
To: Krishna Kumar <krishnak@linux.ibm.com>, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, bhelgaas@google.com,
 tpearson@raptorengineering.com, oohall@gmail.com, brking@linux.vnet.ibm.com,
 mahesh.salgaonkar@in.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-2-krishnak@linux.ibm.com>
Content-Language: en-US
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <20240624121052.233232-2-krishnak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krishna,

On 6/24/24 7:09 AM, Krishna Kumar wrote:
> Description of the problem: The hotplug driver for powerpc
> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
> hot-unplug/disable the PCIe switch/bridge from the PHB.
> 
> Root Cause of Crash: The crash is due to the reason that, though the msi
> data structure has been released during disable/hot-unplug path and it
> has been assigned with NULL, still during unregistartion the code was
> again trying to explicitly disable the msi which causes the Null pointer
> dereference and kernel crash.
> 
> Proposed Fix : The fix is to correct the check during unregistration path
> so that the code should not  try to invoke pci_disable_msi/msix() if its
> data structure is already freed.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gaurav Batra <gbatra@linux.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Brian King <brking@linux.vnet.ibm.com>
> 
> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>

As with v1, I can confirm that this patch solves the panic encountered
when hotplugging PCIe bridges on POWER9.

Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>

Thanks,
Shawn

