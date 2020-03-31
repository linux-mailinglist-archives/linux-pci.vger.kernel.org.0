Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA4199CCF
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgCaR0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 13:26:25 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41767 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaR0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 13:26:25 -0400
Received: by mail-oi1-f175.google.com with SMTP id k9so19614989oia.8
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2020 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzGg1kVOlB5ow1mXELvHrAEPsqNs/nnlpOpM6c5N6KI=;
        b=DL2U+PvjDv70Ux5WV1TMdlp/HEtSyb9MB1D7L2MuGOMKbkTWFKRej8oHLM3xr5lSPO
         9/+l17wfPCCSW7VD0rEsLwgSgOLd33vG/WLAasafW4kbEN9Q1iSJrUhB28y1gWsnak4p
         amEdifcAXGdq02gnhs/MgrTXLdnmFc3kg/yu5MCP2LxoWURsIxmxxYQbnBEz2r6ROUCk
         VBpeCqM4m2NFZwNTiYMbd0wxOvofV6W+8kdymTIn/cEycuFkuT4FKiJAao9xvmNiD1ml
         JEngztUZ08nrA8+W1G9DtLEe1wPRpiYEQn6amd6RTYDVL/pBVxmKSdlYr6ZholdZZsx7
         oieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzGg1kVOlB5ow1mXELvHrAEPsqNs/nnlpOpM6c5N6KI=;
        b=HtLQdCvoO1wt7tgiXfh5PwLjEi7z712rBNUa0Wb+fdZzbZ6MJkbKTCYH2DG1VykiUn
         euxmPSgqHL45Dn+5g4nWotGcgGpIMJKkw3rwSQfAAwC+NVcSmi2dJ4UT5Y3MBpAnr/Da
         gXJrpAbSDBslfv/A2+tXTRtmttB4+FfPiB/eipag8Wkeh3xo4l1/CUCsAKOhhAxv7k37
         LoaQjCeKyOOvLe8igNWU24rX06ckPT5mvVvgsBglWh5MYBz5KMXQnQ4nWN2mnFo9aC2p
         9Mfcn5IMzRMg7NCFwZOPmNeQAXFwbO/0L650rzRfBmDPqvtCPyOFJMYBBDLo1QwtOc9V
         gnRw==
X-Gm-Message-State: ANhLgQ1kRK+LfvcJGEAm3qavuOnpTMmqMUEkXIoljnGDtdkQelhx8jz8
        lB7WLNkmN0DAWJLGS/erIyJzTqSvF3uZSomid6WM+5xn4vRfMA==
X-Google-Smtp-Source: ADFU+vs0M0XuUXEo2UOVmjn2kQnDo2OfuTO6vKmmeRKFsZZMh8k9PNPZgJ+65KSlwBJbiA0ulYGxIISO9SixvXL+KgY=
X-Received: by 2002:aca:cf0d:: with SMTP id f13mr2745518oig.162.1585675582210;
 Tue, 31 Mar 2020 10:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com> <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com> <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 31 Mar 2020 18:25:55 +0100
Message-ID: <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
Subject: Re: PCIe EPF
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Tue, Mar 31, 2020 at 8:10 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Prabhakar-san,
>
> > From: Lad, Prabhakar, Sent: Monday, March 30, 2020 10:47 PM
> <snip>
> > > > Agreed. But we don't flush in SW when -d option is not specified I am
> > > > assuming  when we us
> > > > -d dma engine takes care of flushing it.
> > >
> > > The -d option switch doesn't change anything on the SW that runs on the host
> > > side (misc/pci-endpoint-test.c). That only tells the EP to use DMA.
> > >
> > > When you use streaming APIs, dma_map_single(), dmap_unmap_single() takes care
> > > of flushing or invalidating memory based on the platform. (Platforms which have
> > > coherent memory will have dma-coherent property,
> > > dma_map_single()/dmap_unmap_single() will not do flush or invalidate.
> > >
> > My bad, I thought dma_sync*() calls did it.
> >
> > Shimoda-san do you see any platform restrictions while using streaming DMA api
> > instead of coherent memory. Note I tried this enabling/disabling ipmmu
> > too but the
> > results are the same.
>
> (Un)fortunately, I have never replaced coherent memory API with stream DMA API.
>
> > > Did you try to probe the failure further by comparing the hexdumps? Where does
> > > the mismatch happen?
> > >
> > I shall dump the memory and check the values, but basically crc is failing.
>
> I'm also interesting about comparing the hexdump between host and ep.
> This is my gut feeling though, I'm guessing this is a timing issue
> because using coherent memory API will be on non-cache even if CPU access,
> but using steaming DMA API will be on cache if CPU access by
> dma_unmap_single(DMA_FROM_DEVICE) and get_random_bytes() in pci_endpoint_test_write().
>
> If my guess is correct, almost all hexdumps are the same, but last
> some bytes (I'm not sure how much bytes though) are not match.
>
So I did some experiments only focusing on read operation for now

1:  I tried printing the crc value in pci_epf_test_write() function
with below code snippet:

@@ -472,6 +474,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
         */
        usleep_range(1000, 2000);

+       dev_err(dev, "%s %llx %llx csum: %x = %x\n", __func__, reg->dst_addr,
+               phys_addr, reg->checksum, crc32_le(~0, dst_addr, reg->size));
+
 err_dma_map:
        kfree(buf);

But with this I get :

[  873.081520] WRITE => Size: 17 bytes   DMA: NO         Time:
0.000002333 seconds      Rate: 7115 KB/s
[  873.092461] Unable to handle kernel paging request at virtual
address ffff800014400001
[  873.100481] Mem abort info:
[  873.103441]   ESR = 0x96000021
[  873.106598]   EC = 0x25: DABT (current EL), IL = 32 bits
[  873.112064]   SET = 0, FnV = 0
[  873.115207]   EA = 0, S1PTW = 0
[  873.118500] Data abort info:
[  873.121473]   ISV = 0, ISS = 0x00000021
[  873.125444]   CM = 0, WnR = 0
[  873.128437] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000048e3e000
[  873.135272] [ffff800014400001] pgd=00000000b9fff003,
pud=00000000b9ffe003, pmd=00000000b2ddc003, pte=00680000fe100707
[  873.146710] Internal error: Oops: 96000021 [#1] PREEMPT SMP
[  873.152326] CPU: 0 PID: 393 Comm: kworker/0:1H Not tainted
5.6.0-rc1-arm64-renesas-g842da098c217-dirty #215
[  873.162085] Hardware name: Silicon Linux RZ/G2E evaluation kit
EK874 (CAT874 + CAT875) (DT)
[  873.170478] Workqueue: kpcitest pci_epf_test_cmd_handler
[  873.175804] pstate: 20000005 (nzCv daif -PAN -UAO)
[  873.180614] pc : crc32_le+0x28/0xe0
[  873.184109] lr : pci_epf_test_cmd_handler+0x4ec/0xb50
[  873.189169] sp : ffff800011cf3cb0
[  873.192488] x29: ffff800011cf3cb0 x28: ffff800011bff000
[  873.197812] x27: 0000000000000000 x26: ffff800014400000
[  873.203136] x25: ffff0000762e0ac8 x24: ffff000072f87000
[  873.208459] x23: ffff000072ce6480 x22: ffff0000764ee000
[  873.213783] x21: ffff800011bff000 x20: ffff0000762e0a80
[  873.219107] x19: ffff800010f0f000 x18: ffffffffffffffff
[  873.224431] x17: 00000000e1b480cf x16: 000000004efa1cf1
[  873.229755] x15: ffff800010f0f908 x14: ffff800091cf39a7
[  873.235078] x13: ffff800011cf39b5 x12: 0000000000000001
[  873.240401] x11: 0000000000000002 x10: 0000000000000050
[  873.245725] x9 : ffff000079bd4fd8 x8 : ffff800014400001
[  873.251048] x7 : 0000000000000011 x6 : 0000000000000000
[  873.256371] x5 : 0000000000000001 x4 : dfdfdfdfdfdfdfdf
[  873.261694] x3 : dfdfdfdfdfdfdfdf x2 : 0000000000000000
[  873.267018] x1 : ffff800014400011 x0 : 00000000ffffffff
[  873.272342] Call trace:
[  873.274795]  crc32_le+0x28/0xe0
[  873.277950]  process_one_work+0x298/0x710
[  873.281968]  worker_thread+0x40/0x468
[  873.285639]  kthread+0x11c/0x120
[  873.288877]  ret_from_fork+0x10/0x18
[  873.292464] Code: 92400ce8 a9401023 8b010108 8b070021 (a9401905)
[  873.298575] ---[ end trace 64f8c9b1e3bdfa49 ]---

2: Instead of get_random_bytes() in pci_epf_test_write() I used
memset() with the fixed value

+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -431,6 +431,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
        }

        get_random_bytes(buf, reg->size);
+       memset(buf, 0xDF, reg->size);
        reg->checksum = crc32_le(~0, buf, reg->size);

And later for the dst buffer I did memset for dst_buffer

@@ -472,6 +474,10 @@ static int pci_epf_test_write(struct pci_epf_test
*epf_test)
         */
        usleep_range(1000, 2000);

+       memset(dst_addr, 0xDF, reg->size);
+       dev_err(dev, "%s %llx %llx csum: %x\n", __func__, reg->dst_addr,
+               phys_addr, reg->checksum);
+
 err_dma_map:
        kfree(buf);

But with this I get similar issue as above:

[  102.576482] WRITE => Size: 151551 bytes       DMA: NO         Time:
0.002141125 seconds      Rate: 69122 KB/s
[  102.590369] Unable to handle kernel paging request at virtual
address ffff800012424fef
[  102.598717] Mem abort info:
[  102.601873]   ESR = 0x96000061
[  102.605094]   EC = 0x25: DABT (current EL), IL = 32 bits
[  102.610492]   SET = 0, FnV = 0
[  102.613645]   EA = 0, S1PTW = 0
[  102.616855] Data abort info:
[  102.619834]   ISV = 0, ISS = 0x00000061
[  102.623742]   CM = 0, WnR = 1
[  102.626733] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000048e2e000
[  102.633528] [ffff800012424fef] pgd=00000000b9fff003,
pud=00000000b9ffe003, pmd=00000000b2d16003, pte=00680000fe124707
[  102.644870] Internal error: Oops: 96000061 [#1] PREEMPT SMP
[  102.650485] CPU: 0 PID: 392 Comm: kworker/0:1H Not tainted
5.6.0-rc1-arm64-renesas-g842da098c217-dirty #216
[  102.660245] Hardware name: Silicon Linux RZ/G2E evaluation kit
EK874 (CAT874 + CAT875) (DT)
[  102.668639] Workqueue: kpcitest pci_epf_test_cmd_handler
[  102.673967] pstate: 00000005 (nzcv daif -PAN -UAO)
[  102.678776] pc : __memset+0x90/0x188
[  102.682359] lr : pci_epf_test_cmd_handler+0x4e4/0xb40
[  102.687419] sp : ffff8000122f3cb0
[  102.690738] x29: ffff8000122f3cb0 x28: ffff000074b44ac8
[  102.696062] x27: 0000000000000000 x26: ffff800012400000
[  102.701386] x25: ffff800011bed000 x24: ffff000072fc3800
[  102.706709] x23: ffff000071300000 x22: ffff0000764f3000
[  102.712033] x21: ffff800011bed000 x20: ffff000074b44a80
[  102.717356] x19: ffff800010eff000 x18: 0000000000000000
[  102.722680] x17: 606069623b383631 x16: 0000000000000001
[  102.728003] x15: 0000000000000036 x14: 000000177c58c470
[  102.733326] x13: 0000000000000284 x12: 0000000000000001
[  102.738650] x11: 0000000000000002 x10: 0000000000000050
[  102.743973] x9 : ffff000079bd4fd8 x8 : ffff800012424fff
[  102.749297] x7 : dfdfdfdfdfdfdfdf x6 : 0000000000000000
[  102.754620] x5 : 0000000000000001 x4 : 0000000000000000
[  102.759943] x3 : 0000000000000030 x2 : 000000000000000f
[  102.765267] x1 : 00000000000000df x0 : ffff800012400000
[  102.770592] Call trace:
[  102.773043]  __memset+0x90/0x188
[  102.776285]  process_one_work+0x298/0x710
[  102.780303]  worker_thread+0x40/0x468
[  102.783976]  kthread+0x11c/0x120
[  102.787214]  ret_from_fork+0x10/0x18
[  102.790800] Code: a8811d07 f2400c42 b4000062 8b020108 (a93f1d07)
[  102.796912] ---[ end trace d3b2b57e50f065f8 ]--

Note: Also changing DMA_FROM_DEVICE to  DMA_BIDIRECTIONAL in
pci_endpoint_test_read() resulted same behaviour for both 1 & 2.

3: After making sure -s was aligned to 128 bytes memset and crc32_le
in pci_epf_test_write() didnt hit above issues,
 and now when I compared the crc value of both the buffers this
matched on endpoint!

4: Now focusing more in rootdevice, I added memset(buf, 0xDF,
reg->size); in pci_epf_test_write() function
and was dumping the contents of buffer in pci_endpoint_test_read()
with below function:

static void print_buffer(struct device *dev, void *buff_addr, size_t size)
{
    size_t i;
    u64 *addr = buff_addr;

    for(i = 0; i < size; i += sizeof(addr))
        dev_err(dev, "buf[%zu] : %llx\n", i, *addr);

    dev_err(dev, "\n\n\n\n");
}

Below is the dump from pci_endpoint_test_read() of one passing case
and other no-passing case:
The contents of buffer match as expected, but the crc32_le is
differrent and I am clue-less why is this
being caused when using non-coherent memory.

root@hihope-rzg2m:~# pcitest -r -s 2176
[  526.726444] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[  526.732942] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[  526.739434] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[  526.746021] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[  526.752587] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[  526.759157] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[  526.765728] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[  526.772307] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[  526.778872] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[  526.785438] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[  526.792001] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[  526.798569] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[  526.805132] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[  526.811697] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[  526.818372] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[  526.825028] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[  526.831687] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[  526.838342] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[  526.844989] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[  526.851645] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[  526.858298] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[  526.864967] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[  526.871623] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[  526.878277] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[  526.884923] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[  526.891576] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[  526.898225] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[  526.904876] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[  526.911525] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[  526.918178] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[  526.924825] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[  526.931489] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[  526.938140] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[  526.944789] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[  526.951439] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[  526.958089] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[  526.964737] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[  526.971390] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[  526.978043] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[  526.984712] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[  526.991371] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[  526.998030] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[  527.004678] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[  527.011330] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[  527.017979] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[  527.024633] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[  527.031291] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[  527.037945] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[  527.044594] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[  527.051246] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[  527.057895] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[  527.064546] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[  527.071194] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[  527.077926] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[  527.084598] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[  527.091262] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[  527.097914] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[  527.104566] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[  527.111214] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[  527.117864] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[  527.124511] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[  527.131177] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[  527.137827] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[  527.144478] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[  527.151127] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[  527.157776] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[  527.164425] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[  527.171076] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[  527.177723] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[  527.184379] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[  527.191028] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[  527.197683] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[  527.204347] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[  527.211007] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[  527.217656] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[  527.224306] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[  527.230964] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[  527.237616] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[  527.244265] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[  527.250916] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[  527.257563] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[  527.264214] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[  527.270864] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[  527.277515] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[  527.284162] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[  527.290819] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[  527.297468] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[  527.304121] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[  527.310770] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[  527.317426] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[  527.324090] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[  527.330788] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[  527.337443] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[  527.344096] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[  527.350745] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[  527.357407] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[  527.364058] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[  527.370707] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[  527.377353] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[  527.384008] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[  527.390669] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[  527.397321] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[  527.403969] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[  527.410621] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[  527.417270] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[  527.423921] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[  527.430579] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[  527.437236] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[  527.443902] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[  527.450562] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[  527.457210] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[  527.463862] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[  527.470510] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[  527.477160] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[  527.483810] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[  527.490462] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[  527.497111] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[  527.503762] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[  527.510410] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[  527.517059] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[  527.523705] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[  527.530369] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[  527.537018] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[  527.543672] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[  527.550322] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[  527.556980] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[  527.563729] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[  527.570476] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[  527.577212] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[  527.583954] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[  527.590691] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[  527.597427] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[  527.604163] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[  527.610900] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[  527.617636] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[  527.624372] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[  527.631119] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[  527.637858] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[  527.644594] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[  527.651331] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[  527.658067] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[  527.664803] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[  527.671537] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[  527.678279] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[  527.685031] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[  527.691778] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[  527.698515] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[  527.705249] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[  527.711984] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[  527.718721] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[  527.725457] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[  527.732205] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[  527.738941] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[  527.745679] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[  527.752414] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[  527.759150] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[  527.765886] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[  527.772625] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[  527.779359] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[  527.786100] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[  527.792841] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[  527.799598] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[  527.806342] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[  527.813095] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[  527.819833] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[  527.826566] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[  527.833316] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[  527.840052] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[  527.846791] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[  527.853527] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[  527.860261] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[  527.866996] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[  527.873733] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[  527.880466] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[  527.887206] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[  527.893942] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[  527.900679] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[  527.907415] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[  527.914156] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[  527.920906] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[  527.927653] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[  527.934398] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[  527.941138] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[  527.947873] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[  527.954611] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[  527.961346] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[  527.968081] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[  527.974817] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[  527.981555] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[  527.988290] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[  527.995027] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[  528.001762] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[  528.008497] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[  528.015232] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[  528.021969] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[  528.028711] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[  528.035470] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[  528.042219] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[  528.048957] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[  528.055693] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[  528.062432] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[  528.069167] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[  528.075904] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[  528.082638] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[  528.089375] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[  528.096131] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[  528.102872] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[  528.109608] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[  528.116345] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[  528.123080] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[  528.129815] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[  528.136560] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[  528.143299] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[  528.150037] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[  528.156788] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[  528.163534] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[  528.170275] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[  528.177008] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[  528.183749] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[  528.190485] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[  528.197222] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[  528.203955] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[  528.210692] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[  528.217427] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[  528.224163] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[  528.230896] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[  528.237646] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[  528.244382] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[  528.251119] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[  528.257856] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[  528.264597] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[  528.271344] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[  528.278089] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[  528.284825] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[  528.291567] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[  528.298303] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[  528.305037] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[  528.311771] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[  528.318508] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[  528.325240] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[  528.331979] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[  528.338721] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[  528.345459] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[  528.352194] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[  528.358933] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[  528.365666] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[  528.372404] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[  528.379137] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[  528.385880] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[  528.392632] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[  528.399379] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[  528.406116] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[  528.412853] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[  528.419588] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[  528.426326] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[  528.433060] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[  528.439811] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[  528.446548] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[  528.453285] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[  528.460020] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[  528.466756] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[  528.473492] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[  528.480229] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[  528.486963] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[  528.493702] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[  528.500439] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[  528.507191] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[  528.513936] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[  528.520679] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[  528.527412] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[  528.534152] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[  528.540893] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[  528.548254] pci-endpoint-test 0000:01:00.0:
[  528.548254]
[  528.548254]
[  528.548254]
[  528.556991] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
ffff0004b61f9000 7e951000 910c690d=910c690d
READ (   2176 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r -s 2176
[  531.627350] pci-endpoint-test 0000:01:00.0: buf[0] : dfdfdfdfdfdfdfdf
[  531.633879] pci-endpoint-test 0000:01:00.0: buf[8] : dfdfdfdfdfdfdfdf
[  531.640377] pci-endpoint-test 0000:01:00.0: buf[16] : dfdfdfdfdfdfdfdf
[  531.646965] pci-endpoint-test 0000:01:00.0: buf[24] : dfdfdfdfdfdfdfdf
[  531.653531] pci-endpoint-test 0000:01:00.0: buf[32] : dfdfdfdfdfdfdfdf
[  531.660102] pci-endpoint-test 0000:01:00.0: buf[40] : dfdfdfdfdfdfdfdf
[  531.666666] pci-endpoint-test 0000:01:00.0: buf[48] : dfdfdfdfdfdfdfdf
[  531.673230] pci-endpoint-test 0000:01:00.0: buf[56] : dfdfdfdfdfdfdfdf
[  531.679792] pci-endpoint-test 0000:01:00.0: buf[64] : dfdfdfdfdfdfdfdf
[  531.686360] pci-endpoint-test 0000:01:00.0: buf[72] : dfdfdfdfdfdfdfdf
[  531.692924] pci-endpoint-test 0000:01:00.0: buf[80] : dfdfdfdfdfdfdfdf
[  531.699492] pci-endpoint-test 0000:01:00.0: buf[88] : dfdfdfdfdfdfdfdf
[  531.706054] pci-endpoint-test 0000:01:00.0: buf[96] : dfdfdfdfdfdfdfdf
[  531.712618] pci-endpoint-test 0000:01:00.0: buf[104] : dfdfdfdfdfdfdfdf
[  531.719266] pci-endpoint-test 0000:01:00.0: buf[112] : dfdfdfdfdfdfdfdf
[  531.725917] pci-endpoint-test 0000:01:00.0: buf[120] : dfdfdfdfdfdfdfdf
[  531.732565] pci-endpoint-test 0000:01:00.0: buf[128] : dfdfdfdfdfdfdfdf
[  531.739230] pci-endpoint-test 0000:01:00.0: buf[136] : dfdfdfdfdfdfdfdf
[  531.745881] pci-endpoint-test 0000:01:00.0: buf[144] : dfdfdfdfdfdfdfdf
[  531.752536] pci-endpoint-test 0000:01:00.0: buf[152] : dfdfdfdfdfdfdfdf
[  531.759200] pci-endpoint-test 0000:01:00.0: buf[160] : dfdfdfdfdfdfdfdf
[  531.765857] pci-endpoint-test 0000:01:00.0: buf[168] : dfdfdfdfdfdfdfdf
[  531.772508] pci-endpoint-test 0000:01:00.0: buf[176] : dfdfdfdfdfdfdfdf
[  531.779160] pci-endpoint-test 0000:01:00.0: buf[184] : dfdfdfdfdfdfdfdf
[  531.785807] pci-endpoint-test 0000:01:00.0: buf[192] : dfdfdfdfdfdfdfdf
[  531.792460] pci-endpoint-test 0000:01:00.0: buf[200] : dfdfdfdfdfdfdfdf
[  531.799108] pci-endpoint-test 0000:01:00.0: buf[208] : dfdfdfdfdfdfdfdf
[  531.805759] pci-endpoint-test 0000:01:00.0: buf[216] : dfdfdfdfdfdfdfdf
[  531.812406] pci-endpoint-test 0000:01:00.0: buf[224] : dfdfdfdfdfdfdfdf
[  531.819058] pci-endpoint-test 0000:01:00.0: buf[232] : dfdfdfdfdfdfdfdf
[  531.825708] pci-endpoint-test 0000:01:00.0: buf[240] : dfdfdfdfdfdfdfdf
[  531.832359] pci-endpoint-test 0000:01:00.0: buf[248] : dfdfdfdfdfdfdfdf
[  531.839016] pci-endpoint-test 0000:01:00.0: buf[256] : dfdfdfdfdfdfdfdf
[  531.845671] pci-endpoint-test 0000:01:00.0: buf[264] : dfdfdfdfdfdfdfdf
[  531.852320] pci-endpoint-test 0000:01:00.0: buf[272] : dfdfdfdfdfdfdfdf
[  531.858972] pci-endpoint-test 0000:01:00.0: buf[280] : dfdfdfdfdfdfdfdf
[  531.865621] pci-endpoint-test 0000:01:00.0: buf[288] : dfdfdfdfdfdfdfdf
[  531.872275] pci-endpoint-test 0000:01:00.0: buf[296] : dfdfdfdfdfdfdfdf
[  531.878936] pci-endpoint-test 0000:01:00.0: buf[304] : dfdfdfdfdfdfdfdf
[  531.885597] pci-endpoint-test 0000:01:00.0: buf[312] : dfdfdfdfdfdfdfdf
[  531.892243] pci-endpoint-test 0000:01:00.0: buf[320] : dfdfdfdfdfdfdfdf
[  531.898898] pci-endpoint-test 0000:01:00.0: buf[328] : dfdfdfdfdfdfdfdf
[  531.905548] pci-endpoint-test 0000:01:00.0: buf[336] : dfdfdfdfdfdfdfdf
[  531.912199] pci-endpoint-test 0000:01:00.0: buf[344] : dfdfdfdfdfdfdfdf
[  531.918848] pci-endpoint-test 0000:01:00.0: buf[352] : dfdfdfdfdfdfdfdf
[  531.925496] pci-endpoint-test 0000:01:00.0: buf[360] : dfdfdfdfdfdfdfdf
[  531.932146] pci-endpoint-test 0000:01:00.0: buf[368] : dfdfdfdfdfdfdfdf
[  531.938840] pci-endpoint-test 0000:01:00.0: buf[376] : dfdfdfdfdfdfdfdf
[  531.945492] pci-endpoint-test 0000:01:00.0: buf[384] : dfdfdfdfdfdfdfdf
[  531.952146] pci-endpoint-test 0000:01:00.0: buf[392] : dfdfdfdfdfdfdfdf
[  531.958796] pci-endpoint-test 0000:01:00.0: buf[400] : dfdfdfdfdfdfdfdf
[  531.965445] pci-endpoint-test 0000:01:00.0: buf[408] : dfdfdfdfdfdfdfdf
[  531.972094] pci-endpoint-test 0000:01:00.0: buf[416] : dfdfdfdfdfdfdfdf
[  531.978746] pci-endpoint-test 0000:01:00.0: buf[424] : dfdfdfdfdfdfdfdf
[  531.985400] pci-endpoint-test 0000:01:00.0: buf[432] : dfdfdfdfdfdfdfdf
[  531.992058] pci-endpoint-test 0000:01:00.0: buf[440] : dfdfdfdfdfdfdfdf
[  531.998723] pci-endpoint-test 0000:01:00.0: buf[448] : dfdfdfdfdfdfdfdf
[  532.005387] pci-endpoint-test 0000:01:00.0: buf[456] : dfdfdfdfdfdfdfdf
[  532.012035] pci-endpoint-test 0000:01:00.0: buf[464] : dfdfdfdfdfdfdfdf
[  532.018691] pci-endpoint-test 0000:01:00.0: buf[472] : dfdfdfdfdfdfdfdf
[  532.025339] pci-endpoint-test 0000:01:00.0: buf[480] : dfdfdfdfdfdfdfdf
[  532.031989] pci-endpoint-test 0000:01:00.0: buf[488] : dfdfdfdfdfdfdfdf
[  532.038648] pci-endpoint-test 0000:01:00.0: buf[496] : dfdfdfdfdfdfdfdf
[  532.045301] pci-endpoint-test 0000:01:00.0: buf[504] : dfdfdfdfdfdfdfdf
[  532.051949] pci-endpoint-test 0000:01:00.0: buf[512] : dfdfdfdfdfdfdfdf
[  532.058605] pci-endpoint-test 0000:01:00.0: buf[520] : dfdfdfdfdfdfdfdf
[  532.065252] pci-endpoint-test 0000:01:00.0: buf[528] : dfdfdfdfdfdfdfdf
[  532.071908] pci-endpoint-test 0000:01:00.0: buf[536] : dfdfdfdfdfdfdfdf
[  532.078559] pci-endpoint-test 0000:01:00.0: buf[544] : dfdfdfdfdfdfdfdf
[  532.085210] pci-endpoint-test 0000:01:00.0: buf[552] : dfdfdfdfdfdfdfdf
[  532.091857] pci-endpoint-test 0000:01:00.0: buf[560] : dfdfdfdfdfdfdfdf
[  532.098511] pci-endpoint-test 0000:01:00.0: buf[568] : dfdfdfdfdfdfdfdf
[  532.105161] pci-endpoint-test 0000:01:00.0: buf[576] : dfdfdfdfdfdfdfdf
[  532.111816] pci-endpoint-test 0000:01:00.0: buf[584] : dfdfdfdfdfdfdfdf
[  532.118478] pci-endpoint-test 0000:01:00.0: buf[592] : dfdfdfdfdfdfdfdf
[  532.125140] pci-endpoint-test 0000:01:00.0: buf[600] : dfdfdfdfdfdfdfdf
[  532.131787] pci-endpoint-test 0000:01:00.0: buf[608] : dfdfdfdfdfdfdfdf
[  532.138451] pci-endpoint-test 0000:01:00.0: buf[616] : dfdfdfdfdfdfdfdf
[  532.145101] pci-endpoint-test 0000:01:00.0: buf[624] : dfdfdfdfdfdfdfdf
[  532.151753] pci-endpoint-test 0000:01:00.0: buf[632] : dfdfdfdfdfdfdfdf
[  532.158399] pci-endpoint-test 0000:01:00.0: buf[640] : dfdfdfdfdfdfdfdf
[  532.165052] pci-endpoint-test 0000:01:00.0: buf[648] : dfdfdfdfdfdfdfdf
[  532.171702] pci-endpoint-test 0000:01:00.0: buf[656] : dfdfdfdfdfdfdfdf
[  532.178352] pci-endpoint-test 0000:01:00.0: buf[664] : dfdfdfdfdfdfdfdf
[  532.185000] pci-endpoint-test 0000:01:00.0: buf[672] : dfdfdfdfdfdfdfdf
[  532.191653] pci-endpoint-test 0000:01:00.0: buf[680] : dfdfdfdfdfdfdfdf
[  532.198302] pci-endpoint-test 0000:01:00.0: buf[688] : dfdfdfdfdfdfdfdf
[  532.204952] pci-endpoint-test 0000:01:00.0: buf[696] : dfdfdfdfdfdfdfdf
[  532.211601] pci-endpoint-test 0000:01:00.0: buf[704] : dfdfdfdfdfdfdfdf
[  532.218251] pci-endpoint-test 0000:01:00.0: buf[712] : dfdfdfdfdfdfdfdf
[  532.224899] pci-endpoint-test 0000:01:00.0: buf[720] : dfdfdfdfdfdfdfdf
[  532.231550] pci-endpoint-test 0000:01:00.0: buf[728] : dfdfdfdfdfdfdfdf
[  532.238214] pci-endpoint-test 0000:01:00.0: buf[736] : dfdfdfdfdfdfdfdf
[  532.244884] pci-endpoint-test 0000:01:00.0: buf[744] : dfdfdfdfdfdfdfdf
[  532.251546] pci-endpoint-test 0000:01:00.0: buf[752] : dfdfdfdfdfdfdfdf
[  532.258200] pci-endpoint-test 0000:01:00.0: buf[760] : dfdfdfdfdfdfdfdf
[  532.264849] pci-endpoint-test 0000:01:00.0: buf[768] : dfdfdfdfdfdfdfdf
[  532.271501] pci-endpoint-test 0000:01:00.0: buf[776] : dfdfdfdfdfdfdfdf
[  532.278150] pci-endpoint-test 0000:01:00.0: buf[784] : dfdfdfdfdfdfdfdf
[  532.284800] pci-endpoint-test 0000:01:00.0: buf[792] : dfdfdfdfdfdfdfdf
[  532.291446] pci-endpoint-test 0000:01:00.0: buf[800] : dfdfdfdfdfdfdfdf
[  532.298098] pci-endpoint-test 0000:01:00.0: buf[808] : dfdfdfdfdfdfdfdf
[  532.304746] pci-endpoint-test 0000:01:00.0: buf[816] : dfdfdfdfdfdfdfdf
[  532.311397] pci-endpoint-test 0000:01:00.0: buf[824] : dfdfdfdfdfdfdfdf
[  532.318045] pci-endpoint-test 0000:01:00.0: buf[832] : dfdfdfdfdfdfdfdf
[  532.324696] pci-endpoint-test 0000:01:00.0: buf[840] : dfdfdfdfdfdfdfdf
[  532.331344] pci-endpoint-test 0000:01:00.0: buf[848] : dfdfdfdfdfdfdfdf
[  532.338006] pci-endpoint-test 0000:01:00.0: buf[856] : dfdfdfdfdfdfdfdf
[  532.344658] pci-endpoint-test 0000:01:00.0: buf[864] : dfdfdfdfdfdfdfdf
[  532.351322] pci-endpoint-test 0000:01:00.0: buf[872] : dfdfdfdfdfdfdfdf
[  532.357978] pci-endpoint-test 0000:01:00.0: buf[880] : dfdfdfdfdfdfdfdf
[  532.364649] pci-endpoint-test 0000:01:00.0: buf[888] : dfdfdfdfdfdfdfdf
[  532.371311] pci-endpoint-test 0000:01:00.0: buf[896] : dfdfdfdfdfdfdfdf
[  532.377968] pci-endpoint-test 0000:01:00.0: buf[904] : dfdfdfdfdfdfdfdf
[  532.384615] pci-endpoint-test 0000:01:00.0: buf[912] : dfdfdfdfdfdfdfdf
[  532.391267] pci-endpoint-test 0000:01:00.0: buf[920] : dfdfdfdfdfdfdfdf
[  532.397917] pci-endpoint-test 0000:01:00.0: buf[928] : dfdfdfdfdfdfdfdf
[  532.404567] pci-endpoint-test 0000:01:00.0: buf[936] : dfdfdfdfdfdfdfdf
[  532.411217] pci-endpoint-test 0000:01:00.0: buf[944] : dfdfdfdfdfdfdfdf
[  532.417866] pci-endpoint-test 0000:01:00.0: buf[952] : dfdfdfdfdfdfdfdf
[  532.424513] pci-endpoint-test 0000:01:00.0: buf[960] : dfdfdfdfdfdfdfdf
[  532.431167] pci-endpoint-test 0000:01:00.0: buf[968] : dfdfdfdfdfdfdfdf
[  532.437829] pci-endpoint-test 0000:01:00.0: buf[976] : dfdfdfdfdfdfdfdf
[  532.444482] pci-endpoint-test 0000:01:00.0: buf[984] : dfdfdfdfdfdfdfdf
[  532.451131] pci-endpoint-test 0000:01:00.0: buf[992] : dfdfdfdfdfdfdfdf
[  532.457782] pci-endpoint-test 0000:01:00.0: buf[1000] : dfdfdfdfdfdfdfdf
[  532.464520] pci-endpoint-test 0000:01:00.0: buf[1008] : dfdfdfdfdfdfdfdf
[  532.471260] pci-endpoint-test 0000:01:00.0: buf[1016] : dfdfdfdfdfdfdfdf
[  532.477999] pci-endpoint-test 0000:01:00.0: buf[1024] : dfdfdfdfdfdfdfdf
[  532.484756] pci-endpoint-test 0000:01:00.0: buf[1032] : dfdfdfdfdfdfdfdf
[  532.491502] pci-endpoint-test 0000:01:00.0: buf[1040] : dfdfdfdfdfdfdfdf
[  532.498246] pci-endpoint-test 0000:01:00.0: buf[1048] : dfdfdfdfdfdfdfdf
[  532.504982] pci-endpoint-test 0000:01:00.0: buf[1056] : dfdfdfdfdfdfdfdf
[  532.511720] pci-endpoint-test 0000:01:00.0: buf[1064] : dfdfdfdfdfdfdfdf
[  532.518457] pci-endpoint-test 0000:01:00.0: buf[1072] : dfdfdfdfdfdfdfdf
[  532.525195] pci-endpoint-test 0000:01:00.0: buf[1080] : dfdfdfdfdfdfdfdf
[  532.531933] pci-endpoint-test 0000:01:00.0: buf[1088] : dfdfdfdfdfdfdfdf
[  532.538680] pci-endpoint-test 0000:01:00.0: buf[1096] : dfdfdfdfdfdfdfdf
[  532.545418] pci-endpoint-test 0000:01:00.0: buf[1104] : dfdfdfdfdfdfdfdf
[  532.552155] pci-endpoint-test 0000:01:00.0: buf[1112] : dfdfdfdfdfdfdfdf
[  532.558891] pci-endpoint-test 0000:01:00.0: buf[1120] : dfdfdfdfdfdfdfdf
[  532.565629] pci-endpoint-test 0000:01:00.0: buf[1128] : dfdfdfdfdfdfdfdf
[  532.572365] pci-endpoint-test 0000:01:00.0: buf[1136] : dfdfdfdfdfdfdfdf
[  532.579104] pci-endpoint-test 0000:01:00.0: buf[1144] : dfdfdfdfdfdfdfdf
[  532.585839] pci-endpoint-test 0000:01:00.0: buf[1152] : dfdfdfdfdfdfdfdf
[  532.592583] pci-endpoint-test 0000:01:00.0: buf[1160] : dfdfdfdfdfdfdfdf
[  532.599332] pci-endpoint-test 0000:01:00.0: buf[1168] : dfdfdfdfdfdfdfdf
[  532.606081] pci-endpoint-test 0000:01:00.0: buf[1176] : dfdfdfdfdfdfdfdf
[  532.612818] pci-endpoint-test 0000:01:00.0: buf[1184] : dfdfdfdfdfdfdfdf
[  532.619557] pci-endpoint-test 0000:01:00.0: buf[1192] : dfdfdfdfdfdfdfdf
[  532.626292] pci-endpoint-test 0000:01:00.0: buf[1200] : dfdfdfdfdfdfdfdf
[  532.633027] pci-endpoint-test 0000:01:00.0: buf[1208] : dfdfdfdfdfdfdfdf
[  532.639773] pci-endpoint-test 0000:01:00.0: buf[1216] : dfdfdfdfdfdfdfdf
[  532.646511] pci-endpoint-test 0000:01:00.0: buf[1224] : dfdfdfdfdfdfdfdf
[  532.653247] pci-endpoint-test 0000:01:00.0: buf[1232] : dfdfdfdfdfdfdfdf
[  532.659984] pci-endpoint-test 0000:01:00.0: buf[1240] : dfdfdfdfdfdfdfdf
[  532.666719] pci-endpoint-test 0000:01:00.0: buf[1248] : dfdfdfdfdfdfdfdf
[  532.673454] pci-endpoint-test 0000:01:00.0: buf[1256] : dfdfdfdfdfdfdfdf
[  532.680188] pci-endpoint-test 0000:01:00.0: buf[1264] : dfdfdfdfdfdfdfdf
[  532.686927] pci-endpoint-test 0000:01:00.0: buf[1272] : dfdfdfdfdfdfdfdf
[  532.693661] pci-endpoint-test 0000:01:00.0: buf[1280] : dfdfdfdfdfdfdfdf
[  532.700402] pci-endpoint-test 0000:01:00.0: buf[1288] : dfdfdfdfdfdfdfdf
[  532.707137] pci-endpoint-test 0000:01:00.0: buf[1296] : dfdfdfdfdfdfdfdf
[  532.713876] pci-endpoint-test 0000:01:00.0: buf[1304] : dfdfdfdfdfdfdfdf
[  532.720630] pci-endpoint-test 0000:01:00.0: buf[1312] : dfdfdfdfdfdfdfdf
[  532.727378] pci-endpoint-test 0000:01:00.0: buf[1320] : dfdfdfdfdfdfdfdf
[  532.734114] pci-endpoint-test 0000:01:00.0: buf[1328] : dfdfdfdfdfdfdfdf
[  532.740861] pci-endpoint-test 0000:01:00.0: buf[1336] : dfdfdfdfdfdfdfdf
[  532.747600] pci-endpoint-test 0000:01:00.0: buf[1344] : dfdfdfdfdfdfdfdf
[  532.754338] pci-endpoint-test 0000:01:00.0: buf[1352] : dfdfdfdfdfdfdfdf
[  532.761117] pci-endpoint-test 0000:01:00.0: buf[1360] : dfdfdfdfdfdfdfdf
[  532.767872] pci-endpoint-test 0000:01:00.0: buf[1368] : dfdfdfdfdfdfdfdf
[  532.774621] pci-endpoint-test 0000:01:00.0: buf[1376] : dfdfdfdfdfdfdfdf
[  532.781360] pci-endpoint-test 0000:01:00.0: buf[1384] : dfdfdfdfdfdfdfdf
[  532.788095] pci-endpoint-test 0000:01:00.0: buf[1392] : dfdfdfdfdfdfdfdf
[  532.794838] pci-endpoint-test 0000:01:00.0: buf[1400] : dfdfdfdfdfdfdfdf
[  532.801573] pci-endpoint-test 0000:01:00.0: buf[1408] : dfdfdfdfdfdfdfdf
[  532.808309] pci-endpoint-test 0000:01:00.0: buf[1416] : dfdfdfdfdfdfdfdf
[  532.815045] pci-endpoint-test 0000:01:00.0: buf[1424] : dfdfdfdfdfdfdfdf
[  532.821783] pci-endpoint-test 0000:01:00.0: buf[1432] : dfdfdfdfdfdfdfdf
[  532.828517] pci-endpoint-test 0000:01:00.0: buf[1440] : dfdfdfdfdfdfdfdf
[  532.835255] pci-endpoint-test 0000:01:00.0: buf[1448] : dfdfdfdfdfdfdfdf
[  532.842004] pci-endpoint-test 0000:01:00.0: buf[1456] : dfdfdfdfdfdfdfdf
[  532.848745] pci-endpoint-test 0000:01:00.0: buf[1464] : dfdfdfdfdfdfdfdf
[  532.855480] pci-endpoint-test 0000:01:00.0: buf[1472] : dfdfdfdfdfdfdfdf
[  532.862218] pci-endpoint-test 0000:01:00.0: buf[1480] : dfdfdfdfdfdfdfdf
[  532.868952] pci-endpoint-test 0000:01:00.0: buf[1488] : dfdfdfdfdfdfdfdf
[  532.875691] pci-endpoint-test 0000:01:00.0: buf[1496] : dfdfdfdfdfdfdfdf
[  532.882428] pci-endpoint-test 0000:01:00.0: buf[1504] : dfdfdfdfdfdfdfdf
[  532.889184] pci-endpoint-test 0000:01:00.0: buf[1512] : dfdfdfdfdfdfdfdf
[  532.895928] pci-endpoint-test 0000:01:00.0: buf[1520] : dfdfdfdfdfdfdfdf
[  532.902668] pci-endpoint-test 0000:01:00.0: buf[1528] : dfdfdfdfdfdfdfdf
[  532.909403] pci-endpoint-test 0000:01:00.0: buf[1536] : dfdfdfdfdfdfdfdf
[  532.916142] pci-endpoint-test 0000:01:00.0: buf[1544] : dfdfdfdfdfdfdfdf
[  532.922877] pci-endpoint-test 0000:01:00.0: buf[1552] : dfdfdfdfdfdfdfdf
[  532.929614] pci-endpoint-test 0000:01:00.0: buf[1560] : dfdfdfdfdfdfdfdf
[  532.936348] pci-endpoint-test 0000:01:00.0: buf[1568] : dfdfdfdfdfdfdfdf
[  532.943096] pci-endpoint-test 0000:01:00.0: buf[1576] : dfdfdfdfdfdfdfdf
[  532.949834] pci-endpoint-test 0000:01:00.0: buf[1584] : dfdfdfdfdfdfdfdf
[  532.956572] pci-endpoint-test 0000:01:00.0: buf[1592] : dfdfdfdfdfdfdfdf
[  532.963306] pci-endpoint-test 0000:01:00.0: buf[1600] : dfdfdfdfdfdfdfdf
[  532.970048] pci-endpoint-test 0000:01:00.0: buf[1608] : dfdfdfdfdfdfdfdf
[  532.976784] pci-endpoint-test 0000:01:00.0: buf[1616] : dfdfdfdfdfdfdfdf
[  532.983524] pci-endpoint-test 0000:01:00.0: buf[1624] : dfdfdfdfdfdfdfdf
[  532.990259] pci-endpoint-test 0000:01:00.0: buf[1632] : dfdfdfdfdfdfdfdf
[  532.997002] pci-endpoint-test 0000:01:00.0: buf[1640] : dfdfdfdfdfdfdfdf
[  533.003737] pci-endpoint-test 0000:01:00.0: buf[1648] : dfdfdfdfdfdfdfdf
[  533.010477] pci-endpoint-test 0000:01:00.0: buf[1656] : dfdfdfdfdfdfdfdf
[  533.017228] pci-endpoint-test 0000:01:00.0: buf[1664] : dfdfdfdfdfdfdfdf
[  533.023980] pci-endpoint-test 0000:01:00.0: buf[1672] : dfdfdfdfdfdfdfdf
[  533.030714] pci-endpoint-test 0000:01:00.0: buf[1680] : dfdfdfdfdfdfdfdf
[  533.037454] pci-endpoint-test 0000:01:00.0: buf[1688] : dfdfdfdfdfdfdfdf
[  533.044198] pci-endpoint-test 0000:01:00.0: buf[1696] : dfdfdfdfdfdfdfdf
[  533.050939] pci-endpoint-test 0000:01:00.0: buf[1704] : dfdfdfdfdfdfdfdf
[  533.057674] pci-endpoint-test 0000:01:00.0: buf[1712] : dfdfdfdfdfdfdfdf
[  533.064409] pci-endpoint-test 0000:01:00.0: buf[1720] : dfdfdfdfdfdfdfdf
[  533.071146] pci-endpoint-test 0000:01:00.0: buf[1728] : dfdfdfdfdfdfdfdf
[  533.077883] pci-endpoint-test 0000:01:00.0: buf[1736] : dfdfdfdfdfdfdfdf
[  533.084617] pci-endpoint-test 0000:01:00.0: buf[1744] : dfdfdfdfdfdfdfdf
[  533.091356] pci-endpoint-test 0000:01:00.0: buf[1752] : dfdfdfdfdfdfdfdf
[  533.098092] pci-endpoint-test 0000:01:00.0: buf[1760] : dfdfdfdfdfdfdfdf
[  533.104829] pci-endpoint-test 0000:01:00.0: buf[1768] : dfdfdfdfdfdfdfdf
[  533.111565] pci-endpoint-test 0000:01:00.0: buf[1776] : dfdfdfdfdfdfdfdf
[  533.118303] pci-endpoint-test 0000:01:00.0: buf[1784] : dfdfdfdfdfdfdfdf
[  533.125039] pci-endpoint-test 0000:01:00.0: buf[1792] : dfdfdfdfdfdfdfdf
[  533.131777] pci-endpoint-test 0000:01:00.0: buf[1800] : dfdfdfdfdfdfdfdf
[  533.138517] pci-endpoint-test 0000:01:00.0: buf[1808] : dfdfdfdfdfdfdfdf
[  533.145282] pci-endpoint-test 0000:01:00.0: buf[1816] : dfdfdfdfdfdfdfdf
[  533.152032] pci-endpoint-test 0000:01:00.0: buf[1824] : dfdfdfdfdfdfdfdf
[  533.158772] pci-endpoint-test 0000:01:00.0: buf[1832] : dfdfdfdfdfdfdfdf
[  533.165508] pci-endpoint-test 0000:01:00.0: buf[1840] : dfdfdfdfdfdfdfdf
[  533.172243] pci-endpoint-test 0000:01:00.0: buf[1848] : dfdfdfdfdfdfdfdf
[  533.178978] pci-endpoint-test 0000:01:00.0: buf[1856] : dfdfdfdfdfdfdfdf
[  533.185713] pci-endpoint-test 0000:01:00.0: buf[1864] : dfdfdfdfdfdfdfdf
[  533.192446] pci-endpoint-test 0000:01:00.0: buf[1872] : dfdfdfdfdfdfdfdf
[  533.199184] pci-endpoint-test 0000:01:00.0: buf[1880] : dfdfdfdfdfdfdfdf
[  533.205920] pci-endpoint-test 0000:01:00.0: buf[1888] : dfdfdfdfdfdfdfdf
[  533.212656] pci-endpoint-test 0000:01:00.0: buf[1896] : dfdfdfdfdfdfdfdf
[  533.219391] pci-endpoint-test 0000:01:00.0: buf[1904] : dfdfdfdfdfdfdfdf
[  533.226127] pci-endpoint-test 0000:01:00.0: buf[1912] : dfdfdfdfdfdfdfdf
[  533.232861] pci-endpoint-test 0000:01:00.0: buf[1920] : dfdfdfdfdfdfdfdf
[  533.239603] pci-endpoint-test 0000:01:00.0: buf[1928] : dfdfdfdfdfdfdfdf
[  533.246347] pci-endpoint-test 0000:01:00.0: buf[1936] : dfdfdfdfdfdfdfdf
[  533.253098] pci-endpoint-test 0000:01:00.0: buf[1944] : dfdfdfdfdfdfdfdf
[  533.259836] pci-endpoint-test 0000:01:00.0: buf[1952] : dfdfdfdfdfdfdfdf
[  533.266587] pci-endpoint-test 0000:01:00.0: buf[1960] : dfdfdfdfdfdfdfdf
[  533.273332] pci-endpoint-test 0000:01:00.0: buf[1968] : dfdfdfdfdfdfdfdf
[  533.280072] pci-endpoint-test 0000:01:00.0: buf[1976] : dfdfdfdfdfdfdfdf
[  533.286805] pci-endpoint-test 0000:01:00.0: buf[1984] : dfdfdfdfdfdfdfdf
[  533.293546] pci-endpoint-test 0000:01:00.0: buf[1992] : dfdfdfdfdfdfdfdf
[  533.300281] pci-endpoint-test 0000:01:00.0: buf[2000] : dfdfdfdfdfdfdfdf
[  533.307018] pci-endpoint-test 0000:01:00.0: buf[2008] : dfdfdfdfdfdfdfdf
[  533.313754] pci-endpoint-test 0000:01:00.0: buf[2016] : dfdfdfdfdfdfdfdf
[  533.320491] pci-endpoint-test 0000:01:00.0: buf[2024] : dfdfdfdfdfdfdfdf
[  533.327226] pci-endpoint-test 0000:01:00.0: buf[2032] : dfdfdfdfdfdfdfdf
[  533.333962] pci-endpoint-test 0000:01:00.0: buf[2040] : dfdfdfdfdfdfdfdf
[  533.340696] pci-endpoint-test 0000:01:00.0: buf[2048] : dfdfdfdfdfdfdfdf
[  533.347443] pci-endpoint-test 0000:01:00.0: buf[2056] : dfdfdfdfdfdfdfdf
[  533.354181] pci-endpoint-test 0000:01:00.0: buf[2064] : dfdfdfdfdfdfdfdf
[  533.360917] pci-endpoint-test 0000:01:00.0: buf[2072] : dfdfdfdfdfdfdfdf
[  533.367653] pci-endpoint-test 0000:01:00.0: buf[2080] : dfdfdfdfdfdfdfdf
[  533.374391] pci-endpoint-test 0000:01:00.0: buf[2088] : dfdfdfdfdfdfdfdf
[  533.381129] pci-endpoint-test 0000:01:00.0: buf[2096] : dfdfdfdfdfdfdfdf
[  533.387881] pci-endpoint-test 0000:01:00.0: buf[2104] : dfdfdfdfdfdfdfdf
[  533.394629] pci-endpoint-test 0000:01:00.0: buf[2112] : dfdfdfdfdfdfdfdf
[  533.401368] pci-endpoint-test 0000:01:00.0: buf[2120] : dfdfdfdfdfdfdfdf
[  533.408105] pci-endpoint-test 0000:01:00.0: buf[2128] : dfdfdfdfdfdfdfdf
[  533.414842] pci-endpoint-test 0000:01:00.0: buf[2136] : dfdfdfdfdfdfdfdf
[  533.421576] pci-endpoint-test 0000:01:00.0: buf[2144] : dfdfdfdfdfdfdfdf
[  533.428312] pci-endpoint-test 0000:01:00.0: buf[2152] : dfdfdfdfdfdfdfdf
[  533.435046] pci-endpoint-test 0000:01:00.0: buf[2160] : dfdfdfdfdfdfdfdf
[  533.441785] pci-endpoint-test 0000:01:00.0: buf[2168] : dfdfdfdfdfdfdfdf
[  533.449184] pci-endpoint-test 0000:01:00.0:
[  533.449184]
[  533.449184]
[  533.449184]
[  533.457921] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
ffff0004b61f9000 7e959800  ce535039=910c690d
READ (   2176 bytes):           NOT OKAY

Note: for failure case the crc is always ce535039

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
