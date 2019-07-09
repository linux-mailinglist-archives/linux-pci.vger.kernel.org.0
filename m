Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2877634D5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGILVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 07:21:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfGILVn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 07:21:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x69BKgxd020314;
        Tue, 9 Jul 2019 06:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562671242;
        bh=a4kaAky6tT6qbHqwtG33eS0XjN43B4HSqj29VXdGZsk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Js7u6nvHO6DYo14LMQ3eSKyq/Uv+ic+vaK4P9fGAz+U7Qj0DaW+Px+sSi78+5YB+r
         4QfT73GjHJ8SK8XuRNhNKdIyvZA5zCKNc610geIsinhD8o+G3LEqOJD6KzVGobdYet
         VdC1RMD5dL90xG6wGK4eZJRilbdQVvCIOv0gsNgk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x69BKgmk052963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jul 2019 06:20:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Jul
 2019 06:20:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Jul 2019 06:20:41 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x69BKaWi028529;
        Tue, 9 Jul 2019 06:20:37 -0500
Subject: Re: [PATCH v1] tools: PCI: Fix installation when `make
 tools/pci_install`
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
 <20190705162358.GA3080@e121166-lin.cambridge.arm.com>
 <20190705170853.GG9224@smile.fi.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7c48dbae-847b-812d-88f3-7336686bd46e@ti.com>
Date:   Tue, 9 Jul 2019 16:48:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705170853.GG9224@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 05/07/19 10:38 PM, Andy Shevchenko wrote:
> On Fri, Jul 05, 2019 at 05:23:58PM +0100, Lorenzo Pieralisi wrote:
>> On Fri, Jun 28, 2019 at 04:33:26PM +0300, Andy Shevchenko wrote:
>>> The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
>>> fixed a `make tools clean` issue and simultaneously brought a regression
>>> to the installation process:
>>>
>>>   for script in .../tools/pci/pcitest.sh; do	\
>>> 	install $script .../usr/usr/bin;	\
>>>   done
>>>   install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory
>>>
>>> Here is the missed part of the fix.
>>
>> Sigh, hopefully that's the last fix :), Kishon if that's OK mind
>> ACKing it please ?
> 
> From my side, yes. Now it works as I expect.
> 
> Honestly, I'm puzzled how so many errors has been pushed upstream...

I'm not sure why, but I don't see any issue without this patch as well. Am I
missing something here? I'm copy pasting the steps below.

a0393678@a0393678ub:~/repos/linux/tools/pci$ make clean
rm -f pcitest
rm -rf include/
find . -name '*.o' -delete -o -name '\.*.d' -delete
a0393678@a0393678ub:~/repos/linux/tools/pci$ make
mkdir -p include/linux/ 2>&1 || true
ln -sf /home/a0393678/repos/linux/tools/pci/../../include/uapi/linux/pcitest.h
include/linux/
make -f /home/a0393678/repos/linux/tools/build/Makefile.build dir=. obj=pcitest
make[1]: Entering directory '/home/a0393678/repos/linux/tools/pci'
  CC       pcitest.o
  LD       pcitest-in.o
make[1]: Leaving directory '/home/a0393678/repos/linux/tools/pci'
  LINK     pcitest
a0393678@a0393678ub:~/repos/linux/tools/pci$ sudo make install
make -f /home/a0393678/repos/linux/tools/build/Makefile.build dir=. obj=pcitest
install -d -m 755 /usr/bin;		\
for program in pcitest pcitest.sh; do	\
	install $program /usr/bin;	\
done;						\
for script in pcitest.sh; do		\
	install $script /usr/bin;	\
done
a0393678@a0393678ub:~/repos/linux/tools/pci$

Thanks
Kishon
