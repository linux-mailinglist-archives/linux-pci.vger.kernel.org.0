Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D402319A895
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgDAJYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 05:24:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33948 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAJYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 05:24:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id d3so17047140oic.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuZP9xe9L/1gxphDNAh1Xxt5Yser4QXnI714XntwCDY=;
        b=RqjZAZfHG5Gwf7NhKpijtcYQilgNrY7cRHhpUtpT1d2ByUWnZRWy1bXwad6kQJiWGf
         StqBfbU/eD5Pq5CxdqB6B4F5a9wCM6vhYP35bTXxQpr/B6UkRZiYiR1N9LcIA+siZYAq
         AN7jgp8kD8H8hmh9JqwWg5DX8jSISTP+81i6sbruhKnkF6BE5dayU9/8GxiTYDQqL7MU
         OLOgSwAdbD9T+Ar29g7havThJXf5ifuv436dVjIBg9y+GyFxpfDNYSXx2j4CeFgSceML
         vjzkTOaN/WLRBq9R4Fw+2nRHLNOXoCmcoIg8Yj/YeEVBDgSjcTaSWy+3ioHrMTfne4BQ
         MehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuZP9xe9L/1gxphDNAh1Xxt5Yser4QXnI714XntwCDY=;
        b=oH3ZNpcn2033ctfhLFxhLNmrH/MNnJfm0ga+NK/SQ9XSY57AH+C8D77bUKwutdhUgF
         XEEkN4Yhlqo8WGkI6o76u1Q2epBps+jnrUyAQa5RNXVK758uT2nR9zmfqVxTsmRk9f1d
         fx3A+/hDCatuoR7hpjh9NWIsewtbmgsVsZeWwbLdYil1MzwGXAu8SnmFDLZtoQHqpxL6
         Je62fcqQPNw0e5SR2g8S7xPqosah2b6/o1rh84cydr1kM2hWvhtcO0yuhIxRBNu4706B
         cRBzOtKm+2RktEQR0lEW+mjHNi+jUOHc3LM+nRj8royLHQq83Gez8dCLLc1n4MQ1E1JY
         JJ/w==
X-Gm-Message-State: AGi0PubK7oRgaJHt41J9cd9N4N4XutZAMRN57BMKB9JbEO+vKRk1+Ys6
        ICjVdbr2L2Y8kpq/qsckl5XWz0zAzx1n/yGhAiQ=
X-Google-Smtp-Source: APiQypKXtNaORyqXgo8djHJcWYP/rW8ta+5dYmwQNjN4kykXx1ME2TPWnAuiUf5qw81CubLjNuCC/cb3YbmOpepfimo=
X-Received: by 2002:aca:ac89:: with SMTP id v131mr2124778oie.7.1585733086906;
 Wed, 01 Apr 2020 02:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com> <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com> <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
 <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com> <TYAPR01MB4544972970249F317DEBE5AAD8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544972970249F317DEBE5AAD8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 1 Apr 2020 10:24:20 +0100
Message-ID: <CA+V-a8vCKRtWxfB1u-XZxVeioi76Fdhb_gOWMC9TtSEmyFersg@mail.gmail.com>
Subject: Re: PCIe EPF
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Shimoda-san,

On Wed, Apr 1, 2020 at 9:50 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Prabhakar-san,
>
> > From: Lad, Prabhakar, Sent: Wednesday, April 1, 2020 5:00 PM
> <snip>
> > > > root@hihope-rzg2m:~# pcitest -r -s 2176
> > > <snip>
> > > > [  528.556991] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > > ffff0004b61f9000 7e951000 910c690d=910c690d
> > >
> > > I'd like to know how to print these crc values. Your report on the case 1
> > > mentioned on pci-epf-test.c like below though.
> > >
> > > > +       dev_err(dev, "%s %llx %llx csum: %x = %x\n", __func__, reg->dst_addr,
> > > > +               phys_addr, reg->checksum, crc32_le(~0, dst_addr, reg->size));
> > >
> > > Also, as I mentioned on previous email, this is possible to cause timing issue.
> > > So, I'd like to where you added the hexdump on pci_endpoint_test.c.
> > > Perhaps, copy and pasting your whole debug diff is useful to understand about it.
> > >
> >
> > Following is the complete diff:
>
> Thanks!
>
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3c49514b4813..e7bf58a1fee8 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -561,6 +561,23 @@ static bool pci_endpoint_test_write(struct
> > pci_endpoint_test *test,
> >      return ret;
> >  }
> >
> > +static void print_buffer(struct device *dev, void *buff_addr, size_t size)
> > +{
> > +    size_t i;
> > +    u64 *addr = buff_addr;
> > +
> > +    for(i = 0; i < size; i += sizeof(addr))
> > +        dev_err(dev, "buf[%zu] : %llx\n", i, *addr);
> > +
> > +    for(i = 0; i < size; i +=1) {
> > +        if (0x910c690d == crc32_le(~0, buff_addr, i))
> > +            dev_err(dev, "%x\n",
> > +                crc32_le(~0, buff_addr, i));
> > +    }
> > +
> > +    dev_err(dev, "\n\n\n\n");
> > +}
> > +
> >  static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
> >                     unsigned long arg)
> >  {
> > @@ -608,7 +625,7 @@ static bool pci_endpoint_test_read(struct
> > pci_endpoint_test *test,
> >      }
>
> I'd like to allocate temporary buffer here to copy data later...
>         void *tmp;
>         ...
>         tmp = kzalloc(size + alignment, GFP_KERNEL);
>
> >      orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> > -                    DMA_FROM_DEVICE);
> > +                    DMA_BIDIRECTIONAL);
> >      if (dma_mapping_error(dev, orig_phys_addr)) {
> >          dev_err(dev, "failed to map source buffer address\n");
> >          ret = false;
> > @@ -640,12 +657,17 @@ static bool pci_endpoint_test_read(struct
> > pci_endpoint_test *test,
> >      wait_for_completion(&test->irq_raised);
> >
> >      dma_unmap_single(dev, orig_phys_addr, size + alignment,
> > -             DMA_FROM_DEVICE);
> > +             DMA_BIDIRECTIONAL);
>
> And then, I'd like to copy addr buffer to the tmp here.
>         memcpy(tmp, addr, size);
>
> >      crc32 = crc32_le(~0, addr, size);
>
> And addr is replaced with tmp;
>
> >      if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
> >          ret = true;
> >
> > +    print_buffer(dev, addr, size);
>
> This addr is also replaced with tmp;
>
> > +    dev_err(dev, "%s %px %llx %x=%x\n", __func__, orig_addr,
> > +        orig_phys_addr, crc32,
> > +        pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM));
>
> The crc32 value was calculated before print the buffer.
> This means that timing is difference between crc32_le(addr) and print_buffer(addr).
> So, I'd like to copy the addr buffer to tmp and use the tmp for crc32_le() and print_buffer().
>
Following is the diff of suggested changes:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3c49514b4813..b782134838d1 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -561,6 +561,23 @@ static bool pci_endpoint_test_write(struct
pci_endpoint_test *test,
     return ret;
 }

+static void print_buffer(struct device *dev, void *buff_addr, size_t size)
+{
+    size_t i;
+    u64 *addr = buff_addr;
+
+    for(i = 0; i < size; i += sizeof(addr))
+        dev_err(dev, "buf[%zu] : %llx\n", i, *addr);
+
+    for(i = 0; i < size; i +=1) {
+        if (0x910c690d == crc32_le(~0, buff_addr, i))
+            dev_err(dev, "%x\n",
+                crc32_le(~0, buff_addr, i));
+    }
+
+    dev_err(dev, "\n\n\n\n");
+}
+
 static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
                    unsigned long arg)
 {
@@ -574,6 +591,7 @@ static bool pci_endpoint_test_read(struct
pci_endpoint_test *test,
     struct pci_dev *pdev = test->pdev;
     struct device *dev = &pdev->dev;
     void *orig_addr;
+    void *tmp_buffer;
     dma_addr_t orig_phys_addr;
     size_t offset;
     size_t alignment = test->alignment;
@@ -601,14 +619,19 @@ static bool pci_endpoint_test_read(struct
pci_endpoint_test *test,
     }

     orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-    if (!orig_addr) {
+    tmp_buffer = kzalloc(size + alignment, GFP_KERNEL);
+    if (!orig_addr || !tmp_buffer) {
         dev_err(dev, "Failed to allocate destination address\n");
         ret = false;
+        if (orig_addr)
+            kfree(orig_addr);
+        if (tmp_buffer)
+            kfree(tmp_buffer);
         goto err;
     }

     orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-                    DMA_FROM_DEVICE);
+                    DMA_BIDIRECTIONAL);
     if (dma_mapping_error(dev, orig_phys_addr)) {
         dev_err(dev, "failed to map source buffer address\n");
         ret = false;
@@ -640,14 +663,24 @@ static bool pci_endpoint_test_read(struct
pci_endpoint_test *test,
     wait_for_completion(&test->irq_raised);

     dma_unmap_single(dev, orig_phys_addr, size + alignment,
-             DMA_FROM_DEVICE);
+             DMA_BIDIRECTIONAL);
+
+    memcpy(tmp_buffer, addr, size);

     crc32 = crc32_le(~0, addr, size);
     if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
         ret = true;

+    print_buffer(dev, addr, size);
+    print_buffer(dev, tmp_buffer, size);
+    dev_err(dev, "%s kzalloc:%px dma handle:%llx buffer CRC:%x BAR
CRC:%x tmp buffer crc: %x\n",
+        __func__, orig_addr, orig_phys_addr, crc32,
+        pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM),
+        crc32_le(~0, tmp_buffer, size));
+
 err_phys_addr:
     kfree(orig_addr);
+    kfree(tmp_buffer);
 err:
     return ret;
 }

> > +
> >  err_phys_addr:
> >      kfree(orig_addr);
> >  err:
> >
> > Note: I have added DMA_BIDIRECTIONAL that is because I am also
> > printing the buffer on ep
> > and calulating the crc
> >
> > > > READ (   2176 bytes):           OKAY
> > > > root@hihope-rzg2m:~# pcitest -r -s 2176
> > > <snip>
> > > > [  533.457921] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > > ffff0004b61f9000 7e959800  ce535039=910c690d
> > > > READ (   2176 bytes):           NOT OKAY
> > > >
> > > > Note: for failure case the crc is always ce535039
> > >
> > > The value of ce535039 is from pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM)?
> > > If so, it's strange because all 0xdf values with 2176 bytes should be 910c690d by crc32_le().
> > >
> > The value ce535039 is the one which is calculated from the buffer and
> > value 910c690d is the one
> > which is passed from the BAR memory which is correct.
>
> I got it. If my guess is correct, using the tmp buffer above can print
> the buffer with wrong value(s).
>
>
> By the way, your PCIe host environment (RZ/G2N) output the following log?
>
> [    0.000000] software IO TLB: mapped [mem 0x7bfff000-0x7ffff000] (64MB)
>
> If so, I guess this issue is related to this software IO TLB behavior.
> IIUC, if we use coherent buffer or GPF_DMA buffer, the kernel will not
> use software IO TLB for these buffers.
>

root@hihope-rzg2m:~# dmesg | grep TLB
[    0.000000] software IO TLB: mapped [mem 0x7bfff000-0x7ffff000] (64MB)
[    0.149808] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.149825] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.149834] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.149843] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
root@hihope-rzg2m:~#
root@hihope-rzg2m:~#
root@hihope-rzg2m:~#
root@hihope-rzg2m:~#
root@hihope-rzg2m:~# pcitest -i1
SET IRQ TYPE TO MSI:            OKAY
root@hihope-rzg2m:~#
root@hihope-rzg2m:~#
root@hihope-rzg2m:~# cat read.sh
pcitest -i 1
while [ 1 ]; do pcitest -r -s 2176; done
root@hihope-rzg2m:~# pcitest -r -s 2176
[   77.863719] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[   77.870299] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[   77.876800] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[   77.883563] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[   77.890241] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[   77.896837] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[   77.903406] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[   77.909971] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[   77.916534] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[   77.923110] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[   77.929672] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[   77.936242] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[   77.942808] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[   77.949374] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[   77.956023] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[   77.962675] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[   77.969323] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[   77.975977] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[   77.982626] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[   77.989281] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[   77.995944] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[   78.002602] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[   78.009253] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[   78.015905] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[   78.022563] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[   78.029214] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[   78.035863] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[   78.042515] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[   78.049165] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[   78.055818] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[   78.062466] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[   78.069116] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[   78.075768] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[   78.082418] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[   78.089066] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[   78.095720] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[   78.102371] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[   78.109025] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[   78.115686] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[   78.122356] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[   78.129003] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[   78.135658] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[   78.142306] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[   78.148958] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[   78.155607] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[   78.162257] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[   78.168905] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[   78.175554] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[   78.182204] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[   78.188854] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[   78.195504] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[   78.202154] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[   78.208804] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[   78.215457] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[   78.222113] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[   78.228769] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[   78.235428] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[   78.242089] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[   78.248741] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[   78.255394] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[   78.262042] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[   78.268692] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[   78.275342] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[   78.281992] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[   78.288639] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[   78.295291] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[   78.301939] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[   78.308587] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[   78.315234] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[   78.321895] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[   78.328545] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[   78.335195] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[   78.341843] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[   78.348496] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[   78.355156] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[   78.361815] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[   78.368462] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[   78.375117] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[   78.381764] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[   78.388416] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[   78.395063] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[   78.401717] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[   78.408366] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[   78.415023] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[   78.421677] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[   78.428329] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[   78.434977] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[   78.441630] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[   78.448279] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[   78.454929] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[   78.461578] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[   78.468231] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[   78.474890] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[   78.481548] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[   78.488199] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[   78.494852] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[   78.501500] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[   78.508150] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[   78.514797] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[   78.521470] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[   78.528122] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[   78.534774] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[   78.541423] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[   78.548070] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[   78.554720] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[   78.561367] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[   78.568017] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[   78.574667] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[   78.581317] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[   78.587964] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[   78.594623] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[   78.601286] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[   78.607946] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[   78.614596] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[   78.621246] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[   78.627902] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[   78.634553] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[   78.641203] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[   78.647852] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[   78.654499] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[   78.661148] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[   78.667794] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[   78.674445] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[   78.681094] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[   78.687746] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[   78.694395] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[   78.701133] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[   78.707870] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[   78.714613] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[   78.721363] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[   78.728119] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[   78.734856] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[   78.741595] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[   78.748330] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[   78.755069] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[   78.761806] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[   78.768543] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[   78.775277] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[   78.782015] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[   78.788749] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[   78.795487] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[   78.802221] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[   78.808957] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[   78.815692] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[   78.822428] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[   78.829173] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[   78.835925] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[   78.842670] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[   78.849531] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[   78.856287] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[   78.863031] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[   78.869767] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[   78.876506] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[   78.883240] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[   78.889983] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[   78.896719] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[   78.903459] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[   78.910194] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[   78.916932] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[   78.923667] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[   78.930414] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[   78.937149] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[   78.943892] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[   78.950628] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[   78.957367] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[   78.964102] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[   78.970846] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[   78.977597] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[   78.984342] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[   78.991078] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[   78.997815] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[   79.004550] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[   79.011288] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[   79.018023] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[   79.024762] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[   79.031504] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[   79.038243] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[   79.044978] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[   79.051715] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[   79.058450] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[   79.065187] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[   79.071922] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[   79.078662] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[   79.085397] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[   79.092137] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[   79.098874] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[   79.105628] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[   79.112375] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[   79.119116] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[   79.125850] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[   79.132599] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[   79.139336] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[   79.146072] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[   79.152808] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[   79.159545] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[   79.166279] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[   79.173015] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[   79.179754] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[   79.186494] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[   79.193230] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[   79.199968] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[   79.206703] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[   79.213442] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[   79.220214] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[   79.226952] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[   79.233700] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[   79.240436] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[   79.247173] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[   79.253907] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[   79.260642] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[   79.267376] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[   79.274110] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[   79.280845] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[   79.287580] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[   79.294315] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[   79.301050] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[   79.307786] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[   79.314524] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[   79.321260] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[   79.327998] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[   79.334742] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[   79.341490] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[   79.348239] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[   79.354979] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[   79.361718] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[   79.368454] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[   79.375192] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[   79.381928] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[   79.388663] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[   79.395399] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[   79.402133] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[   79.408868] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[   79.415606] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[   79.422340] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[   79.429075] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[   79.435814] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[   79.442551] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[   79.449289] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[   79.456027] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[   79.462769] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[   79.469524] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[   79.476272] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[   79.483017] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[   79.489754] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[   79.496490] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[   79.503224] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[   79.509960] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[   79.516696] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[   79.523434] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[   79.530172] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[   79.536915] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[   79.543650] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[   79.550387] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[   79.557121] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[   79.563857] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[   79.570592] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[   79.577326] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[   79.584061] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[   79.590803] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[   79.597553] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[   79.604303] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[   79.611041] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[   79.617780] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[   79.624514] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[   79.631252] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[   79.637992] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[   79.644729] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[   79.651464] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[   79.658202] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[   79.664939] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[   79.671678] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[   79.678415] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[   79.685812] pci-endpoint-test 0000:01:00.0:
[   79.685812]
[   79.685812]
[   79.685812]
[   79.694542] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[   79.701018] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[   79.707504] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[   79.714066] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[   79.720629] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[   79.727189] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[   79.733753] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[   79.740319] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[   79.746885] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[   79.753461] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[   79.760026] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[   79.766590] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[   79.773154] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[   79.779717] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[   79.786369] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[   79.793017] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[   79.799667] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[   79.806318] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[   79.812985] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[   79.819643] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[   79.826296] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[   79.832942] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[   79.839670] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[   79.846336] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[   79.852996] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[   79.859644] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[   79.866297] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[   79.872946] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[   79.879602] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[   79.886253] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[   79.892902] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[   79.899550] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[   79.906199] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[   79.912850] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[   79.919502] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[   79.926150] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[   79.932801] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[   79.939455] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[   79.946107] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[   79.952755] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[   79.959406] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[   79.966060] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[   79.972723] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[   79.979379] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[   79.986028] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[   79.992675] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[   79.999328] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[   80.005976] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[   80.012627] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[   80.019277] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[   80.025928] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[   80.032577] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[   80.039236] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[   80.045885] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[   80.052535] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[   80.059185] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[   80.065837] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[   80.072487] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[   80.079136] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[   80.085786] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[   80.092451] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[   80.099110] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[   80.105764] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[   80.112413] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[   80.119068] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[   80.125718] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[   80.132368] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[   80.139021] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[   80.145670] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[   80.152319] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[   80.158968] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[   80.165616] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[   80.172265] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[   80.178915] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[   80.185564] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[   80.192212] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[   80.198862] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[   80.205512] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[   80.212179] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[   80.218839] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[   80.225493] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[   80.232144] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[   80.238801] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[   80.245463] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[   80.252113] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[   80.258759] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[   80.265411] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[   80.272060] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[   80.278710] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[   80.285359] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[   80.292010] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[   80.298659] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[   80.305308] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[   80.311958] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[   80.318606] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[   80.325257] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[   80.331919] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[   80.338586] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[   80.345241] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[   80.351890] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[   80.358541] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[   80.365189] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[   80.371838] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[   80.378489] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[   80.385138] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[   80.391788] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[   80.398439] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[   80.405087] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[   80.411737] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[   80.418388] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[   80.425039] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[   80.431688] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[   80.438346] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[   80.444997] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[   80.451661] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[   80.458321] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[   80.464972] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[   80.471620] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[   80.478267] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[   80.484918] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[   80.491567] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[   80.498215] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[   80.504863] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[   80.511510] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[   80.518160] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[   80.524807] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[   80.531550] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[   80.538291] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[   80.545028] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[   80.551765] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[   80.558503] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[   80.565243] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[   80.571995] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[   80.578742] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[   80.585493] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[   80.592230] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[   80.598968] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[   80.605704] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[   80.612441] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[   80.619177] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[   80.625912] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[   80.632648] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[   80.639394] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[   80.646129] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[   80.652864] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[   80.659599] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[   80.666336] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[   80.673070] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[   80.679806] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[   80.686544] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[   80.693297] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[   80.700044] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[   80.706783] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[   80.713519] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[   80.720255] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[   80.726994] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[   80.733728] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[   80.740468] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[   80.747206] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[   80.753941] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[   80.760677] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[   80.767415] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[   80.774151] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[   80.780883] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[   80.787624] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[   80.794358] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[   80.801103] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[   80.807851] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[   80.814600] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[   80.821339] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[   80.828079] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[   80.834870] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[   80.841635] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[   80.848386] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[   80.855127] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[   80.861864] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[   80.868603] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[   80.875337] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[   80.882075] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[   80.888810] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[   80.895549] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[   80.902290] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[   80.909029] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[   80.915765] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[   80.922501] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[   80.929238] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[   80.935974] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[   80.942716] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[   80.949466] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[   80.956203] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[   80.962953] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[   80.969694] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[   80.976431] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[   80.983166] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[   80.989903] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[   80.996638] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[   81.003373] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[   81.010107] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[   81.016846] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[   81.023582] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[   81.030318] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[   81.037054] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[   81.043799] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[   81.050534] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[   81.057270] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[   81.064003] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[   81.070744] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[   81.077483] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[   81.084239] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[   81.090985] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[   81.097722] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[   81.104459] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[   81.111195] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[   81.117930] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[   81.124667] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[   81.131403] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[   81.138138] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[   81.144878] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[   81.151616] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[   81.158352] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[   81.165087] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[   81.171824] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[   81.178560] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[   81.185293] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[   81.192033] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[   81.198770] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[   81.205522] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[   81.212272] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[   81.219015] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[   81.226317] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[   81.233133] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[   81.239882] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[   81.246644] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[   81.253382] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[   81.260121] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[   81.266856] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[   81.273593] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[   81.280331] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[   81.287070] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[   81.293805] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[   81.300545] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[   81.307280] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[   81.314016] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[   81.320750] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[   81.327488] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[   81.334221] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[   81.340965] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[   81.347722] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[   81.354468] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[   81.361205] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[   81.367945] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[   81.374679] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[   81.381417] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[   81.388150] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[   81.394891] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[   81.401624] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[   81.408362] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[   81.415096] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[   81.421833] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[   81.428570] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[   81.435309] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[   81.442045] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[   81.448790] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[   81.455527] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[   81.462270] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[   81.469020] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[   81.475770] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[   81.482505] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[   81.489245] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[   81.495981] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[   81.502719] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[   81.509464] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[   81.516824] pci-endpoint-test 0000:01:00.0:
[   81.516824]
[   81.516824]
[   81.516824]
[   81.525562] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b6392000 dma handle:7e92f000 buffer CRC:910c690d BAR
CRC:910c690d tmp buffer crc: 910c690d
READ (   2176 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r -s 2176
[   85.302372] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[   85.308869] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[   85.315361] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[   85.321949] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[   85.328517] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[   85.335087] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[   85.341649] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[   85.348216] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[   85.354778] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[   85.361341] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[   85.367902] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[   85.374465] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[   85.381028] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[   85.387593] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[   85.394241] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[   85.400892] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[   85.407547] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[   85.414198] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[   85.420846] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[   85.427499] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[   85.434152] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[   85.440820] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[   85.447475] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[   85.454123] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[   85.460773] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[   85.467428] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[   85.474076] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[   85.480729] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[   85.487377] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[   85.494030] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[   85.500678] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[   85.507335] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[   85.513985] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[   85.520636] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[   85.527285] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[   85.533937] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[   85.540586] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[   85.547239] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[   85.553891] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[   85.560556] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[   85.567214] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[   85.573872] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[   85.580520] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[   85.587171] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[   85.593818] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[   85.600469] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[   85.607124] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[   85.613775] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[   85.620425] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[   85.627078] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[   85.633724] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[   85.640374] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[   85.647025] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[   85.653676] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[   85.660324] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[   85.666976] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[   85.673626] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[   85.680293] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[   85.686950] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[   85.693607] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[   85.700257] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[   85.706914] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[   85.713563] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[   85.720213] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[   85.726861] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[   85.733509] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[   85.740384] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[   85.747076] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[   85.753738] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[   85.760395] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[   85.767043] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[   85.773698] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[   85.780346] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[   85.786996] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[   85.793643] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[   85.800292] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[   85.806951] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[   85.813601] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[   85.820249] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[   85.826973] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[   85.833639] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[   85.840303] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[   85.846956] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[   85.853611] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[   85.860261] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[   85.866910] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[   85.873558] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[   85.880206] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[   85.886855] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[   85.893505] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[   85.900154] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[   85.906812] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[   85.913471] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[   85.920124] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[   85.926774] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[   85.933420] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[   85.940072] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[   85.946731] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[   85.953395] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[   85.960057] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[   85.966707] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[   85.973356] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[   85.980006] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[   85.986655] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[   85.993301] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[   85.999952] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[   86.006700] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[   86.013372] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[   86.020105] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[   86.026777] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[   86.033434] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[   86.040091] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[   86.046752] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[   86.053405] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[   86.060055] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[   86.066706] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[   86.073355] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[   86.080003] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[   86.086650] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[   86.093302] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[   86.099948] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[   86.106611] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[   86.113262] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[   86.119915] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[   86.126563] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[   86.133212] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[   86.139949] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[   86.146690] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[   86.153440] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[   86.160197] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[   86.166933] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[   86.173676] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[   86.180413] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[   86.187150] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[   86.193886] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[   86.200626] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[   86.207367] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[   86.214106] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[   86.220842] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[   86.227579] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[   86.234316] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[   86.241054] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[   86.247886] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[   86.254636] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[   86.261372] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[   86.268111] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[   86.274849] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[   86.281604] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[   86.288348] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[   86.295092] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[   86.301828] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[   86.308574] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[   86.315310] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[   86.322045] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[   86.328779] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[   86.335517] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[   86.342254] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[   86.348988] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[   86.355723] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[   86.362460] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[   86.369194] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[   86.375936] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[   86.382672] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[   86.389410] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[   86.396147] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[   86.402892] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[   86.409819] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[   86.416585] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[   86.423320] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[   86.430065] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[   86.436800] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[   86.443542] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[   86.450277] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[   86.457014] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[   86.463749] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[   86.470485] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[   86.477220] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[   86.483956] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[   86.490689] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[   86.497427] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[   86.504163] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[   86.510911] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[   86.517647] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[   86.524388] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[   86.531135] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[   86.537881] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[   86.544614] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[   86.551357] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[   86.558095] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[   86.564831] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[   86.571565] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[   86.578302] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[   86.585036] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[   86.591774] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[   86.598511] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[   86.605246] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[   86.611986] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[   86.618723] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[   86.625468] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[   86.632205] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[   86.638940] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[   86.645683] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[   86.652434] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[   86.659181] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[   86.665916] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[   86.672656] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[   86.679392] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[   86.686129] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[   86.692866] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[   86.699602] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[   86.706338] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[   86.713079] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[   86.719815] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[   86.726552] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[   86.733287] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[   86.740025] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[   86.746759] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[   86.753496] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[   86.760232] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[   86.766980] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[   86.773725] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[   86.780464] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[   86.787198] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[   86.793936] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[   86.800672] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[   86.807409] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[   86.814149] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[   86.820888] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[   86.827625] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[   86.834364] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[   86.841102] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[   86.847895] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[   86.854647] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[   86.861395] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[   86.868131] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[   86.874873] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[   86.881608] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[   86.888345] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[   86.895078] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[   86.901816] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[   86.908549] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[   86.915295] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[   86.922031] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[   86.928770] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[   86.935505] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[   86.942243] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[   86.948978] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[   86.955715] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[   86.962449] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[   86.969189] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[   86.975935] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[   86.982682] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[   86.989416] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[   86.996157] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[   87.002891] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[   87.009628] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[   87.016367] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[   87.023106] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[   87.029841] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[   87.036577] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[   87.043331] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[   87.050072] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[   87.056804] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[   87.063544] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[   87.070279] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[   87.077016] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[   87.083753] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[   87.090494] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[   87.097245] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[   87.103994] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[   87.110730] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[   87.117488] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[   87.124845] pci-endpoint-test 0000:01:00.0:
[   87.124845]
[   87.124845]
[   87.124845]
[   87.133581] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[   87.140059] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[   87.146537] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[   87.153099] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[   87.159663] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[   87.166226] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[   87.172787] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[   87.179348] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[   87.185912] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[   87.192477] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[   87.199042] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[   87.205606] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[   87.212186] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[   87.218765] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[   87.225420] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[   87.232069] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[   87.238720] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[   87.245370] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[   87.252021] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[   87.258669] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[   87.265319] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[   87.271969] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[   87.278618] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[   87.285266] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[   87.291919] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[   87.298568] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[   87.305217] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[   87.311866] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[   87.318523] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[   87.325178] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[   87.331843] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[   87.338500] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[   87.345152] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[   87.351800] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[   87.358451] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[   87.365099] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[   87.371748] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[   87.378396] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[   87.385046] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[   87.391696] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[   87.398345] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[   87.404994] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[   87.411645] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[   87.418299] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[   87.424948] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[   87.431597] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[   87.438247] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[   87.444901] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[   87.451571] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[   87.458229] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[   87.464881] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[   87.471529] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[   87.478179] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[   87.484829] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[   87.491479] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[   87.498124] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[   87.504779] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[   87.511428] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[   87.518087] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[   87.524736] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[   87.531385] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[   87.538037] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[   87.544688] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[   87.551337] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[   87.557987] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[   87.564637] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[   87.571301] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[   87.577960] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[   87.584612] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[   87.591259] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[   87.597911] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[   87.604559] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[   87.611209] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[   87.617863] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[   87.624514] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[   87.631164] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[   87.637812] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[   87.644461] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[   87.651109] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[   87.657757] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[   87.664404] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[   87.671051] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[   87.677701] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[   87.684351] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[   87.691014] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[   87.697674] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[   87.704327] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[   87.710973] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[   87.717630] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[   87.724280] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[   87.730932] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[   87.737578] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[   87.744230] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[   87.750878] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[   87.757527] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[   87.764174] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[   87.770823] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[   87.777481] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[   87.784133] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[   87.790781] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[   87.797433] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[   87.804081] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[   87.810737] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[   87.817402] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[   87.824073] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[   87.830724] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[   87.837374] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[   87.844073] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[   87.850740] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[   87.857401] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[   87.864056] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[   87.870707] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[   87.877360] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[   87.884008] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[   87.890660] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[   87.897306] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[   87.903960] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[   87.910609] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[   87.917257] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[   87.923911] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[   87.930563] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[   87.937210] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[   87.943864] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[   87.950511] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[   87.957160] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[   87.963810] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[   87.970549] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[   87.977300] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[   87.984047] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[   87.990782] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[   87.997521] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[   88.004256] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[   88.010994] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[   88.017729] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[   88.024471] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[   88.031208] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[   88.037947] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[   88.044680] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[   88.051423] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[   88.058160] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[   88.064898] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[   88.071640] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[   88.078380] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[   88.085118] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[   88.091870] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[   88.098618] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[   88.105362] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[   88.112096] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[   88.118835] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[   88.125576] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[   88.132314] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[   88.139052] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[   88.145789] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[   88.152524] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[   88.159261] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[   88.165995] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[   88.172732] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[   88.179467] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[   88.186202] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[   88.192940] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[   88.199679] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[   88.206417] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[   88.213167] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[   88.219911] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[   88.226659] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[   88.233394] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[   88.240131] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[   88.246864] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[   88.253603] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[   88.260339] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[   88.267077] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[   88.273812] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[   88.280547] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[   88.287283] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[   88.294018] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[   88.300752] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[   88.307491] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[   88.314226] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[   88.320967] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[   88.327721] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[   88.334468] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[   88.341204] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[   88.347945] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[   88.354680] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[   88.361416] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[   88.368153] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[   88.374890] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[   88.381626] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[   88.388361] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[   88.395095] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[   88.401833] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[   88.408569] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[   88.415306] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[   88.422041] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[   88.428783] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[   88.435521] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[   88.442263] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[   88.449012] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[   88.455756] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[   88.462494] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[   88.469232] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[   88.475967] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[   88.482705] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[   88.489442] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[   88.496205] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[   88.502942] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[   88.509681] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[   88.516416] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[   88.523154] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[   88.529895] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[   88.536633] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[   88.543371] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[   88.550108] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[   88.556844] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[   88.563583] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[   88.570318] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[   88.577055] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[   88.583791] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[   88.590530] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[   88.597263] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[   88.604003] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[   88.610740] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[   88.617505] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[   88.624251] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[   88.630996] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[   88.637731] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[   88.644470] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[   88.651206] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[   88.657945] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[   88.664682] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[   88.671420] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[   88.678155] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[   88.684892] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[   88.691626] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[   88.698365] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[   88.705103] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[   88.711839] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[   88.718574] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[   88.725310] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[   88.732051] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[   88.738795] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[   88.745543] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[   88.752289] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[   88.759029] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[   88.765769] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[   88.772505] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[   88.779245] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[   88.785978] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[   88.792720] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[   88.799453] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[   88.806194] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[   88.812930] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[   88.819668] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[   88.826403] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[   88.833207] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[   88.839961] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[   88.846710] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[   88.853463] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[   88.860202] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[   88.866939] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[   88.873675] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[   88.880410] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[   88.887145] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[   88.893879] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[   88.900619] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[   88.907353] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[   88.914091] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[   88.920825] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[   88.927562] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[   88.934303] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[   88.941043] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[   88.947781] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[   88.955146] pci-endpoint-test 0000:01:00.0:
[   88.955146]
[   88.955146]
[   88.955146]
[   88.963900] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b6393000 dma handle:7e93c800 buffer CRC:ce535039 BAR
CRC:910c690d tmp buffer crc: ce535039
READ (   2176 bytes):           NOT OKAY

And starangely even tmp_buffer has the value of 0xDF, but the CRC is screwed.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
> > Cheers,
> > --Prabhakar
