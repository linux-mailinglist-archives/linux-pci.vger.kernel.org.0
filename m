Return-Path: <linux-pci+bounces-12622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B954C96899B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC112844AF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BED19F12A;
	Mon,  2 Sep 2024 14:15:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8D19F139;
	Mon,  2 Sep 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286520; cv=none; b=ECm6diMKMt8Q94DnREbXaBeRrbA7RhCF15JKjEj1B2GEYZFYNOsLpDR0e+2ddTpNTVtxAjP58RMeF6sL3Dl14uYxS81dZr4K6HWJTzMvNdekSZL7H5E7FsvsgxM6Wu7Xc50WJLNIuxDB1Ym0m0wlNR4SCWHbtDIkJtCn+tZjuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286520; c=relaxed/simple;
	bh=eKcS4egfaLEvKsQO+3YJgecSI6VbK+jzE9ME7MUG9So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ol7bSCgy6hf7DqE1ELSBkItpdDiKtVnHBeVa0LB7aePhGQlxIqA7wCRV2HiCWcI3CbTW2apty/wcLioNxgA0QT7tujXXA7TGonEsUnJmZhNu+L2f1jcVsUoNw+Klhj6aGLLaNWufWOwU5KgFXlGUzAiEJDTglNCNhKlN5swxzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1sl7oK-009LEN-2i; Mon, 02 Sep 2024 17:13:40 +0300
Received: from [10.198.21.172] (unknown [10.198.21.172])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Wy9k943bTzkWM5;
	Mon,  2 Sep 2024 17:14:41 +0300 (MSK)
Message-ID: <1e9500de-3388-402d-84a3-cebca7bc24df@astralinux.ru>
Date: Mon, 2 Sep 2024 17:14:34 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH v2] PCI: kirin: Fix buffer overflow
Content-Language: ru
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240719122153.1987-1-adiupina@astralinux.ru>
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <20240719122153.1987-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepveefleetjeetfffgleeuvedujeffieffgedttdegudejheetfeeikeffueefgffgnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrddvuddrudejvdenucfrrghrrghmpehhvghloheplgdutddrudelkedrvddurddujedvngdpihhnvghtpedutddrudelkedrvddurddujedvmeegfedtfedvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopehsohhnghigihgrohifvghisehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepfigrnhhgsghinhhghhhuiheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifsehlihhnuhigrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 gshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgdohhhurgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725281031#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12155458, Updated: 2024-Sep-02 12:31:53 UTC]

just a friendly reminder


19/07/24 15:21, Alexandra Diupina пишет:
> In kirin_pcie_parse_port() pcie->num_slots is compared to
> pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
> condition to pcie->num_slots + 1 >= MAX_PCI_SLOTS and move
> pcie->num_slots increment lower to avoid out-of-bounds
> array access.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2: some changes
>   drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d5523f302102..deab1e653b9a 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -412,12 +412,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>   			if (pcie->gpio_id_reset[i] < 0)
>   				continue;
>   
> -			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> +			if (pcie->num_slots + 1 >= MAX_PCI_SLOTS) {
>   				dev_err(dev, "Too many PCI slots!\n");
>   				ret = -EINVAL;
>   				goto put_node;
>   			}
> +			pcie->num_slots++;
>   
>   			ret = of_pci_get_devfn(child);
>   			if (ret < 0) {


