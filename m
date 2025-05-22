Return-Path: <linux-pci+bounces-28281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5BAC1143
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE4D3A3768
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FD25178C;
	Thu, 22 May 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bah/kLXa"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682381741;
	Thu, 22 May 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931917; cv=none; b=AmMHtrk/ubB/Y6aX/+cRj0slh/eSTOwJoGj3CEOGhDz1vG7Tg8vAeC9OOXujvd8mnhBY4ltkUdNO4rlT91PdI/go9c+SnzSgZzyORYLbhMdy0Kk06IiH6ke7gPzDvxcf5n6k2wKvIggXzo6YhejU8E/IhUuHire4DgC54Uy8GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931917; c=relaxed/simple;
	bh=SMl97D+vEtmd7mHiOegou6xsUl1MDouMYXny4UdBsVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muovFBHwNdXIiVTZH0mVpngwkO8QqeY6SAJdv0uV/qeavdVlAb95Ag0Ck2MefhbfkrBKJJ6RbT9XwvhMDkan30bNXexHBUJpj98JBJaOl3HKpVDrrXKzGlCtUAoPTi3J5VOHK8asJeFnBf1fd6a3cny1UFmOHSCGFiDZo0QdrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bah/kLXa; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DnNTvmaikPOhgS4nY7hgnFwbwgcYmQnqPJ/Qbevc5eI=;
	b=bah/kLXaxaqx7GVs46P2Fv4hPNDY15H9j/5jybVSiehd3DHI7a+eS8bVLJBoy9
	5cgRD06LhYvytD0thYLUS/vcXnvnQg4UMB5Xvy8w9uPjSAR6nBeXVSJG33XQEi3M
	pUFYHylHsB4ULunP+yFMxnQEG2LEUR34DLlhXF1Ms7Z+I=
Received: from [192.168.71.93] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC31JPkUi9oo_0nAQ--.41716S2;
	Fri, 23 May 2025 00:37:57 +0800 (CST)
Message-ID: <dac8950f-9dd0-4a95-983b-ab9afa0a1c4b@163.com>
Date: Fri, 23 May 2025 00:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
To: bhelgaas@google.com, kwilczynski@kernel.org,
 manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250522163251.399223-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250522163251.399223-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgC31JPkUi9oo_0nAQ--.41716S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyUWF1kGr1UJFW3AFW7twb_yoW8Gr43pa
	1Ikay0ya4Utayj93W7XF47urW5Zws5X3yUGw1aywnYkanIy34kJFy2gFyruFs5Gr9Fyw4x
	tayUt3WfC3WjvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrManUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxtVo2gvTnlpjgAAsh

Dear all,

I'm very sorry for the warning that occurred during my local 
compilation. Then I made a patch on the spot. I sent the wrong email. 
Please ignore it.

Best regards,
Hans

On 2025/5/23 00:32, Hans Zhang wrote:
> Fix the kernel-doc warning by describing the 'dma_dev' member in
> the tegra_i2c_dev struct.  This resolves the compilation warning:
> 
> drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or struct member 'dma_dev' not described in 'tegra_i2c_dev'
> 
> Fixes: cdbf26251d3b ("i2c: tegra: Allocate DMA memory for DMA engine")
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/i2c/busses/i2c-tegra.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 87976e99e6d0..07bb1e7e84cc 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -253,6 +253,7 @@ struct tegra_i2c_hw_feature {
>    * @dma_phys: handle to DMA resources
>    * @dma_buf: pointer to allocated DMA buffer
>    * @dma_buf_size: DMA buffer size
> + * @dma_dev: DMA device used for transfers
>    * @dma_mode: indicates active DMA transfer
>    * @dma_complete: DMA completion notifier
>    * @atomic_mode: indicates active atomic transfer
> 
> base-commit: fee3e843b309444f48157e2188efa6818bae85cf


