Return-Path: <linux-pci+bounces-37766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C9BC9A9A
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D1C3C03D6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BED2EBBBF;
	Thu,  9 Oct 2025 14:59:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0C2EBB89;
	Thu,  9 Oct 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021943; cv=none; b=BclPVV+NloP+gjR7z60w5UBzA6FxG1eZH85xKVgeBaniZjIDwJQWA2taDc9vcScfiTcclcaG742+2HDLIkz0+CGYY/EMKsYf2yidQPXPSLe4PEoVapAD3vrHr6Rv3ngwfUpr4vCCJqYCAZmenvFzjJoKHTg4a2WSvV7n6ENqzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021943; c=relaxed/simple;
	bh=MV845+QAB8phKCuhPtan4pCwbZvBXPz7JcyZz9iT/U8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imRECNubSbdemb84Tbc8GWYrrmWr44yN5GZGCvlQgwC3ZnD27NRNflleY+uBvpdTF6aVTOYgBVUPPwhIXmYaybqoPyNxPBk3LSRorEzRpZIohxlcrY1uJj7Lwc5sVEUXphAi0WdA1PBhoYZ8Hf9wYpo6lQkYv0Nmi/H9V812QI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjCfx2j8Wz6L5Ds;
	Thu,  9 Oct 2025 22:58:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C5CF1402FD;
	Thu,  9 Oct 2025 22:59:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:58:59 +0100
Date: Thu, 9 Oct 2025 15:58:58 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 08/13] pci: Save only spec-defined configuration
 space
Message-ID: <20251009155858.0000179c@huawei.com>
In-Reply-To: <93623324232f4ec4dcda830d497ac2890b19215f.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<93623324232f4ec4dcda830d497ac2890b19215f.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:44 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Change PCI configuration space save/restore operations by
> saving only the regions defined by the PCI specification avoiding any
> potential side effects of undefined behaviour.
> 
> The current implementation saves the entire configuration space for
> device restore operations, including reserved and undefined regions.
> This change modifies the save logic to save only architecturally defined
> configuration space regions and skipping the undefined areas.
> 
> This benefits the PCSC hitrate, as a 4byte access to a region where only
> 2 bytes are cacheable and 2 are undefined, therefore uncached, will lead
> to a HW access instead.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  drivers/pci/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index db940f8fd408..3e99baaaf8cd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1752,11 +1752,62 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
> -	/* XXX: 100% dword access ok here? */
> -	for (i = 0; i < 16; i++) {
> -		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> -		pci_dbg(dev, "save config %#04x: %#010x\n",
> -			i * 4, dev->saved_config_space[i]);
> +
> +	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> +		for (i = 0; i < 13; i++) {

Needs basing on the register defines not magic numbers.

Same for other cases.

Jonathan

