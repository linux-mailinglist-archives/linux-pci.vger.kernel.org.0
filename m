Return-Path: <linux-pci+bounces-11687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5795283E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 05:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3D41C222C0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BA2AF1D;
	Thu, 15 Aug 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nx1z/6z4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793A1BDDB;
	Thu, 15 Aug 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692032; cv=none; b=Msv9ZS/OzlN0xX/ZbjI+YRXOulBXOrcn6VCpprce1mvQp7+/D/SD2T+mB+VEwiJHV+Q0UcV5AmgrmNHQ42+otpV6FgQfDk4dKn3ZtoqcX7M5LN4Yo/j9xOWUoXDxYafxTRtNy9AOMfXCYzZnSzeDU0STYKFS9bXJwdlZW2ck1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692032; c=relaxed/simple;
	bh=BpPYc4Tihajr/RR/HigJKLrUSFb7msnqHcQi0RKYHXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h62ODO+ENSwfaQgIKZlZelhVQqmRUp0NGvWp9rKppyCmJspcTJ+PIYDpvEtAGneouBgg+QCib649vydnaTI0b5RS97FshLR4bKtudBa4S9PEsTXjxu2j3hx7qUGnnfw1oXXMfXWDyN37pno33ieprfKMT7AbBjwh52gbb5EREyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nx1z/6z4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723692027;
	bh=9heJ5lej0lmzgaMPk+qYVLtyn5V38y1FDbls6T33vyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nx1z/6z45RHAu8+PoDYNG6J4zfHMH/t7JHlIzyjBMY58UDdiAp5GnNgOLaSZwrH77
	 +qIwqMJS4Yslrv1XBPWnLwDgVhTeg6gzGdeFPcHHL3AOEVRVZzKR4+4E2UsJ/NOkjd
	 cVPTytEN8Bz1Z5Z5/oux2/Z8ibioei0xEPUGwGXhUklhMnvXkJBLcIfeRGoLPjr647
	 aPIBx5qROon+XOdmmHMDrLabvL1U+v3avgXNASlNtgbtFJhalqFRaTHQVGrB5ec2S4
	 twYsPLD9YfqJPY56NcdwLyOwPtA4a4gvzyeVUHUpOEkHUCzpAiAqje24tCaZDWSE+j
	 tXznfHA+2Zjfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wkr3X5dtxz4x1H;
	Thu, 15 Aug 2024 13:20:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Amit Machhiwal
 <amachhiw@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Saravana Kannan <saravanak@google.com>, Vaibhav Jain
 <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan
 Srinivasan <svaidy@linux.ibm.com>, Kowshik Jois B S
 <kowsjois@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 kernel-team@lists.ubuntu.com, Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [PATCH v3] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
In-Reply-To: <20240806200059.GA74866@bhelgaas>
References: <20240806200059.GA74866@bhelgaas>
Date: Thu, 15 Aug 2024 13:20:23 +1000
Message-ID: <87h6bm1ngo.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Sat, Aug 03, 2024 at 12:03:25AM +0530, Amit Machhiwal wrote:
>> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
>> of a PCI device attached to a PCI-bridge causes following kernel Oops on
>> a pseries KVM guest:
>
> What is unique about pseries here?  There's nothing specific to
> pseries in the patch, so I would expect this to be a generic problem
> on any arch.
>
>>  RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
>>  Kernel attempted to read user page (10ec00000048) - exploit attempt? (uid: 0)
>>  BUG: Unable to handle kernel data access on read at 0x10ec00000048
>
> Weird address.  I would expect NULL or something.  Where did this
> non-NULL pointer come from?

It originally comes from np->data, which is supposed to be an
of_changeset.

The powerpc code also uses np->data for the struct pci_dn pointer, see
pci_add_device_node_info().

I wonder if that's why it's non-NULL?

Amit, do we have exact steps to reproduce this? I poked around a bit but
couldn't get it to trigger.

cheers

