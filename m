Return-Path: <linux-pci+bounces-3144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFA84B698
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9E1F264BF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F37130ADC;
	Tue,  6 Feb 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="cpkPDWai";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="vCnkNoeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA4131752
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226820; cv=none; b=K0Mz6vGmxdBl1zITTReI1hMpIXz1acpqpFZueZR8LoqNiHQ0FqDldrSKJzDFb7qd/cti23My8c03qbASMICXf2mVysqXlVzTLPBf5s+GgSQ2SoJE29l+RGnhxAdthSsgey4xrG+Xf4qzdyTUa1tN0fk2iGkMUIp9REVJOtkZaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226820; c=relaxed/simple;
	bh=OR9lAUcOzFkCV68LII0FU4ZqcRO2I/I3/EilhIKa+vE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU9q+7KjXYEg6c3qXN5Bg7CC8xLr31qFvfrOCm7T053Z/yn7efdASzgF52dEKVRUVlAtzSdeodOPKlnnu0iIJCR9HdCClC14gmUheYkI5ZVzASyPyrIgiBpY0v3M4VFyXQ5CUbSF7858dFU0iqvlwYfWSUPiqG9+JcwCMtbqMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=cpkPDWai; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=vCnkNoeI; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 730B0C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1707226298; bh=lg5Or6IzKvVQaZw6ElDtsf04r4+kSWJNjdJoOJ67yZE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=cpkPDWaiQsCkoipyFyzETWyfJPTsjN3eV4me0QT8Kx+5XgeK5OgUI6hXZSa2rzb69
	 rHb6WcrXQeBzqgri/psOHO9hXbv2R5O2J2k4N/kAQlFmVQnE1Z7SmFwCMAX8bJTKs8
	 YyRY/nIW+SP7gOol5WvSez3pJufPQ+pKWfxIIaMA1rNLJem0gTUYcsS2pNgaB/hVOj
	 kk+UIiHdr+F+F7PmUdW6YMcZJJ2rP57zGBrFpz9YDy0veXQQfMEyEPTQNyBZGf95lF
	 BaEkGQ2PFbnFYtd4B4nYlsAf9Z8xrDkRJq3r1RJlij3aTtzJPpLuKzOhCz1n5K5e9Q
	 EgEGvFDscYg5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1707226298; bh=lg5Or6IzKvVQaZw6ElDtsf04r4+kSWJNjdJoOJ67yZE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=vCnkNoeIGc73ClvIz/oaxMxc1amrO8BgptmxmwbmFHwZLpKihc2o2yeQG/kVHd/GW
	 ix9Z3wl+rllp4vjisVgQYDR5CuB2hoHJkAr3vAnaZPQ5iu+CCp5cBcpNqwm5TFT2CF
	 mbPgY8AxFRl2YiXjtXTOKPOARSo5CC7w/Vw3pYPqUKkwe9zJAYZz21CB12EAXqW1+a
	 1qinuQoPkXftduY2tJnC3hqmPr5M/IzvOY4iPOqC7RwYH6GfCS8YFqRE5Ra9vf+PVR
	 6wQYOTcu1fQXw2gjVoOOLcsJSk93Uh5GgIr94+0Nj4HwpQH5O1EjVF6Dw8bV64So/4
	 BPywnKMYTyVFg==
Date: Tue, 6 Feb 2024 16:31:36 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, "Sergei
 Miroshnichenko" <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: Re: [PATCH v2 00/15] pciutils: Add utility for Lane Margining
Message-ID: <20240206163136.239ef14d.n.proshkin@yadro.com>
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

On Wed, 27 Dec 2023 14:44:49 +0500
Nikita Proshkin <n.proshkin@yadro.com> wrote:

> PCIe Base Spec Rev 4.0 introduced new extended capability mandatory for all
> ports - Lane Margining at the Receiver. This new feature allows to get an
> approximation of the Link eye margin diagram by four points. This
> information shows how resistant the Link is to external influences and can
> be useful for link debugging and presets tuning.
> Previously, this information was only available using a hardware debugger.
> 
> Patch series consists of two parts:
> 
> * Patch for lspci to add Margining registers reading. There is not much
>   information available without issuing any margining commands, but this
>   info is useful anyway;
> * New pcilmr utility.
> 
> Patch series is also posted as PR on pciutils github:
> https://github.com/pciutils/pciutils/pull/162
> 
> Changelog:
> 
> v2:
> - Replace packed structures with bitfields for margining registers parsing
>   with BIT() and MASK() macros;
> - Hardware quirks are now based on ports PCI ID instead of /proc/cpuinfo;
> - Refer to the PCIe Spec properly;
> - Clean up the formatting;
> - Move the entire internal interface of the utility into one common header;
> - Use pcilib u8/16/... types instead of types from stdint.h;
> - Use common.c functions such as die() and xmalloc() as Martin suggested;
> - Change utility building to the variant with linking object files
>   separately instead of building lmr as a library.
> 
> v1:
> https://lore.kernel.org/linux-pci/20231208091734.12225-1-n.proshkin@yadro.com/

Gently pinging Martin.

Review v2 patches, please.
I would like to hear any requests/suggestions on them.
Thanks.

Nikita Proshkin

