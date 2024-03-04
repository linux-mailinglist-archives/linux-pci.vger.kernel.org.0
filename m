Return-Path: <linux-pci+bounces-4392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D878A86FA9A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 08:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FC61C20C49
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3EC12B6F;
	Mon,  4 Mar 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="FDQx+MiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF1134A3
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536792; cv=none; b=f/BRXtiy5D2DkKE5h3nr0omVgXuwcCehty45rodpY9SBWUw5gTn0Ftp6LzmRy8S36cFIE/7hBm4moHvEp+kqHsGCj+n4YwOZm7U45n5W4Mt5gSpTJgufbnlUIvy++Amy+fGKVkRRCn8/QbMQcpy51CJnLuDuLO4aFupzTuVj0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536792; c=relaxed/simple;
	bh=jnH47bOiPMxUsCEirptSqiUETBRVPbNj5lKX7XDjl4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOMbZcR+Av6lPJT4ch49yw05HTDr+Sxt++aE/hwLjtYkRc3FerBwV1OfYlRgMHNmspzGDOHk115NLMIldIN0iPfWVAZmgqpidaYufeTvNirLocUYxYtMFCXr6ZmqH5XrszIpH3DDR0GDk9ohlXc+L9q9AFG1sWIq1sJ1G0pz/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=FDQx+MiF; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=jnH47bOiPMxU
	sCEirptSqiUETBRVPbNj5lKX7XDjl4g=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=FDQx+MiFWPPdsiFrfmacbFW5qrE7AfqiqZp1c3Dx
	wawYg0qQUcvdfHs3v6sNo2yXcbIbcjUp+W3R1NpX9iKtL9/XRMWluzaECpv25VD/w05As0
	v1rUT9OMznqqxHF1yKjH7O5Fj2twMajMWowzgyu0mV47Ra/bq51E9yHD1hQfw=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 061ef965 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 08:19:38 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 4247JbXu796257
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Mon, 4 Mar 2024 08:19:37 +0100
Message-ID: <02aecc45-0184-4aa5-94cd-4bdb4e8e9309@aixigo.com>
Date: Mon, 4 Mar 2024 08:19:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: AER: Corrected error message received from 0000:00:06.0
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20240229202652.GA361290@bhelgaas>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <20240229202652.GA361290@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-02-29 21:26:52, Bjorn Helgaas wrote:
> 
> Probably not, since these errors are normally corrected by hardware
> without software intervention.  But we do need to improve the way we
> log these, so if you could open a report at
> https://bugzilla.kernel.org in the Drivers/PCI component, and attach
> a complete dmesg log and output of "sudo lspci -vvxxxx" to the
> bugzilla, I'll take a look and make sure.
> 

This is https://bugzilla.kernel.org/show_bug.cgi?id=218556

Thank you very much
Harri

