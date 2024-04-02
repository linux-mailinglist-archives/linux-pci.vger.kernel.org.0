Return-Path: <linux-pci+bounces-5564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4A895A78
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BC1286EBE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444B159916;
	Tue,  2 Apr 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AemAqCtV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4814C5B0;
	Tue,  2 Apr 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078103; cv=none; b=VbWi0/45OlKseEOXVep7cFwvZhdyabS6l1kPmhqiIuAzUFh5tnXD1NIFxGC2T/RzKN/0TK2OZKscc339SHpUnLA6/4vdA0ShRK6kzW1lHE5yxCVcOcZhNKaS/vnsbLCN0FbJeiF6U8VpdF002ypXTisz7bp/Dg2k6bO7hQcOYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078103; c=relaxed/simple;
	bh=2BaXhVcstFW0jvQeiK33wxM461j7UJUM44Ukbw+ZOCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dyj/uHM8JD6JI9TJo3cLpRguqYRQdZ7vG7SJ5KOU7QLgNAm3+P+LIwFu6W23NTEsfAGnT9Jqt+aONLwkRHvUHHKYxY+CgBmSxoyzGFYHvsrwhS/R4d2oAMT5q5waCLEBg/IZ/NMy397kZURyL6/UNHVed/je91ABKfNW9hmQ1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AemAqCtV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712078102; x=1743614102;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2BaXhVcstFW0jvQeiK33wxM461j7UJUM44Ukbw+ZOCw=;
  b=AemAqCtVwMI3RjKHQsgfLlZLbgc0f9Kh6S0UGybiSIc/To01ThXJdOF7
   VGec9XM5YZKY9JlAyjzmEKU8np5LRMBKkcIGcAzTtbW/4TJoMPXC7wEZi
   TH9LYTb7/YqntY99nYhkPGjHnG/8g53Nmbzjz5/vTtYWggCXYRh2kgsry
   x9+u3e6gvnWTQ3W6CKCzmtQcTr7LvYR3PIC1WhByxRTCiv5rwxU6iTeM8
   bQPmZJ8PXcV1LBeJ+KWVsfXnH+lNjH2kKFBwr4xdNP/lgU7GFiBRMrhlS
   4CAx8sQHJ0TVqpF5ts9GcnxC53O7xLSULwmf2YbiKMhT/d35Q5rOV+txH
   g==;
X-CSE-ConnectionGUID: 1YWu1/t2ShSymp+Vuh06Hw==
X-CSE-MsgGUID: ntl/8rF5TB6q0aEmhambQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18628480"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18628480"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:15:01 -0700
X-CSE-ConnectionGUID: jDvXfXfAQhSacly1OhphUw==
X-CSE-MsgGUID: Z9fPpwCqQKqqvIQtGi/ASQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18122645"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:15:01 -0700
Date: Tue, 2 Apr 2024 10:14:52 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Bjorn Helgaas <helgaas@kernel.org>
cc: joyce.ooi@intel.com, bhelgaas@google.com, lpieralisi@kernel.org, 
    kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
    conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: altera: covert to yaml
In-Reply-To: <20240401224447.GA1762763@bhelgaas>
Message-ID: <alpine.DEB.2.22.394.2404021012530.364942@sj-4150-psse-sw-opae-dev2>
References: <20240401224447.GA1762763@bhelgaas>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 1 Apr 2024, Bjorn Helgaas wrote:

> "git log --oneline Documentation/devicetree/bindings/pci/" says the
> typical style would be:
>
>  dt-bindings: PCI: altera: Convert to YAML

Good suggestion about the 'git log --oneline ...' I will update title in 
v2.

>
> On Fri, Mar 29, 2024 at 12:00:31PM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Covert the device tree bindings for the Altera Root
>> Port controller from text to yaml.
>
> s/covert/convert/ (both in subject and commit log).
>
> Rewrap to fill 80 columns.
>

Thanks for catching the spelling error. Wrapping and spelling fix will be 
included in v2.

Matthew Gerlach

