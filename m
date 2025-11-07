Return-Path: <linux-pci+bounces-40587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE839C40D54
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94676566DC3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51E32ED3D;
	Fri,  7 Nov 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="pb1KkEXj"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F132E147;
	Fri,  7 Nov 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531998; cv=none; b=bXeUeUaDXC15T1Tg55kYryYg4D3dl7WHGzNNZNgnXXO7jssW3u1+h6B9vfdZHHk38PkB+lRnazdPtZYIBX0nlGI8C0Xp2EAO4P+DMzsTFjUxQ0DcAJCGL8sR/bcVW/JsoEyZgXQeRdnmstOG+oW7rPui/Us2bR5oigpI2jgPOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531998; c=relaxed/simple;
	bh=5Nqh1Cm15+XPj5WliYS/sGVMlMkUi6oRuZu4jad3Ovw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RboC+T5m/89J5nHaLE4WJ6hEvTBbotYhEgMNI/N0bBOvH91XakRMhfjXe4ZJgPspyxKzCsXC78CzDHgcIxAwKobKfPJyrxmyaKCEHWKHneQezpZTkHHgU0nd4cEnymaqFWIO3gewJeDDgJf0rah3l6lk//GHxX/mbz6iiRCdtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=pb1KkEXj; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C283077908A1;
	Fri,  7 Nov 2025 10:07:22 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 21dgOA9Zntfu; Fri,  7 Nov 2025 10:07:20 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BB3857791950;
	Fri,  7 Nov 2025 10:07:20 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BB3857791950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1762531640; bh=5hxGhzBJs6gJa/ASFK5SjIMdAdt+bdzNzMEFXUGcp8g=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=pb1KkEXjGw/I4q36LwOmPSLTVqKvP8AyRnqDq7fubf8C4qeiHO0Nr9G7MGGYHpFqN
	 810OC5KBlUEQX0b/KDvOq7EfTnswx9Du5/x25F9dgecOI7H1EMgMp71s0AHb391kpx
	 DaWsfU7flNSmjb3ywxhFjFqWsa/ocOCaQNQfsNVY=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Npboz4zOJH1J; Fri,  7 Nov 2025 10:07:20 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9050377908A1;
	Fri,  7 Nov 2025 10:07:20 -0600 (CST)
Date: Fri, 7 Nov 2025 10:07:20 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1801829574.18016.1762531640458.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2d00ed57-3c74-492e-83ae-88ca1ce98311@kernel.org>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com> <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com> <bf390f9e-e06f-4743-a9dc-e0b995c2bab2@kernel.org> <304758063.1694752.1757427687463.JavaMail.zimbra@raptorengineeringinc.com> <97746540.1782404.1759973048120.JavaMail.zimbra@raptorengineeringinc.com> <2d00ed57-3c74-492e-83ae-88ca1ce98311@kernel.org>
Subject: Re: [PATCH] PCI: pnv_php: Fix potential NULL dereference in slot
 allocator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Fix potential NULL dereference in slot allocator
Thread-Index: CtRjw05oWZGOt/qVaF0yP9/m4nCNzA==



----- Original Message -----
> From: "Jiri Slaby" <jirislaby@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Thursday, October 9, 2025 12:54:19 AM
> Subject: Re: [PATCH] PCI: pnv_php: Fix potential NULL dereference in slot allocator

> On 09. 10. 25, 3:24, Timothy Pearson wrote:
>> A highly unlikely NULL dereference in the allocation error handling path was
>> introduced in 466861909255.  Avoid dereferencing php_slot->bus by using
>> dev_warn() instead of SLOT_WARN() in the error path.
>> 
>> Fixes: 466861909255 ("PCI: pnv_php: Clean up allocated IRQs on unplug")
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> 
> LGTM, perhaps also a lnk to the report:
> Link:
> https://lore.kernel.org/all/304758063.1694752.1757427687463.JavaMail.zimbra@raptorengineeringinc.com/
> 
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> thanks,
> --
> js
> suse labs

Just a quick follow up on this to see if we could get it merged?  Thanks!

