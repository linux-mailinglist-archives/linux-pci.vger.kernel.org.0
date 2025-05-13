Return-Path: <linux-pci+bounces-27639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5EAAB5779
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11481886807
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD33244666;
	Tue, 13 May 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWtS+CRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8B1A8412
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147465; cv=none; b=mgLuhuYHKZHcIBMwYDccaofGa7/NCmJE6OfLrKGQC2PS9DqBTewMVkZMwKKdv/nu2Nu9h3wJ1GJ0X2O8XqVl0gyozzNvBD+KpsyKJBTphYC7tKDXR3ALCp8S65QT9BZ42mYWsz/779WDBJzDoX+yqC4m//l6tdaS2bdO/wWpcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147465; c=relaxed/simple;
	bh=xdDG5wmlD2/F5QJnoRq47kR5G8oK4NQvYC30s91zIa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hDxxIFNFVRY5DhBGk8TOPYV4ccEm1kNIO2nMjFrNOpYdvkO1bfy6VLw6jWVdNacT5DEsShfu3OpWR606RHJhlqNlr4sYMfDod7yAgdqQueaJsS4yapmWi9z3WGQPbnk+2ttcxmAGi//2KLg1AaS6juN8eHyRb9XL+dZZ15WuASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jWtS+CRV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0618746bso43734845e9.2
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747147461; x=1747752261; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COerkxIln7e++nlqNopvBWN7m6Frh8qSXypYxxafsww=;
        b=jWtS+CRVm5v2KK16mREfIv6LNB0GPra8VP+bmmAphyoVfmotEexz4504vb41LFdHML
         dayMxf3n26WgeLm67v62E+6+poZ8IPxkECWOj2wLo0l7JvVs4c9ISUunmd5YYywfkZWv
         KoMm3laMgOEYz3qFUlxZUP86VjOW5hFunwSCifJeoS8ci3h85wJczMecIAhUiYrF9drZ
         4eWw1PWsgyEy7z+2BeaqnER3lbpaaLVmxIwmINGK3eAVY5LbYAsKDc5BF25vPsWRdqrZ
         m0K3bgottavMQDNVXJ5l3+JiiYLDUFR2tXmArHqWb/3lwqIMPCBg/jPhTacERxq+wrHD
         N2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147461; x=1747752261;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COerkxIln7e++nlqNopvBWN7m6Frh8qSXypYxxafsww=;
        b=cpHPY9mpEc832ku5TLByP4JrQ4oLlVwiHc2y8dXrNMlQxjSbjdpQecdLbajoiFxnbq
         1oQu/QsUfP95RbiF7ubwLlg8h7Aau6lG/sT8NTC4osGYo6kylIUyA210YxnxKxOk4jpB
         kQpY6JoR+d7AeYoixZjaUn+y8zNHpnsfD7GkxwymJyJtm9uUjS1mwmNmgp/55a07emsn
         y4ZuaQYHkLLE/ByFC6fp+ocA2mIwC6hof21B/OXmU20JNZni+Uke1ncSmZlih6uqmi7h
         EES/tuK1LhPPwpCoM+LY9DLrdvFq1x5nQIU/ah6S4IthXVC1e0Qzn7DywkoD1cCTR4PN
         0ldg==
X-Forwarded-Encrypted: i=1; AJvYcCWVSVLZs7Top5+szh287WzRDO3DLd6n9u31cuf7k5SpRROCxFNytjGwubxk8ZjuZgqBkySSwPTTBPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWctl44ylrb9rsDjJQxq523tsFBpBadmnlsDlHmdy25IPwrHmZ
	aghb7L4tXjujMTM8t2T4n1KtIOCOUi2bxFLrXEDvHvzR+Oq+ahNx3BfmD5IO2U0=
X-Gm-Gg: ASbGncuJOCyvEJZXExgViXAZtmOOBjTEfkP72aftwKlF03U+5Q40DD1zxu82QwGlXdQ
	nXDLlNO09TsYls60t+FIto+IuBnZWW0k6tyRz/LBd/WHkNl2w5oFVQPdCNX8QkAfAllUoXPOjUh
	46Iamw51k+hYdeXR/1UTpTonknow8rv/Yrsn2ycb8biZts7xCOvFueP7vGnfHWMcSIrWJ4PIYkP
	jyutXu+EPKmsfPIaV9d/o72j+hN1bYx6UdGLJ4Eo8VMegVknDhzlSeJoTnEGLsIVNCqsN4lkeVM
	aY5DakNffVHW67oSnU5CpbBeiuRf8jDo39sPhf2SvcPCshlzlIlwpzyEDxZ79LkWBhyrGnJhK+1
	T/bKk5g==
X-Google-Smtp-Source: AGHT+IGgCDI5BfDxBYIYTge59ZLvMwLnd/0dXP71Y36XYhfoLmiT63rwk00N7IpeTL5+jqpnpktC5Q==
X-Received: by 2002:a05:600c:3b2a:b0:440:6a1a:d8a0 with SMTP id 5b1f17b1804b1-442d6d18bacmr136140305e9.7.1747147461296;
        Tue, 13 May 2025 07:44:21 -0700 (PDT)
Received: from localhost (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd6fe86sm22071015e9.0.2025.05.13.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:44:21 -0700 (PDT)
Date: Tue, 13 May 2025 17:44:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:ptm-debugfs 1/4] drivers/pci/pcie/ptm.c:275
 context_update_write() error: buffer overflow 'buf' 7 <= 7
Message-ID: <b41c1754-c6b7-4805-9f14-7c643d6c5304@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm-debugfs
head:   356fc3e997f3bf54448a8cb39b49c7d73959d166
commit: 1130deffd29ab25da8091b573e173ef9d889e827 [1/4] PCI: Add debugfs support for exposing PTM context
config: alpha-randconfig-r073-20250511 (https://download.01.org/0day-ci/archive/20250511/202505111829.bSouegRR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505111829.bSouegRR-lkp@intel.com/

smatch warnings:
drivers/pci/pcie/ptm.c:275 context_update_write() error: buffer overflow 'buf' 7 <= 7

vim +/buf +275 drivers/pci/pcie/ptm.c

1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  257  static ssize_t context_update_write(struct file *file, const char __user *ubuf,
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  258  			     size_t count, loff_t *ppos)
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  259  {
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  260  	struct pci_ptm_debugfs *ptm_debugfs = file->private_data;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  261  	char buf[7];
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  262  	int ret;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  263  	u8 mode;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  264  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  265  	if (!ptm_debugfs->ops->context_update_write)
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  266  		return -EOPNOTSUPP;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  267  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  268  	if (count < 1 || count > sizeof(buf))

Should be >= instead of >.

1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  269  		return -EINVAL;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  270  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  271  	ret = copy_from_user(buf, ubuf, count);
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  272  	if (ret)
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  273  		return -EFAULT;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  274  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05 @275  	buf[count] = '\0';
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  276  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  277  	if (sysfs_streq(buf, "auto"))
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  278  		mode = PCIE_PTM_CONTEXT_UPDATE_AUTO;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  279  	else if (sysfs_streq(buf, "manual"))
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  280  		mode = PCIE_PTM_CONTEXT_UPDATE_MANUAL;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  281  	else
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  282  		return -EINVAL;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  283  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  284  	mutex_lock(&ptm_debugfs->lock);
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  285  	ret = ptm_debugfs->ops->context_update_write(ptm_debugfs->pdata, mode);
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  286  	mutex_unlock(&ptm_debugfs->lock);
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  287  	if (ret)
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  288  		return ret;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  289  
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  290  	return count;
1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  291  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


