Return-Path: <linux-pci+bounces-19222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19757A00977
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99A93A11E4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153961B4F09;
	Fri,  3 Jan 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="G/wY73s8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45C17FE
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908512; cv=none; b=ezzIEGSK66HULa2ncQpDZt6FtlnDv0sEXc7vr0mTZ2zcAryxSqZK+TBoMUTTMf6nPTeeyd/MwY+YvL9PtTiQ01N3aUoShdFjVNQpUkujN2pfk1L5tA7lmaCDKZD9aGkoZbR7ep/2X/7BtSmkEAWudl4A9hTtLeEhjAuGJYLtqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908512; c=relaxed/simple;
	bh=Gx2tBk5b5iiiVDk5sGoYvRMPKAo2Jskn32iHs1ldREI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otkrriCcXxtTkuqE02aS38a30NG1OYJo4MkFbic0ilTTDZlB403svmN1Eg0mBscKz60f2uVc0yPynqWqBi7nufeD6WW9Jgvmwsg4PrGyGO6bhisS0z2CKhPgSkJv3i0X1e9crqaR32sLjplguz8MaYPn3bfRFbNB7Qvs+4W/TlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=G/wY73s8; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 920B6240028
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 13:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1735908502; bh=Gx2tBk5b5iiiVDk5sGoYvRMPKAo2Jskn32iHs1ldREI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=G/wY73s8tteF8dQ5OHyZ0AG2IAIkfS6ko1dXyyV5klNvJNJljeZ5u8OAeWxqg6KOr
	 RqUl71SLbwmZqE+99KgOFwQ/HbLXiGbmxoQnryss1X0/IwCJOoPaRlLvpUIVOKjKqh
	 uVpYBLvK4L63/6m9Rby59nHojHzL9Vpyn5a11d1iSQ0vil9orXZ/FzmXfcdmTapzY7
	 ROu9rbQgN9dE+UvH61NPlumrvfXkh1rIT1FBJULqKeExjfyTT1+a52YFk8hKCfvhtN
	 1ptqHcQpVJWHa/VDiw1Ii+xhWB02nWJ80vyDgaGGSveANNUZUTULrVsH3iu6Tz/AFB
	 XJOAGxhreu5CQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YPjzn5DTTz6twV;
	Fri,  3 Jan 2025 13:48:21 +0100 (CET)
Message-ID: <83b8a4d8-6b8d-449d-9bbc-8f7af1ed0048@posteo.de>
Date: Fri,  3 Jan 2025 12:48:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] vfio/pci: Fallback huge faults for unaligned pfn
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterx@redhat.com,
 athul.krishna.kr@protonmail.com, regressions@lists.linux.dev
References: <20250102183416.1841878-1-alex.williamson@redhat.com>
Content-Language: en-US
From: Precific <precification@posteo.de>
In-Reply-To: <20250102183416.1841878-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 02, 2025 at 19:32:54 +0100, Alex Williamson wrote:
> The PFN must also be aligned to the fault order to insert a huge
> pfnmap.  Test the alignment and fallback when unaligned.
> 
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219619
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: Precific <precification@posteo.de>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Tested-by: Precific <precification@posteo.de>


