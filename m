Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C457FA4B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGYHbu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 25 Jul 2022 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 03:31:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211B311C39
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 00:31:48 -0700 (PDT)
Received: from mail-ej1-f41.google.com ([209.85.218.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MnJdC-1noY1X28VI-00jMwu for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022
 09:31:47 +0200
Received: by mail-ej1-f41.google.com with SMTP id os14so19008117ejb.4
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 00:31:47 -0700 (PDT)
X-Gm-Message-State: AJIora+47KnhFXEk+p80HoYMy/UeWqzNtEV96PlFQYfl0iRuouz87Yg8
        r+hBiRS3kBuPrlcFS5scan9QytXrtHYGM+gxWHU=
X-Google-Smtp-Source: AGRyM1vsvWClRqqetm520re8n4cGTiovqA9RjGoSp74hFiueZ1PjJyB2gnzgaznRGNLgBPfjuUt3vHEKZBa/C/XKbu0=
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id
 zd7-20020a17090698c700b0072b20fe807dmr9187171ejb.75.1658734307158; Mon, 25
 Jul 2022 00:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <202207170012.RhbvYS0z-lkp@intel.com> <20220722194023.GA1924461@bhelgaas>
 <20220722201928.x6c4omhpqsnctzxv@pali>
In-Reply-To: <20220722201928.x6c4omhpqsnctzxv@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 09:31:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34kKvLEFGW6XXenjP0mZBU5E+JWSdLfn+Dxzf6Dk6Ybw@mail.gmail.com>
Message-ID: <CAK8P3a34kKvLEFGW6XXenjP0mZBU5E+JWSdLfn+Dxzf6Dk6Ybw@mail.gmail.com>
Subject: Re: [helgaas-pci:pci/misc 2/2] drivers/pcmcia/omap_cf.c:240:18:
 error: implicit declaration of function 'pci_remap_iospace'; did you mean 'pci_remap_cfgspace'?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>,
        kbuild-all@lists.01.org, linux-pci <linux-pci@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:cr9Jba82OBhSEMXgCeqsWsn+NRERayikna6psOKZWKfG7B7Cdwo
 BpknXmaT3R0Vo1NOf50iIAN4LEDPMUb11MMA6H5XZdqtfZdDVtH7okcuggp6Dr48DeLwasH
 XN95Alwai9ETaWBkFiWMO/DkIqLG6NuPJkZDW8jL3Z+Oa8Qyn/m6mpCKUKCuHkWbP5PvyCY
 DmOGEzk3aTYzbyz3WhPjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X3wQmynpHkQ=:ALsxOxM/udMFgKjG0A/F5+
 VM3mpaxTRUhwhAU1x1R8cNJGVZBQGBASgzn4GM39r1L9rIVAA2tup1xiUXYD/gCxX7HGxZvwy
 sni24kV243tJg5aWF1IDNZ1DePqz7LIESavw8zrHDnD3B+T4yEHT1zJWJkYfy9/MosfTkvhWw
 eoYyYrZ9pRQk93IDbYJ3h7G+/loQu0GlY3Hxyc0skEGHdKNWzkybWfrSN4FxLry/f8rO6Zqv4
 n+HQjRaW4WW+iISxte3Wkms5ZqohGOHMc0AFFq3ln8/temjFNqVmhc31MdX+TMJlGhH+ehqQ9
 Ny1R2KXjdBMCPCU6cYETt84VpzkEg7pXT/aImYt05LXNwZHbiW2mq7kW75nErDWPSXvwqpg0b
 31WgHI5JHMhLVbr0COaA6QkdCuae75ECD2qTEpDKbXcwf4zyNG4p7PW1mgH3+ZrlLb+M6g5Tj
 hdRFKbm3UPAtpr0rDTUuIGvoiBLtRos22lZ/SMLcd66GWgHRVDpivHtNyRSG03EJD4efMFWIq
 qIKeTSdKnrzW8tmZGZdKDNyui7OUWP1hhRjvWipRXjQf0WyHi5ytK/eUSIk7QyOcZMEOqiGkk
 yQn4ol7f06tgMrOheOuSWBv33Sgv4bNfgu5+GbW9VttGtx2bjUI5KgeiGesDsjF+8o+qOhev7
 nyljBYWYT5wPQeHZ+7C0lB7qnu31xTuvAlyLW0FQMVPtJBVghkViHkPpfQYD8bnlD4LMR4u0a
 zw7J1oHMEmTgfk57CdW+asMyrqaTAA1aiJ4OANBOXVfGikwrdfI3es93gJt5wdWq1FpCyR+Wk
 tik/A1JBKfLXnI+f5TvGcMS4xqz5NLaD9FvRavtUy7oscwT6Jnxv+4g0CTHb1qgf+N/b7fMjR
 z7iXoqoflb3drto9CABw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 10:19 PM Pali Rohár <pali@kernel.org> wrote:
> On Friday 22 July 2022 14:40:23 Bjorn Helgaas wrote:
> > On Sun, Jul 17, 2022 at 12:21:13AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
> > > head:   c86c8360959ec706576baf17237dec3004154d4b
> > > commit: c86c8360959ec706576baf17237dec3004154d4b [2/2] arm: ioremap: Fix pci_remap_iospace() when CONFIG_MMU unset
> > > config: arm-randconfig-r016-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170012.RhbvYS0z-lkp@intel.com/config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=c86c8360959ec706576baf17237dec3004154d4b
> > >         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> > >         git fetch --no-tags helgaas-pci pci/misc
> > >         git checkout c86c8360959ec706576baf17237dec3004154d4b
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pcmcia/
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/pcmcia/omap_cf.c: In function 'omap_cf_set_socket':
> > >    drivers/pcmcia/omap_cf.c:127:25: warning: variable 'control' set but not used [-Wunused-but-set-variable]
> > >      127 |         u16             control;
> > >          |                         ^~~~~~~
> >
> > The above is a pre-existing warning, legitimate, but not our problem.
> >
> > >    drivers/pcmcia/omap_cf.c: In function 'omap_cf_probe':
> > > >> drivers/pcmcia/omap_cf.c:240:18: error: implicit declaration of function 'pci_remap_iospace'; did you mean 'pci_remap_cfgspace'? [-Werror=implicit-function-declaration]
> > >      240 |         status = pci_remap_iospace(&iospace, cf->phys_cf + SZ_4K);
> > >          |                  ^~~~~~~~~~~~~~~~~
> > >          |                  pci_remap_cfgspace
> >
> > This config (arm-randconfig-r016-20220715 above) has:
> >
> >   # CONFIG_MMU is not set
>
> Arnd, any idea what is happening here with pcmcia omap driver?

The OMAP PCMCIA driver can be enabled for non-MMU configurations when
compile testing, and it does not depend on PCI:

config OMAP_CF
        tristate "OMAP CompactFlash Controller"
        depends on PCMCIA
        depends on ARCH_OMAP16XX || (ARM && COMPILE_TEST)

> It is just missing some include header file, or broken dependences in
> Kconfig?

The problem is that the generic pci_remap_iospace() is only available
when PCI is enabled, both the function definition and the declaration are
guarded with CONFIG_PCI.

Since the I/O space accessors are shared between PCI, ISA and
PCMCIA, we have to use the same pci_remap_iospace() function to
map it when any of the three are in use. For some platforms,
we work around it using a static boot-time mapping to PCI_IOBASE
with iotable_init(), but pci_remap_iospace() is generally the cleaner
approach.

It's probably best to just mark this driver as depending on !MMU,
since we don't care about MMU-less OMAP kernels and the driver
is not usable elsewhere.

        Arnd
