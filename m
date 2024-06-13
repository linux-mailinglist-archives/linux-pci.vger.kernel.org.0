Return-Path: <linux-pci+bounces-8697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF479061AE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 04:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20501F2141C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556741A84;
	Thu, 13 Jun 2024 02:20:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993833062;
	Thu, 13 Jun 2024 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245244; cv=none; b=Z1pDo2AmU3NgtNwrGZQd709h4zpuE6e87i5K9185y7A2Zv1eAeGi4qh6rWgSfk6yCF9TwOJ7KMwca78By5Xb7H6njMm4Gv+aEQ2Ti0zY/f/jLVTl9t1rqtXODHtIOn2K8ZLiijeyw7sCl4BtauK+2mataa7ONax1Se7miAC2bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245244; c=relaxed/simple;
	bh=NrB1tWFuIhfmrmOs66MYBHQVmBB3oACaTlrPzQkS7dA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nj87qpjDHPRvlcWBIjO6f/UMp8K1UAY/bVC3gWssBkJUFebj3wC+62QNtXsxpLTgX4BQX7GuobKZirHjgVYJCY5Ycy6A67zElASNeir1Falhq1dslaWDP67t2jcyOET7sZXPn8xU5AXPgt9csRW/6lO5fl9CSy0MpwPKbt6MpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Bx3+t0V2pmEkEGAA--.9673S3;
	Thu, 13 Jun 2024 10:20:37 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx78dvV2pmVgceAA--.8207S3;
	Thu, 13 Jun 2024 10:20:32 +0800 (CST)
Subject: Re: [PATCH v2] PCI: use local_pci_probe when best selected cpu is
 offline
To: Markus Elfring <Markus.Elfring@web.de>,
 Huacai Chen <chenhuacai@loongson.cn>, linux-pci@vger.kernel.org,
 loongarch@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240605075419.3973256-1-zhanghongchen@loongson.cn>
 <9bf241c5-68af-4471-a159-1c673243d80d@web.de>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <d36de70b-3052-71eb-fdb4-c09256ff3b96@loongson.cn>
Date: Thu, 13 Jun 2024 10:20:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9bf241c5-68af-4471-a159-1c673243d80d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx78dvV2pmVgceAA--.8207S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAHB2ZqUJQAbQABsl
X-Coremail-Antispam: 1Uk129KBj9xXoWruF1kZryruw1fZFWkKr43CFX_yoWkWFc_uF
	n5GFs7Z3yqyr1DXanYkrsxuF98Wa17AFySyw18JFnF9w15J3ZxAayUJry5Aw15X34a9rn8
	C3WYq3y093W3uosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=

Hi Markus,
   Thanks for your review.

On 2024/6/13 上午2:08, Markus Elfring wrote:
> …
>> This can be happen if a node is online while all its CPUs are offline
>> (we can use "maxcpus=1" without "nr_cpus=1" to reproduce it), Therefore,
>> in this case, we should call local_pci_probe() instead of work_on_cpu().
> 
> * Please take text layout concerns a bit better into account also according to
>    the usage of paragraphs.
>    https://elixir.bootlin.com/linux/v6.10-rc3/source/Documentation/process/maintainer-tip.rst#L128OK, Let rewrite the commit message.
> * Please improve the change description with an imperative wording.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc3#n94
OK, Let me use imperative word.
> * Would you like to add the tag “Fixes” accordingly?
OK, Let me add Fixes.
> * How do you think about to specify the name of the affected function
>    in the summary phrase?
OK, Let me add the affected function in summary phrase.

> 
> Regards,
> Markus
> 


-- 
Best Regards
Hongchen Zhang


