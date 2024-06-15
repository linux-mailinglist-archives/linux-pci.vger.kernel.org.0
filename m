Return-Path: <linux-pci+bounces-8859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB8A909877
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206C71C211A1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39B49639;
	Sat, 15 Jun 2024 13:13:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52C4962A;
	Sat, 15 Jun 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457180; cv=none; b=RQD28cMCaJZBag6248aAIgHCCfKG0TRNth0KNlXuzBOk7CwL/peLFRUxTdf0JvLBcQ+bqmS3+evujMMhcmCcG+ZKkhc2qh/BbzNPry1VPfr4uut9ryoT/8iXszlc7yXG6sGGXxQoXnWxUxpr1lcMb3A1SG3zuxZ5CuLdjhGGSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457180; c=relaxed/simple;
	bh=8R9kwNnyf9yYTmlKTPhrDKd+jZ3FnclJtBhCgCclI3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3Trks0n7Ha69rrehcSGq9FjnJOVtj53TLKB2MQ+Epx72iwoDoD1gi1CEWNpAbegs4FZAcu1Mb1LTSmOfZXkygH0yKtgzN+NygMLxSGhKI2AIKZSR3nRIQVFXYPMrWDQCOH+3rQgQzy/P4uMvZLBc5cAUZkpkhkDL3inUkcrhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4C47D28010885;
	Sat, 15 Jun 2024 15:12:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 36E591DB746; Sat, 15 Jun 2024 15:12:55 +0200 (CEST)
Date: Sat, 15 Jun 2024 15:12:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <Zm2TVxvMaD7ogNfK@wunner.de>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
 <20240522101142.559733-3-alistair.francis@wdc.com>
 <20240523122448.0000799f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523122448.0000799f@Huawei.com>

On Thu, May 23, 2024 at 12:24:48PM +0100, Jonathan Cameron wrote:
> What happens if multiple DOE which support the same protocol?
> (IIRC that's allowed).  You probably need to paper over repeat
> sysfs attributes and make sure they don't get double freed etc.

So I believe this was fixed in v11 but assuming the point here is
to allow lspci to display supported protocols without speaking DOE
with the device, the way it's implemented now user space cannot
discern which mailbox supports which protocol.  Or if multiple
mailboxes support the same protocol.  I'm wondering in how far
that limits the usefulness of the feature.

sysfs doesn't support nested groups.  But we could dynamically
create one attribute group per mailbox.  Or have one file per
mailbox in a common doe_features group, each file containing
all the supported protocols. Hm...

Thanks,

Lukas

