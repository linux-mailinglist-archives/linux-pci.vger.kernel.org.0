Return-Path: <linux-pci+bounces-31004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC2AEC85F
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2103B1139
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963E219A81;
	Sat, 28 Jun 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ct0AqLFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B6A214A94;
	Sat, 28 Jun 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751125513; cv=none; b=UgoY0l4mdFFAtlQ+/WvJFb9VRavcpi6WQ578M9NkGUXc7ACvdw+RPSj75CfYx/gZmlmjGJeVj5pT8HVDH31lRTokNSOZh4ymbxJ9FvlLRRjJ40/ig9S/MiR4Y6Ve+QOGGXOrD376i+eC5ezClJo8DmZHPliLv1EpVV0oeMBxsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751125513; c=relaxed/simple;
	bh=LXcxF/56bkPDAHY9INU5Rtiyk4foNQDRc3RCGj3eVp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZmm2wCzIESvOhtvM15t+pha9eo+A4PLpaUoZ30h0nL00xfgOApsrSh/7dUxS7OegFJ0Kb5vynRbL9U84e90NtIiLGLMZXWeJqQ6DKkO9jSMIrC3BXRRtbz7jm/9ZEP0jjSHwvdwQ9n/Ajbv8+pixo9M0E4MFXCmZHDuV0Abp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ct0AqLFT; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=coLrn4K3E/R95z5bSzACGaQDmXOiBNgAB+edWrJyIBI=;
	b=Ct0AqLFT3jt85V7GU6qqtCYDztqD7zjEbBNrHDP1ZYbkE4GvUavMj2KCBTopX9
	gOU9Zl5e0+TPn4YITDkQFeLHR6rJS3ro+c76T2Q5oU8yFj2SgS6WucIizWtP/tUx
	Xu//adK24Fs2AZmIEK398Vgme19qdwzp7ucmdbvXlyyqQ=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3V5viDWBok6B_AQ--.53326S2;
	Sat, 28 Jun 2025 23:44:35 +0800 (CST)
Message-ID: <23f8b2b3-0232-449f-85d5-20ed5e575111@163.com>
Date: Sat, 28 Jun 2025 23:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dwc: Refactor code by using
 dw_pcie_clear_and_set_dword()
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250626145040.14180-3-18255117159@163.com>
 <202506280542.6ttkdrur-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202506280542.6ttkdrur-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgD3V5viDWBok6B_AQ--.53326S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17KrW3Cr13try3XFb_yoW5GFW3pa
	yUAr4avFW8Jr4Fga1kJa92vF1aqan8J3y3C3WxGw429F47ZFyDtaySkry5Kr9rKF40gryF
	kr13uasYgrn8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOTmDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwx6o2hgB4l31QAAsy



On 2025/6/28 06:20, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.16-rc3 next-20250627]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-dwc-Refactor-code-by-using-dw_pcie_clear_and_set_dword/20250627-031223
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20250626145040.14180-3-18255117159%40163.com
> patch subject: [PATCH v3] PCI: dwc: Refactor code by using dw_pcie_clear_and_set_dword()
> config: arc-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280542.6ttkdrur-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280542.6ttkdrur-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506280542.6ttkdrur-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/pci/controller/dwc/pcie-amd-mdb.c:21:
>     drivers/pci/controller/dwc/pcie-designware.h: In function 'dw_pcie_dbi_ro_wr_en':
>>> drivers/pci/controller/dwc/pcie-designware.h:712:2: error: implicit declaration of function 'dw_pcie_clear_and_set_dword'; did you mean 'pcie_capability_set_dword'? [-Werror=implicit-function-declaration]
>       dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       pcie_capability_set_dword
>     cc1: some warnings being treated as errors
> 
> 

Dear Mani,

This compilation error can be ignored.

Since the Subject of this patch is wrong, it should be:

Subject:  s/PATCH v3/PATCH v3 02/13/

Do I still need to resubmit the version?

Best regards,
Hans

> vim +712 drivers/pci/controller/dwc/pcie-designware.h
> 
>     709	
>     710	static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>     711	{
>   > 712		dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
>     713					    0, PCIE_DBI_RO_WR_EN);
>     714	}
>     715	
> 


