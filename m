Return-Path: <linux-pci+bounces-3258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5E84EAED
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9208E289C6D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FD4F5F1;
	Thu,  8 Feb 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjeZhXif"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217094F5EC;
	Thu,  8 Feb 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429320; cv=none; b=UwVw7IDCqfwKj01+pms34coBKV9GrkQSVfDlUbFeT+3Hhne6bwY46SU6xzr3tP+UHBhP0SkW6v8hwMD8O2rC9IBtc2yoV9qjd2SGjFno9I7GlLKrFYfxZwIW0UB0UGWVXmUxb8ABGij4ybqz45ZofV+6NR3mteI5lsIbJ8Ao8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429320; c=relaxed/simple;
	bh=qpe/bk740xF6+TArsiyZ/Gghuo9KZRMRpbOgjwEkEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=chdeUDKndjvDbH+iAxT29EUt/BX2YW75JWoYCW7xNqH1wo3eQXeT/fHaBWZT8F1CmMgJRqtJw+c3h71taweupnb6EvFfDklOL1t7dYD22nZzOk3C4DdFX8ksfYVlyWuq6z+ecqzQKwlzKuSf2385Z94G9qGY7ajMqgNpfJfXxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjeZhXif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46884C433C7;
	Thu,  8 Feb 2024 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707429319;
	bh=qpe/bk740xF6+TArsiyZ/Gghuo9KZRMRpbOgjwEkEhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sjeZhXifEJf/k4TsbGWdWut7BtgKYaxXZTB2KxSyor/EiRbh4Wi8Etc4GihBCJALM
	 qGKELDZB4EgLn2olUjTypzSXJABv6zajA+bLz9kfJVUCgxn4aC7Tc3osufJIolTQum
	 1MEvWxoK3fRQQX+gjLiJmxFy2WER2Ck+aItjkbNrXTUklHsSU+/jWuuaYr67AROwOk
	 6I2TRda4viTydGv80rvQy3xocF2HepUYHPHQkh6LNXJ0al/yEBFlukwfzTkVqaWqDM
	 6XZGJqllN5SsGCW9yPpRCp5HH4YqX2F8X4tAgvYwxJlkvAtKGDS9+XjrPOm24B93Fx
	 493bpwVyMdI9A==
Date: Thu, 8 Feb 2024 15:55:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH kernel 0/4] pci/doe/ide: Capabilities, protocols
Message-ID: <20240208215517.GA974726@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060228.3070928-1-aik@amd.com>

On Thu, Feb 01, 2024 at 05:02:24PM +1100, Alexey Kardashevskiy wrote:
> Here are 4 small independent patches defining new PCIe caps and bits and
> protocols, I am using them with my test device so they are real :)
> 
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (4):
>   pci/doe: Define protocol types and make those public
>   pci/doe: Support discovery version
>   pci: Define TEE-IO bit in PCIe device capabilities
>   pci: Define Integrity and Data Encryption (IDE) extended capability

For changes in drivers/pci and related files, follow the subject line
convention (learn from "git log --oneline drivers/pci/").

