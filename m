Return-Path: <linux-pci+bounces-25511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C8A81318
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 18:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CB54A6DF1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8622D795;
	Tue,  8 Apr 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="dMq/p+0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575122ACE3
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131441; cv=none; b=ofiX1vm3jttoUmc8QlcLrbW5QMkFlJbXWxPdjCxUr/k7kgrswghUotjAnSyg92zvSRomSXPHpdVcHXNqx87fGLH9oaXrEdBtMGKHJP65Lot5q9wYkEgrDP2xitrf4aZukcE+UbPvEBZjU6j3Gm97tSGFJ9D4Z68qEc/n3mGMT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131441; c=relaxed/simple;
	bh=O0+17WUfEaHXbmjRQLD+nSND55dYNbv+rYx911yjSMU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=WhIAGO3IKws294vyTTZWQsQHNRJVebkqEWNu05cPLQnKUO4K+sK3QQOJDsUElK1gBRm22iW2iUQ2B3Jyzkdudp3yGstonoeo+vu1/sfDXsaukg5iWmwfQ5gzROOIueyPnI8OrLrUgVbwSxggw/1A7JLYkdIYHTHHKbZp2WDEJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=dMq/p+0w; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6J5HqLg7d0KAcqcPTq2XYRoxTDZiGcXuWLeV6rOZ7kg=; b=dMq/p+0wKouap7QG3kFDwk/SCs
	M7Bq74xkoRlBlWUtYXbhWZA6R6iMPpEZDVX9NsUX3Ll5mO4RXHYQj+offK5ldEjYKVjeQBKCRBea8
	ILagV0JVq/Frmep+UfJL3pI8qiaiTZEQEfofQ3vgtqX72bWhi4pYFz8acoOOUsIIWwM+2ReV89oNy
	K5rM4PPv1Vo+05c5h/SPSf2d8EGYFN0WNlRJHvqXwD5LQwugIhL5EjzL9q8HdipW6ETblLy/FByiR
	AZvHFc9UsVwCF79hFWeF0VDUhuMDNF48wiK2vQOOFKHXNU4TrRcKdTM2lgPn7ocuyWBnl92nXh5ab
	RDVg3CoQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1u2Bl3-0004Ac-19;
	Tue, 08 Apr 2025 10:25:06 -0600
Message-ID: <6695d513-3c0d-427f-96e5-79ada046cedf@deltatee.com>
Date: Tue, 8 Apr 2025 10:25:03 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lukas Wunner <lukas@wunner.de>, Damir Chanyshev <conflict342@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>
 <20250408150623.GA232275@bhelgaas>
 <CAAUwoOg-uUGRcyNx3npvJuA9ZQa=dH+7tzdtKnA1y69kBriyuw@mail.gmail.com>
 <Z_VAuOu7lvm5ykNX@wunner.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Z_VAuOu7lvm5ykNX@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lukas@wunner.de, conflict342@gmail.com, helgaas@kernel.org, linux-pci@vger.kernel.org, michael.j.ruhl@intel.com, ilpo.jarvinen@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: P2PDMA support status for the sappire rapids+
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-04-08 09:28, Lukas Wunner wrote:
> On Tue, Apr 08, 2025 at 06:14:55PM +0300, Damir Chanyshev wrote:
>> On Tue, Apr 8, 2025 at 6:06???PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> The pci_p2pdma_whitelist[] is only updated when somebody tests a
>>> platform and determines that its RC can route peer-to-peer
>>> transactions between separate Root Ports.  This routing is not
>>> required by the PCIe spec, so we can't assume that all platforms
>>> support it.
>>
>> For the testing, is simple rdma ping-pong sufficient? Or a more
>> specific testing tool?
>> Unfortunately I don't have a fancy pcie hardware analyzer.
> 
> You should test that performance is satisfactory for you needs.

I couldn't have said it better myself.

If you have any application running on a machine that uses P2P then that
is sufficient testing in and of itself to add the machine to the list.

My expectation is that any modern Intel root complex should work, but we
don't have a concise rule that guarantees this so we are stuck in the
unfortunate situation to add each family as they are tested by someone
who cares about it.

AMD confirmed for us that all modern devices will support P2P and
provided a concise rule that works for all current and future devices.

My limited experience with ARM devices suggest many root complexes do
not support P2P, so they will likely always have to be added on a case
by case basis.

Logan

