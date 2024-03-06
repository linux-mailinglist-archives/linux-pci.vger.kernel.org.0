Return-Path: <linux-pci+bounces-4541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7627872C44
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 02:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D759281427
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BE6FAF;
	Wed,  6 Mar 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cto8kBu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B70ECF;
	Wed,  6 Mar 2024 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689032; cv=none; b=FyWupOAJYw5bxIqIDpzZU/fzAPivFekc9lLzS8WLcC8IU0hlYU0pOCfVz6+jlzsDvPnfBKhnt6s6hkkiluucoU/wvr1Wi6RZyH/oHiKRsAzQz98TSWgSnpy10elUygxd9JikGEx39CLf+ZV9vAwEp8fQ0nHOaZ3Ig7KLJB/X3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689032; c=relaxed/simple;
	bh=nNCPtCjeN4ZD5FeOywBZs3lEGyACtFVhReOebhXpM4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKiSvVo/Saae16h/XWHIOhTGbQrIlmIv58li0eyW+CiAedDkqWjZDLE+/FDpJYSnwxGrrMMlfuLyt62Y2NAGESXd8YwY7uqwbZDXfTbvR3S6QaNiRQULxCcVAIB7nQldZDBGm4i2DKy9RikiAmCPT+H7hp1isZwUoLcGaG/U9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cto8kBu8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709689031; x=1741225031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nNCPtCjeN4ZD5FeOywBZs3lEGyACtFVhReOebhXpM4M=;
  b=Cto8kBu8guHHeJ0pvZgsRijvZu5BS376D/n6jIJkBblRs2CVqNchY3jM
   yhBuAc0TAptyWFI0yneXfFK+czYap9CR7d9Q/hJ21/ioe5sdRTxKxtwVp
   /jfSAN6XO7OJ9AaZ4UHrwf7NXvKrpNN3EmmJefv/TH+xGLlDQq1mduppI
   1w0G66gLcAuvfKUIUtkjE5JlwOVPQKX4xGgO/5Pv0TfOu+h5KlDlfdZhx
   /ru5fQPR7rLiJEvfvhIEY10UCKhFaMV1W3DU7XJPf/zFW7ZNw0DfCSF38
   u2hwlWC4B7n1k6tMp4ZMIxprPUgRjayzu4FedwUiabwttbtmAI4dBdqN5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15425596"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="15425596"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14146701"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:37:05 -0800
Message-ID: <4908a5ab-dc07-41fa-bdf4-36b1f3f516e2@linux.intel.com>
Date: Wed, 6 Mar 2024 09:37:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, Smita.KoralahalliChannabasappa@amd.com,
 ilpo.jarvinen@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240305092139.GA28325@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240305092139.GA28325@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2024 5:21 PM, Lukas Wunner wrote:
> On Tue, Mar 05, 2024 at 10:09:20AM +0800, Ethan Zhao wrote:
>> On 3/4/2024 7:58 PM, Lukas Wunner wrote:
>>> On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
>>>> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>>    {
>>>> +	if (!dpc_is_surprise_removal(pdev))
>>>> +		return false;
>>> This change of moving dpc_is_surprise_removal() into
>>> dpc_handle_surprise_removal() seems unrelated to the problem at hand.
>>>
>>> Please drop it if it's unnecessary to fix the issue.
>> To only export one function dpc_is_surprise_removal()... or I have to
>> export them both.
>> Seems I should keep them intact or refactor them in separated patch ?
> Please keep them intact and make both public.  (You're not "exporting"
> the functions, there are no modular users.)
>
> However, I doubt whether you need to respin this patch at all:
>
>
>> Reproduced on "Hardware name: Intel Corporation ArcherCity/ArcherCity,
>>   BIOS EGSDCRB1.86B.0107.D20.2310211929 10/21/2023"
> Eagle Stream BIOS, isn't that an Intel-provided BIOS?
>
> Sathya's comments sound like the BIOS is misbehaving.  If so,
> then the first thing to do is ask the BIOS team to fix the issue.
> We do not want to pollute the kernel with workarounds for BIOS bugs
> that can be fixed in the field through a BIOS update.

Agree, BIOS writer finally was convinced to fix it in BIOS.
no need to respin.


Thanks,
Ethan

>
> Thanks,
>
> Lukas

