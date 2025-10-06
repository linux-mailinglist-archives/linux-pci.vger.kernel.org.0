Return-Path: <linux-pci+bounces-37633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80ABBF1E1
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 21:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B077B34B53F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F2254B03;
	Mon,  6 Oct 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="fkbzrcUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED22AF1B;
	Mon,  6 Oct 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779769; cv=none; b=Hr+v092LQHXtIQ3NAZ6eE9GpW71hGLeXCS0zaVwq2LxQeTI/x4AzJRDoM0dsMVvi5rX3joouXjvnZz6nbhMO8ZE3UZgXHXHFoTgzlyG+47NDHotVYWkCo8gteuekD9UAX5vPQSziErzkBAZovew/kpPc6OGgqHVxewRfWhqELYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779769; c=relaxed/simple;
	bh=agAOwGGk7/WaedOho35v/y7fkZ6L2K5cWMQgm+4Dw14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwf0va0z281/mv6XaMSdQyRoS2c6rmJo+XkuYKSU0MEhzgcqY4BqooK95aHsL9pqWO/T1lZPLiU6eVukcxF9x2NiLMiGoAaIW4OGgubDLPUX2YneOtqHJGyk7IcXbGiKq6CZqyKSrhy2IySUM/uBjyvHOXmvmDV18mEG+Xjm834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=fkbzrcUe; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cgV6R3H8kz4YbS;
	Mon,  6 Oct 2025 15:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759779760; bh=agAOwGGk7/WaedOho35v/y7fkZ6L2K5cWMQgm+4Dw14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fkbzrcUe0oF6iL72n91Lzd5KQVs4pQoGPto4C1OcdfCEW0GJsEV1bCkWDZ5uvhQhp
	 chUB3eXfHVWORwYqfxJUYPNJLnwr+HVdQVlYxnxIEstR0Hy5cJxMqqY3OVIDe2F8it
	 Y20ZU2sHt7dCISBbTqGO4DroK1MoE3Accp2BVReA=
Message-ID: <b2f03b08-4361-4e5d-aaed-8b63ec7c4870@panix.com>
Date: Mon, 6 Oct 2025 12:42:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: Manivannan Sadhasivam <mani@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, rafael@kernel.org,
 bhelgaas@google.com, vicamo.yang@canonical.com,
 ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20250904171158.GA1268495@bhelgaas>
 <121a26de-b5d4-42a2-ae52-02b386f17109@panix.com>
 <s7t5duadivgemkwmx4vjrzsaxy3xdeotwve734sq7iy477g2ur@lwusjd2iklxl>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <s7t5duadivgemkwmx4vjrzsaxy3xdeotwve734sq7iy477g2ur@lwusjd2iklxl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/25 23:12, Manivannan Sadhasivam wrote:

> ASPM patches targeting devicetree plaforms are now in pci/aspm and merged to
> pci/next for testing. 
 > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm

Yes and I see they're in Linus' master now.

> David could send a followup to add the VMD driver now
> reusing the pcie_{aspm/clkpm}_override_default_link_state() helpers.

David? Your old commit doesn't apply cleanly now; I'll give it a shot 
trying to redo it with the new API from above, but as this is your baby 
maybe you could refactor it as well?

Thanks,

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


