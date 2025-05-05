Return-Path: <linux-pci+bounces-27252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EEAAB7DA
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E002B177A22
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6514298CDC;
	Tue,  6 May 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hSyAR+g6"
X-Original-To: linux-pci@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120528D8C4;
	Mon,  5 May 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488025; cv=none; b=UddKlr9bPx1mi7rrmjK6OxKhtOtZvxY4mCq8VLGXvKJzvwUvCl06rL3SiGbbbHtMAG5SDqibJh88eRjrNc54XWJUEvX0eWnJyLoYl01aqSZL9IyvZJgRkLm2/YLzVVIfsa0TNJpD92wKMwr6qbFVZmInHQ5vE7L2VTnYWz+A/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488025; c=relaxed/simple;
	bh=WKuU6D637T2dkhpGjtXl020F2GzW4nCjRe2GvoQvLTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnDWzp3J6o8Os1wWbTJqIturgNg2U4alK1z8fWZhCwO+J5KVxPSOeA5QDE5dix1giR/t0Ek6Se8GPNcUmvWGII4s/aihb2SxwjwYBvT3vuNA8khdXnNiCtadzg1UCtCjFO4km1sWN39yOKpKy54nhYJCgnD68XIYZClY14V4ALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hSyAR+g6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4iLctDif0AceRqQI03x1YLY/szLkNdkPahqj14SIziU=; b=hSyAR+g6G5cSZIhXSpWzfgyBIi
	YdtMvF5uEwESmaxpIqOqVaqEkTXtgiPAVTswewHfZ3zH0x1RhGqjsaFNb//2dKwXWztnnlYFemguA
	mmIFcGJZUmeNtBjjd4JLhk/b8bjpoVuFOu2R8rs1L0RLNVbjIPxGAmiUUv7HjDlDN0V/LUH/35sq2
	9NY2am0eKOO2K+c6KV+8eZyxr/D16NXWudAHMoGZ0rWMSH8izeWDlf1W/QSjzBms2al3/2cK2c5b+
	EYes1wSiJ68zCQyXIT4YIFU55ft+l8uuBEiP2smuWQr7LGYF6bGCFVkjSfYjTC43jZsVL2wSb1JG6
	i5rOg7Aw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uC5Hw-0000000FZLH-2gQe;
	Mon, 05 May 2025 23:33:33 +0000
Message-ID: <0ab5fe5d-feda-4a3a-8803-92eb4e52e3b4@infradead.org>
Date: Mon, 5 May 2025 16:31:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for May 5 (drivers/pci/pcie/bwctrl.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20250505184148.210cf0aa@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250505184148.210cf0aa@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/25 1:41 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250502:
> 

on x86_64:

drivers/pci/pcie/bwctrl.c:56:22: warning: 'pcie_bwctrl_lbms_rwsem' defined but not used [-Wunused-variable]
   56 | static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
      |                      ^~~~~~~~~~~~~~~~~~~~~~
include/linux/rwsem.h:153:29: note: in definition of macro 'DECLARE_RWSEM'
  153 |         struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
      |                             ^~~~~~~~



-- 
~Randy


