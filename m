Return-Path: <linux-pci+bounces-6743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19468B4847
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 23:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1605282D19
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB251419BA;
	Sat, 27 Apr 2024 21:14:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC247F63;
	Sat, 27 Apr 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252474; cv=none; b=c9tJW/0QSfaCo6pT+dwcXbyqIPyxRtaFMQCE5Zfey+WIUf6jl5bFd7PxFDhP1nBHop8/a86ZUU7dEq8HyDOOMooLDdxWMRa26nIfqqlJ7S3wZKnX0/qMfeTHQxYfyD3fhO5OSwi1X0Jw+WKtaYZKa1vhVebht+4Majbf2GV2z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252474; c=relaxed/simple;
	bh=JLb9nkXBuq9tVxjgmesZjvdH2BXz28wXTyP7JHc7zJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snrzUWs9IggkyY0Ds3a01bUeqinbgXEIZGnrrw0kqNcC4raVR91LEgvmHY0fnE1T2XzwZkWZuJyxrQR/dBaZXIJ2E9sMgvxxGnw/DFDnfASvM2FOn5h0urkVt31GOn0VbCMC/vg+3k6Of1QVvFjRC6FWTuob0a+OC6iqRQ6bkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B9A7C2801371D;
	Sat, 27 Apr 2024 23:14:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8C896190545; Sat, 27 Apr 2024 23:14:28 +0200 (CEST)
Date: Sat, 27 Apr 2024 23:14:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <Zi1qtKNwcyydP4c2@wunner.de>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
 <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Sat, Apr 27, 2024 at 09:49:41AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > But I want to raise awareness that the inability to hide
> > empty attribute groups feels awkward.
> 
> That is fair, it was definitely some gymnastics to only change user
> visible behavior for new "invisible aware" attribute groups that opt-in
> while leaving all the legacy cases alone.
> 
> The concern is knowing when it is ok to call an is_visible() callback
> with a NULL @attr argument, or knowing when an empty array actually
> means "hide the group directory".
> 
> We could add a sentinel value to indicate "I am an empty attribute list
> *AND* I want my directory hidden by default". However, that's almost
> identical to requiring a placeholder attribute in the list just to make
> __first_visible() happy.
> 
> Other ideas?

Perhaps an optional ->is_group_visible() callback in struct attribute_group
which gets passed only the struct kobject pointer?

At least for PCI device authentication, that would be sufficient.
I could get from the kobject to the corresponding struct device,
then determine whether the device supports authentication or not.

Because it's a new, optional callback, there should be no compatibility
issues.  The SYSFS_GROUP_INVISIBLE return code from the ->is_visible()
call for individual attributes would not be needed then, at least in my
use case.

Thanks,

Lukas

