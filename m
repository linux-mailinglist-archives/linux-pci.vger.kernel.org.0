Return-Path: <linux-pci+bounces-29969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F8ADDC20
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1EA1940960
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EB215073;
	Tue, 17 Jun 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="JsLGOubC"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4C202C48
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187964; cv=none; b=i1fvs8/smtRpsfUBZ3LFEufsyJFSBAZXIxoYVDaGxMIpjyQglm6ULwKWbEo9mumEamHhmnI9N6hwvX+gbeOtX248dObUPYnJ0DwcUVuHqDLWSvLtSDCXaNsaOfR/SpSPqrFte2AEk2+FOKpBGxlpKsC4R5Hgt12/h+YUCtt15Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187964; c=relaxed/simple;
	bh=B/DgyDKfqbfcDcoi9UQhQClJle+7HI/+h6F/KE7cpgM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SpvQ3keZyXHGfLMD43SflVFYwE5I/OASnoFfrbayPQD9Rc928pHz+2uUVO0wRcI2mhqcxkdkDhxBkupaY5RNMLZUOGGyPHdUJiO12kQhS4kpAgBji7Cha7JBSALI3+9I0TYA0kLbyV48W0N1JSBmrzfdPM8Zxftvgu6cmMQepWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=JsLGOubC; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9F86A828526C;
	Tue, 17 Jun 2025 14:19:21 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id oYHv3Gfn5ztB; Tue, 17 Jun 2025 14:19:19 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0FCC48282708;
	Tue, 17 Jun 2025 14:19:19 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 0FCC48282708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750187959; bh=X0MxCZnjred9IGWNQTgg/FkN6eQuJT4tsoqOuAyhFtw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=JsLGOubCbeHBszz7kFKwOi/jQG3+j5MQGGBmnZ1kvPP0jyAumr6vX+ko8g9lrY0iM
	 sLJHgsTimvyaBxhnMt81W84nMC28wIHi2Yca1NtU2BENvFfRArH4GRl+1igoBupzku
	 9Wp2bsq6Ighf4+oHtqJTnA4sKFPSuz3xSZc63Le4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3zgwQ6apvWpf; Tue, 17 Jun 2025 14:19:18 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D418C82854A7;
	Tue, 17 Jun 2025 14:19:18 -0500 (CDT)
Date: Tue, 17 Jun 2025 14:19:15 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>, 
	Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <1129057878.1309277.1750187955867.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250617185938.GA1144445@bhelgaas>
References: <20250617185938.GA1144445@bhelgaas>
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
Thread-Index: uJ96gK0vJrJuPZ1COzQfPmIZavdkJg==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Tuesday, June 17, 2025 1:59:38 PM
> Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function

> On Tue, Jun 17, 2025 at 11:10:50AM -0500, Timothy Pearson wrote:
>> ----- Original Message -----
>> > From: "Bjorn Helgaas" <helgaas@kernel.org>
>> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> > Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>,
>> > "Oliver" <oohall@gmail.com>, "Madhavan
>> > Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
>> > "Lukas Wunner" <lukas@wunner.de>
>> > Sent: Tuesday, June 17, 2025 11:04:28 AM
>> > Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
>> 
>> > On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
>> >> Add pcie_link_is_active() function to check if the physical PCIe link is
>> >> active, replacing duplicate code in multiple locations.
> 
>> Will do in the future.  There is some urgency on this overall
>> patchset as we have had hotplug support broken for many years now,
>> and it's causing continued problems on customer deployed machines.
>> While we can continue to point customers at the patchset and have
>> them compile their own kernels, patience from our customer side is
>> wearing a bit thin for that.  I will continue to try to push this
>> forward (along with the associated ppc patch set) at a more
>> reasonable pace.
> 
> Apparently this got pulled out of a series where the urgency might
> have been obvious.  As a standalone patch, AFAICT it's a cleanup that
> doesn't actually fix any problems.
> 
> Bjorn

Correct -- my apologies for not making that clear.  The original patch set for ppc (PowerNV) hotplug fixes was blocked on this pending patch by the ppc maintainers -- logicially it makes some sense, but I can't really submit a series that requires both groups of maintainers to approve.

