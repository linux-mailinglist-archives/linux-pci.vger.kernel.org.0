Return-Path: <linux-pci+bounces-8032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904B8D39F5
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C9A28A65E
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B91581E8;
	Wed, 29 May 2024 14:51:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13917B404
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994284; cv=none; b=lDO9nvxR8/HeZitJ5OEsvUM9+Hb/CHmwviJGOixfawlaugxdTd6yaTeiqeVXIRZIH7v+5BL9/Ns5OgCWTdgAvmk2ivcZ/edxDZrYbtIkAa7/XGmRpWqPp/muRv1jP4HyHjYS/Q6NBbK/VdVYVWyJ5ZTdyglYEqR3q2xd3MX3YZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994284; c=relaxed/simple;
	bh=87tgenCcbkDkT1v056+Rrow6+rvKb6ED20JwCzwCEBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgxj0JcGK/2nFbCTJ8Vk56M4Hr6JzqDAtQL538+t4s3V5lCQme0Usxux8s2do6Y2n6cefV1ZH2eS2ckdQ3DubnfrNBJ8axDyO+MF28o47mr40CPJehwQYFdtXqXnklVkv4ACOrTHschBuXe1NoVqJfzUjy1q+4Yvzf6L7YBBwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C5EC530000D14;
	Wed, 29 May 2024 16:43:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B0FAA230885; Wed, 29 May 2024 16:43:51 +0200 (CEST)
Date: Wed, 29 May 2024 16:43:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "scott@spiteful.org" <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <Zlc_J2386nAAhn1s@wunner.de>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de>
 <ZhapFF3393xuIHwM@wunner.de>
 <8c3d00850e7449c184e4c45a3c9b9dfa@realtek.com>
 <ZlR0grWLqO9nch8Q@wunner.de>
 <94918684e6a84122a6373ef45b3c117c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94918684e6a84122a6373ef45b3c117c@realtek.com>

On Wed, May 29, 2024 at 07:47:13AM +0000, Ricky WU wrote:
> We tried this patch as below situation: 
> 1.keep the SDEX card enter S3 then resume ->PASS 
> 2. on S3 mode insert the SDEX card then resume -> PASS
> 3.on S3 mode remove the SDEX card then resume -> PASS
> 4.replace card on S3 mode (different brand) ->PASS
> 5.replace card on S3 mode (same brand and same capacity) ->FAIL
> Can not see the msg "device replace during system sleep"
> 
> Against 5 we found a issue, most card not declare capability
> "PCI_EXT_CAP_ID_DSN", even if there is the capability the config space
> value are 0, cause pci_get_dsn() return 0 normally.
> However these cards can show the SN on CrystalDiskInfo.

Thanks for testing.  That's the expected behavior so I went ahead and
submitted the patch:

https://lore.kernel.org/all/a1afaa12f341d146ecbea27c1743661c71683833.1716992815.git.lukas@wunner.de/

If vendors neglect to populate the Device Serial Number in config space,
it's zero and we cannot use it to detect device replacement.

A DSN of "all zeroes" is a reserved value:

   "The all-zeros EUI-48 value (00-00-00-00-00-00) and EUI-64 value
    (00-00-00-00-00-00-00-00), though assigned to an organization,
    have not been and will not be used by that assignee as an EUI.
    (They can be considered as assigned to the IEEE Registration Authority.)"

    https://standards-support.ieee.org/hc/en-us/articles/4888705676564-Guidelines-for-Use-of-Extended-Unique-Identifier-EUI-Organizationally-Unique-Identifier-OUI-and-Company-ID-CID

The serial numbers of block devices shown by lsblk are not PCI
serial numbers, but specific to the NVME or SCSI or ATA layer.
I'll look into adding a PCI helper which those layers can call
on resume if they detect a change in device identity, but that's
independent from the patch I just submitted.

Thanks,

Lukas

