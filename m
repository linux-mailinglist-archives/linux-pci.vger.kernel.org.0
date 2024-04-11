Return-Path: <linux-pci+bounces-6157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C78A2259
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 01:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF6281973
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 23:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC443481CD;
	Thu, 11 Apr 2024 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESAYJtWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A518B14;
	Thu, 11 Apr 2024 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878468; cv=none; b=PPyZKP44iIgm2cuvOaISwxO5E3BU4P1KZXLzR+vNuaiJlQsKE/oQeTJ5Xs+znahPhtuVg8S/IznEtDMeFf3rmr6zqYnZ43GmgvRkO1NNAyZkX+iriQnMqP+tDCWli5dZXy75ftTtWr5TcgFG131REwNqIdEPtrgMz5zR/D5J+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878468; c=relaxed/simple;
	bh=sk0XiYegamb+eqwCZVvKDkTYSQ0dUvVPxzkYMKFwSms=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oXBrcbIbtz1Z2aAavkxLmPkLgfHXOQ+deaFtKobncMpPxhKtkxUnpj2clctnaW2DhAfmfbBO6uttavgkZPrXJstOwCNwo0+sAMtXiezW26/gLlx/Fy/WxlOJ/j9T3MV4p/shaeC5C+Sbtmw8OKT40hly8r7GNLOmaHTfTQqHXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESAYJtWa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712878468; x=1744414468;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sk0XiYegamb+eqwCZVvKDkTYSQ0dUvVPxzkYMKFwSms=;
  b=ESAYJtWa9cUNeBwDgfffdhJTSfYgYFrJKx+Lb0hOAuaACPiTiMNolZhu
   hcSUEHxz7RlJQ7YIvK93Sb8/ShI5agsllBfbNFHBCzcclCPHy/Mp8+iKY
   Ifua8eeSWTGdXSfagqrW6dPtJJVxpEV3RpIXo1j9Bv0CN7ns4qXomewYu
   3E3lt7giYZEqIKD+9PFbcYGrH6CHNrudD6WuGIehbegmhs1Ecfifset05
   W8KzWR7eJBaf0zBOrOOWFKc49c4g6oGrxS1UV8YIdKLUhO0YoU1YaWAjx
   Mww6Aalob9TzmYZ2rjVr/H/qk7lIl8pQiZUm2ZBGayLL5iUlVjdjW4wYP
   Q==;
X-CSE-ConnectionGUID: s58ahnDjS76XxaX9tMEjNw==
X-CSE-MsgGUID: 1Riv5fVHSdaQQfzRbGsPFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19033043"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19033043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:34:27 -0700
X-CSE-ConnectionGUID: J/Y4eHXCSzuDf6OhJw2BTA==
X-CSE-MsgGUID: Ct90QprWT1SeV9B2FRDd4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25597967"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:34:26 -0700
Date: Thu, 11 Apr 2024 16:34:17 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, bhelgaas@google.com, 
    lpieralisi@kernel.org, kw@linux.com, krzysztof.kozlowski+dt@linaro.org, 
    conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240410172924.GA622917-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2404111619010.410528@sj-4150-psse-sw-opae-dev2>
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com> <2ece9ac2-899c-4185-b0f3-8ab939afc1e5@linaro.org> <alpine.DEB.2.22.394.2404081309050.381257@sj-4150-psse-sw-opae-dev2> <d079bf4d-ebfe-4d98-b718-0c545aabbd30@linaro.org>
 <20240410172924.GA622917-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 10 Apr 2024, Rob Herring wrote:

> On Tue, Apr 09, 2024 at 08:29:07AM +0200, Krzysztof Kozlowski wrote:
>> On 08/04/2024 22:34, matthew.gerlach@linux.intel.com wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..999dcda05f55
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>>>> @@ -0,0 +1,106 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +# Copyright (C) 2024, Intel Corporation
>>>>
>>>> This is derivative of previous work, which is easily visible by doing
>>>> the same mistakes in DTS as they were before.
>>>
>>> This is definitely derivative of previous work, and I want to fix the
>>> DTS mistakes too.
>>>
>>>>
>>>> You now added fresh copyrights ignoring all previous work, even though
>>>> you copied it. I don't agree.
>>>>
>>>> If you want to ignore previous copyrights, then at least don't copy
>>>> existing code... although even that would not be sufficient.
>>>
>>> Ignoring previous copyrights was not my intent. There is no copyright
>>> statement in the original text version of the device tree bindings. Should
>>> that lack of copyright statement carry forward?
>>
>> All the authors are copyright holders automatically, at least in some or
>> maybe most jurisdictions. You do not need to add copyright label for
>> material to be copyrighted. That's why you are not allowed to relicense
>> the work for example, without other authors' agreement.
>
> The only thing I see as missing is some years. All the authors were
> Altera which is now Intel, so Intel is the sole copyright holder.
> Whether is says 2015 contributions were Altera or Intel is probably
> immaterial.  There were also contributions by Google (Bjorn), but those
> were purely editorial.

Yes, Altera is now Intel who now owns the copyrights. At some point the 
future this might change as Intel spins off Altera. So given the state 
now, should the copyright line be as follows?

# Copyright (C) 2015, 2019, 2024, Intel Corporation


Matthew
>
> Rob
>

