Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE061625B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 13:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKBMAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 08:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiKBMAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 08:00:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D032B
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 04:59:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1128554wmb.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Nov 2022 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqC8zIB5hFCuedylIvLG06nndw5bK/Tf6gwg4OqiSs0=;
        b=kztAEqC8qS7bWCMpmhee0CNfrE20lYgD4jyURs/FqK4eL1deFhN+9IprXICuFr3+pF
         Kv6l4NyEMUmtT9v51D8NaxzOdcOJQhW0Lzx6SIlbKm0idvu/kDzANmlTxd50WPzCHF0T
         QPYh7Om47FbSgJ39H1owRCyUWUtet0ndgR5UjbJDa281lORnmjd62d5+3zZ2liQAXwLr
         XWrfn2y4QL1AYZ3J2aZv7WUndpv1D0WUtuZDgpM2myoNNfwj/Z4K+MqDzNcuJDR822Cz
         5sMcZ0k1n+cc4cRvFSRWXPFh+vMwK9dTTUGGiRuv2rPmiFOzqwo6/PD4eu52vlZdTOVs
         /5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqC8zIB5hFCuedylIvLG06nndw5bK/Tf6gwg4OqiSs0=;
        b=BpTvJ2vF+QkfGLHlraXj2xiIu+RMOE7f1H7lsFYEFaU8a5xtz8tiG/Pb94/FTMIgIj
         XQ91GzsMZswN7vNdZAzjBjIbFuWEJJwu/OFsZR9ohSmdmEuN+FomxasSQtgtfsuA8oV4
         oefpf9cBWTSMc6h/ftpCNm0M9UFUJJzwL7AxIDGMm4GcB047Zteh1mWDi4CVD6at3Sql
         p/F9zxQAWJf7x/ZNTCORvdMNMJZbDy3MykXbtyh9oxfu4fvJOc6aoGFwHUtIkOrV7T7c
         2YUY9JSwet6HqGt2biHsKV11qxic5o3xkWkvh2PUi2eOj6IRzr2/6J92cbcOofqNymyG
         Wbdw==
X-Gm-Message-State: ACrzQf1KqzP4/gu4M0GQ1N1dEbNwnsnjlQQ7/QRdFDX4V5+xUArUY5Ku
        d6ruZHKXgLsIvKCUS8q2v6Yduji52+0=
X-Google-Smtp-Source: AMsMyM4G09XvRVCGEJi1P+Sb6Fgtaz0UTwLVqODp2is2aKTK41eKVW+nWVILUqjk6rlXDXuzR/2FKQ==
X-Received: by 2002:a05:600c:384d:b0:3c6:f5ad:1e0 with SMTP id s13-20020a05600c384d00b003c6f5ad01e0mr25398912wmr.127.1667390393192;
        Wed, 02 Nov 2022 04:59:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003a601a1c2f7sm2031585wmq.19.2022.11.02.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:59:52 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:59:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, yinghai@kernel.org,
        bhelgaas@google.com, rafael.j.wysocki@intel.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH] PCI: fix handle error case in pci_alloc_child_bus()
Message-ID: <202210290121.UbqunpOZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028031709.3120927-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yang,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Yingliang/PCI-fix-handle-error-case-in-pci_alloc_child_bus/20221028-112049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
patch link:    https://lore.kernel.org/r/20221028031709.3120927-1-yangyingliang%40huawei.com
patch subject: [PATCH] PCI: fix handle error case in pci_alloc_child_bus()
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/pci/probe.c:1143 pci_alloc_child_bus() error: we previously assumed 'bridge' could be null (see line 1111)

vim +/bridge +1143 drivers/pci/probe.c

cbd4e055fc8f09 Adrian Bunk            2008-04-18  1076  static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
cbd4e055fc8f09 Adrian Bunk            2008-04-18  1077  					   struct pci_dev *bridge, int busnr)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1078  {
^1da177e4c3f41 Linus Torvalds         2005-04-16  1079  	struct pci_bus *child;
07e292950b9368 Rob Herring            2020-08-20  1080  	struct pci_host_bridge *host;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1081  	int i;
4f535093cf8f6d Yinghai Lu             2013-01-21  1082  	int ret;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1083  
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1084  	/* Allocate a new bus and inherit stuff from the parent */
670ba0c8883b57 Catalin Marinas        2014-09-29  1085  	child = pci_alloc_bus(parent);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1086  	if (!child)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1087  		return NULL;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1088  
^1da177e4c3f41 Linus Torvalds         2005-04-16  1089  	child->parent = parent;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1090  	child->sysdata = parent->sysdata;
6e325a62a0a228 Michael S. Tsirkin     2006-02-14  1091  	child->bus_flags = parent->bus_flags;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1092  
07e292950b9368 Rob Herring            2020-08-20  1093  	host = pci_find_host_bridge(parent);
07e292950b9368 Rob Herring            2020-08-20  1094  	if (host->child_ops)
07e292950b9368 Rob Herring            2020-08-20  1095  		child->ops = host->child_ops;
07e292950b9368 Rob Herring            2020-08-20  1096  	else
07e292950b9368 Rob Herring            2020-08-20  1097  		child->ops = parent->ops;
07e292950b9368 Rob Herring            2020-08-20  1098  
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1099  	/*
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1100  	 * Initialize some portions of the bus device, but don't register
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1101  	 * it now as the parent is not properly set up yet.
fd7d1ced29e5be Greg Kroah-Hartman     2007-05-22  1102  	 */
fd7d1ced29e5be Greg Kroah-Hartman     2007-05-22  1103  	child->dev.class = &pcibus_class;
1a9271331ab663 Kay Sievers            2008-10-30  1104  	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1105  
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1106  	/* Set up the primary, secondary and subordinate bus numbers */
b918c62e086b21 Yinghai Lu             2012-05-17  1107  	child->number = child->busn_res.start = busnr;
b918c62e086b21 Yinghai Lu             2012-05-17  1108  	child->primary = parent->busn_res.start;
b918c62e086b21 Yinghai Lu             2012-05-17  1109  	child->busn_res.end = 0xff;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1110  
4f535093cf8f6d Yinghai Lu             2013-01-21 @1111  	if (!bridge) {
                                                                     ^^^^^^
This code assumes bridge can be NULL.

4f535093cf8f6d Yinghai Lu             2013-01-21  1112  		child->dev.parent = parent->bridge;
4f535093cf8f6d Yinghai Lu             2013-01-21  1113  		goto add_dev;
4f535093cf8f6d Yinghai Lu             2013-01-21  1114  	}
3789fa8a2e5345 Yu Zhao                2008-11-22  1115  
3789fa8a2e5345 Yu Zhao                2008-11-22  1116  	child->self = bridge;
3789fa8a2e5345 Yu Zhao                2008-11-22  1117  	child->bridge = get_device(&bridge->dev);
4f535093cf8f6d Yinghai Lu             2013-01-21  1118  	child->dev.parent = child->bridge;
98d9f30c820d50 Benjamin Herrenschmidt 2011-04-11  1119  	pci_set_bus_of_node(child);
9be60ca0497a25 Matthew Wilcox         2009-12-13  1120  	pci_set_bus_speed(child);
9be60ca0497a25 Matthew Wilcox         2009-12-13  1121  
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1122  	/*
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1123  	 * Check whether extended config space is accessible on the child
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1124  	 * bus.  Note that we currently assume it is always accessible on
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1125  	 * the root bus.
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1126  	 */
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1127  	if (!pci_bridge_child_ext_cfg_accessible(bridge)) {
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1128  		child->bus_flags |= PCI_BUS_FLAGS_NO_EXTCFG;
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1129  		pci_info(child, "extended config space not accessible\n");
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1130  	}
17e8f0d4cee2bf Gilles Buloz           2018-05-03  1131  
3e466e2d3a04c7 Bjorn Helgaas          2017-11-30  1132  	/* Set up default resource pointers and names */
fde09c6d8f92de Yu Zhao                2008-11-22  1133  	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
^1da177e4c3f41 Linus Torvalds         2005-04-16  1134  		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
^1da177e4c3f41 Linus Torvalds         2005-04-16  1135  		child->resource[i]->name = child->name;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1136  	}
^1da177e4c3f41 Linus Torvalds         2005-04-16  1137  	bridge->subordinate = child;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1138  
4f535093cf8f6d Yinghai Lu             2013-01-21  1139  add_dev:
44aa0c657e3e45 Marc Zyngier           2015-07-28  1140  	pci_set_bus_msi_domain(child);
4f535093cf8f6d Yinghai Lu             2013-01-21  1141  	ret = device_register(&child->dev);
b1aa2ac592efcc Yang Yingliang         2022-10-28  1142  	if (WARN_ON(ret < 0)) {
b1aa2ac592efcc Yang Yingliang         2022-10-28 @1143  		bridge->subordinate = NULL;
                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

b1aa2ac592efcc Yang Yingliang         2022-10-28  1144  		put_device(&child->dev);
b1aa2ac592efcc Yang Yingliang         2022-10-28  1145  		return NULL;
b1aa2ac592efcc Yang Yingliang         2022-10-28  1146  	}
4f535093cf8f6d Yinghai Lu             2013-01-21  1147  
10a9574756201f Jiang Liu              2013-04-12  1148  	pcibios_add_bus(child);
10a9574756201f Jiang Liu              2013-04-12  1149  
057bd2e0528ec6 Thierry Reding         2016-02-09  1150  	if (child->ops->add_bus) {
057bd2e0528ec6 Thierry Reding         2016-02-09  1151  		ret = child->ops->add_bus(child);
057bd2e0528ec6 Thierry Reding         2016-02-09  1152  		if (WARN_ON(ret < 0))
057bd2e0528ec6 Thierry Reding         2016-02-09  1153  			dev_err(&child->dev, "failed to add bus: %d\n", ret);
057bd2e0528ec6 Thierry Reding         2016-02-09  1154  	}
057bd2e0528ec6 Thierry Reding         2016-02-09  1155  
4f535093cf8f6d Yinghai Lu             2013-01-21  1156  	/* Create legacy_io and legacy_mem files for this bus */
4f535093cf8f6d Yinghai Lu             2013-01-21  1157  	pci_create_legacy_files(child);
4f535093cf8f6d Yinghai Lu             2013-01-21  1158  
^1da177e4c3f41 Linus Torvalds         2005-04-16  1159  	return child;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1160  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

