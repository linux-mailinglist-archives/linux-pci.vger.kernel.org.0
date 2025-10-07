Return-Path: <linux-pci+bounces-37691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6507BC2EA8
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 01:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E36934D606
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314A1ACDFD;
	Tue,  7 Oct 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="jyZfXQ6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1762C9D
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878136; cv=none; b=fQg26gPFTysLg7v/Qd5tl9xhroFSo9MEVrCGRR+x0bRL5k1StlvE6dDQdJckuWpSUeRDEWwNBxfAhuQ1/mVnWPoI7ETUSgi4hierDx+GYnYk4R7IsZBfftOyuzVHwEU3Yp76OBJZx3IrsH4pwkYBZbtQmB3gz6tQn6m3FIBPIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878136; c=relaxed/simple;
	bh=CY0+sySbNK5SEsNTHpkyVBbGyXuTARsARzbE3Mc1NQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wuxx0rbMkOk8KxOgoKFoyyfGX72DlToGlOzR/AhA6299jfdVCQfFkbfk+CP7MBWQ/PZaNnsN0uQQzwxgmm95kV3p6kabWIxLMq8U5BbJ1uf9DChysyLax8iqHPy5l3puP1URLS9mp8daeSCHHjLmnPLtrAGDFaObRJ8C37F6DeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=jyZfXQ6/; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chBVD6mnkz3yx0;
	Tue,  7 Oct 2025 19:02:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759878133; bh=CY0+sySbNK5SEsNTHpkyVBbGyXuTARsARzbE3Mc1NQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jyZfXQ6/2Kuyyki13u2WPXtjcDdBFUUEP3JGBied5wP2IS1VePn3tqc9r4MNUG0dJ
	 Wu5W42HyyR1TMVBTrG4zaFC+4M5Kef7i1sdYRtkY22YvwWbHxkh85bnQqYLfmzBqKl
	 YTkqiSpR3vxto23fY0nM0KPlDbo1yhyF4pvBOK3k=
Message-ID: <cb5d09de-d7b6-48bb-9c2a-22094e00ee4e@panix.com>
Date: Tue, 7 Oct 2025 16:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
To: ilpo.jarvinen@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Kenneth C <kenny@panix.com>
References: <dd551b81-9e81-480b-aab3-7cf8b8bbc1d0@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <dd551b81-9e81-480b-aab3-7cf8b8bbc1d0@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/25 14:39, Kenneth Crudup wrote:

> I have a Thunderbolt dock (Amazon Basics generic thing, but it also 
> happens on my CalDigit TB4). With the above commit (and aaae2863e731 
> ("PCI: Refactor remove_dev_resources() to use pbus_select_window()), so 
> the Subject: commit would come out cleanly) if I plug in a TB device 
> past my TB Dock, they don't fully enumerate (i.e., no DP tunneling, no 
> partitions created, etc.)

I should mention for completness' sake that if I attach anything 
directly to the/another TB port it's fully recognized; the only trouble 
comes is when there's a TB dock in the middle.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


