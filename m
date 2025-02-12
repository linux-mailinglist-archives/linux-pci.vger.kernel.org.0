Return-Path: <linux-pci+bounces-21312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16378A3315B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC7A7A28F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585811FFC5F;
	Wed, 12 Feb 2025 21:17:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAB1FBC8D;
	Wed, 12 Feb 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395071; cv=none; b=PU050ZA+IdzKGZOdqyqzP2/vpGMFBYPP+Fofvq8MnuMczuTjFlQzqKrzGaQ3itDjYThi4yAx3nExuRev7y8xNW6T9jaqiygLQOH3YmJeD5G11yzZXfDsUdPJ7/NE4KR5y9n2Xuiug0mmvFbCn1byp8QdW7lcAkOBYAtv3Ea8gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395071; c=relaxed/simple;
	bh=+gI0g62zMZTou4c7gCp4VIj/jCbRJW2dl3AylMovcfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLY5VBd8tTaMJb2k4kAiGdAM2EEd0cu/KlYOwfO87a0po+U3dBlDU5zWZg5eqBLXxCrV27opplHw74f0EBVVVLB8N1hsjzI71KP3MVhn9ebB9lZscbD4BYo9SXzrTQTyPTWLFLGyTpGr4PmiDAgmivO+eoKoFkWWnd9Hzfr8zKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id F3DEF3000A0A1;
	Wed, 12 Feb 2025 22:17:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EA7795EF83; Wed, 12 Feb 2025 22:17:43 +0100 (CET)
Date: Wed, 12 Feb 2025 22:17:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <Z60P921qJq6h1Fa5@wunner.de>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-5-terry.bowman@amd.com>
 <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
 <9035be0b-7102-4abc-a21a-61648211be55@amd.com>
 <67acfd24a4245_2d1e29437@dwillia2-xfh.jf.intel.com.notmuch>
 <02c5b364-f97a-44de-980f-e16438ec66f8@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c5b364-f97a-44de-980f-e16438ec66f8@amd.com>

On Wed, Feb 12, 2025 at 03:08:10PM -0600, Bowman, Terry wrote:
> I found in using is_internal_error() (v5) a USP with fatal UCE will not
> have AER status populated in aer_info structure, only the severity field
> is populated (see aer_get_device_error_info()). The aer_info is not
> populated because concern reading the USP's AER (config space) when
> the upstream link state is invalid. Calling is_internal_error() in this
> case will return false because the uncorrectable internal error (UIE) bit
> is 0 and proceed to treat as a PCIe error.
> How do you want to proceed to handle the UCE protocol error in this case?

Shuai Xue is proposing a solution in this pending patch:

https://lore.kernel.org/r/20250207093500.70885-5-xueshuai@linux.alibaba.com/

