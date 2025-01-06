Return-Path: <linux-pci+bounces-19331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718AEA0246C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 12:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC8B160805
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C551917E9;
	Mon,  6 Jan 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlKU2Jv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF078F2A
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163566; cv=none; b=KU+GYMaVcYXs7oHueNsow4UKf/xmqUDUCCjLt44LZAveXzfwy9cGrht1eYp1XFAmTR7cTFUQ67kTw9a/+sOiDBX3HzWVzQxFMDA2blxdqPR7OdlnU192S6djSyCsX/Svfcluit4DtDD3XRSWc5dacky+DhMN4XJ/zCaoDgu3iOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163566; c=relaxed/simple;
	bh=26pjsa9xFHb9OG9vxKGj54thfd/2fsofHqoCepdK3/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z8LNedvRz+RCcAV/fVJZjwvFgorML4FLU4dlfVch0m41/Q1CahLEcVb8CADrRa6xbwOgEkuQbeweN+ZZKUlvctPM6anapf/4v/3bNOOma4o7rRB3vuh6iMnrHVknQwCS0WYNDVm2rF0mzF4EITkL0p0ljWCq9eZ/LbMXSMLY0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlKU2Jv7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e06af753so7137689f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736163563; x=1736768363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGGE5ZgPMc/qWU6n7x03EMW8N+ct1TmxeLEwS/agbwU=;
        b=rlKU2Jv73gjuyCgcD9rHkr4CmROQFWef4dPFQjCTtUANsmFEaxjOCAvqrtEkdxARNW
         de37zaomtI6xJ/no/hoIhMrpoASASboZJGdcn3Leh5OOR8ZQ71FQlkzkUiHHmlH9T8fC
         9X8mH9wCn2cN1JOK80R1pbmdT09BHlpbmyKj/OUrPwGpgh8n9kelL52PWDnzlpiTUB5Q
         fdQWVar31NKmXV6p9F7zSCynJXAqEbmIl38lIG1ADD4qTrNwhQ4jWHbwCRJ6KRjYcaXq
         VvPKYgt48ETGStw5p0nX2V3JItcO2NCpWt2Onl5UeK1M9Ebp5bVdL9f4Hbs+ijnVDqXr
         lEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736163563; x=1736768363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGGE5ZgPMc/qWU6n7x03EMW8N+ct1TmxeLEwS/agbwU=;
        b=SMDnlTNyRunPjIy28ooF0iB+qSPb5Utxw2K0qhjhzI2GbB0ozhMWvmd5r9KHBcppHM
         hQMtygM328qpsscuDHwqOQftqHKgvgfiotwJ5eGD1kGiYvNhw7ef19rjAGopLM+lR24M
         I4tHMeyAFlwKmi/INopD+CxVz6a5QCdQDOfg/nV5V5lwBWVxIFx6NANhz6xJtJO22+xH
         PVcQSdO3Y8Rv23/NpIXFqpziDz+Z1X75fmnqCYya0cg4rvnjBgbgETCwg6vAS72Uf1oc
         7km9kZV++hc1v73uiaGq0r7VdktFa5T2A+DuW/1Unq2dgCjI0L61IJ7ZqceL79dyvhU6
         Fg2A==
X-Forwarded-Encrypted: i=1; AJvYcCUaUKVix98O8eMr7T0ymEizVkhEjY3soZ5miuwD+cO+PB9SMpmOADoT9yxM3UsivAALhFRg6bJLIiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVVkoPv9NZ69YDAoNzIK0LK6uoPbisZ66+YR0lqcqBjMXGrOO
	HTlG9q9a5ghFqZb5AxMnnaq54TDrNnO8i7IKfnyIwyr/jt0EG4XzLgMwpisFsiA=
X-Gm-Gg: ASbGncveULOBVC/JCC9iAqfCWgEdNsxjgRyP61ZQ5S21L+Mk/3guNOEB8Tt+5oM0Sl7
	0WxdmO1O9gC0XAglHIYSPCcTFbNRXtkaYNdR2mv6zW8mARjGeGQOX+cqZGNEJ4KQJ5rbCEix4Zd
	DjoSAwbrjTCz3oDGEU9FvthUOmovtwp6e7sMJx8pCIhxk1VSqB9CXnChrGqtjyIaGc5G7D/ByfB
	5SEPTPiHf/dKkz163Vfg5+mf+aua27uU/pTRFiX5v1YRUCpBJLdm6ccYgbThQ==
X-Google-Smtp-Source: AGHT+IErqpiG9dUFlGsnpWUvGF4tVLHkOIJGkA1M5xs+/xZCEUFs+lJ2J8dnZD6u5ktnBPrPKucZQw==
X-Received: by 2002:a5d:64e9:0:b0:385:f56c:d90a with SMTP id ffacd0b85a97d-38a223fd452mr55871172f8f.55.1736163563247;
        Mon, 06 Jan 2025 03:39:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a636asm48935694f8f.88.2025.01.06.03.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:39:22 -0800 (PST)
Date: Mon, 6 Jan 2025 14:39:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/rockchip 1/3]
 drivers/pci/controller/pcie-rockchip.c:134 rockchip_pcie_parse_dt() warn:
 passing zero to 'dev_err_probe'
Message-ID: <dc020ef3-e48a-42cb-aa4c-81d46ebac338@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
head:   8261bf695c47b98a2d8f63e04e2fc2e4a8c6b12b
commit: fa0ce454cd4ee35703d4126c5b8e4a9a398cf198 [1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
config: arm64-randconfig-r073-20250102 (https://download.01.org/0day-ci/archive/20250104/202501040409.SUV09R80-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501040409.SUV09R80-lkp@intel.com/

smatch warnings:
drivers/pci/controller/pcie-rockchip.c:134 rockchip_pcie_parse_dt() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +134 drivers/pci/controller/pcie-rockchip.c

964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  115  	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  116  	if (IS_ERR(rockchip->aclk_rst)) {
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  117  		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  118  			dev_err(dev, "missing aclk reset property in node\n");
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  119  		return PTR_ERR(rockchip->aclk_rst);
e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  120  	}
e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  121  
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  122  	if (rockchip->is_rc)
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  123  		rockchip->perst_gpio = devm_gpiod_get_optional(dev, "ep",
840b7a5edf88fe drivers/pci/controller/pcie-rockchip.c Manivannan Sadhasivam 2024-04-16  124  							       GPIOD_OUT_LOW);
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  125  	else
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  126  		rockchip->perst_gpio = devm_gpiod_get_optional(dev, "reset",
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  127  							       GPIOD_IN);
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  128  	if (IS_ERR(rockchip->perst_gpio))
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  129  		return dev_err_probe(dev, PTR_ERR(rockchip->perst_gpio),
a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  130  				     "failed to get PERST# GPIO\n");
e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  131  
fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02  132  	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02  133  	if (rockchip->num_clks < 0)
fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02 @134  		return dev_err_probe(dev, err, "failed to get clocks\n");


"err" is zero.  It should be "rockchip->num_clks".

4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  135  
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  136  	return 0;
4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  137  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


