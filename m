Return-Path: <linux-pci+bounces-14088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD099695A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC9B213F1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5418B465;
	Wed,  9 Oct 2024 11:57:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84772188718
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475059; cv=none; b=jbFOPmVwOW/sJGuYKx2PDe7wj41DOomErH3kpxQIdEgZfLqfwzv230i8iRJAx6sgobbFcoUzNacuA7XhxwHn1d4quKHScZ8uRJsq9EQQ931uN6Wu3Ahf5200WxeimJkMPjsJxby83EYfKYPYwZK/VUWMdwllr3xicOqMxrh6N6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475059; c=relaxed/simple;
	bh=cZ2BIKyg1MQXTSxf1rlQ8VlYgpztvuVSwDo3A3/8iSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN0nFl0Ps6fzP2dkF+0ylBboPyJhRLSmzuvIJSkxFSRLK7f6X8FTl3NTbZ+tyG+pK00haD16bf4QAhnE/+liPswl5LDdXmvD7S3IVX1yuy77VuiI+xm+Y7WLWuKvaRjeb6SvwZF37vnTDF/hGT2YXROX260dnjz8NIJtfCrpHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C5A3E100E2004;
	Wed,  9 Oct 2024 13:47:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9285C8158; Wed,  9 Oct 2024 13:47:52 +0200 (CEST)
Date: Wed, 9 Oct 2024 13:47:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <ZwZtaHPizigdoCmP@wunner.de>
References: <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
 <ZwU6ijD8I5hzMv9X@wunner.de>
 <20241008163732.GT275077@black.fi.intel.com>
 <ZwV4r8zAcFuJnzH8@wunner.de>
 <20241009044442.GV275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009044442.GV275077@black.fi.intel.com>

On Wed, Oct 09, 2024 at 07:44:42AM +0300, mika.westerberg@linux.intel.com wrote:
> On Tue, Oct 08, 2024 at 08:23:43PM +0200, Lukas Wunner wrote:
> > Okay this seems to have been introduced by 0fc70886569c ("thunderbolt:
> > Reset USB4 v2 host router").
> 
> Correct, and there is similar commit for USB4 v1 routers.
> 
> > Is that a good idea though?  What if the machine was booted from a
> > Thunderbolt-attached drive?  At least on Macs that has been supported
> > since day 1.  I'd assume that it may cause issues if the connection to
> > the drive on which the root partition resides is forcefully torn down
> > and re-established?
> 
> For Macs we still "discover" the topology. This is only for software
> connection manager USB4 hosts. This same "strategy" is being used in
> Windows nowadays, it allows to re-configure sub-optimal setup that the
> BIOS CM might have done and avoids some issues too on AMD.

Hm, I'd assume recent Apple Silicon host routers are USB4 compliant,
so we may have to exempt those from the reset once Thunderbolt is
brought up on them...

Thanks,

Lukas

