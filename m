Return-Path: <linux-pci+bounces-14933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450F9A5C81
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F951283F4A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411B1D12F9;
	Mon, 21 Oct 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdlnAeBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B51D131E
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495053; cv=none; b=hgbDktUiO6DTXM/LgnmZFSmhv1erM43IXZYTTtkMjFWDprYXbJSTaw19BjC3LEHPl1RBBTbo9GwoUOZZhwebXwICQLOQMp2Ea/KENMTF+8PIYSeHMEfB82TFRFZqMxiy4emGqxM7DIKdf8hUuG4qoBLCU7X4klEsmzkIXSJAO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495053; c=relaxed/simple;
	bh=E7+7301djVpMUQeotCSGphW/XiK2+37+MdD3fplNdsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OEQKDfe0i9W1HTjHAB8CUxC4AEoJqAYYMOwD92w/vr7rWfBqqVYqlDv9PLeTyghXy9UF4wS/ayMVnK5zI/fFir4b4HUWExLognFpH0dYOMVojtabd3M7kI23BN/BjkEgCRZV0MNdil4f8jRg62ylrV2Jrwu6yS4WVfqaDtI1B4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdlnAeBq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314f38d274so56699635e9.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729495050; x=1730099850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+m8fTvMjxKK9SDB4irlUC6OD3WAtnh15KYs4Bil8CxE=;
        b=TdlnAeBqIjU/ttQ6vRnWURBHW7UjC6f6c/q1WaBwM94RnnzY1fMTQoHN+3oeCB4ij1
         wm42I7aNDNxgzLZrf1AFUNVlNTiEviQdEiU/ZBT3kEUDeplvwPHFydmEYsMmh/XW3Xgq
         NT1RqwTJUH/RjNZBFrjZBlMGXPGe3KXC0AD/GmGjlclbqLFO7rWJOEK/omm+q+Kz0klw
         y88ddFWeIN4u3J08eEtekxvObMRvaf/NeWCeasONSNKSKwv1N4uYS91sXufAItsXUS3i
         UFoK+J5674dvjqe4Y5QVG+dviOsXJBGq6IZnM5ywagSD3+yo37Zgd5++/1HQodtjmVFA
         EYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495050; x=1730099850;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+m8fTvMjxKK9SDB4irlUC6OD3WAtnh15KYs4Bil8CxE=;
        b=CkKsxy0SAvDvaYR7N9zCaQubSjnf6cmzIqBdyZEl4GN/mWpP6Oi8Y8HOkcnlFc27ex
         C60RPfwJIFjXYrLvRFvbX2QCtXNa12j/cP8l0hrAiyMpKhMv5qM2QbSfOwBNyC5ULYYq
         Jd4wNCayIq350VSs4oKMih4RxtxoFak7sC+334W/2zYnYQhAdwSDgGgLheBgf3nF/IrG
         kk0xWbqvI5DVxA++pFxMezXwTIB0lcmWSR53/bD0843Y/wmJPjD3lKcShWajeRw9PuN4
         9/BDAhXdyx8iK5S8sZsbSL0d+iKXZM3JUAsT7O9tUvpCe+y+S8HhiZcc7iPyBTV0Bdmm
         oG0w==
X-Forwarded-Encrypted: i=1; AJvYcCWuT2/IBO6gQSdGd8s+3ltWkkOWs5MjYWXMn9eNulGnH33+QVi9wm6kNoiuSGX+rmGDYKR3WCacjxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzH9UtkLwTPoFyWdkb+yja+SnZvovTw6NmbwaSyEFeVS8y1XZy
	xNt28qxfFdQS9DlNZYFux2tFudaKcq+AwM4LwNBBvIDF5GhZZOWeV1htBfT+kqg=
X-Google-Smtp-Source: AGHT+IGXcjSY/qQ6Yjj36xtAVc0dYZUUx35AYEwS9RfB1wu2AACGrjRhixmmA0i0CqZsSES/VJFNnQ==
X-Received: by 2002:a05:600c:1547:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-43161627e3emr113376925e9.11.1729495049729;
        Mon, 21 Oct 2024 00:17:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431605f81a2sm112892065e9.0.2024.10.21.00.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:17:29 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:17:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Guixin Liu <kanie@linux.alibaba.com>,
	bhelgaas@google.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <206eef75-bd2b-43ef-a324-6556c47c9b93@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

Hi Guixin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/PCI-optimize-proc-sequential-file-read/20241018-135026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241018054728.116519-1-kanie%40linux.alibaba.com
patch subject: [PATCH] PCI: optimize proc sequential file read
config: i386-randconfig-141-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190659.9MCI8EyL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410190659.9MCI8EyL-lkp@intel.com/

smatch warnings:
drivers/pci/proc.c:365 pci_seq_tree_remove_dev() warn: variable dereferenced before check 'dev' (see line 361)

vim +/dev +365 drivers/pci/proc.c

4ca256d9a0e58a Guixin Liu 2024-10-18  359  void pci_seq_tree_remove_dev(struct pci_dev *dev)
4ca256d9a0e58a Guixin Liu 2024-10-18  360  {
4ca256d9a0e58a Guixin Liu 2024-10-18 @361  	unsigned long idx = dev->proc_seq_idx;
                                                                    ^^^^^^^^^^^^^^^^^
Dereferenced

4ca256d9a0e58a Guixin Liu 2024-10-18  362  	struct pci_dev *latest_dev = NULL;
4ca256d9a0e58a Guixin Liu 2024-10-18  363  	struct pci_dev *ret;
4ca256d9a0e58a Guixin Liu 2024-10-18  364  
4ca256d9a0e58a Guixin Liu 2024-10-18 @365  	if (!dev)
                                                    ^^^^
Checked too late

4ca256d9a0e58a Guixin Liu 2024-10-18  366  		return;
4ca256d9a0e58a Guixin Liu 2024-10-18  367  
4ca256d9a0e58a Guixin Liu 2024-10-18  368  	xa_lock(&pci_seq_tree);
4ca256d9a0e58a Guixin Liu 2024-10-18  369  	__xa_erase(&pci_seq_tree, idx);
4ca256d9a0e58a Guixin Liu 2024-10-18  370  	pci_dev_put(dev);
4ca256d9a0e58a Guixin Liu 2024-10-18  371  	/*
4ca256d9a0e58a Guixin Liu 2024-10-18  372  	 * Move the latest pci_dev to this idx to keep the continuity.
4ca256d9a0e58a Guixin Liu 2024-10-18  373  	 */
4ca256d9a0e58a Guixin Liu 2024-10-18  374  	if (idx != pci_max_idx - 1) {
4ca256d9a0e58a Guixin Liu 2024-10-18  375  		latest_dev = __xa_erase(&pci_seq_tree, pci_max_idx - 1);
4ca256d9a0e58a Guixin Liu 2024-10-18  376  		ret = __xa_cmpxchg(&pci_seq_tree, idx, NULL, latest_dev,
4ca256d9a0e58a Guixin Liu 2024-10-18  377  				GFP_KERNEL);
4ca256d9a0e58a Guixin Liu 2024-10-18  378  		if (!ret)
4ca256d9a0e58a Guixin Liu 2024-10-18  379  			latest_dev->proc_seq_idx = idx;
4ca256d9a0e58a Guixin Liu 2024-10-18  380  		WARN_ON(ret);
4ca256d9a0e58a Guixin Liu 2024-10-18  381  	}
4ca256d9a0e58a Guixin Liu 2024-10-18  382  	pci_max_idx--;
4ca256d9a0e58a Guixin Liu 2024-10-18  383  	xa_unlock(&pci_seq_tree);
4ca256d9a0e58a Guixin Liu 2024-10-18  384  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


