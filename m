Return-Path: <linux-pci+bounces-4053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38008680EA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2E51C229BB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6B12FB35;
	Mon, 26 Feb 2024 19:24:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F112F361
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975496; cv=none; b=mvvrMi97KsQzX2wejSh24ACkjt73FHSwYmhA9M3exAcn5aDt7qEJ6N/c7rSXf+wtDoJ5DjY8Sd6yf0oqwWP5FIhQ1M1k/QNsuFZf9GvSTUtYM49CWVwOYoajSBptZMOHa8qDW1068WPCokpIYiYYh2ObwGdlUkhaapYABEtm8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975496; c=relaxed/simple;
	bh=rwdGJlcDgXq6EHNen1Ryc3fNIUeXoK3L1OikNVdoS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkwKmprjv5yp+yuHLPMG3fGJDLk5beIVkp2clT1NYf+VdreeZ08UjqS0RRjKxkhIs5Apq5JMWqSJl7FaEwhd3FLHaTTVCsvKLs1Ryhfxhr5kT+Kug7ML6TalrdKE/INZrUnCP0fv3BsGTSQorhuAUfNz5OMPcjW8gafdVe6JCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D4A01100DA1C4;
	Mon, 26 Feb 2024 20:24:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A3B8E5C9E12; Mon, 26 Feb 2024 20:24:44 +0100 (CET)
Date: Mon, 26 Feb 2024 20:24:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, Martin =?iso-8859-15?Q?Mare=A8?= <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH pciutils v2 1/2] ls-ecaps: Add decode support for IDE
 Extended Capability
Message-ID: <20240226192444.GA22489@wunner.de>
References: <20240226060135.3252162-1-aik@amd.com>
 <20240226060135.3252162-2-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226060135.3252162-2-aik@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 26, 2024 at 05:01:34PM +1100, Alexey Kardashevskiy wrote:
> IDE (Integrity & Data Encryption) Extended Capability defined in [1]
> implements control of the PCI link encryption. The verbose level > 2 prints
> offsets of the fields to make running setpci easier.
> 
> The example output is:
> 
> Capabilities: [830 v1] Integrity & Data Encryption
> 	IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+

Hm, I'm wondering if the Supported Algorithms should be listed on a
line by themselves, each enumerated with a '+' or '-' indicator?
Maybe that's easier to parse?

In general, I'd prefer it if the output was linewrapped at 80 chars,
(i.e. begin a new line and indent as appropriate).

Thanks,

Lukas

