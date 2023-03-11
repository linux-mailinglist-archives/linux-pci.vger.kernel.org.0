Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEF6B5C81
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCKNyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCKNyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 08:54:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10964224;
        Sat, 11 Mar 2023 05:54:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so5863478wms.0;
        Sat, 11 Mar 2023 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678542877;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6VNgsWjX3Wuvimz8g5dmkPK1Cy/m4ikAbDoLw6beJQ=;
        b=EgpADp9mPyWPriOHQHt/ftRejPRpNulP0dfOXzeleBhIPgj1NGQIJbytBzJ2k1iF4R
         CyITUZOvJLHKAPxgRdheh7BTJmNg+LH8xo7nE4cpnK/TrtstTxkyuMZEe6QB0uKZbsho
         bha6cNC4l0ab+HfNrdxjVgcV4nNCXjrWHLvd5AgmtK0unzXSSZWpk338fqWEaWfbfDXc
         gS8s4MTSvK5KviuS4DzupSZgdAs7GDKSC97xY/DJNQkr+LExD4sU3rKuRX3/o8kJ1rWj
         n5Cc6BbMqxbQX9xXF/Ai+zkDgJk3y+PUHE9rOyhjFvIaxai7o22SnhvFxKXJxhQbJB/I
         C2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542877;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6VNgsWjX3Wuvimz8g5dmkPK1Cy/m4ikAbDoLw6beJQ=;
        b=a3dkdY3JHp9tA+W/1PBX+HQ4G+w2k6Gn7htDt/LSL7i5cOuFA52jsR6r+T5H0egSEU
         A27J63ae2kPlly/hpy1k4kofYGA9ah7D5WTNu2Y3phHZNMNOEiOfQKIwHvBCi/YDyFCq
         gTO78UlUeBjlN3rfA8FAOc0nMw/HOMcT2Cg1l2OHbrch61YkZs9ZHTFqMmUNsP4snO8J
         ggF3UFYjVtKKYnhEI5mmk3pgrBgRZlKaiZvg/kwV9phXVqRi42EHo0L5GKb8RoCCSXxK
         cr+owDq1kgTomiZdpIexbxwOMhBR/R3kh3ShAfU/xFVu2MsVMDRPvrtqTlWfWTAlqwgz
         XIuw==
X-Gm-Message-State: AO0yUKXk9tihcJGnRJqdVqbSKj9/D62g4LHTh1qtqfpqtghXyOp4ozed
        gRoXUQn88X/9NiZLHTIOaVY=
X-Google-Smtp-Source: AK7set8Q/kmI9mpEEdXrr7E14surqp2hrZc9WFbOGPYrv2F11V19h1lecKjCq/bjwK7VwWka+od15A==
X-Received: by 2002:a05:600c:4e8c:b0:3eb:4cb5:dfa with SMTP id f12-20020a05600c4e8c00b003eb4cb50dfamr5440417wmq.31.1678542877399;
        Sat, 11 Mar 2023 05:54:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hn4-20020a05600ca38400b003dc1d668866sm2899772wmb.10.2023.03.11.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:54:37 -0800 (PST)
Date:   Sat, 11 Mar 2023 16:54:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <d057ac5c-5947-41e1-abc7-9428fbd2fbe2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PCI-Introduce-pci_dev_for_each_resource/20230311-011642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230310171416.23356-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230311/202303112149.xD47qKOY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303112149.xD47qKOY-lkp@intel.com/

smatch warnings:
drivers/pnp/quirks.c:248 quirk_system_pci_resources() warn: was && intended here instead of ||?

vim +248 drivers/pnp/quirks.c

0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  229  static void quirk_system_pci_resources(struct pnp_dev *dev)
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  230  {
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  231  	struct pci_dev *pdev = NULL;
059b4a086017fb Mika Westerberg 2023-03-10  232  	struct resource *res, *r;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  233  	int i, j;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  234  
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  235  	/*
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  236  	 * Some BIOSes have PNP motherboard devices with resources that
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  237  	 * partially overlap PCI BARs.  The PNP system driver claims these
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  238  	 * motherboard resources, which prevents the normal PCI driver from
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  239  	 * requesting them later.
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  240  	 *
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  241  	 * This patch disables the PNP resources that conflict with PCI BARs
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  242  	 * so they won't be claimed by the PNP system driver.
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  243  	 */
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  244  	for_each_pci_dev(pdev) {
059b4a086017fb Mika Westerberg 2023-03-10  245  		pci_dev_for_each_resource(pdev, r, i) {
059b4a086017fb Mika Westerberg 2023-03-10  246  			unsigned long type = resource_type(r);
999ed65ad12e37 Rene Herman     2008-07-25  247  
059b4a086017fb Mika Westerberg 2023-03-10 @248  			if (type != IORESOURCE_IO || type != IORESOURCE_MEM ||
                                                                                                  ^^
This || needs to be &&.  This loop will always hit the continue path
without doing anything.

059b4a086017fb Mika Westerberg 2023-03-10  249  			    resource_size(r) == 0)
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  250  				continue;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  251  
059b4a086017fb Mika Westerberg 2023-03-10  252  			if (r->flags & IORESOURCE_UNSET)
f7834c092c4299 Bjorn Helgaas   2015-03-03  253  				continue;
f7834c092c4299 Bjorn Helgaas   2015-03-03  254  
95ab3669f78306 Bjorn Helgaas   2008-04-28  255  			for (j = 0;
999ed65ad12e37 Rene Herman     2008-07-25  256  			     (res = pnp_get_resource(dev, type, j)); j++) {
aee3ad815dd291 Bjorn Helgaas   2008-06-27  257  				if (res->start == 0 && res->end == 0)
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  258  					continue;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  259  
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  260  				/*
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  261  				 * If the PNP region doesn't overlap the PCI
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  262  				 * region at all, there's no problem.
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  263  				 */
059b4a086017fb Mika Westerberg 2023-03-10  264  				if (!resource_overlaps(res, r))
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  265  					continue;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  266  
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  267  				/*
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  268  				 * If the PNP region completely encloses (or is
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  269  				 * at least as large as) the PCI region, that's
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  270  				 * also OK.  For example, this happens when the
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  271  				 * PNP device describes a bridge with PCI
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  272  				 * behind it.
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  273  				 */
059b4a086017fb Mika Westerberg 2023-03-10  274  				if (res->start <= r->start && res->end >= r->end)
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  275  					continue;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  276  
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  277  				/*
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  278  				 * Otherwise, the PNP region overlaps *part* of
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  279  				 * the PCI region, and that might prevent a PCI
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  280  				 * driver from requesting its resources.
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  281  				 */
c7dabef8a2c59e Bjorn Helgaas   2009-10-27  282  				dev_warn(&dev->dev,
059b4a086017fb Mika Westerberg 2023-03-10  283  					 "disabling %pR because it overlaps %s BAR %d %pR\n",
059b4a086017fb Mika Westerberg 2023-03-10  284  					 res, pci_name(pdev), i, r);
4b34fe156455d2 Bjorn Helgaas   2008-06-02  285  				res->flags |= IORESOURCE_DISABLED;
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  286  			}
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  287  		}
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  288  	}
0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  289  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

