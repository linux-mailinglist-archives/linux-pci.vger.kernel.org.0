Return-Path: <linux-pci+bounces-20497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C7A2107D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A5D1689CF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFA1C5F1D;
	Tue, 28 Jan 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhERA85L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449CF1DC9BE;
	Tue, 28 Jan 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087866; cv=none; b=lxpdTYZLn7JEOEtVnkZmXlCioFW7la9oIDbGgiiAFe27/XiEe36adoCxVxIethh1qtsdEFJPadiop3hokSlGGI7Rqy18psIT6Vc3ZO5F4Hc8nlRLuMofSokhcc/akBafT4gnUZvrLSqxdyNUCMVNY2Uml5zG85IR79eJ8iuFhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087866; c=relaxed/simple;
	bh=6iUo6+Kgwo1Lg5/UqnQyym/poX4xhRu6u3Uunf7pHRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8O8WajW9upqw6AbtKqrgvv7HZEcCvmRnajdy2UmXB8MZE2LbAq8fRqN06VWxjkcWUYBL0qTLK/Lc54slhL6ZWcCvk4r9BJHC2CcxuURzLKD+HkFY4xKqrjukM/6xudQTFl1YSkTXiRzZeIVkRopv1Co3flVZBqnITqAlqCr6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhERA85L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695C8C4CEE1;
	Tue, 28 Jan 2025 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738087865;
	bh=6iUo6+Kgwo1Lg5/UqnQyym/poX4xhRu6u3Uunf7pHRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhERA85LQ9laU9ZDG/1SF6nR6VdmydXlRcKYuruAH83cIdFym1wz8FyT9mtKAkLFE
	 Z5iRkhLV8zXGXxV0/jpSDiS0TMe9Nxy7GafbOh8DlDU/m7Ul1SRQ36mKLt+l9uBa3w
	 AAFlCcNrgsNvKuv+mcNTn9hJc/pbTbQ+EkPV3brLAvwjVUAKb1DkU+KRsAoExDSgqD
	 mxmsPLOzGSuAtK+U5Db2Irxs3/oKkROphLFQGhuVjGYTrV8OUiskYZQgMZeLpc4wh+
	 dDiwrPw1litXYLIU1OalVavCD/F9hfDq3Rjw290CTDKxjeDYbvSSUyCGsfqA3VEo+V
	 a4mNYnJnNOZvA==
Date: Tue, 28 Jan 2025 13:11:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.13 13/15] PCI: Store number of supported
 End-End TLP Prefixes
Message-ID: <Z5kduHuaGWQwS9M_@lappy>
References: <20250128175346.1197097-1-sashal@kernel.org>
 <20250128175346.1197097-13-sashal@kernel.org>
 <19475994-b606-604e-f17d-a5251026c4df@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19475994-b606-604e-f17d-a5251026c4df@linux.intel.com>

On Tue, Jan 28, 2025 at 08:00:39PM +0200, Ilpo Järvinen wrote:
>On Tue, 28 Jan 2025, Sasha Levin wrote:
>
>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> [ Upstream commit e5321ae10e1323359a5067a26dfe98b5f44cc5e6 ]
>>
>> eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
>> are supported by the path or not, and the value is only calculated if
>> CONFIG_PCI_PASID is set.
>>
>> The Max End-End TLP Prefixes field in the Device Capabilities Register 2
>> also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6.2 sec
>> 7.5.3.15). The number of supported End-End Prefixes is useful for reading
>> correct number of DWORDs from TLP Prefix Log register in AER capability
>> (PCIe r6.2 sec 7.8.4.12).
>>
>> Replace eetlp_prefix_path with eetlp_prefix_max and determine the number of
>> supported End-End Prefixes regardless of CONFIG_PCI_PASID so that an
>> upcoming commit generalizing TLP Prefix Log register reading does not have
>> to read extra DWORDs for End-End Prefixes that never will be there.
>>
>> The value stored into eetlp_prefix_max is directly derived from device's
>> Max End-End TLP Prefixes and does not consider limitations imposed by
>> bridges or the Root Port beyond supported/not supported flags. This is
>> intentional for two reasons:
>>
>>   1) PCIe r6.2 spec sections 2.2.10.4 & 6.2.4.4 indicate that a TLP is
>>      malformed only if the number of prefixes exceed the number of Max
>>      End-End TLP Prefixes, which seems to be the case even if the device
>>      could never receive that many prefixes due to smaller maximum imposed
>>      by a bridge or the Root Port. If TLP parsing is later added, this
>>      distinction is significant in interpreting what is logged by the TLP
>>      Prefix Log registers and the value matching to the Malformed TLP
>>      threshold is going to be more useful.
>>
>>   2) TLP Prefix handling happens autonomously on a low layer and the value
>>      in eetlp_prefix_max is not programmed anywhere by the kernel (i.e.,
>>      there is no limiter OS can control to prevent sending more than N TLP
>>      Prefixes).
>>
>> Link: https://lore.kernel.org/r/20250114170840.1633-7-ilpo.jarvinen@linux.intel.com
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hi,
>
>Why is this being auto selected? It's not a fix nor do I see any
>dependency related tags. Unless the entire TLP consolidation would be
>going into stable, I don't see much value for this change in stable
>kernels.

I wasn't too sure about it either. My thinking was that there is a spec
compatibility issue here, but looks like I was wrong.

I'll drop it, thanks!

-- 
Thanks,
Sasha

