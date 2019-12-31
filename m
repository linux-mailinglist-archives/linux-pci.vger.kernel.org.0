Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4D12D718
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfLaIdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 03:33:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43494 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaIdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 03:33:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBV8XIpv039830;
        Tue, 31 Dec 2019 02:33:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577781198;
        bh=jbOv1LVbSazAXgc+tVdf1lshir3VjpBQ9GhevKwekk8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r7+o6OffmTxm00zXbxuk2arAa6kz5nEw+UIp4kePDchAbpZ4KlHXxLAdnSOyjpl5O
         GlwjRBFqjGrIvptP+WgjzySX+BJ2kjZgLx/ejB68e0dB+nxOl0uKDPPWj0eFRKaWU6
         VE1qelkQVC98qpqL9kaXZNpNtMURAhzlUS+7R/NY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBV8XHDu082565;
        Tue, 31 Dec 2019 02:33:17 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 02:33:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 02:33:17 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBV8XEaC127311;
        Tue, 31 Dec 2019 02:33:15 -0600
Subject: Re: [PATCH 2/7] misc: pci_endpoint_test: Do not request or allocate
 IRQs in probe
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191230123315.31037-3-kishon@ti.com>
 <201912310039.Jef27rlg%lkp@intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b561503f-a753-7750-2a43-78509755eb83@ti.com>
Date:   Tue, 31 Dec 2019 14:05:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201912310039.Jef27rlg%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 30/12/19 10:40 PM, kbuild test robot wrote:
> Hi Kishon,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on pci/next arm-soc/for-next linus/master v5.5-rc4 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Kishon-Vijay-Abraham-I/Improvements-to-pci_endpoint_test-driver/20191230-203402
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git d1eef1c619749b2a57e514a3fa67d9a516ffa919
> config: arm-randconfig-a001-20191229 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11:0,
>                     from include/linux/delay.h:22,
>                     from drivers/[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.commisc/pci_endpoint_test.c:10:
>    drivers/misc/pci_endpoint_test.c: In function 'pci_endpoint_test_probe':
>    drivers/misc/pci_endpoint_test.c:73:22: error: 'PCI_DEVICE_ID_TI_J721E' undeclared (first use in this function); did you mean 'PCI_DEVICE_ID_TI_7510'?
>       ((pdev)->device == PCI_DEVICE_ID_TI_J721E)

The patches in this series should be merged only after [1]. With that
this error wouldn't be seen.

[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com

Thanks
Kishon
