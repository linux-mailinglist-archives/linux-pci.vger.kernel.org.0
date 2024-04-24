Return-Path: <linux-pci+bounces-6609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7A8B010A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 07:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF11C2254C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475C154BFC;
	Wed, 24 Apr 2024 05:30:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A66156873
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936654; cv=none; b=ga7QmdTMgHMAa4CGLOLVNB8t7EqbN7XpHUjUhF+1Nb2B2TkifhiHEc8w4+T1LYmKDDFZsq30ZdIdRB9pHxSWQ1gh06815a03+juYkBnjVnXEnnofh3UTBI1zXQGo9Lf10LFLZLcmBFLRAWWMPA2SBacmg0RGEi3y6Vyym4r3Lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936654; c=relaxed/simple;
	bh=y7FJxfYjyMYzJ6Nwt0TuqXxs0XRptmKd77gyosE9II4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mFd1LzfbRJ9Fue8uvdbTg8QPvJqOrFfIU7QUtyFYJDJqv7FQfTOG7DPogC4cdp4we6/dnhM8PZqw+YH6RLHZt3tJevTkujcs9/aIBKLAkbA7N6JtV+cSyHHb/dfsmO25zCR57G17L4pP9AD0u4CD5gM+bC1HtcHBvsLYCRI5IVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af5d1.dynamic.kabel-deutschland.de [95.90.245.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C617761E5FE05;
	Wed, 24 Apr 2024 07:30:42 +0200 (CEST)
Message-ID: <ed4d665b-7f3c-4459-a697-a28ed745d0c3@molgen.mpg.de>
Date: Wed, 24 Apr 2024 07:30:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Booting with `pci=nobios` fails on Dell XPS 13 9360
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


On the Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, booting Linux 
6.9-rc5-00036-g9d1ddab261f3 with `pci=nobios`, the internal keyboard 
does not work, and there are DRHD (IOMMU) errors and intel-lpss errors 
printed by Linux. (As the keyboard does not work, I am unable to enter 
the LUKS passphrase, and capture the Linux messages.)

Is that option supposed to work, and should Linux be able to detect and 
configure itself without the help from the system firmware?


Kind regards,

Paul

