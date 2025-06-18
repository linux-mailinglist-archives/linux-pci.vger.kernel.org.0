Return-Path: <linux-pci+bounces-30006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BF1ADE309
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FA61898D66
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 05:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9281F8747;
	Wed, 18 Jun 2025 05:27:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095963A1DB
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224440; cv=none; b=TE2FrLPRhVFVIOwuVRNFfnvnpR71/UHL5tiUjYCayOZm4IlpIMipBJo20O2oJqflmiC2xqk5ASvJjg1JxsZEDtjUH86lp7dL+7uTC2jWHX+8qAjsN62mD/YhrkP3xeL/2ederkDt4pOZgHlxm0nVa6vbxHvaXSLMvAn7jt+rMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224440; c=relaxed/simple;
	bh=OiHOH+gOId7nAoNgnk0w09IkkzEN1Ydh9tBfYlBT9H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PysW8catP8bM4qRUIDweowOy1iQvOkDuI5ROafPxcA4Y7Hgoe051ylV/iM7eq/wVL6F8EvzTrF1ZrhHaBIWE3W9lQAe9gXLuDbTiPE+58uSK5s/SYZda/z/HB0SzC5QAYV2UdUtbAhYXNtJvYOIetv5ndMtcywMpIKJZtpkZ4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0635F200A291;
	Wed, 18 Jun 2025 07:27:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DF26F20D68D; Wed, 18 Jun 2025 07:27:09 +0200 (CEST)
Date: Wed, 18 Jun 2025 07:27:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: linux-pci@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>, Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	David Airlie <airlied@redhat.com>
Subject: Re: amd-iommu / agpgart-amd64 problem: Resources present before
 probing
Message-ID: <aFJOLZ88KIH5WBy2@wunner.de>
References: <wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg>

On Tue, Jun 17, 2025 at 10:47:48PM +0300, Fedor Pchelkin wrote:
> Hello,
> 
> there is a 
> 
>   [    0.579232] pci 0000:00:00.2: Resources present before probing
> 
> error message observed after
> 
>   commit 3be5fa236649da6404f1bca1491bf02d4b0d5cce
>   Author: Lukas Wunner <lukas@wunner.de>
>   Date:   Fri Apr 25 11:24:21 2025 +0200
>   
>       Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices"

For the record, the reporter of the above-quoted issue appears to be
working for an OFAC sanctioned entity:

https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890

This prohibits me from two-way engagement with the reporter:

https://www.linuxfoundation.org/blog/navigating-global-regulations-and-open-source-us-ofac-sanctions

   "Reviewing an unsolicited patch from a contributor in a sanctioned
    region should generally be fine, but actively engaging them to
    better understand their issue, diagnose the problem, or help
    improve a patch or modify code would likely cross the line.
    If the contributor is linked to a sanctioned entity or region,
    in general, it is best to keep communications strictly one-way.
    If a patch is received and you improve it and submit it upstream,
    that should be fine, but going back and forth in communications
    with the SDN developer likely would not."

Hence I am removing the reporter and the lvc-project@linuxtesting.org
address (hosted by ispras.ru) from the To: and Cc: headers.

I note that prior to 6fd024893911, the amd64-agp.c driver was only bound
to devices with a PCI_CAP_ID_AGP capability.

agp_amd64_probe() does check for presence of the capability, but that's
too late to avoid the error message emitted by really_probe().

What we could do however is to first check for presence of a device with
PCI_CAP_ID_AGP, and only if one is found would we try to bind to any
device.  That should avoid the message on any halfway modern system.

Thoughts?

Thanks,

Lukas

