Return-Path: <linux-pci+bounces-11488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7994C038
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309BB1C2146A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA787190692;
	Thu,  8 Aug 2024 14:47:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11FBE5D;
	Thu,  8 Aug 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128430; cv=none; b=tm1vKdsH7jOV6A/xJD8DW42ND6MpKtxEvEcnQqVsc3mag2CzczkRkHYem6yacaVbP3FcM+uBSGBoIdIYPbp0OCCEI0MExZ+pG5gwZATk6zokVdf/HNKKgcfvBo47WAnp5L9dn6g99ckum/UmY1D2oUqPANtv3emzWy/fmnPdzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128430; c=relaxed/simple;
	bh=44OMY1Rz2f6aeQg49EK+58rmPUMUd8BEw9Fs8yRIY+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6mCPJuOCWveJXiYSZbwlsB4AGsczo6sZ997rOEdwJ4k46CKooWQ7Umj5wY8KaNkpCndIt+KTTuo9vDh1O74GVd5n75EF0aGfXE5qKy5MZiWwQjaO6W/BnalnbCNqb7DRviBXtRkJZ9G9JnjtcJDjt5XsMZHPwKY0E4FJi3dM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1sc4Ov-005Exg-2s; Thu, 08 Aug 2024 17:46:01 +0300
Received: from [10.198.19.72] (unknown [10.198.19.72])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WfqcX1NF2zkWJv;
	Thu,  8 Aug 2024 17:46:36 +0300 (MSK)
Message-ID: <60fc38e5-cf67-4199-b5fb-d5f0f5d6ca77@astralinux.ru>
Date: Thu, 8 Aug 2024 17:45:45 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH RFC] PCI: kirin: prevent buffer overflow in
 kirin_pcie_parse_port
Content-Language: ru
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240715134917.14760-1-abelova@astralinux.ru>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20240715134917.14760-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepjeefheffjeehtdehvdeugfehiedvleejhfeugeeuhffguefhgffgtdfhgfdvgfegnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrdduledrjedvnecurfgrrhgrmhephhgvlhhopegluddtrdduleekrdduledrjedvngdpihhnvghtpedutddrudelkedrudelrdejvdemheeikeduvddpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopehsohhnghigihgrohifvghisehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepfigrnhhgsghinhhghhhuiheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifsehlihhnuhigrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrg
 grshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgdohhhurgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1723124212#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12094337, Updated: 2024-Aug-08 12:38:52 UTC]

Just a friendly remainder.


15/07/24 16:49, Anastasia Belova пишет:
> If pcie->num_slots = MAX_PCI_SLOTS, i equals MAX_PCI_SLOTS
> during the next iteration. Then pcie->gpio_id_reset is accessed
> by invalid index. Strengthen check on pcie->num_slots to
> prevent this.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d5523f302102..5ef3384c137d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -413,7 +413,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>   				continue;
>   
>   			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> +			if (pcie->num_slots >= MAX_PCI_SLOTS) {
>   				dev_err(dev, "Too many PCI slots!\n");
>   				ret = -EINVAL;
>   				goto put_node;


