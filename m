Return-Path: <linux-pci+bounces-27450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886BDAB0002
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C00189ECD6
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161FE27AC43;
	Thu,  8 May 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nO8XRuLa"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1D27E7EF;
	Thu,  8 May 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720864; cv=none; b=E+DYO1z+Kdlr0HspiRtgLZTGd154bdbuoVHbHieXcEovpodIMbMsdZ/gxIJ6GmFqUA5YtJWjZ0/UO/mhYhblTto/eJJZp/js4jHqyL9Lx60CfXEtQUz34Tvta/haSbCmsW2Sis2Vxw5cs9Ex8rzfTiDvaR3HEYGhBuiCTGlB7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720864; c=relaxed/simple;
	bh=hX5iMWpZ9yceRFUoRBf9NqUVir64zEn65k32D5jq2AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXzo/TywFNsYdA3pfIaAvREzeLaHViUQPzjY98EVJr9eHPYKGb80SfoyOOvNiqdd+7yIpF/+CHjZbe8Xj6EPIb5mzctvegzaxBmCTBcOm67W1GSKd+5Y4/3HmPwNqktkQav8ZB6Sf79wnQ5jddekDF72Zft0NSkL6UB93t5T+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nO8XRuLa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=81aBPS6yBfZnl27zRH7ZXiOuAu20NzRTJepaZfWeHBs=;
	b=nO8XRuLaqeMEuHMiGg9pJfKjkfKjM+1nBX1d2T192PZgLu6UTTHVGO6dXzLDW0
	cf/AsM6lG5pEV67BuhdNNSy0k9bRt19USAk9majVuVTNoA4jdIixL8ThyfVnZqF0
	HUDD0DJf8rE0C9zNyn9/2YPnlyot7ejFIaDGGmtjL04wY=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJmHo1xxoaC4OAA--.307S2;
	Fri, 09 May 2025 00:12:25 +0800 (CST)
Message-ID: <25c89e3c-9625-49ac-b816-945ab9145f87@163.com>
Date: Fri, 9 May 2025 00:12:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
To: Niklas Cassel <cassel@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, lpieralisi@kernel.org,
 kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
 manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <b364eed2-047d-4c74-9f30-45291305bc4b@163.com> <aBybUYYhrmlOeLAj@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aBybUYYhrmlOeLAj@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJmHo1xxoaC4OAA--.307S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18XF48WF4Uur1kXF1xAFb_yoWkCrbE9r
	9IkrWxC3WUGan7Crs7Krn3ArWqqayDZ345W34Fy3y3A3s8ArW5uFs0k3ZaqF1rtay3KF4q
	kryYvF1jkrW29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbku45UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwpGo2gbipOKhwACsF



On 2025/5/8 19:53, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, May 08, 2025 at 12:47:12AM +0800, Hans Zhang wrote:
>> On 2025/5/8 00:36, Pali Rohár wrote:
>>>
>>> Sorry, but I stopped doing any testing of the aardvark driver with the
>>> mainline kernel after PCI maintainers stopped taking fixes for the
>>> driver and stopped responding.
>>>
>>> I'm not going to debug same issues again, which I have analyzed,
>>> prepared fixes, sent patches and see no progress there.
>>>
>>> Seems that there is a status quo, and I'm not going to change it.
>>
>> Dear Niklas,
>>
>> Do you have any opinion on Pali's reply? Should patch 3/3 be discarded?
> 
> While I do have an opinion, I'm not going to share it on a public mailing
> list :)
> 
> With regards to your patch 3/3, I think that your patch looks fine, but if
> the driver maintainer does not want the cleanup for >reasons*, that is totally
> fine with me. However, I'm not a PCI maintainer, so my opinion does not really
> matter. It's the PCI maintainers that decide.
> 

Dear Niklas,

Thank you very much for your reply. Let's wait for the decision of the 
PCI maintainer on this series of patches.

Best regards,
Hans


