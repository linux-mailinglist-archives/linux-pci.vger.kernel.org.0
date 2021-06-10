Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C63A2E1B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJO2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 10:28:40 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35527 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFJO2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 10:28:40 -0400
Received: by mail-pg1-f176.google.com with SMTP id o9so19896333pgd.2;
        Thu, 10 Jun 2021 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+0lFObsPfySoTkZUVkBKY6h9vNmCPSAZfeonfL6xoX8=;
        b=hEe7cZgbo+V9n7A46a8DVbZe8UHhZHsjwXZ/2GhaAxouuaH1O8NxbePeDpJwCYjrt2
         amJXLbBVHXyFD17jUeb8VhROWrW9g+qj7aLP/akERHSLLPhgWXl1neylR90pBqBddjzy
         Kq+SbNcBmhwM3uVR6ctDeDvpOi/6WN6s0eTVSrZTTPC7W1QKJjfdDlmI2AI2fy1YkV2e
         kiNHLk18NihEt8dvH5Go2fnFiXZIk4kt8/0QWk9XJiRus8lc/RcKAo0Y9Hxp0Gqxf3jk
         ZJkyXPmmkUz1AU+w5SfqEbzrig+x8ixoOykwUG6/dbqxlZpn5s/cR8LI1RTNbiAynICG
         2kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+0lFObsPfySoTkZUVkBKY6h9vNmCPSAZfeonfL6xoX8=;
        b=j2d2377Q1vbnvlKUj4psIbn0Oio2hND6DPYUgOU3Ydfj514c9oDjMUCxavxYKz+Lkb
         2f24c7Gif15r+vwJeyyDV1nPAAgrmptes2Kb4G8dJlNqffI6Hmf/2sSy8nfQWiQXLS5B
         FrxNSwflAbHYyr666iTwnhqv2VAPXs4jT2Wkqc/RyuqtlSfiYz+9vTd9oW7s340rwJ/w
         an6HZa/gPkiauoZW8yScI3DV3oPZgTHEGRFb++bZ5OUCNW+K0t5wZdRTAw/C8d+rvtR5
         676/Vt4XKlMAvwEpeiDVN9ptW3rEHSX4gUirsY2GDrx1lvcqa/sz8clxVDgQ1Bb5JpOw
         Lg7g==
X-Gm-Message-State: AOAM533MRsWiZEraCB7AcVubNMcsejtxXvZoDjZrozBMkCpuJntnpYPd
        IcZGB3lnV5Ezbs/RSMkZyRg=
X-Google-Smtp-Source: ABdhPJzOJEMQiJi3wgM0GCFKZi4xEA7nX+CV9P3v2fNhxp9bDwPU7ffjWL2WZlXm5qvQEIXD6fWv7A==
X-Received: by 2002:a63:1c6:: with SMTP id 189mr5215110pgb.144.1623335129372;
        Thu, 10 Jun 2021 07:25:29 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id n72sm2763202pfd.8.2021.06.10.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:25:28 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     helgaas@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>, pgwipeout@gmail.com,
        Ard Biesheuvel <ardb@kernel.org>, briannorris@chromium.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 0/4] PCI: of: Improvements to handle 64-bit attribute
 for non-prefetchable ranges
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
        <CANAwSgT=SoNbpV7Lx1s=zo+FAOT1yQvT==0p6Mb+Gb4ctQNiJg@mail.gmail.com>
Date:   Thu, 10 Jun 2021 23:25:26 +0900
In-Reply-To: <CANAwSgT=SoNbpV7Lx1s=zo+FAOT1yQvT==0p6Mb+Gb4ctQNiJg@mail.gmail.com>
        (Anand Moon's message of "Thu, 10 Jun 2021 14:35:40 +0530")
Message-ID: <87mtrxkd9l.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Anand,

Anand Moon <linux.amoon@gmail.com> writes:

> Hi Punit,
>
> On Mon, 7 Jun 2021 at 17:02, Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Hi,
>>
>> This is the third iteration to improve handling of the 64-bit
>> attribute on non-prefetchable host bridge ranges. Previous version can
>> be found at [0][1].
>>
>> This version is a small update over the previous version - changelog
>> below. If there is no futher feedback on the patches, please consider
>> merging them.
>>
>> Thanks,
>> Punit
>>
>
> Thanks for your work, I have tested this on my RK3399 (Odroid N1) SBC.
> It partially works on this board. So I looked into
> RK3399TRM_V1.3_Part2 for more details.
>
> 17.6.7.1.45  Root Complex BAR Configuration Register
>    It looks like these config changes are related to the issue you are
> trying to solve.
>
> On this basis here are the code changes I made in the driver for testing.
>
> [alarm@alarm linux-rockchip-5.y-devel]$ git diff
> drivers/pci/controller/pcie-rockchip.h
> drivers/pci/controller/pcie-rockchip.c
> diff --git a/drivers/pci/controller/pcie-rockchip.c
> b/drivers/pci/controller/pcie-rockchip.c
> index 990a00e08bc5..18e315de9f04 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -405,9 +405,20 @@ void rockchip_pcie_cfg_configuration_accesses(
>                 struct rockchip_pcie *rockchip, u32 type)
>  {
>         u32 ob_desc_0;
> +       u32 status;
>
>         /* Configuration Accesses for region 0 */
> -       rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
> +       status = rockchip_pcie_read(rockchip, PCIE_RC_BAR_CONF);
> +       status |= FIELD_PREP(PCIE_RC_BAR_RCBAR0A, 0x14) |
> +               FIELD_PREP(PCIE_RC_BAR_RCBAR0C, 0x6) |
> +               FIELD_PREP(PCIE_RC_BAR_RCBAR1A, 0x14) |
> +               FIELD_PREP(PCIE_RC_BAR_RCBAR1C, 0x4) |
> +               PCIE_RC_BAR_RCBARPME |
> +               PCIE_RC_BAR_RCBARPMS |
> +               PCIE_RC_BAR_RCBARPIE |
> +               PCIE_RC_BAR_RCBARPIS |
> +               PCIE_RC_BAR_RCBCE;
> +       rockchip_pcie_write(rockchip, status, PCIE_RC_BAR_CONF);
>
>         rockchip_pcie_write(rockchip,
>                             (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
> diff --git a/drivers/pci/controller/pcie-rockchip.h
> b/drivers/pci/controller/pcie-rockchip.h
> index 1650a5087450..a68ca18de4ec 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -114,6 +114,16 @@
>  #define PCIE_CORE_INT_MASK             (PCIE_CORE_CTRL_MGMT_BASE + 0x210)
>  #define PCIE_CORE_PHY_FUNC_CFG         (PCIE_CORE_CTRL_MGMT_BASE + 0x2c0)
>  #define PCIE_RC_BAR_CONF               (PCIE_CORE_CTRL_MGMT_BASE + 0x300)
> +#define   PCIE_RC_BAR_RCBAR0A           GENMASK(5, 0)
> +#define   PCIE_RC_BAR_RCBAR0C           GENMASK(8, 6)
> +#define   PCIE_RC_BAR_RCBAR1A           GENMASK(13, 9)
> +#define   PCIE_RC_BAR_RCBAR1C           GENMASK(16, 14)
> +#define   PCIE_RC_BAR_RCBARPME          BIT(17)
> +#define   PCIE_RC_BAR_RCBARPMS          BIT(18)
> +#define   PCIE_RC_BAR_RCBARPIE          BIT(19)
> +#define   PCIE_RC_BAR_RCBARPIS          BIT(20)
> +#define   PCIE_RC_BAR_RCBCE             BIT(31)
> +
>  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_DISABLED               0x0
>  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS              0x1
>  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS             0x4
>
> But I am getting the following error at my end.
> --------------------
> [  OK  ] Found device /dev/ttyS2.
> [    7.089794] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> [    7.092945] rk808-rtc rk808-rtc: registered as rtc0
> [    7.103462] rockchip-pcie f8000000.pcie:      MEM
> 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> [    7.113384] rockchip-pcie f8000000.pcie:       IO
> 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> [    7.123294] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
> [    7.123524] rk808-rtc rk808-rtc: setting system clock to
> 2021-06-10T07:36:35 UTC (1623310595)
> [    7.130589] rockchip-pcie f8000000.pcie: no vpcie3v3 regulator found
> [    7.187409] mc: Linux media interface: v0.10
> [    7.210178] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> [    7.217643] pci_bus 0000:00: root bus resource [bus 00-1f]
> [    7.224126] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> [    7.234975] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> (bus address [0xfbe00000-0xfbefffff])
> [    7.246527] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> [    7.264087] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x003fffff 64bit]
> [    7.271770] pci 0000:00:00.0: supports D1
> [    7.276265] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    7.284724] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    7.293874] pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
> [    7.300656] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
> [    7.308542] pci 0000:01:00.0: reg 0x10: [io  size 0x0008]
> [    7.309498] videodev: Linux video capture interface: v2.00
> [    7.314606] pci 0000:01:00.0: reg 0x14: initial BAR value 0x00000000 invalid
> [    7.328593] pci 0000:01:00.0: reg 0x14: [io  size 0x0004]
> [    7.334661] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
> [    7.342545] pci 0000:01:00.0: reg 0x18: [io  size 0x0008]
> [    7.342578] pci 0000:01:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
> [    7.342581] pci 0000:01:00.0: reg 0x1c: [io  size 0x0004]
> [    7.342609] pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
> [    7.342612] pci 0000:01:00.0: reg 0x20: [io  size 0x0010]
> [    7.342640] pci 0000:01:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
> [    7.383491] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    7.383533] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 512)
> [    7.385978] panfrost ff9a0000.gpu: clock rate = 500000000
> [    7.387283] rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
> [    7.387295] rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
> [    7.387377] rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
> [    7.387614] rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
> [    7.387623] rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
> [    7.387631] rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
> [    7.387643] rk_gmac-dwmac fe300000.ethernet: integrated PHY? (no).
> [    7.387682] rk_gmac-dwmac fe300000.ethernet: cannot get clock clk_mac_speed
> [    7.387688] rk_gmac-dwmac fe300000.ethernet: clock input from PHY
> [    7.391688] panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init
> [panfrost]] Failed to register cooling device
> [    7.392704] rk_gmac-dwmac fe300000.ethernet: init for RGMII
> [    7.392908] rk_gmac-dwmac fe300000.ethernet: User ID: 0x10, Synopsys ID: 0x35
> [    7.392921] rk_gmac-dwmac fe300000.ethernet:         DWMAC1000
> [    7.392926] rk_gmac-dwmac fe300000.ethernet: DMA HW capability
> register supported
> [    7.392931] rk_gmac-dwmac fe300000.ethernet: RX Checksum Offload
> Engine supported
> [    7.392935] rk_gmac-dwmac fe300000.ethernet: COE Type 2
> [    7.392939] rk_gmac-dwmac fe300000.ethernet: TX Checksum insertion supported
> [    7.392943] rk_gmac-dwmac fe300000.ethernet: Wake-Up On Lan supported
> [    7.393016] rk_gmac-dwmac fe300000.ethernet: Normal descriptors
> [    7.393022] rk_gmac-dwmac fe300000.ethernet: Ring mode enabled
> [    7.393026] rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation
> via HW Watchdog Timer
> [    7.393070] rk_gmac-dwmac fe300000.ethernet: Unbalanced pm_runtime_enable!
> [    7.393421] libphy: stmmac: probed
> [    7.399404] rockchip-pcie f8000000.pcie: local interrupt received
> [    7.405075] panfrost ff9a0000.gpu: mali-t860 id 0x860 major 0x2
> minor 0x0 status 0x0
> [    7.412338] rockchip-pcie f8000000.pcie: an error was observed in
> the flow control advertisements from the other side
> [    7.412377] rockchip-pcie f8000000.pcie: phy link changes
> [    7.417620] pci_bus 0000:01: fixups for bus
> [    7.417624] pci_bus 0000:01: bus scan returning with max=01
> [    7.417628] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> [    7.417637] pci_bus 0000:00: bus scan returning with max=01
> [    7.417650] pci 0000:00:00.0: BAR 0: assigned [mem
> 0xfa000000-0xfa3fffff 64bit]
> [    7.417662] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa400000-0xfa4fffff]
> [    7.417666] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    7.417671] pci 0000:01:00.0: BAR 6: assigned [mem
> 0xfa400000-0xfa40ffff pref]
> [    7.417675] pci 0000:01:00.0: BAR 5: assigned [mem 0xfa410000-0xfa4101ff]
> [    7.417689] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
> [    7.417702] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
> [    7.417715] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
> [    7.417729] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
> [    7.417742] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
> [    7.417756] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    7.417760] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    7.417766] pci 0000:00:00.0:   bridge window [mem 0xfa400000-0xfa4fffff]
> [    7.417872] pcieport 0000:00:00.0: assign IRQ: got 93
> [    7.417884] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
> [    7.417895] pcieport 0000:00:00.0: enabling bus mastering
> [    7.418081] SError Interrupt on CPU5, code 0xbf000002 -- SError
> [    7.418084] CPU: 5 PID: 90 Comm: kworker/u12:2 Not tainted
> 5.13.0-rc5-xn1ml-00004-g128f93a6219c-dirty #6
> [    7.418085] Hardware name: Hardkernel ODROID-N1 (DT)
> [    7.418086] Workqueue: events_unbound deferred_probe_work_func
> [    7.418089] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    7.418091] pc : __pci_enable_msix_range+0x498/0x6b0
> [    7.418092] lr : __pci_enable_msix_range+0x44c/0x6b0
> [    7.418093] sp : ffff80001249b710
> [    7.418094] x29: ffff80001249b710 x28: 0000000000000000 x27: ffff0000059ba000
> [    7.418098] x26: ffff0000059ba0c0 x25: 0000000000000001 x24: 0000000000000000
> [    7.418102] x23: 000000000000000c x22: 0000000000000000 x21: ffff0000059ba2e8
> [    7.418106] x20: 0000000000000001 x19: 0000000000000000 x18: 0000000000000002
> [    7.418110] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    7.418114] x14: 0000000000000001 x13: 00000000000e98d4 x12: 0000000000000040
> [    7.418117] x11: ffff00000081afe8 x10: ffff00000081afea x9 : ffff800011d129e0
> [    7.418121] x8 : 0000000000000000 x7 : ffff800011fca91c x6 : 0000000000000000
> [    7.418125] x5 : 000000000000c011 x4 : ffff8000178000b0 x3 : 0000000000000002
> [    7.418128] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000004efe680
> [    7.418132] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    7.418134] CPU: 5 PID: 90 Comm: kworker/u12:2 Not tainted
> 5.13.0-rc5-xn1ml-00004-g128f93a6219c-dirty #6
> [    7.418136] Hardware name: Hardkernel ODROID-N1 (DT)
> [    7.418137] Workqueue: events_unbound deferred_probe_work_func
> [    7.418139] Call trace:
> [    7.418140]  dump_backtrace+0x0/0x1a0
> [    7.418141]  show_stack+0x1c/0x70
> [    7.418142]  dump_stack+0xd0/0x12c
> [    7.418143]  panic+0x16c/0x334
> [    7.418145]  add_taint+0x0/0xb0
> [    7.418146]  arm64_serror_panic+0x7c/0x88
> [    7.418147]  do_serror+0x68/0x70
> [    7.418148]  el1_error+0x80/0xf8
> [    7.418149]  __pci_enable_msix_range+0x498/0x6b0
> [    7.418150]  pci_alloc_irq_vectors_affinity+0xbc/0x13c
> [    7.418152]  pcie_port_device_register+0x11c/0x40c
> [    7.418153]  pcie_portdrv_probe+0x48/0x100
> [    7.418154]  local_pci_probe+0x44/0xb0
> [    7.418155]  pci_device_probe+0x114/0x1b0
> [    7.418156]  really_probe+0xe4/0x504
> [    7.418157]  driver_probe_device+0x64/0xcc
> [    7.418158]  __device_attach_driver+0xb8/0x114
> [    7.418159]  bus_for_each_drv+0x78/0xd0
> [    7.418160]  __device_attach+0xd8/0x180
> [    7.418161]  device_attach+0x18/0x24
> [    7.418162]  pci_bus_add_device+0x54/0xc0
> [    7.418163]  pci_bus_add_devices+0x40/0x90
> [    7.418165]  pci_host_probe+0x44/0xc4
> [    7.418166]  rockchip_pcie_probe+0x2fc/0x4d4 [pcie_rockchip_host]
> [    7.418167]  platform_probe+0x6c/0xdc
> [    7.418168]  really_probe+0xe4/0x504
> [    7.418169]  driver_probe_device+0x64/0xcc
> [    7.418170]  __device_attach_driver+0xb8/0x114
> [    7.418171]  bus_for_each_drv+0x78/0xd0
> [    7.418172]  __device_attach+0xd8/0x180
> [    7.418173]  device_initial_probe+0x18/0x2c
> [    7.418174]  bus_probe_device+0xa0/0xac
> [    7.418175]  deferred_probe_work_func+0x88/0xc0
> [    7.418176]  process_one_work+0x1cc/0x350
> [    7.418177]  worker_thread+0x13c/0x470
> [    7.418178]  kthread+0x158/0x160
> [    7.418179]  ret_from_fork+0x10/0x30
> [    8.063493] SMP: stopping secondary CPUs
> [    8.063495] Kernel Offset: disabled
> [    8.063496] CPU features: 0x10001031,20000846
> [    8.063498] Memory Limit: none

I am not sure I follow the changes you've made. Also the issue in the
bootlog seems to be different (unrelated?) to the one I am looking to
fix - failing to allocate non-prefetchable 32-bit BARs from 64-bit
resource windows.

Not sure how I can help.

Thanks,
Punit

[...]

