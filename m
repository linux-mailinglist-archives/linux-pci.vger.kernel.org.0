Return-Path: <linux-pci+bounces-32182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBAB064E3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88735672DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7427E052;
	Tue, 15 Jul 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdMbRqep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1923CEF8;
	Tue, 15 Jul 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599200; cv=none; b=ND7P7cKy1Xdcb/+zStDQEpvd5FXBw6YGfrwxsVdPR7FSTMZpNRmB5zh/awVEWHSXaYvUU1EJBpbbuWGwAJVtnqTd6ZUbqYVwiW4Ydt5HZWHPio/oNX4ItB+vRYwO5BRE5tHfmzs1vFCPZtHXyZi4dtJGWXXMDZb1U7iHmMfC/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599200; c=relaxed/simple;
	bh=kjtRBVThquxBloKl8boVtFp48fMKX97oSvCEnYi+w4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcmc/PsQaw7QipHr3grkHfIKFjsidGwfXp5BXeVowNOR/q7jAB+lvqgdRqKWZOsJ9oDyKkx48C3Nvx0S1jMYAtmzHhdjLkn/zud4oMIIAGbO0QCpfQL602qkOFMHJ78A6+nMsvzalldMLkSTHjctgYx6SwYzKStG5+JQydAzQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdMbRqep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4F3C4CEE3;
	Tue, 15 Jul 2025 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752599199;
	bh=kjtRBVThquxBloKl8boVtFp48fMKX97oSvCEnYi+w4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdMbRqepg9lAlEEYiL29CWcpSkHiT/OaFnix6CRS1YmvEuqfawQ6wUH2cBWvjD9Gt
	 Uwab1xw346/M7a/DwLJ5Cu35EcAk2OMGwvboMY6IOFAjxCjWibimcLvClLTizPrb5C
	 n7KA7sqwB0hlUra6i1v1ZEz33eUsZx0Pl+UE/jv/F1ShB37PCNrJa73iOwhMnIqbJl
	 kanFWn5JLjIwxb7M3y2HA+pYIXZI+j90e8DROL6V8Vd1xUblTC8VZGDr9CTc7hF2Wm
	 zZaewsccJcbAaiMX7jfRUQgbui5JnvAV1cJVNJOI/7zWO0Qfh4TkRieI8hMFGcJvlF
	 zCLJSz4wZhq1g==
Received: by pali.im (Postfix)
	id 474E395B; Tue, 15 Jul 2025 19:06:37 +0200 (CEST)
Date: Tue, 15 Jul 2025 19:06:37 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250715170637.mtplp7s73zwdbjay@pali>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali>
 <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 15 July 2025 12:43:16 Rostyslav Khudolii wrote:
> >
> > Yes, I would like to get access to ECS via CF8/CFC direct IO for
> > debugging purposes, even though MMCFG is enabled and used.
> >
> > If you can send me a simple patch or any sample / idea how to do it,
> > I would be very happy. I was not able to figure out how to enable ECS
> > over CF8/CFC.
> >
> 
> Hi Pali,
> I'm sorry for the late reply.
> 
> If I understand your request correctly, all you need to do  is patch
> the pci_enable_pci_io_ecs() function to use
> the different register to set EnableCF8ExtCfg: D18F4x044.
> 
> Regards,
> Ros

Hello, thank you for information.

Just I would like to know, where did you find information that the
EnableCF8ExtCfg register was moved to D18F4x044? It is documented in
some AMD specification?

I did not find anything regarding this change.

Pali

