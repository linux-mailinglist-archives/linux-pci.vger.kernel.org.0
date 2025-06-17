Return-Path: <linux-pci+bounces-29947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DCADD629
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660D12C4698
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F882E54D9;
	Tue, 17 Jun 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="fodlhOZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FC1A2632
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176987; cv=none; b=WOLYxxTUQeU+PDzCHVmptVkRfE4UDobPMH8vfzkXHBPSnayrNV+gZKrJSZpp3eSIZpYVlolWr5YM+f4BMQbWCrrSBmMKCd0qrYkZKqPKGZqNVPTRj91Z+vr7+rGLma7JvqwdlFUggOwcMmt3N0uGHgwDXvf67Iy/m80GPZoAB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176987; c=relaxed/simple;
	bh=tXVLViBoyIkBkr/3Jx42A0yxOtW+jyVmSWc3detDxV8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hI36KvcNRZIyxW4jIKzPzNQisllvLiZ9Arqc7R6qEmXe4laTh4JjwHXis+lX2K5Lf/ICfP1pMSCS6qAnXXTq5yJ7cwM5pcQvDSbglTdeDM11Wu5djkpxV6aYAU9kGkx2SoUAL6dIhgkSDdBFFvLu4BVC4FgM8FwJ7X359Dll41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=fodlhOZZ; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D392B8288DB2;
	Tue, 17 Jun 2025 11:16:24 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4ERCxKvt3Qrf; Tue, 17 Jun 2025 11:16:24 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 01F308288C59;
	Tue, 17 Jun 2025 11:16:24 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 01F308288C59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750176984; bh=cX06GwlLMww3MyZFmLLFEQH4I2gcuBa1AAiBsj362MI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=fodlhOZZe7HZSSF7Pg5ktbeSNHb0JyWrCWF8x3IZUMxHlK9yj/DHjOerk/uwIkoB8
	 NMHYqOS5vSS+xAeGfAdg2i/HTrBu7X+z6k6L6s1oHfPfhqLNs6JGItOKHyAnDFoheE
	 kXll4GqHu+CWtlywjVVkypubKBwI5RAMfR5J+kxU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bgM6KWG3rVLy; Tue, 17 Jun 2025 11:16:23 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C9283828594F;
	Tue, 17 Jun 2025 11:16:23 -0500 (CDT)
Date: Tue, 17 Jun 2025 11:16:19 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>, 
	Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <699078203.1309081.1750176979904.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>
References: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>
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
Thread-Index: Tf5MFWbY9QC7+aSYgQMp7TPgJM6ygEAOFw9L



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
> To: "Bjorn Helgaas" <helgaas@kernel.org>
> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Tuesday, June 17, 2025 10:41:58 AM
> Subject: [PATCH v10] PCI: Add pcie_link_is_active() function

> Add pcie_link_is_active() function to check if the physical PCIe link is
> active, replacing duplicate code in multiple locations.

Note I have re-added EXPORT_SYMBOL here, since on further inspection it looks like we need to export the symbol after all.  The problem is that some hotplug drivers (pnv-php in particular) both a.) need this functionality and b.) may be built as a module.

I think we should still keep the definition in the PCI include directory, but the symbol itself needs to be exported.

