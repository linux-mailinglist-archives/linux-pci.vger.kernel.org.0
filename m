Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C844E7BF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhKLNrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 08:47:53 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35522 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhKLNrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 08:47:52 -0500
Received: by mail-pf1-f178.google.com with SMTP id c4so8558342pfj.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Nov 2021 05:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeHPSCNxHZlxju1VOgB2x+z6NfAyey/4vwoDg4zd4rY=;
        b=SZ+shick5SVzi9WKxlz+TP2Hlry/qcZXiQDSSbITAteurTMh1MKiWvBlYPyOEhoc/1
         4zBexvY1s6n6QeVhFOCygesMN069QoZJkFSbtFObObzEIYoVL0mPO1lddSt3SVrk9Vxs
         KpMwsjJOfCE2Y289Z9JkGRoXGfTYgsT5bUsvZGCJSO9DV1sRoesK1idrg+dBlmnBwwc8
         qx+d659XW1YJ4TXueIZsxDykITfjZg5ZxVi+/ClRU9RzwIQ203UcbJvgBw6x2e1hryAq
         HhkIRsEW2dEFoqxz4ryw6ne7RQ6v1tzdTOKZ1Ayz4Zk/BFQ65nuCCFLEtiMGzE9y2PBU
         NSyg==
X-Gm-Message-State: AOAM531JIiYxeecOCUluzc6MlJ5750zvcfzulMHKUx9K9OG7V/6FGWOz
        I6CObYOh87tsLZ428hYKmIh7A2aSHJPunDQd
X-Google-Smtp-Source: ABdhPJzP6a0SqZuzjXkZje8V9B1pAdJIPiVcG+Mnna64/K6IW+EjFeKZZu8WnbX7s6CfiwCgqVq/jA==
X-Received: by 2002:a05:6a00:130c:b0:4a2:6c4c:55d0 with SMTP id j12-20020a056a00130c00b004a26c4c55d0mr5618092pfu.5.1636724702003;
        Fri, 12 Nov 2021 05:45:02 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p1sm7444569pfo.143.2021.11.12.05.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:45:01 -0800 (PST)
Date:   Fri, 12 Nov 2021 14:44:51 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/guest.c:34:29:
 sparse: sparse: incorrect type in assignment (different modifiers)
Message-ID: <YY5v0wzW192k1fG+@rocinante>
References: <202111121836.Oiqcphv0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202111121836.Oiqcphv0-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Jonathan, Dan, Frederic and Andrew for visibility]

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver
> head:   0508b6f72f055b88df518db4f3811bda9bb35da4
> commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor out common dev->driver expressions
> config: powerpc64-randconfig-s032-20211025 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=115c9d41e58388415f4956d0a988c90fb48663b9
>         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>         git fetch --no-tags helgaas-pci pci/driver
>         git checkout 115c9d41e58388415f4956d0a988c90fb48663b9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/misc/cxl/guest.c:34:29: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>    drivers/misc/cxl/guest.c:34:29: sparse:     expected struct pci_error_handlers *err_handler
>    drivers/misc/cxl/guest.c:34:29: sparse:     got struct pci_error_handlers const *err_handler
>    drivers/misc/cxl/guest.c:108:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
>    drivers/misc/cxl/guest.c:108:33: sparse:     expected unsigned long long [usertype] phys_addr
>    drivers/misc/cxl/guest.c:108:33: sparse:     got restricted __be64 [usertype]
>    drivers/misc/cxl/guest.c:109:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
>    drivers/misc/cxl/guest.c:109:27: sparse:     expected unsigned long long [usertype] len
>    drivers/misc/cxl/guest.c:109:27: sparse:     got restricted __be64 [usertype]
>    drivers/misc/cxl/guest.c:111:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
>    drivers/misc/cxl/guest.c:111:35: sparse:     expected unsigned long long [usertype] len
>    drivers/misc/cxl/guest.c:111:35: sparse:     got restricted __be64 [usertype]
>    drivers/misc/cxl/guest.c:443:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
>    drivers/misc/cxl/guest.c:443:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>    drivers/misc/cxl/guest.c:443:33: sparse:     got unsigned short [usertype] *
>    drivers/misc/cxl/guest.c:446:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>    drivers/misc/cxl/guest.c:446:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>    drivers/misc/cxl/guest.c:446:33: sparse:     got unsigned int *
>    drivers/misc/cxl/guest.c:449:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
>    drivers/misc/cxl/guest.c:449:33: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
>    drivers/misc/cxl/guest.c:449:33: sparse:     got unsigned long long [usertype] *
>    drivers/misc/cxl/guest.c:537:23: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:537:23: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:537:23: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:538:23: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:538:23: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:538:23: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:540:31: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:540:31: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:540:31: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:543:23: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:543:23: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:543:23: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:544:23: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:544:23: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:544:23: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:546:31: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:546:31: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:546:31: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:549:31: sparse: sparse: invalid assignment: |=
>    drivers/misc/cxl/guest.c:549:31: sparse:    left side has type restricted __be64
>    drivers/misc/cxl/guest.c:549:31: sparse:    right side has type unsigned long long
>    drivers/misc/cxl/guest.c:552:31: sparse: sparse: cast from restricted __be64
> --
> >> drivers/misc/cxl/pci.c:1816:29: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>    drivers/misc/cxl/pci.c:1816:29: sparse:     expected struct pci_error_handlers *err_handler
>    drivers/misc/cxl/pci.c:1816:29: sparse:     got struct pci_error_handlers const *err_handler
>    drivers/misc/cxl/pci.c:2041:37: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>    drivers/misc/cxl/pci.c:2041:37: sparse:     expected struct pci_error_handlers *err_handler
>    drivers/misc/cxl/pci.c:2041:37: sparse:     got struct pci_error_handlers const *err_handler
>    drivers/misc/cxl/pci.c:2090:37: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>    drivers/misc/cxl/pci.c:2090:37: sparse:     expected struct pci_error_handlers *err_handler
>    drivers/misc/cxl/pci.c:2090:37: sparse:     got struct pci_error_handlers const *err_handler
> 
> vim +34 drivers/misc/cxl/guest.c
> 
>     17	
>     18	static void pci_error_handlers(struct cxl_afu *afu,
>     19					int bus_error_event,
>     20					pci_channel_state_t state)
>     21	{
>     22		struct pci_dev *afu_dev;
>     23		struct pci_driver *afu_drv;
>     24		struct pci_error_handlers *err_handler;
>     25	
>     26		if (afu->phb == NULL)
>     27			return;
>     28	
>     29		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>     30			afu_drv = afu_dev->driver;
>     31			if (!afu_drv)
>     32				continue;
>     33	
>   > 34			err_handler = afu_drv->err_handler;
>     35			switch (bus_error_event) {
>     36			case CXL_ERROR_DETECTED_EVENT:
>     37				afu_dev->error_state = state;
>     38	
>     39				if (err_handler &&
>     40				    err_handler->error_detected)
>     41					err_handler->error_detected(afu_dev, state);
>     42				break;
>     43			case CXL_SLOT_RESET_EVENT:
>     44				afu_dev->error_state = state;
>     45	
>     46				if (err_handler &&
>     47				    err_handler->slot_reset)
>     48					err_handler->slot_reset(afu_dev);
>     49				break;
>     50			case CXL_RESUME_EVENT:
>     51				if (err_handler &&
>     52				    err_handler->resume)
>     53					err_handler->resume(afu_dev);
>     54				break;
>     55			}
>     56		}
>     57	}
>     58	

	Krzysztof
