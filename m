Return-Path: <linux-pci+bounces-29946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CEADD582
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953EB7B02F6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001AD285050;
	Tue, 17 Jun 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="D1sowHgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D528504B
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176656; cv=none; b=kD9QGOgUoAxRY1o2iiuQTR2Z81nmZkeFKvGXpBDVFt1Ks3yduLSQfuT+1lDpQ7sw7rdtDlVUw6xWbhr7TrwIqVlLpbzYfzkj6oGMXv0LVl9geSx1SZQ7drgSz1p3qSTuX4U5vxx3NFGkoEajguFTKgRuqqJ/+To++rupsJa6QLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176656; c=relaxed/simple;
	bh=JK5DGEavut6ArIbshPfPRgPErsCI1bIW6j04jqNqL7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TNqYNqJGpREaUyKjJDonx9PwmFKSSrMYWa34M1W2PSXK7maKbRPezEkFVntltNBvU7gbzKqR9geZbITTbye9dSG4dz6OEurgDhig6p16vaM8YNay5QFoLPJYqcfA7OBZJGKeCfKxRb2ERX9IIf4MktTTjXFfqu5oo/gb9OyBn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=D1sowHgo; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1D17D8288520;
	Tue, 17 Jun 2025 11:10:54 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0QcpdD3jveUO; Tue, 17 Jun 2025 11:10:53 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4F1D282856F0;
	Tue, 17 Jun 2025 11:10:53 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4F1D282856F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750176653; bh=dscBg2SL47MFJbUDj/NudkQQfRd9NXx3C+bqWpMRBzs=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=D1sowHgob1l+ZqNxhfmEXrTBKYDE/2AO5kDlynfTr8UiFQW2g7ePN5K2CD2xZO4dh
	 I7WoE8hl42eZD6mb4NYXQ58ZYOu1FJOi+4EAQLCRW+rb2qtlppnGMzYrYorrtGLJap
	 F1ly8tJ1wHOn5tI99hbBoXE8+KNOzr6nUV3frddg=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Sh4OuMmRBuqW; Tue, 17 Jun 2025 11:10:53 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 25A058288520;
	Tue, 17 Jun 2025 11:10:53 -0500 (CDT)
Date: Tue, 17 Jun 2025 11:10:50 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>, 
	Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <2085066023.1309071.1750176650554.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250617160428.GA1137986@bhelgaas>
References: <20250617160428.GA1137986@bhelgaas>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: Add pcie_link_is_active() function
Thread-Index: RI55lcd3yNDQU8jas+NZLDIZ75V4cQ==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Tuesday, June 17, 2025 11:04:28 AM
> Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function

> On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
>> Add pcie_link_is_active() function to check if the physical PCIe link is
>> active, replacing duplicate code in multiple locations.
>> 
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> 
> Whoa, whoa, slow down.  This doesn't address all the things I
> mentioned (EXPORT_SYMBOL, for example).  But four postings in 90
> minutes is way too much.  There's no hurry, everybody has other things
> to do, and we can only assimilate a reposting every few days.  That
> way others have a chance to respond with additional feedback, and you
> can address it all at once.

Understood, my apologies.  I realized I had sent a couple of incorrect versions in, and wanted to avoid the known commentary on what was done wrong.

> When you do post an updated version, consider adding a brief changelog
> (e.g., what changed between v8 and v9) below the "---" line so we know
> what to look for.
> 
> > +EXPORT_SYMBOL(pcie_link_is_active);

Will do in the future.  There is some urgency on this overall patchset as we have had hotplug support broken for many years now, and it's causing continued problems on customer deployed machines.  While we can continue to point customers at the patchset and have them compile their own kernels, patience from our customer side is wearing a bit thin for that.  I will continue to try to push this forward (along with the associated ppc patch set) at a more reasonable pace.

Thanks!

