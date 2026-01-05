Return-Path: <linux-pci+bounces-43997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B25CF300B
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24CA7300997D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0426E709;
	Mon,  5 Jan 2026 10:36:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B017A303;
	Mon,  5 Jan 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609378; cv=none; b=Ool33L9eifyO74fYpSVDiF+s7sJXAex4OYbR5LgzSbN/M/JtJSG2WsmXwRiDXlX92aMZ4B/1hfUMCCYBzLaSCgvzTxTq5/1f4Hz1ERN7ACFaCjNGKf+25nOuOna3Y+xUyzLqR9XVrjnvJhXaOEg8VFohVMxTkDe847tCHYhmRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609378; c=relaxed/simple;
	bh=Tbnt18oN/75aVVorH+eUF1iqHfdt4NCHj40brDLpdoE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+MrzA0NVcrLW7Qrps4QLQ+dhkDa4t0wgPgM8pLhiHK++g3hsVwh/6Md20gPuTnMMw1gE6QwREjHrdVkhBdWjcFSPsd3vIFs2PALFG/Bi4XKhtTtJp2oWsbwUYXaVHRbA7ULE1l9VS9oEWaLEcxs8WBF/Awm4mKs6Wa2fje+0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dl9fp080yzJ46jg;
	Mon,  5 Jan 2026 18:35:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC8C40086;
	Mon,  5 Jan 2026 18:36:14 +0800 (CST)
Received: from localhost (10.48.146.88) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 10:36:13 +0000
Date: Mon, 5 Jan 2026 10:36:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?UTF-8?Q?Roh?=
 =?UTF-8?Q?=C3=A1r?= <pali@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Tyrel Datwyler <tyreld@linux.ibm.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/3] PCI: pnv_php: Simplify with scoped for each OF
 child loop
Message-ID: <20260105103611.0000788f@huawei.com>
In-Reply-To: <20260102124900.64528-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
	<20260102124900.64528-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  2 Jan 2026 13:49:02 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index c5345bff9a55..0d80bee284e0 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
>  static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  				      struct device_node *dn)
>  {
> -	struct device_node *child;
> -	int ret = 0;
> +	int ret;
>  
> -	for_each_child_of_node(dn, child) {
> +	for_each_child_of_node_scoped(dn, child) {
>  		ret = of_changeset_attach_node(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  
>  		ret = pnv_php_populate_changeset(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)


