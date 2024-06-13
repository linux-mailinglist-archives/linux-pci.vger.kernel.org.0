Return-Path: <linux-pci+bounces-8758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E485E907D33
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788BCB2635D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EC136E1D;
	Thu, 13 Jun 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+NGYBMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD078C80;
	Thu, 13 Jun 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309609; cv=none; b=QkmiTzfx0pnKvCycg2lM8UWIUcdITLInB8liTcfxgSt5QGYi4EKfDdYaYuliy0zN51zosqvo6KOT4o9jtcuYt7jM5VrGbvJvsyB7m0d2M1m/FrUSDCY0AVAt24+JKzZA9xJYwmuStWLRH+yn2dLCyG/gK/zRGV5fe6PlnXuvlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309609; c=relaxed/simple;
	bh=G6I+tiBGGMSLsR0tz+OV9tBUoiDJ7Ijy7tbjP5zhCsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FP9S9o87jpRG3gkmEbkjI4Jy3PI46k0mCGPy5/b9+6OTIiIJLoMpk1GEutqJp8irwaRgPKZ1rbgUm182Ti3oirIMfC4s43uF32oG7KdJgPwaBQVS5qACPoyrRDXYTWElFpKksmDi3WwyMIGq5GIhdkJuchxyA5rItdb47oleBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+NGYBMf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718309608; x=1749845608;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G6I+tiBGGMSLsR0tz+OV9tBUoiDJ7Ijy7tbjP5zhCsY=;
  b=F+NGYBMfZwS6M5uttcSQdQxppDHsC0iUrL98nGewldXlFp6gUMoEI6Sz
   N//OKKDUG2roFeL7bTV5P7ZEwL1BRVdjNKzvbRKXYrwWaIsAe2kS6UrzH
   8zj2YNpL6/NQywvFGInHfnAsd9/wmEODnJZ3AZCkZaGx0+P9BKsFTuTIT
   jaT5sup9ab1hU2cTba3T3qRcnUq2Zb37fS+33AkBr1h8XbAoxU2/+FB+K
   TSwDKTRMBoJ81jrqDJI8zt5s5UjPR/KMaXIOaOlNRCVh3hIhfgK3MxTjq
   Mu0vq+/Ie/OBsLzt7OxwoL9x7N6QXSAnRc9Jwhe1jq/KXVzgNzrHURd0B
   g==;
X-CSE-ConnectionGUID: atiIDKjMTfSUWIZ5FqsJLA==
X-CSE-MsgGUID: Gfq791A4QK6E8nSrMxNkpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25841053"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25841053"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 13:13:27 -0700
X-CSE-ConnectionGUID: aP4YqvWsSXCVaXYJEkhp+w==
X-CSE-MsgGUID: EkxNsMyxQXSHzqF/O/96+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40926394"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 13:13:26 -0700
Date: Thu, 13 Jun 2024 13:13:26 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com, 
    bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org, 
    conor+dt@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: altera: support dt binding update
In-Reply-To: <20240613175131.GA2070202-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2406131301550.662691@sj-4150-psse-sw-opae-dev2>
References: <20240611170410.GA989554@bhelgaas> <alpine.DEB.2.22.394.2406120744350.662691@sj-4150-psse-sw-opae-dev2> <20240613175131.GA2070202-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Thu, 13 Jun 2024, Rob Herring wrote:

> On Wed, Jun 12, 2024 at 08:12:05AM -0700, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 11 Jun 2024, Bjorn Helgaas wrote:
>>
>>> On Tue, Jun 11, 2024 at 11:35:25AM -0500, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add support for the device tree binding update. As part of
>>>> converting the binding document from text to yaml, with schema
>>>> validation, a device tree subnode was added to properly map
>>>> legacy interrupts. Maintain backward compatibility with previous binding.
>>>
>>> If something was *added* to the binding, I think it would be helpful
>>> to split that into two patches: (1) convert to YAML with zero
>>> functional changes, (2) add the new stuff.  Adding something at the
>>> same time as changing the format makes it hard to review.
>
> The policy for conversions is changes to match reality are fine, just
> need to be noted in the commit message. That generally implies no driver
> or dts changes which is not the case here.
>
>> Thanks for feedback. It was during the conversion to YAML that a problem
>> with the original binding was discovered. As Rob Herring pointed out in
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240513205913.313592-1-matthew.gerlach@linux.intel.com/
>>
>> "Making the PCI host the interrupt parent didn't even work in the kernel
>>  until somewhat recently (maybe a few years now). That's why a bunch of PCI
>>  hosts have an interrupt-controller child node."
>>
>> This was an attempt to fix the problem. I can resubmit a conversion to YAML
>> with zero functional changes.
>
> I wasn't suggesting you fix it. Just something I noticed looking at
> the other issue. If no one noticed or cared, why bother? It should work
> fine for recent kernels.

Thanks for the feedback. I can resubmit a single conversion commit that 
passes the schema check by adding 3 address fields as you suggested. I 
will also mention this slight modification in the commit message.

Matthew

>
> Rob
>

