Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934862D22A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 05:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKQEMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 23:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKQEM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 23:12:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B432B8F;
        Wed, 16 Nov 2022 20:12:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so1315708wrm.13;
        Wed, 16 Nov 2022 20:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gM3PtvPAdYS2cL7GwLPhGFEGDIfhNGK5xW1YKSqAlqI=;
        b=i7enR9MnStHWDiFeKdWX5LPhsTsRCxiq4GaJlWfecj34xt3cMfTeP5VYwZDz6BN8Go
         zSiJFITJaa8RhwWFtQbjfwImn4uf4edOeMNSxLLCSf1EtIL4u35IqKUBrTFIo0HbgjJj
         p3HKVQCzMGWvF4CtF4c3CIWbYkQ0oySnBoxQWk9ZxHEkcFJxPhS1M4x93CDzXFEVhLDG
         E0IDec710zT71gTUlNXEJtC21QZ/Kc1MPeTw8rfEY4tgiP88EEcnq1kxDl73Xkc19tqy
         MZsOGkrFHml4Z7oJevYDpGdpPyip1H8o9zhTT9dLDs9EcOUbH2k+3NCtNufvFbPPQRPL
         p9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gM3PtvPAdYS2cL7GwLPhGFEGDIfhNGK5xW1YKSqAlqI=;
        b=6vxONInLDykO5W+JJw/VPR3xluYAxCe4A7JMxViAx1ZGDtmyG8it+80V64A+AEzwH6
         /4Qz23/XEi2p3f3nDnljqSiSql13esiwe72YMI+XH15vOJ6nQAnh/3ec/y64Hs7KX3Nk
         LBhd0GLQ90iAXQlM/dD0OMbdbKsyAQSeogizMJPajNg+WzznCUtObzaoef1lo8o+WwJy
         6q8jDp/+hY8+2C9xt3jWXAOv+yFd0FjvxvWqKHXxyvZOkw06u+OWdWU82hs7sYfefSGi
         1B4APbnP0sCC/bgHGSV8mD14daiECrcRoXyUBVUI7j48MpYbo936nJ2Z2PjLIvwcAt3b
         ZrGw==
X-Gm-Message-State: ANoB5pmNpyHcwYIBRKVCgm2QkqYSGAQgV/rrrT0D0CJrdlp3hjg2vGS+
        tQ/zQBwd8YvvxJ9I8zEezAQ=
X-Google-Smtp-Source: AA0mqf5mLvMwgquR9ICuNaOBwEssOw9+IVyuu28bZWGtGGVsZmBYcoFOd5y45nQljfNsNCS87F7iLg==
X-Received: by 2002:adf:d84c:0:b0:236:6f1a:955 with SMTP id k12-20020adfd84c000000b002366f1a0955mr283056wrl.111.1668658346920;
        Wed, 16 Nov 2022 20:12:26 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d54cb000000b002415dd45320sm16479931wrv.112.2022.11.16.20.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 20:12:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 07:12:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, liupeibao@loongson.cn,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: loongson: add skip-scan property for child DT
 node
Message-ID: <202211160131.oycRMuJQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103090040.836-1-liupeibao@loongson.cn>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Liu,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Peibao/PCI-loongson-add-skip-scan-property-for-child-DT-node/20221103-170125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
patch link:    https://lore.kernel.org/r/20221103090040.836-1-liupeibao%40loongson.cn
patch subject: [PATCH 1/2] PCI: loongson: add skip-scan property for child DT node
config: loongarch-randconfig-m041-20221114
compiler: loongarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/pci/controller/pci-loongson.c:257 setup_masklist() error: not allocating enough for = 'entry' 24 vs 8

vim +/entry +257 drivers/pci/controller/pci-loongson.c

f93e71fb8e65ba Liu Peibao  2022-11-03  242  static int setup_masklist(struct loongson_pci *priv)
f93e71fb8e65ba Liu Peibao  2022-11-03  243  {
f93e71fb8e65ba Liu Peibao  2022-11-03  244  	struct device *dev = &priv->pdev->dev;
f93e71fb8e65ba Liu Peibao  2022-11-03  245  	struct device_node *dn, *parent = dev->of_node;
f93e71fb8e65ba Liu Peibao  2022-11-03  246  	struct mask_entry *entry;
f93e71fb8e65ba Liu Peibao  2022-11-03  247  	int devfn;
f93e71fb8e65ba Liu Peibao  2022-11-03  248  
f93e71fb8e65ba Liu Peibao  2022-11-03  249  	INIT_LIST_HEAD(&priv->masklist);
f93e71fb8e65ba Liu Peibao  2022-11-03  250  
f93e71fb8e65ba Liu Peibao  2022-11-03  251  	for_each_child_of_node(parent, dn) {
f93e71fb8e65ba Liu Peibao  2022-11-03  252  		if (of_property_read_bool(dn, "skip-scan")) {
f93e71fb8e65ba Liu Peibao  2022-11-03  253  			devfn = of_pci_get_devfn(dn);
f93e71fb8e65ba Liu Peibao  2022-11-03  254  			if (devfn < 0)
f93e71fb8e65ba Liu Peibao  2022-11-03  255  				continue;
f93e71fb8e65ba Liu Peibao  2022-11-03  256  
f93e71fb8e65ba Liu Peibao  2022-11-03 @257  			entry = devm_kzalloc(dev, sizeof(entry), GFP_KERNEL);
                                                                                          ^^^^^^^^^^^^^
Should be sizeof(*entry)

f93e71fb8e65ba Liu Peibao  2022-11-03  258  			if (!entry)
f93e71fb8e65ba Liu Peibao  2022-11-03  259  				return -ENOMEM;
f93e71fb8e65ba Liu Peibao  2022-11-03  260  
f93e71fb8e65ba Liu Peibao  2022-11-03  261  			entry->devfn = devfn;
f93e71fb8e65ba Liu Peibao  2022-11-03  262  			list_add_tail(&entry->entry, &priv->masklist);
f93e71fb8e65ba Liu Peibao  2022-11-03  263  		}
f93e71fb8e65ba Liu Peibao  2022-11-03  264  	}
f93e71fb8e65ba Liu Peibao  2022-11-03  265  
f93e71fb8e65ba Liu Peibao  2022-11-03  266  	return 0;
f93e71fb8e65ba Liu Peibao  2022-11-03  267  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

