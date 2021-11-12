Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012ED44DFDE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 02:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhKLBpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 20:45:07 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41745 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbhKLBpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 20:45:07 -0500
Received: by mail-pf1-f180.google.com with SMTP id g19so7131663pfb.8
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 17:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnrvUG3VdZiuyIh7kln9dxzciqmpc8apyv+Dvi+kZx4=;
        b=hFXD2RnDysCcyueI87NrP5yni2VW5brBs7jYZcva8GWxY47HdNN2wj/Ol5gwrD9qgm
         2/Kc9fOOBksckepjFtX0EmFVLtt2F8MP+10mwiEuFswojHGFyTepUgBKvVwuiqyuvwGN
         HE3ENByq5rWKz8Afd8Y/jjOwuGwD2+0b8Kt6GG8+0THkayl+tMfMFSF4SARM5HSmnqEX
         pE8Ann5JhJSX1qzvcLHq+WQsj3h3eH3XRfDS6bze4qGJxHzY6cDADUs+FcEV82B9Imxo
         4cIR2K22uc3m5ue5dSZotFJXomvO2dmMZ7IlwQf9mrxVPad7/GWm2eDg14Hc44pK1Dyj
         hBow==
X-Gm-Message-State: AOAM531h+nUoibHjRkjvODZTCfVjBfxHImQ/vycwCvjLD7MJiWHEnbJM
        scYa8uo5Zlk3EI+UfetuGE0=
X-Google-Smtp-Source: ABdhPJzf6lMrU+pSBDEtO6su5P2QQThZo6A00ntSF6Xuo4znMBr3z+xcvsebU/Id0oDA3xrI9XqD/w==
X-Received: by 2002:a62:33c6:0:b0:4a0:3a81:3489 with SMTP id z189-20020a6233c6000000b004a03a813489mr10010012pfz.59.1636681337294;
        Thu, 11 Nov 2021 17:42:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u2sm4099351pfi.120.2021.11.11.17.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:42:16 -0800 (PST)
Date:   Fri, 12 Nov 2021 02:42:06 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/pci.c:1816:29:
 error: assignment discards 'const' qualifier from pointer target type
Message-ID: <YY3GbjLsnkUc/zhG@rocinante>
References: <202111120955.M4Pkd0T4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202111120955.M4Pkd0T4-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Jonathan, Dan, Frederic and Andrew for visibility]

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver
> head:   0508b6f72f055b88df518db4f3811bda9bb35da4
> commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor out common dev->driver expressions
> config: powerpc64-allnoconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=115c9d41e58388415f4956d0a988c90fb48663b9
>         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>         git fetch --no-tags helgaas-pci pci/driver
>         git checkout 115c9d41e58388415f4956d0a988c90fb48663b9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/misc/cxl/pci.c: In function 'cxl_vphb_error_detected':
> >> drivers/misc/cxl/pci.c:1816:29: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>     1816 |                 err_handler = afu_drv->err_handler;
>          |                             ^
>    drivers/misc/cxl/pci.c: In function 'cxl_pci_slot_reset':
>    drivers/misc/cxl/pci.c:2041:37: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>     2041 |                         err_handler = afu_drv->err_handler;
>          |                                     ^
>    drivers/misc/cxl/pci.c: In function 'cxl_pci_resume':
>    drivers/misc/cxl/pci.c:2090:37: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>     2090 |                         err_handler = afu_drv->err_handler;
>          |                                     ^
>    cc1: all warnings being treated as errors
> --
>    drivers/misc/cxl/guest.c: In function 'pci_error_handlers':
> >> drivers/misc/cxl/guest.c:34:29: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>       34 |                 err_handler = afu_drv->err_handler;
>          |                             ^
>    cc1: all warnings being treated as errors
> 
> 
> vim +/const +1816 drivers/misc/cxl/pci.c
> 
>   1793	
>   1794	static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
>   1795							pci_channel_state_t state)
>   1796	{
>   1797		struct pci_dev *afu_dev;
>   1798		struct pci_driver *afu_drv;
>   1799		struct pci_error_handlers *err_handler;
>   1800		pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
>   1801		pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
>   1802	
>   1803		/* There should only be one entry, but go through the list
>   1804		 * anyway
>   1805		 */
>   1806		if (afu == NULL || afu->phb == NULL)
>   1807			return result;
>   1808	
>   1809		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   1810			afu_drv = afu_dev->driver;
>   1811			if (!afu_drv)
>   1812				continue;
>   1813	
>   1814			afu_dev->error_state = state;
>   1815	
> > 1816			err_handler = afu_drv->err_handler;
>   1817			if (err_handler)
>   1818				afu_result = err_handler->error_detected(afu_dev,
>   1819									 state);
>   1820			/* Disconnect trumps all, NONE trumps NEED_RESET */
>   1821			if (afu_result == PCI_ERS_RESULT_DISCONNECT)
>   1822				result = PCI_ERS_RESULT_DISCONNECT;
>   1823			else if ((afu_result == PCI_ERS_RESULT_NONE) &&
>   1824				 (result == PCI_ERS_RESULT_NEED_RESET))
>   1825				result = PCI_ERS_RESULT_NONE;
>   1826		}
>   1827		return result;
>   1828	}
>   1829	

	Krzysztof
