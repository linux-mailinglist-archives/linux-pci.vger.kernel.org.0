Return-Path: <linux-pci+bounces-25150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF3A78C8F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9407A5164
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D6236458;
	Wed,  2 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ontMlA/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C5C236A98;
	Wed,  2 Apr 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590574; cv=none; b=uOCiOeH9leYo4yHu7LqqMMi39JkwvZayToSxfNv3ksl4xHaoIISwg80m4zBnjcWdEGTvlexqLnij9Zoamyf4PdokrtsZSZI/MBCAInSXyQ+hryvlopMMpcAXdbe+JeqI7YNtv2tMO3UH08ZcACVdOEqvlqaIUWb//lUp6+Ln/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590574; c=relaxed/simple;
	bh=jvCPXBkMR01+H0/gE+9GrtRjlN3dPzEAtl91KC/IW4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkWFjVzdOFwKdcr/OpK40bf0zaco/Hzbeo/jsbsIl2jRMIhSOYrmbhgAlq0kRLqDLHt8RBZVN5zxo7ssCb7YYtwQNiJFsf3nhuZ6jhyhYbjt9WIDjy+9WeWV6aN7n+zMO8p052adxy1lIy9VO0ij+64GA6rnZ6/6ofOlU64KWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ontMlA/B; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=VR24xgoS8feUSFAEGMRfyNjAAFTUtLrhNnAA7b/J2oQ=;
	b=ontMlA/BsnHycNKnU5V1TKXGfrKx9JFjrDc24A5L2nRx868+k+2lhbk6+1Ebuq
	0993Wi1YEXVj0zyvhMQh3XbNZBl4au2YzUawOk7QdmkOpqbB/NMtwYTJfyeqsi7s
	ji6UOJfLSZZC9j/NJrGXRopkZe+YlevPIXBUPlanEIVuI=
Received: from [192.168.60.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCn8qF6FO1nmwyABA--.39487S2;
	Wed, 02 Apr 2025 18:42:06 +0800 (CST)
Message-ID: <b0dc232e-fdd8-4df3-a55e-d21b90441a4c@163.com>
Date: Wed, 2 Apr 2025 18:42:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
 manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250402042020.48681-3-18255117159@163.com>
 <202504021623.LgnqoZPE-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202504021623.LgnqoZPE-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgCn8qF6FO1nmwyABA--.39487S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17urW5tr1rKrW5GFg_yoWrXw4xpa
	yxXFy7u3yUGw1vganrAa1Iyr92qaykArW7XFWDGwn8AF1DA345ZFWSgFWfJa47KF98KFy3
	Xa98G34xJF12v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJkucUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgUjo2ftDGf+6gAAsK



On 2025/4/2 17:19, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on acb4f33713b9f6cadb6143f211714c343465411c]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Refactor-capability-search-into-common-macros/20250402-122544
> base:   acb4f33713b9f6cadb6143f211714c343465411c
> patch link:    https://lore.kernel.org/r/20250402042020.48681-3-18255117159%40163.com
> patch subject: [v7 2/5] PCI: Refactor capability search functions to eliminate code duplication
> config: loongarch-randconfig-001-20250402 (https://download.01.org/0day-ci/archive/20250402/202504021623.LgnqoZPE-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250402/202504021623.LgnqoZPE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504021623.LgnqoZPE-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/pci.c: In function '__pci_find_next_ht_cap':
>>> drivers/pci/pci.c:627:17: error: 'rc' undeclared (first use in this function); did you mean 'rq'?
>       627 |                 rc = pci_read_config_byte(dev, pos + 3, &cap);
>           |                 ^~
>           |                 rq
>     drivers/pci/pci.c:627:17: note: each undeclared identifier is reported only once for each function it appears in
> 

  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
  {
-	int rc, ttl = PCI_FIND_CAP_TTL;
  	u8 cap, mask;

The rc variable was deleted by mistake and will be changed in the next 
version.

  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
  {
-	int rc;
  	u8 cap, mask;

Best regards,
Hans

> 
> vim +627 drivers/pci/pci.c
> 
> 70c0923b0ef10b Jacob Keller     2020-03-02  614
> f646c2a0a6685a Puranjay Mohan   2020-11-29  615  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  616  {
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  617  	u8 cap, mask;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  618
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  619  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  620  		mask = HT_3BIT_CAP_MASK;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  621  	else
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  622  		mask = HT_5BIT_CAP_MASK;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  623
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  624  	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> 2675dfd086c109 Hans Zhang       2025-04-02  625  				      PCI_CAP_ID_HT);
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  626  	while (pos) {
> 687d5fe3dc3379 Michael Ellerman 2006-11-22 @627  		rc = pci_read_config_byte(dev, pos + 3, &cap);
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  628  		if (rc != PCIBIOS_SUCCESSFUL)
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  629  			return 0;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  630
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  631  		if ((cap & mask) == ht_cap)
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  632  			return pos;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  633
> 47a4d5be7c50b2 Brice Goglin     2007-01-10  634  		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
> 47a4d5be7c50b2 Brice Goglin     2007-01-10  635  					      pos + PCI_CAP_LIST_NEXT,
> 2675dfd086c109 Hans Zhang       2025-04-02  636  					      PCI_CAP_ID_HT);
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  637  	}
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  638
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  639  	return 0;
> 687d5fe3dc3379 Michael Ellerman 2006-11-22  640  }
> f646c2a0a6685a Puranjay Mohan   2020-11-29  641
> 


