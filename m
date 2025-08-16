Return-Path: <linux-pci+bounces-34129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27325B28F47
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9962D1C23692
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F311B21BD;
	Sat, 16 Aug 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O74Nt/oT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086319DFAB;
	Sat, 16 Aug 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359662; cv=none; b=re5BDeg2geOHQG7+NlvFT1LwTSrYgl7I5BmOhU6eOBstDnk+QxSh8kaIi5f0ZIfRlXuwZaSGxSKoVxpjyrGASE1MBitx/nAzce0EjH3HMIg/yzry3HxEqHxcS6hvlfYi7epaauBMYZ/4tOcc9OlSv/ni7VhuhZTlZCWwyNtOvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359662; c=relaxed/simple;
	bh=0wK3rB9helm3Z65kOsxIJGvDNRT3d2q87PtWtDOkxEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1JrJxpCY1dlHPlVY9yC3fsQCuop9egn7uo1WqadzYVZsg8s/4LpoccmVzyKgVFZItrYpkU3d89vLUDtEwsW9Bk0Xmc1qFd8nFVjCrXHoK+nM0oNd8XBoMH1ukLAj8v88vgBuEdOosAsC5/sF4tRmEmfXOASdkUuF5gOXJ4hhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O74Nt/oT; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=cRmkhgClkwi8F4qHCHtaVyztulnF5HFvw137U0WVuQY=;
	b=O74Nt/oTFCwSCXFCjB7DodpKQ18RkcuRYIj0+AzdNPJHzo37m07jvUsSFQXvbi
	SghYC82/UFwmVlm7mSaB4q65gXn8e8N83O3OMhxWkoHHniu1ZICih9YUW0Tjex/t
	Fnffl17qxwzI+Jd6Hc6jjH0eU8veIkj2kfzRuRzYjRJk4=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnbdGaqaBoqQzDCQ--.44799S2;
	Sat, 16 Aug 2025 23:54:03 +0800 (CST)
Message-ID: <d5d12494-aa17-4012-8265-3c91981611c4@163.com>
Date: Sat, 16 Aug 2025 23:54:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Remove redundant TTL variable initialization
To: bhelgaas@google.com
Cc: ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616152414.966218-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250616152414.966218-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBnbdGaqaBoqQzDCQ--.44799S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy3Gw17Ary7tFW8ur1DGFg_yoW5tFyDpF
	W5uF1YyrWrWFy8XanFqF4UCFy2v3W8J3yI9FykG34avF1DCF98tFySkF1FvFn7JrZxCr4x
	XwnI9r97Gayqvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zippBfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxmro2ignM3xWAADs5

Dear Bjorn,

Because of this series, you have accepted it.
https://patchwork.kernel.org/project/linux-pci/cover/20250813144529.303548-1-18255117159@163.com/

It is already in the following branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search


But I saw the status of patch as "Not Applicable". Is it necessary for 
me to remake the v2 version based on v6.17-rc1? Or is this patch 
unreasonable?

Best regards,
Hans

On 2025/6/16 23:24, Hans Zhang wrote:
> The local variables `ttl` were initialized to PCI_FIND_CAP_TTL but never
> actually used. The loop termination condition is inherently controlled
> by the TTL mechanism inside the PCI_FIND_NEXT_CAP_TTL macro, which already
> ensures protection against infinite loops.
> 
> Remove these redundant operations to simplify the code and eliminate
> potential logical ambiguities. This change does not affect functionality,
> as the TTL safeguard is properly implemented within the macro.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> - Submissions based on the following patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250607161405.808585-1-18255117159@163.com/
> 
> Recently, I checked the code and found that there are still some areas that can be further optimized.
> The above series of patches has been around for a long time, so I'm sending this one out for review
> as a separate patch.
> ---
>   drivers/pci/quirks.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee634263..50d0f193e4a3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2742,10 +2742,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
>    */
>   static int msi_ht_cap_enabled(struct pci_dev *dev)
>   {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	int pos;
>   
>   	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
> -	while (pos && ttl--) {
> +	while (pos) {
>   		u8 flags;
>   
>   		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
> @@ -2796,10 +2796,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
>   /* Force enable MSI mapping capability on HT bridges */
>   static void ht_enable_msi_mapping(struct pci_dev *dev)
>   {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	int pos;
>   
>   	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
> -	while (pos && ttl--) {
> +	while (pos) {
>   		u8 flags;
>   
>   		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
> @@ -2935,12 +2935,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>   
>   static int ht_check_msi_mapping(struct pci_dev *dev)
>   {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> -	int found = 0;
> +	int pos, found = 0;
>   
>   	/* Check if there is HT MSI cap or enabled on this device */
>   	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
> -	while (pos && ttl--) {
> +	while (pos) {
>   		u8 flags;
>   
>   		if (found < 1)
> @@ -3060,10 +3059,10 @@ static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
>   
>   static void ht_disable_msi_mapping(struct pci_dev *dev)
>   {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	int pos;
>   
>   	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
> -	while (pos && ttl--) {
> +	while (pos) {
>   		u8 flags;
>   
>   		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494


