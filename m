Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF38A19A6BD
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgDAIAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 04:00:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37920 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbgDAIAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 04:00:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so21457516oic.5
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lq3AlFGjGPxkA6xhEsL71aUG5A59I4n8CzSwT7t4q2Y=;
        b=JGAHbMpXpGefq4MX6Twbk3nG0XHw7rpQIE/SOLtHLc9FEeIN3BeZkWcdQgjM+q3Aby
         XscM5AsSX1/JXeN6uWQVWoeXtWCIz0zt7wi1WkUdJm7UnAzWmJYZb/2VxGfGQBqKQNAq
         xXW4EKEKPlvs0F8f2DirBgHWTPF63wfS6BuFIFgqw3zYNM+q8DEhfZUGF9Hv7KZDfiWe
         QhdoKQckhNWHDUwZZjSJVvJMlVN2YVFlSPzyxO4RhY6AEazAOkAOh0znQ5RclkF4XDbg
         XZok55XdzRsu44hxWK5OeADejk9WeIKl337c3L9gm/D8xUr/fd4We9A6ScZOalaLEhoy
         emhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lq3AlFGjGPxkA6xhEsL71aUG5A59I4n8CzSwT7t4q2Y=;
        b=pGASitme2zAKyGBm4R+4LAQY0Rm4p9SsuksZm9v/x8V0x6YhgXXmHTdswLGXnebA/T
         9/dj2a5OQUT0FXW1d6l7wMQZsNLgdJkZMfD0Lk+/evljdonNGNUvwGybfOcUslSb8/N2
         nqPshuQzH6W8V1LbXBa9X0FyrU7dPAffb3vgkBeWYb5dVdBjOquXzr1Ykvm42dtxDeo8
         3S9kXksvsOPD/3l1mMZXaWS5XKxndHMU6W8Cxg6aQeXHE05+imCx1UhZDde33pODUjzU
         n+xH6BCldvuTBgSmLOtHpTNzL55QIrRUtcsGrjy+526clcJ2s1OXqA+5epUljTDpKegZ
         sl5Q==
X-Gm-Message-State: AGi0PuZhBGXYIDhOgKVrESQolmqm4fG+2+zkZi+Qmic8Jf6BLziqyHjs
        XFTqItNM1PpKBQIQ3PQYQ5pALfcZco5PHcUzT7g=
X-Google-Smtp-Source: APiQypIqUOmG2SXd8kIzghMkfImA+M0cHy9leFZYRF/54+gMXst5gxWAnbYRryMgVL0BlsQRs5N6hgpd8WNjKl4oCQg=
X-Received: by 2002:aca:5444:: with SMTP id i65mr1815462oib.101.1585728030160;
 Wed, 01 Apr 2020 01:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com> <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com> <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com> <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 1 Apr 2020 09:00:03 +0100
Message-ID: <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com>
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

Hi Shimoda-san,

On Wed, Apr 1, 2020 at 2:25 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Prabhakar-san,
>
> > From: Lad, Prabhakar, Sent: Wednesday, April 1, 2020 2:26 AM
> <snip>
> > > > > Did you try to probe the failure further by comparing the hexdumps? Where does
> > > > > the mismatch happen?
> > > > >
> > > > I shall dump the memory and check the values, but basically crc is failing.
> > >
> > > I'm also interesting about comparing the hexdump between host and ep.
> > > This is my gut feeling though, I'm guessing this is a timing issue
> > > because using coherent memory API will be on non-cache even if CPU access,
> > > but using steaming DMA API will be on cache if CPU access by
> > > dma_unmap_single(DMA_FROM_DEVICE) and get_random_bytes() in pci_endpoint_test_write().
> > >
> > > If my guess is correct, almost all hexdumps are the same, but last
> > > some bytes (I'm not sure how much bytes though) are not match.
> > >
> > So I did some experiments only focusing on read operation for now
> >
> > 1:  I tried printing the crc value in pci_epf_test_write() function
> > with below code snippet:
> >
> > @@ -472,6 +474,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >          */
> >         usleep_range(1000, 2000);
> >
> > +       dev_err(dev, "%s %llx %llx csum: %x = %x\n", __func__, reg->dst_addr,
> > +               phys_addr, reg->checksum, crc32_le(~0, dst_addr, reg->size));
> > +
> >  err_dma_map:
> >         kfree(buf);
> >
> > But with this I get :
>
> I don't know why this happen for now.
>
> <snip>
> > 2: Instead of get_random_bytes() in pci_epf_test_write() I used
> > memset() with the fixed value
> <snip>
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -431,6 +431,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >         }
> >
> >         get_random_bytes(buf, reg->size);
> > +       memset(buf, 0xDF, reg->size);
> >         reg->checksum = crc32_le(~0, buf, reg->size);
> >
> > And later for the dst buffer I did memset for dst_buffer
> >
> > @@ -472,6 +474,10 @@ static int pci_epf_test_write(struct pci_epf_test
> > *epf_test)
> >          */
> >         usleep_range(1000, 2000);
> >
> > +       memset(dst_addr, 0xDF, reg->size);
>
> I think this memset is not needed because this function calls memcpy_toio(dst_addr, buf,..).
>
> > +       dev_err(dev, "%s %llx %llx csum: %x\n", __func__, reg->dst_addr,
> > +               phys_addr, reg->checksum);
> > +
> >  err_dma_map:
> >         kfree(buf);
> >
> > But with this I get similar issue as above:
>
> I don't know why like the case 1 for now...
>
> <snip>
> >
> > 3: After making sure -s was aligned to 128 bytes memset and crc32_le
> > in pci_epf_test_write() didnt hit above issues,
> >  and now when I compared the crc value of both the buffers this
> > matched on endpoint!
>
> OK.
>
> > 4: Now focusing more in rootdevice, I added memset(buf, 0xDF,
> > reg->size); in pci_epf_test_write() function
> > and was dumping the contents of buffer in pci_endpoint_test_read()
> > with below function:
> >
> > static void print_buffer(struct device *dev, void *buff_addr, size_t size)
> > {
> >     size_t i;
> >     u64 *addr = buff_addr;
> >
> >     for(i = 0; i < size; i += sizeof(addr))
> >         dev_err(dev, "buf[%zu] : %llx\n", i, *addr);
> >
> >     dev_err(dev, "\n\n\n\n");
> > }
> >
> > Below is the dump from pci_endpoint_test_read() of one passing case
> > and other no-passing case:
> > The contents of buffer match as expected, but the crc32_le is
> > differrent and I am clue-less why is this
> > being caused when using non-coherent memory.
> >
> > root@hihope-rzg2m:~# pcitest -r -s 2176
> <snip>
> > [  528.556991] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > ffff0004b61f9000 7e951000 910c690d=910c690d
>
> I'd like to know how to print these crc values. Your report on the case 1
> mentioned on pci-epf-test.c like below though.
>
> > +       dev_err(dev, "%s %llx %llx csum: %x = %x\n", __func__, reg->dst_addr,
> > +               phys_addr, reg->checksum, crc32_le(~0, dst_addr, reg->size));
>
> Also, as I mentioned on previous email, this is possible to cause timing issue.
> So, I'd like to where you added the hexdump on pci_endpoint_test.c.
> Perhaps, copy and pasting your whole debug diff is useful to understand about it.
>

Following is the complete diff:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3c49514b4813..e7bf58a1fee8 100644
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
@@ -608,7 +625,7 @@ static bool pci_endpoint_test_read(struct
pci_endpoint_test *test,
     }

     orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-                    DMA_FROM_DEVICE);
+                    DMA_BIDIRECTIONAL);
     if (dma_mapping_error(dev, orig_phys_addr)) {
         dev_err(dev, "failed to map source buffer address\n");
         ret = false;
@@ -640,12 +657,17 @@ static bool pci_endpoint_test_read(struct
pci_endpoint_test *test,
     wait_for_completion(&test->irq_raised);

     dma_unmap_single(dev, orig_phys_addr, size + alignment,
-             DMA_FROM_DEVICE);
+             DMA_BIDIRECTIONAL);

     crc32 = crc32_le(~0, addr, size);
     if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
         ret = true;

+    print_buffer(dev, addr, size);
+    dev_err(dev, "%s %px %llx %x=%x\n", __func__, orig_addr,
+        orig_phys_addr, crc32,
+        pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM));
+
 err_phys_addr:
     kfree(orig_addr);
 err:

Note: I have added DMA_BIDIRECTIONAL that is because I am also
printing the buffer on ep
and calulating the crc

> > READ (   2176 bytes):           OKAY
> > root@hihope-rzg2m:~# pcitest -r -s 2176
> <snip>
> > [  533.457921] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > ffff0004b61f9000 7e959800  ce535039=910c690d
> > READ (   2176 bytes):           NOT OKAY
> >
> > Note: for failure case the crc is always ce535039
>
> The value of ce535039 is from pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM)?
> If so, it's strange because all 0xdf values with 2176 bytes should be 910c690d by crc32_le().
>
The value ce535039 is the one which is calculated from the buffer and
value 910c690d is the one
which is passed from the BAR memory which is correct.

Cheers,
--Prabhakar
