Return-Path: <linux-pci+bounces-30096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3465ADF325
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1CC3A214F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5392FEE16;
	Wed, 18 Jun 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="SG8+Ktpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA312FEE02;
	Wed, 18 Jun 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265762; cv=none; b=IpVfQZlpjdUN0N0686qKbzjqh8UU5GHAvJb/ZgEJtdOU7ZilIyxgbmBj3IRmKYa6nQwnbSDb8kaoxrtvOhyixBSprUrS8PsS/KBW50X6oGzwcs2DRpK5REaWCVVsv7hBcshEDxOLue9xS/ZgburrYsvdw6bijjtBCevSDr52VlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265762; c=relaxed/simple;
	bh=45dfFt7/Lw+vYZ6FODYE896bX4frJlHHJRgCr3IatxI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UbujXoB5SMyHrXAokyGBJoTAdX90dhvelKzK7+zCBtjSUXFRevnTUD5DfTQGCF67Dl9KwzUAJAHjqthOtruxKZdfqhTq4/6oSHLTu34+9t7RcaNXdwohKOrxr8P5LU/wRQ4RshXGNF4bnwHNlVhsfu3x5UyQaonVNQBRyePFCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=SG8+Ktpn; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 828C88286FBD;
	Wed, 18 Jun 2025 11:55:59 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0aUYil_3E0-H; Wed, 18 Jun 2025 11:55:58 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 88B968287179;
	Wed, 18 Jun 2025 11:55:58 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 88B968287179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265758; bh=lsH6Mcb5sOzQ2SC69uB9LMQwjmUITv6dqf33k1ZaAf0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=SG8+Ktpn6Q4bBiZ3ABXaM45t5s/V+sMoNCVSb0T9rxV1PPzYIoYLjKaXLaBLSAyY/
	 5qwfBhof6dKUdiJuk0rFFbPkEmcEk3yfkjd76FJk04zGXTK75NibzVgEerXqrYaRra
	 Bkvv+mo6EnYtnHZ71trKJYhcqqd6UJLdZHQWW0CA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z7uLIchHfRBv; Wed, 18 Jun 2025 11:55:58 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 59BA28286FBD;
	Wed, 18 Jun 2025 11:55:58 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:55:58 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <596516884.1310632.1750265758190.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1728509613.1310543.1750263002144.JavaMail.zimbra@raptorengineeringinc.com>
References: <946966095.1309769.1750220559201.JavaMail.zimbra@raptorengineeringinc.com> <aFJQ8AtYlKx1t_ri@infradead.org> <1728509613.1310543.1750263002144.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and
 eeh_ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops
Thread-Index: bupdJGUzprnsSSzB+HYmaNkawJnfUc+y9UXi



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
> To: "Christoph Hellwig" <hch@infradead.org>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Wednesday, June 18, 2025 11:10:02 AM
> Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops

> ----- Original Message -----
>> From: "Christoph Hellwig" <hch@infradead.org>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel"
>> <linux-kernel@vger.kernel.org>, "linux-pci"
>> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
>> "Michael Ellerman" <mpe@ellerman.id.au>,
>> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao"
>> <naveen@kernel.org>, "Bjorn Helgaas"
>> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
>> Sent: Wednesday, June 18, 2025 12:38:56 AM
>> Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and
>> eeh_ops
> 
>> On Tue, Jun 17, 2025 at 11:22:39PM -0500, Timothy Pearson wrote:
>>>  /* Platform dependent EEH operations */
>>>  struct eeh_ops *eeh_ops = NULL;
>>> +EXPORT_SYMBOL(eeh_ops);
>> 
>> Exporting ops vectors is generally a really bad idea.  Please build a
>> proper abstraction instead.
>> 
>> And use EXPORT_SYMBOL_GPL for any kind of low-level API.
> 
> Fair enough.  I'll add a properly exported method for PE get_state() and update
> the series in the next couple of days.

Somehow I completely missed eeh_pe_get_state() the first time around.  I don't need to change the API, v2 incoming now.

