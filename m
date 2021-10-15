Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9D42FB18
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhJOShE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbhJOShD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:37:03 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADDEC061570;
        Fri, 15 Oct 2021 11:34:56 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id h4so19908104uaw.1;
        Fri, 15 Oct 2021 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdvpEps5RpPexHJoN2yLUAHP53T3CGc/Z15Qzk7WYlQ=;
        b=Oh5YqBS9BrZMxjbxK5OnqaHgU0HD5E1rfRlMO0HnG7CYJVNXh1UppQgLwvxC4AbGkO
         KVPPfZnAWxtEbMfpj8LEQ5K8J9Ea8yJRae8hprvomTJaGRDbSTwqfHTjL1leJgjgf6Dc
         9v8Ui9Au6A0rIaEJLDkJkSRXIuxlXXnIAvtqFC+uZRrvoDz7m35gtaUm7aDdTYWeOxBu
         BgRTWEKrznwt5h5UcZJbZ09I+rBfmmUWvhLI530ZbFLVfd85/qnHtaveusVGCj24qvEs
         n3OGu+o0VubvxnI3eB/XHi3fSkeFGzStk6V9PyN1sOGaiVMTinxISrFT0nqdpwpgdXpW
         AzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdvpEps5RpPexHJoN2yLUAHP53T3CGc/Z15Qzk7WYlQ=;
        b=mNjp/xl1/T7w6Ak5eottkFjb5f29uPKFe90ec9XXVpdaADagWfINmZKH2zlZyQa/im
         JrzJMMcI7C0QgueA23lFBEI8eX2xWBcDgr8fECVp3TRTK/BW8rH/D9wfota8w33Gz91o
         7URPFUBnqpR3mMpWS8jW5YhNK6VFP5B8eeErkl6OAVTPK6K+3imVfmdLKUBOZe86kevT
         GiFrnbmXKdoMN1vsqZuMoTphht6j5m3kt3bVGN0rIulntTNkIKbIfnUnRMrI1STfOORn
         mL0EXLudqSTgiilh/lkjobm9KngciLBqDg72vAtXLVmV9r3Lpr/fjADmj1pAOqWTsIaA
         yZGg==
X-Gm-Message-State: AOAM533Uda3dVaCHGkXXUaWMYscbU7VmvKTIFFOINq0N4u9z1ve7b0hS
        1Wcpcsqv3chJ3+hpGK+DREXaGTlT06YwfayNyk++CeW9
X-Google-Smtp-Source: ABdhPJx55Xc6Bp0Vri8rnJIqfP9F32H7316jWFrB+R94r+SZ4FMQ3YR2ju4nRXmyGtaORK9Kku94MppZ0bCJyJzkR9Y=
X-Received: by 2002:ab0:3386:: with SMTP id y6mr14790557uap.53.1634322895780;
 Fri, 15 Oct 2021 11:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com> <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 15 Oct 2021 15:34:45 -0300
Message-ID: <CAOMZO5DD9mouiBvYE0JwHEAJKENC3Af=j3tQbCsUfWCi8Ji8ug@mail.gmail.com>
Subject: Re: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link never
 came up
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Fri, Oct 15, 2021 at 3:32 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> When PCIe PHY link never came up and vpcie regulator is present, there
> would be following dump when try to put the regulator.
> Disable this regulator to fix this dump when link never came up.
>
>   imx6q-pcie 33800000.pcie: Phy link never came up
>   imx6q-pcie: probe of 33800000.pcie failed with error -110
>   ------------[ cut here ]------------
>   WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256 _regulator_put.part.0+0x14c/0x158
>   Modules linked in:
>   CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
>   Hardware name: FSL i.MX8MM EVK board (DT)
>   Workqueue: events_unbound async_run_entry_fn
>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>   pc : _regulator_put.part.0+0x14c/0x158
>   lr : regulator_put+0x34/0x48
>   sp : ffff8000122ebb30
>   x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
>   x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
>   x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
>   x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000108
>   x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
>   x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
>   x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
>   x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
>   x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
>   Call trace:
>    _regulator_put.part.0+0x14c/0x158
>    regulator_put+0x34/0x48
>    devm_regulator_release+0x10/0x18
>    release_nodes+0x38/0x60
>    devres_release_all+0x88/0xd0
>    really_probe+0xd0/0x2e8
>    __driver_probe_device+0x74/0xd8
>    driver_probe_device+0x7c/0x108
>    __device_attach_driver+0x8c/0xd0
>    bus_for_each_drv+0x74/0xc0
>    __device_attach_async_helper+0xb4/0xd8
>    async_run_entry_fn+0x30/0x100
>    process_one_work+0x19c/0x320
>    worker_thread+0x48/0x418
>    kthread+0x14c/0x158
>    ret_from_fork+0x10/0x18
>   ---[ end trace 3664ca4a50ce849b ]---
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

I am seeing this on imx6 too. When you send a v2, after addressing
Lucas' comments, please add a Fixes tag/
