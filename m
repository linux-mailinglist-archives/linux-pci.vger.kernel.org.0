Return-Path: <linux-pci+bounces-14964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E19A95C1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71F11C21C53
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7212EBE9;
	Tue, 22 Oct 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g7qMAmvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53E1E51D
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562079; cv=none; b=pTFroqLPpAoUgQplfwybSrhqdMap4FKI/hJF3ELgo88qDOfI1T4XJMhsixbYHdFjyLcFw4AwMUmFg8wlDQK449PsNLFLSkhRtNnOPg90wTwuIdFLAVjhQexh6M+05ZANYBCi/3jggcgT4CBEE3VSpAuVT0wkDY95X7AXNCAJNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562079; c=relaxed/simple;
	bh=LfEOqGm0ls6BIYjVb+4/LvIwf6YOWxWIxcy5uf+hnGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3mREIgiMxo0JC6Rq1DG3qmSmwCBBv0hAhe9Uf3ced8zVUgU7qi0mgHhFyuwBTWQycVQka6OUmkzrLbFT6+54Cuo6sj2/1LaiQUIit+Ln4GvSMnU2KNYWeYXHvhH8dJmDIpD2VOlBWb8gyBtRizKFzJ421HsxtkiZBPiaC4lVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g7qMAmvi; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729562074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O13sI1AHb9SVp0WIrZBCnG4QTD1a8k/+2urAePRh+BE=;
	b=g7qMAmvijD5fANZZ+Jk//1BhRA1GMn+IX/2UJcKmhwiN35GaIuSpdFk9oFy1LKwdoxc0A4HfEhDIZ8ybyoNNhI26gwPkXT/vegiRxGqqqY8KTlnlsmtoVAJbwHPsEwc6OO5XyW92lgvl87Mw5xIpk4zy4OMHDt0yea5Ewj1/pgQ=
Received: from 30.178.82.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHg1zHf_1729562072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 09:54:34 +0800
Message-ID: <56519e26-029d-46a1-b7cf-9391775da5bc@linux.alibaba.com>
Date: Tue, 22 Oct 2024 09:54:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: optimize proc sequential file read
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 bhelgaas@google.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
References: <206eef75-bd2b-43ef-a324-6556c47c9b93@stanley.mountain>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <206eef75-bd2b-43ef-a324-6556c47c9b93@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/21 15:17, Dan Carpenter 写道:
> Hi Guixin,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/PCI-optimize-proc-sequential-file-read/20241018-135026
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20241018054728.116519-1-kanie%40linux.alibaba.com
> patch subject: [PATCH] PCI: optimize proc sequential file read
> config: i386-randconfig-141-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190659.9MCI8EyL-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410190659.9MCI8EyL-lkp@intel.com/
>
> smatch warnings:
> drivers/pci/proc.c:365 pci_seq_tree_remove_dev() warn: variable dereferenced before check 'dev' (see line 361)
>
> vim +/dev +365 drivers/pci/proc.c
>
> 4ca256d9a0e58a Guixin Liu 2024-10-18  359  void pci_seq_tree_remove_dev(struct pci_dev *dev)
> 4ca256d9a0e58a Guixin Liu 2024-10-18  360  {
> 4ca256d9a0e58a Guixin Liu 2024-10-18 @361  	unsigned long idx = dev->proc_seq_idx;
>                                                                      ^^^^^^^^^^^^^^^^^
> Dereferenced

Thanks, changed in v2.

Best Regards,

Guixin Liu

> 4ca256d9a0e58a Guixin Liu 2024-10-18  362  	struct pci_dev *latest_dev = NULL;
> 4ca256d9a0e58a Guixin Liu 2024-10-18  363  	struct pci_dev *ret;
> 4ca256d9a0e58a Guixin Liu 2024-10-18  364
> 4ca256d9a0e58a Guixin Liu 2024-10-18 @365  	if (!dev)
>                                                      ^^^^
> Checked too late
>
> 4ca256d9a0e58a Guixin Liu 2024-10-18  366  		return;
> 4ca256d9a0e58a Guixin Liu 2024-10-18  367
> 4ca256d9a0e58a Guixin Liu 2024-10-18  368  	xa_lock(&pci_seq_tree);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  369  	__xa_erase(&pci_seq_tree, idx);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  370  	pci_dev_put(dev);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  371  	/*
> 4ca256d9a0e58a Guixin Liu 2024-10-18  372  	 * Move the latest pci_dev to this idx to keep the continuity.
> 4ca256d9a0e58a Guixin Liu 2024-10-18  373  	 */
> 4ca256d9a0e58a Guixin Liu 2024-10-18  374  	if (idx != pci_max_idx - 1) {
> 4ca256d9a0e58a Guixin Liu 2024-10-18  375  		latest_dev = __xa_erase(&pci_seq_tree, pci_max_idx - 1);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  376  		ret = __xa_cmpxchg(&pci_seq_tree, idx, NULL, latest_dev,
> 4ca256d9a0e58a Guixin Liu 2024-10-18  377  				GFP_KERNEL);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  378  		if (!ret)
> 4ca256d9a0e58a Guixin Liu 2024-10-18  379  			latest_dev->proc_seq_idx = idx;
> 4ca256d9a0e58a Guixin Liu 2024-10-18  380  		WARN_ON(ret);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  381  	}
> 4ca256d9a0e58a Guixin Liu 2024-10-18  382  	pci_max_idx--;
> 4ca256d9a0e58a Guixin Liu 2024-10-18  383  	xa_unlock(&pci_seq_tree);
> 4ca256d9a0e58a Guixin Liu 2024-10-18  384  }
>

