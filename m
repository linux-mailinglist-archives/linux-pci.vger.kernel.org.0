Return-Path: <linux-pci+bounces-4739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C6878F19
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2487CB214A0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377C2A1B8;
	Tue, 12 Mar 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="E4aNegPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26401B657
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228946; cv=none; b=VxtZ8PJm6ZfMG4cgTd7llY7tsTyxrF+ZnC01aZNJ3XnTk8VPHnJ+cKCrIM5BtOdN0wxU2T5IevKKio/7hDQilN1taX4zHVXaJtWyFTBow49PdqEnRPsSGYWYblf7QPG+yfiLzxAmj6EOwDvmvyOSvQfhS/5z0VXZ66td11EV8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228946; c=relaxed/simple;
	bh=i8LxFDf1XaIdOe1QRMw/keLvlJBrPRFle3EnGoiU51o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltuqHvgcfpIwCSjjFev72UNUKIuxJANiRgISNu5Mb/J8+nuG9D/pNLgVf59OCTNrIr94vQu+XIasV4VLsyLsf7Y4TGn8Tb/va+KxVG9+Ol8nnXA1U+0iNKtHRluXgLlGj57eZ7derSd40mbF4oAlsugrvfHB+h97laSXWp5kY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=E4aNegPF; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=i8LxFDf1XaId
	Oe1QRMw/keLvlJBrPRFle3EnGoiU51o=; h=in-reply-to:references:cc:to:from:
	subject:date; d=aixigo.com; b=E4aNegPFx1/wbV5PnHqMUA2Gid1Jo1RLfRKsbxRm
	xbB38ZBIOy0lX2AGACNL6aC/SnzA1KTI559XJo9gI2Mn5eZ2Fad/3CrH9gX9aloeAP3hM9
	hQ3l+clgWFPjux04b9NNoB5UJ3K/amGmJApx3tbyBd/QBEoPY6WFT92gb8myw=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 96beadbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Mar 2024 08:35:32 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 42C7ZVIf2611094
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 12 Mar 2024 08:35:32 +0100
Message-ID: <b2269edc-2928-426e-ae09-d555f239ea79@aixigo.com>
Date: Tue, 12 Mar 2024 08:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: AER: Corrected error message received from 0000:00:06.0
From: Harald Dunkel <harald.dunkel@aixigo.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20240229202652.GA361290@bhelgaas>
 <02aecc45-0184-4aa5-94cd-4bdb4e8e9309@aixigo.com>
Content-Language: en-US
In-Reply-To: <02aecc45-0184-4aa5-94cd-4bdb4e8e9309@aixigo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

For the records: Booting with pcie_aspm=off seems to help.

Regards
Harri

