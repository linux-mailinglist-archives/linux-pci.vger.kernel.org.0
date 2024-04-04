Return-Path: <linux-pci+bounces-5712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C7898174
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE761C2212E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C74CB23;
	Thu,  4 Apr 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aS5ICsXu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865714CB37
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212197; cv=none; b=SAHojKuMDOflt1vwEHR8pqieNL5NFPsE1eWzgUk3E0yyEWns2Y24TyDcCR727sUGg9AB75siqF+e36D0Iv83GsW0KUdoptYCQwerS35Z08NXD8JMyi5BOIYbHQQIB1WBnUZZTQJXD+vRw5wUjWK2tkzsUTJ89o0leovpJDnBdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212197; c=relaxed/simple;
	bh=N2EBofg0RqwFuqCFJowHjGnGSYzIzirgztIJAPFJFr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BG27GtrG+/TbLoG7sKd4K+OkEeuOCVq/aKZqfju5NLUiwcsEKxShHJP9f7zVACs7+0XPaM7TnFZSX+qYNVD2RAy17b5Dx+C1G523Fp087hWREj38p/9Fomk2GokJS2fj6yUd06h51pEnsnswgB4wAAP5H0DEeiXtWSyvS1UKZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aS5ICsXu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51799456e9so88590966b.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712212194; x=1712816994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UNZae/k2EBcx5FlHf+Q0FilIMtRBcS/dSCMZEDWPas=;
        b=aS5ICsXuLGzFNEaZ+NeK5U8Ak5RVfSJ71mj928npM4oOLtA/5FbltOJD3ep0+FmvYm
         NrunZ7fCemVstbWoxoCNXJMx9dMvDEXNK2ZapV4Y/XqxWJl7szfGp7DutvXX3H/1PtKt
         ANPOwVTUSEXA04MBFqo7Phl72bF4+kI7kEYWcfShEWbiT6g1PKP2hKuYnJ7t3AXXSmf6
         tUUuiwai1WWKvdA/7/6S3Lg4iVZUPL1bt+dMZ7dsG3SBQ7e82tSiVJfWO9DLlvEb1naI
         74kWhg1FKRggOQ99NSRFY/PWUqsFS3uzpGPyTKrhdi0xfsW1duWY3jrpoa6kCyjCmZG8
         ikDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212194; x=1712816994;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UNZae/k2EBcx5FlHf+Q0FilIMtRBcS/dSCMZEDWPas=;
        b=uR5ZCfkMxLoS9c69ZOHaaCd4pnS+F4DHfsm0s+GIszpvXQQtRr6QKE66I3lLykn5z2
         T4bXL63/j3CFEmdZ3jbgdU7C5/QH6F1GHj+9k24bSfUKVnkZJxvKx0jbPdYPjMbCyHF/
         iMYfhs27bP0VdVwr0B6n733I6e67I5acMzKF/A78BEEBjE8We9O9rjNIOT2zUu3JeA2m
         fmFCC/UZjkVKMlyF0FInKhoNy7bhtgS7QJg7gYMMD9kN+2PLQMuaX0WX3VxNFULK6Ecv
         SuokdWn9FUZ0JbDTXPx3bD47gDket6QoQkFAZTlU4Krwo6US6HVnA+ACvYTEcuGeuvuC
         SIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfsjQ55uDf2n87HcsuZKmE6uTMW8/+uMloTE6TakMZxQq7IPjtUhOwhoDf0RJHem1wKbCj6Yn9jDtaMY2Ef83CBUtl919A6P3H
X-Gm-Message-State: AOJu0YzgsmGzN9tV+9IWUurl3jvGbrCTINI6MSOECiWx5kRq0tMJLS6z
	vOyY174yt9DR227fJMTGTGvIcAAtvnkPyASJrWKB/wVqp2hJzGNz/+IcgmTrmjE=
X-Google-Smtp-Source: AGHT+IEC5kYIEakGdkrA8tGW3LWmI7igo3mAP1KXlZN0cpSOuO8oBoj84PvDyIQH6wZORBgrm+VQOw==
X-Received: by 2002:a17:906:3891:b0:a4e:1035:3ed7 with SMTP id q17-20020a170906389100b00a4e10353ed7mr934130ejd.25.1712212193696;
        Wed, 03 Apr 2024 23:29:53 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id xc4-20020a170907074400b00a4e5ab88803sm5503487ejb.183.2024.04.03.23.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:29:53 -0700 (PDT)
Date: Thu, 4 Apr 2024 09:29:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Philipp Stanner <pstanner@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <helgaas@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH v5 02/10] PCI: Deprecate iomap-table functions
Message-ID: <c59ff5c5-7551-41ca-a5cc-9c214051a20d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080712.13986-5-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/PCI-Add-new-set-of-devres-functions/20240403-160932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240403080712.13986-5-pstanner%40redhat.com
patch subject: [PATCH v5 02/10] PCI: Deprecate iomap-table functions
config: i386-randconfig-141-20240404 (https://download.01.org/0day-ci/archive/20240404/202404040920.QIxhNeMu-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404040920.QIxhNeMu-lkp@intel.com/

smatch warnings:
drivers/pci/devres.c:897 pcim_iomap_regions_request_all() error: we previously assumed 'legacy_iomap_table' could be null (see line 894)

vim +/legacy_iomap_table +897 drivers/pci/devres.c

acc2364fe66106 Philipp Stanner 2024-01-31  865  int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
acc2364fe66106 Philipp Stanner 2024-01-31  866  				   const char *name)
acc2364fe66106 Philipp Stanner 2024-01-31  867  {
34e90b966504f3 Philipp Stanner 2024-04-03  868  	short bar;
34e90b966504f3 Philipp Stanner 2024-04-03  869  	int ret;
34e90b966504f3 Philipp Stanner 2024-04-03  870  	void __iomem **legacy_iomap_table;
acc2364fe66106 Philipp Stanner 2024-01-31  871  
34e90b966504f3 Philipp Stanner 2024-04-03  872  	ret = pcim_request_all_regions(pdev, name);
34e90b966504f3 Philipp Stanner 2024-04-03  873  	if (ret != 0)
34e90b966504f3 Philipp Stanner 2024-04-03  874  		return ret;
acc2364fe66106 Philipp Stanner 2024-01-31  875  
34e90b966504f3 Philipp Stanner 2024-04-03  876  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
34e90b966504f3 Philipp Stanner 2024-04-03  877  		if (!mask_contains_bar(mask, bar))
34e90b966504f3 Philipp Stanner 2024-04-03  878  			continue;
34e90b966504f3 Philipp Stanner 2024-04-03  879  		if (!pcim_iomap(pdev, bar, 0))
34e90b966504f3 Philipp Stanner 2024-04-03  880  			goto err;
34e90b966504f3 Philipp Stanner 2024-04-03  881  	}
34e90b966504f3 Philipp Stanner 2024-04-03  882  
34e90b966504f3 Philipp Stanner 2024-04-03  883  	return 0;
34e90b966504f3 Philipp Stanner 2024-04-03  884  
34e90b966504f3 Philipp Stanner 2024-04-03  885  err:
34e90b966504f3 Philipp Stanner 2024-04-03  886  	/*
34e90b966504f3 Philipp Stanner 2024-04-03  887  	 * Here it gets tricky: pcim_iomap() above has most likely
34e90b966504f3 Philipp Stanner 2024-04-03  888  	 * failed because it got an OOM when trying to create the
34e90b966504f3 Philipp Stanner 2024-04-03  889  	 * legacy-table.
34e90b966504f3 Philipp Stanner 2024-04-03  890  	 * We check here if that has happened. If not, pcim_iomap()
34e90b966504f3 Philipp Stanner 2024-04-03  891  	 * must have failed because of EINVAL.
34e90b966504f3 Philipp Stanner 2024-04-03  892  	 */
34e90b966504f3 Philipp Stanner 2024-04-03  893  	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
34e90b966504f3 Philipp Stanner 2024-04-03 @894  	ret = legacy_iomap_table ? -EINVAL : -ENOMEM;
                                                              ^^^^^^^^^^^^^^^^^^
Check for NULL

34e90b966504f3 Philipp Stanner 2024-04-03  895  
34e90b966504f3 Philipp Stanner 2024-04-03  896  	while (--bar >= 0)
34e90b966504f3 Philipp Stanner 2024-04-03 @897  		pcim_iounmap(pdev, legacy_iomap_table[bar]);
                                                                                   ^^^^^^^^^^^^^^^^^^
Unchecked dereference

34e90b966504f3 Philipp Stanner 2024-04-03  898  
34e90b966504f3 Philipp Stanner 2024-04-03  899  	pcim_release_all_regions(pdev);
34e90b966504f3 Philipp Stanner 2024-04-03  900  
34e90b966504f3 Philipp Stanner 2024-04-03  901  	return ret;
acc2364fe66106 Philipp Stanner 2024-01-31  902  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


