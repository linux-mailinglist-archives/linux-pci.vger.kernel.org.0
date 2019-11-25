Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1C10933E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfKYSEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 13:04:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42698 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfKYSEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 13:04:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id o12so13931679oic.9;
        Mon, 25 Nov 2019 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qf6nvy3AGfk/8F2fH6p52T8sEikYK4qLF7OLDsSQxbg=;
        b=j1+gP1ErVBO+nVSm8cnRJ4kxirh1rvcAlRDVbOZORPnILAMw8xRyPiyBmIdA9UhdZX
         vGW5/pQnGpmrVpNMIzxwbDz5GBcZ1reUut7iZrajJfPRmfXQZ6ogVAkU/93YwuNOFL+Y
         gx5n7X2MKb5czekH8c1emzi6OTDJYM3jD0PPx68hzM/LX3AzHms5CVNSdFJMOZ1G5k1w
         WKi1l+hR1LiQhRsCaeng9JIOoHU/PgAl1JzBqKEs38sAxCWfvYyOcj480tIqGhSyvS+w
         RjmN3NZFngXIThzk8M4jPYt59d4/y1kbnqSsZqSVuQpz8aUwEghubC1SBf+i1HQ61m2O
         +Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qf6nvy3AGfk/8F2fH6p52T8sEikYK4qLF7OLDsSQxbg=;
        b=Ay84Dz4+59Q+gOp53OjBWZV2QKI5a8Xvr876dj1ipSoGUDhWF75nJ3HqIrQmB2MlPH
         gbAPLXXVghdPWjMz6F7d031C6/+V2rSPE4Vn3bwds44NlXfHPgpd11FqwXM4yao5O87B
         QcLAMGMNhtyKQEbHO92g4hJ//lizNjIRZ8zn9Wzp6XAskQxw2RPz4YWbgDnirtAdfNLV
         ewjXMWAJ+NzfaM154gxjBLFvNEdJ0zqGu6hwkST0vkLW8eWhbolvP9OpmD1BB1dGbmf/
         dOn9F7KDOZVHU5jn0VxwRF6orw5+wmEW308UHjdu522FV32aeMlws7/zIX567HaqvfLy
         NdGQ==
X-Gm-Message-State: APjAAAXmH9UcsOBn3/UQXtbGm5r9681anM9BMflVY67Y+tnlcoBervJT
        NCLTLx3ez1cepjw3d5v31Mk=
X-Google-Smtp-Source: APXvYqx88ShXK9ME4qgF+QCD2NcrwZ8kGtNvTA3vIRCrckPcFKmP+TwmHBWU6esdOK0iF/W+0/XO/A==
X-Received: by 2002:aca:c4d3:: with SMTP id u202mr96850oif.59.1574705090802;
        Mon, 25 Nov 2019 10:04:50 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id i11sm2640024otj.17.2019.11.25.10.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 10:04:50 -0800 (PST)
Date:   Mon, 25 Nov 2019 11:04:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Message-ID: <20191125180448.GA39139@ubuntu-x2-xlarge-x86>
References: <20191122193138.19278-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191122193138.19278-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 01:31:36PM -0600, Navid Emamdoost wrote:
> In the implementation of pci_iov_add_virtfn() the allocated virtfn is
> leaked if pci_setup_device() fails. The error handling is not calling
> pci_stop_and_remove_bus_device(). Change the goto label to failed2.
> 
> Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/pci/iov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b3f972e8cfed..713660482feb 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -164,7 +164,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  
>  	rc = pci_setup_device(virtfn);
>  	if (rc)
> -		goto failed1;
> +		goto failed2;
>  
>  	virtfn->dev.parent = dev->dev.parent;
>  	virtfn->multifunction = 0;
> -- 
> 2.17.1
> 

Hi Navid,

This patch causes a Clang warning about failed1 no longer being a used
label, as shown by this 0day build report. Would you please look into it
and address it in the same patch so there is not a warning regression?

Cheers,
Nathan

On Mon, Nov 25, 2019 at 07:20:46AM +0800, kbuild test robot wrote:
> CC: kbuild-all@lists.01.org
> In-Reply-To: <20191122193138.19278-1-navid.emamdoost@gmail.com>
> References: <20191122193138.19278-1-navid.emamdoost@gmail.com>
> TO: Navid Emamdoost <navid.emamdoost@gmail.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
> CC: emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
> 
> Hi Navid,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on v5.4-rc8 next-20191122]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Navid-Emamdoost/PCI-IOV-Fix-memory-leak-in-pci_iov_add_virtfn/20191125-020946
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm64-defconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 844d97f650a2d716e63e3be903c32a82f2f817b1)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/pci/iov.c:204:1: warning: unused label 'failed1' [-Wunused-label]
>    failed1:
>    ^~~~~~~~
>    1 warning generated.
> 
> vim +/failed1 +204 drivers/pci/iov.c
> 
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  135  
> 753f612471819d3 Jan H. Schönherr 2017-09-26  136  int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  137  {
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  138  	int i;
> dc087f2f6a2925e Jiang Liu        2013-05-25  139  	int rc = -ENOMEM;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  140  	u64 size;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  141  	char buf[VIRTFN_ID_LEN];
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  142  	struct pci_dev *virtfn;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  143  	struct resource *res;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  144  	struct pci_sriov *iov = dev->sriov;
> 8b1fce04dc2a221 Gu Zheng         2013-05-25  145  	struct pci_bus *bus;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  146  
> b07579c0924eee1 Wei Yang         2015-03-25  147  	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> dc087f2f6a2925e Jiang Liu        2013-05-25  148  	if (!bus)
> dc087f2f6a2925e Jiang Liu        2013-05-25  149  		goto failed;
> dc087f2f6a2925e Jiang Liu        2013-05-25  150  
> dc087f2f6a2925e Jiang Liu        2013-05-25  151  	virtfn = pci_alloc_dev(bus);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  152  	if (!virtfn)
> dc087f2f6a2925e Jiang Liu        2013-05-25  153  		goto failed0;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  154  
> b07579c0924eee1 Wei Yang         2015-03-25  155  	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  156  	virtfn->vendor = dev->vendor;
> 3142d832af10d8c Filippo Sironi   2017-08-28  157  	virtfn->device = iov->vf_device;
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  158  	virtfn->is_virtfn = 1;
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  159  	virtfn->physfn = pci_dev_get(dev);
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  160  
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  161  	if (id == 0)
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  162  		pci_read_vf_config_common(virtfn);
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  163  
> 156c55325d30261 Po Liu           2016-08-29  164  	rc = pci_setup_device(virtfn);
> 156c55325d30261 Po Liu           2016-08-29  165  	if (rc)
> 59fb9307eee20d6 Navid Emamdoost  2019-11-22  166  		goto failed2;
> 156c55325d30261 Po Liu           2016-08-29  167  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  168  	virtfn->dev.parent = dev->dev.parent;
> aa9319773619c9d Alex Williamson  2014-01-09  169  	virtfn->multifunction = 0;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  170  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  171  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> c1fe1f96e30d31c Bjorn Helgaas    2015-03-25  172  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  173  		if (!res->parent)
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  174  			continue;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  175  		virtfn->resource[i].name = pci_name(virtfn);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  176  		virtfn->resource[i].flags = res->flags;
> 0e6c9122a6ec96d Wei Yang         2015-03-25  177  		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  178  		virtfn->resource[i].start = res->start + size * id;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  179  		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  180  		rc = request_resource(res, &virtfn->resource[i]);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  181  		BUG_ON(rc);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  182  	}
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  183  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  184  	pci_device_add(virtfn, virtfn->bus);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  185  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  186  	sprintf(buf, "virtfn%u", id);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  187  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  188  	if (rc)
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  189  		goto failed2;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  190  	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  191  	if (rc)
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  192  		goto failed3;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  193  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  194  	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  195  
> 27d6162944b9b34 Stuart Hayes     2017-10-04  196  	pci_bus_add_device(virtfn);
> 27d6162944b9b34 Stuart Hayes     2017-10-04  197  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  198  	return 0;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  199  
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  200  failed3:
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  201  	sysfs_remove_link(&dev->dev.kobj, buf);
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  202  failed2:
> cf0921bea66c556 KarimAllah Ahmed 2018-03-19  203  	pci_stop_and_remove_bus_device(virtfn);
> dd7cc44d0bcec5e Yu Zhao          2009-03-20 @204  failed1:
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  205  	pci_dev_put(dev);
> dc087f2f6a2925e Jiang Liu        2013-05-25  206  failed0:
> dc087f2f6a2925e Jiang Liu        2013-05-25  207  	virtfn_remove_bus(dev->bus, bus);
> dc087f2f6a2925e Jiang Liu        2013-05-25  208  failed:
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  209  
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  210  	return rc;
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  211  }
> dd7cc44d0bcec5e Yu Zhao          2009-03-20  212  
> 
> :::::: The code at line 204 was first introduced by commit
> :::::: dd7cc44d0bcec5e9c42fe52e88dc254ae62eac8d PCI: add SR-IOV API for Physical Function driver
> 
> :::::: TO: Yu Zhao <yu.zhao@intel.com>
> :::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
