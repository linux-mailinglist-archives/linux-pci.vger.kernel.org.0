Return-Path: <linux-pci+bounces-6750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A08B4B34
	for <lists+linux-pci@lfdr.de>; Sun, 28 Apr 2024 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1716B281998
	for <lists+linux-pci@lfdr.de>; Sun, 28 Apr 2024 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB454BE0;
	Sun, 28 Apr 2024 10:08:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF654BFC;
	Sun, 28 Apr 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298934; cv=none; b=LQYoZwgULTlFMwu2D1F+HzuQ16RvrEPun1qFMf53lV/DLiua1KY0O5Oh0gVS3oqpOWTWICbOP/x/fDRezSRKkYhP0ZsyXiTmaD843DaFAHl0pcAoJJFeTz9DCdJSZq5KTR0SImKYylSdAZufl3VZHZntfksPiIZsW3Qj8Uf/xSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298934; c=relaxed/simple;
	bh=TTARU/Xd9FlQOME2CIODtyLJRuvfgCO/Q3kMmgLEpAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdNQCGYj8L1lYuiMw11TX8nlT8CzQEmggXtZVczU3fWUBHhRN1JxYfTrSvVO36/9vpmPjsHZ8hBzQzfVlnW6GnE+pVb1fmMYM0OUhvfHNBZ643A3BCCgS26waUMkxfFX3WkGzL9XCqYftP0zJfr+YVmgwhb9PSq2xkrL3UrwZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 83873280072AE;
	Sun, 28 Apr 2024 12:08:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4D1F555998; Sun, 28 Apr 2024 12:08:43 +0200 (CEST)
Date: Sun, 28 Apr 2024 12:08:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <Zi4gK8rs7jjdJOh8@wunner.de>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
 <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zi1qtKNwcyydP4c2@wunner.de>
 <662d6f24528d7_b6e0294d2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662d6f24528d7_b6e0294d2@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Sat, Apr 27, 2024 at 02:33:24PM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > Perhaps an optional ->is_group_visible() callback in struct attribute_group
> > which gets passed only the struct kobject pointer?
> > 
> > At least for PCI device authentication, that would be sufficient.
> > I could get from the kobject to the corresponding struct device,
> > then determine whether the device supports authentication or not.
> > 
> > Because it's a new, optional callback, there should be no compatibility
> > issues.  The SYSFS_GROUP_INVISIBLE return code from the ->is_visible()
> > call for individual attributes would not be needed then, at least in my
> > use case.
> 
> That's where I started with this, but decided it was overkill to
> increase the size of that data structure globally for a small number of
> use cases.

Memory is cheap and memory-constrained devices can set CONFIG_SYSFS=n.

There aren't that many struct attribute_groups and this is just
8 additional bytes on a 64-bit machine.  (There are way more
struct attribute than struct attribute_group.)  The contortions
necessary to overload individual attribute ->is_visible() callbacks
to also govern the group's visibility aren't worth it.

Having an ->is_group_visible() callback has the additional benefit that
the mode of directories no longer needs to be hardcoded to 0755 in
sysfs_create_dir_ns(), but can be set to, say, 0500 or 0700 or 0511,
depending on the use case.  So more flexibility there as well.

Thanks,

Lukas

