Return-Path: <linux-pci+bounces-3229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1384DA9B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 08:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60BB1F235B6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC96930C;
	Thu,  8 Feb 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUI+o3Ug"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591E692EE
	for <linux-pci@vger.kernel.org>; Thu,  8 Feb 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376513; cv=none; b=JOArGv/7UeryGSleRByoKSXL+k4bHDLuYBOAMr1PS3om2fyZkA2pL+x01r50Zw9294NeHRfccl7Q9inRdgJoidX+tJi3UcY/z59HXMzIoGt4EWX/ubIvZAcscilpZ80BM60ArMa/zh3xVcr0w6WjpWwX13/xtLsGUXXP9HdHWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376513; c=relaxed/simple;
	bh=vK/5Gz1QSwmxYzRM+M3atdSA7U9sTy/frFNKMtYClAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K8hkaGUtPKRO1gSnqlXOHgIBayJvHT4EAHDIMbvTPSiPEboHBWVUmy3HSNvXC6hdclM5grVBU2D95kmaFbrpd9Wa8rw7EaDquDJ5H3+mTKwm0e6+msJyjCYIISq50OQ4gm89KllO8I+SApy+kE8f5J5+4d2vtHSCoNbQzWL0b5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUI+o3Ug; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso1100458a12.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 23:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707376510; x=1707981310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5RJhuVckeXbSoDSHqZK4xAbBIVthUC0MdjCe3vhbYQ=;
        b=uUI+o3Ug0tOP1pHa2sPeAxzYX/C+aV5cFlfflRePncS18I6sepgqbQ0yXwvorU3iuU
         tifQnD9d4+mxNFDerrg50EAF65iJKXo1xRG49C2elUoXxt1LXcQNy1PTlStNEyqK+NAK
         Tg+AqwKMNTQmrpth8EyDRFmQuhQUYntTcjjtVg/vQY3ofhG4tmZL8iwsbX54w5XS+Fqz
         CVMm2RWpWBTqqoNy5MyJOTtdAuFSJKvxMC5iqQvUU1LvtMZs7oySkj77RkhH/No8ra1l
         lcHoaRi1d0ZWeiheU0brxvZId1FIVz384xQQGQsGMPsf8lSAtfSGGKp4ovbKEmj5imjb
         UR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707376510; x=1707981310;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5RJhuVckeXbSoDSHqZK4xAbBIVthUC0MdjCe3vhbYQ=;
        b=Go5a9Fpe5YH3NNutPg3yHQO2tGfcXCJd+BI5sWD0jHqN3wSA5XRwe0ACwmmNX00Qf0
         rzOGvmiM1c4Pa5WbsFrNdgCH6d6fCY3WDqYpdLQs7G67yvDyrr4viGcRlUJhnmbfSsdD
         AQOaSgr0JivDVHnG8pqCvlQBr6TDSdxwyDy/J1/6vo5GdLd9WL8I1smV7Cz2eowanxXS
         v36pj16Jrha+uIrgXo8sj0jkhrGPCsLvHP2nXgRA47mdcnsvPTMQZ/dI6Olx3t7bnrTL
         lk4s4bSgBus1PTef7ZK2yoGRJqSCkaV2NfutIReVZKj+2O4xfbNO9qICpRzZlB0vUYIP
         pAjA==
X-Forwarded-Encrypted: i=1; AJvYcCXqIL+r/kSFtuAJnjIqLbd8oeAASV+ZxsbC6dFGSUn2EZ915ITdRdolvfN2E6HTAlsZ7lwwD085jdCh9dz+peAuBJ8nF6KmQJ/h
X-Gm-Message-State: AOJu0YzjrfEBU7TVR0qOdKn0Dhb3/QXy6CX/2U0KPlUz7ft1ZgSe7wnF
	mQzP0BjSvv+aS2ykUMfFPTDDcjrhU7NPHmnyulUYOD7ul0dLZozl/W4ufZaufP8=
X-Google-Smtp-Source: AGHT+IE4WyGx5+NrWJrNDbHiwts0XIOSGoJrDUDfeCg4GYwug22ZiFtQVShwh8Q0Vv/ctnQ5MLpqmQ==
X-Received: by 2002:a05:6402:27c9:b0:561:123d:ed8c with SMTP id c9-20020a05640227c900b00561123ded8cmr431557ede.2.1707376509857;
        Wed, 07 Feb 2024 23:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/5RW8GSuoXDIAlEWg7ccUX02G0LTAdoI9PvgnWCVnJUhkL4NYhlR+A/nuYNj13NEpDSSDb0h3CZsyf8rDSG5W3cqDBYw5dpIu8gEavLXiLqdQIQczCtsFoFs//XPDItH5TdG1ZQtqK2JUo+oXwCPJOi7OlDG8HdW6CvtZq/dUaWhGrDRszxT1yy5LGJeXaoMwn/ILyW+aQCTKZUCJiF4o5J0i1noq+8zyLAbV6cN8+cOk9Z0GSJnklCB3uEb+mA+Te3oG3iJA6Ez1jMuc+t3O+rdgKxfEyZ4Q1MVfCkiiopbf6M3bItpV9PdABDoFXlrmqKwhVN20XW+kMWak7iwVxCKcz910CK4mAYSOTHbUFwi6xOrPYojHudMVFKbOE69ZBKdveTfeOYvNiJ9Wshy2/1HLuD0lXWaCjij2TcgthPF3FXgCbcqt63ajk4IQuCJXW2U9ngxJYFFUmpzfmKwrATNcpfXMlFUMeuY+TDBK5UjGCUeUoPsy8M9IpUs7UzA/eqZ8yfF2f2Y=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cs4-20020a0564020c4400b005609619be04sm529701edb.41.2024.02.07.23.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 23:15:09 -0800 (PST)
Date: Thu, 8 Feb 2024 10:15:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ethan Zhao <haifeng.zhao@linux.intel.com>,
	baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: Re: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for
 qi_check_fault() and refactor callers
Message-ID: <b0b45e40-7510-4107-92a0-27fafb5d7bf7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129034924.817005-5-haifeng.zhao@linux.intel.com>

Hi Ethan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240129-115259
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240129034924.817005-5-haifeng.zhao%40linux.intel.com
patch subject: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for qi_check_fault() and refactor callers
config: x86_64-randconfig-161-20240207 (https://download.01.org/0day-ci/archive/20240208/202402080321.n77hu71Y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402080321.n77hu71Y-lkp@intel.com/

smatch warnings:
drivers/iommu/intel/dmar.c:1533 qi_flush_dev_iotlb() error: we previously assumed 'info->dev' could be null (see line 1533)

vim +1533 drivers/iommu/intel/dmar.c

20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1522  void qi_flush_dev_iotlb(struct intel_iommu *iommu,
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1523  			struct device_domain_info *info, u64 addr,
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1524  			unsigned int mask)
6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1525  {
c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1526  	struct pci_dev *pdev = NULL;
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1527  	u16 sid, qdep, pfsid;
6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1528  	struct qi_desc desc;
6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1529  
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1530  	if (!info || !info->ats_enabled)
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1531  		return;
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1532  
c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28 @1533  	if (info->dev || !dev_is_pci(info->dev))

Missing ! character.  if (!info->dev

c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1534  		return;
c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1535  
c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1536  	pdev = to_pci_dev(info->dev);
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1537  	sid = info->bus << 8 | info->devfn;
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1538  	qdep = info->ats_qdep;
20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1539  	pfsid = info->pfsid;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


