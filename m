Return-Path: <linux-pci+bounces-28356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F9AC2B18
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784EE1B6614F
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C01F78E6;
	Fri, 23 May 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="WSKrnYRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92401F1527;
	Fri, 23 May 2025 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033384; cv=none; b=MJcadLycmjQ7X3wa1V1NDGWnXEzDlfKTySCwlkSLmcwMye7VfK32etzCqKiDkEkmJDMNbVq9WRyKmmsPOn/wDiaolOxNeflT9PyiX5ubeF6mE3ksNVgDjJP5Ex46+ZVUieyqISZZvD/q0SB1jBOLRZ0Ja1gBccblMXyxGn8oHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033384; c=relaxed/simple;
	bh=rmrqfWLefbhaUco9usgJOWeiHWTgCLPJYBQDj5C+X+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkkT9uzyhcT+XtqOuOzHkF2A4dkbPna46OP8jlHJ5P+QL/MaOwDi11zPjrlMJQheQ4hyiwBTrbGauChRc1BG5mgUFj+V1WryDjkE5dtD14mWTgndts+F3Oijf/jRdOIRK/pv0ab5652dX/xWJqoMZiqKBeA32kGftyVIGqpcE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=WSKrnYRu; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.32] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4b3y2V4qhVz4gBY;
	Fri, 23 May 2025 16:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1748033380; bh=rmrqfWLefbhaUco9usgJOWeiHWTgCLPJYBQDj5C+X+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WSKrnYRuyxhZZxgZPtLRdF2Y05TGKqdmF840p+QYiNTTYZs3q76fEr0M4fqCMwkk6
	 reJUsA1txEUxdS+/FMf79FaUrRjHexQEPlJxR3T9o9HiSufUguIw8kXZ1C/2oCHnDG
	 bRVPeRJ/kHhbA0QTtxga70pZX8sdiHy9hRuZTVzU=
Message-ID: <c8746066-b5cf-4582-83d1-02ca28fe4c38@panix.com>
Date: Fri, 23 May 2025 13:49:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
To: "Rafael J. Wysocki" <rafael@kernel.org>, Me <kenny@panix.com>
Cc: Russell Haley <yumpusamongus@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pm@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pci@vger.kernel.org,
 Sergey Dolgov <sergey.v.dolgov@gmail.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Jian-Hong Pan <jhp@endlessos.org>, "David E. Box"
 <david.e.box@linux.intel.com>
References: <20250512210938.GA1128238@bhelgaas>
 <7aedd720-c29a-4225-a79a-d44a3a9ca129@gmail.com>
 <b52a2045-0b26-4287-80a4-e1b571d76a26@panix.com>
 <CAJZ5v0hWAbwtvZm4WrFc06v79JEpTVQ9KeHPuzVkvm5Vp9gK3Q@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAJZ5v0hWAbwtvZm4WrFc06v79JEpTVQ9KeHPuzVkvm5Vp9gK3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/23/25 12:44, Rafael J. Wysocki wrote:

> I would try to replace the PCIE_LINK_STATE_ASPM_ALL in the patch with
> 
> PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1 |
> PCIE_LINK_STATE_L1_1_PCIPM

I could get "Pkg%pc8" with these but no deeper until I'd added 
"PCIE_LINK_STATE_L1_2" to the mix.

(I didn't see any power regressions after that (including 
suspend/resume, but I didn't try for a longer time), so didn't re-add 
"PCIE_LINK_STATE_L1_2_PCIPM", so that one may not be needed.)


-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


