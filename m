Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297F64F671
	for <lists+linux-pci@lfdr.de>; Sat, 17 Dec 2022 01:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLQAp5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 19:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLQApz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 19:45:55 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EA1CFFF;
        Fri, 16 Dec 2022 16:45:54 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r205so2480404oib.9;
        Fri, 16 Dec 2022 16:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWg9wkFT4ZXDaL5R+ZrQ8A3wXuZdrfbZGO5+ybNKwD8=;
        b=IrMDX6HzbVbj0D3HmhfEn7ql6+u9Cz+HK+7ZZWCgyEe4G8AC38w/0A0g15kk3lhqKY
         JUUVCtscTivfzzpwA7fGf5KWN7xwcUF0gEoz9h1xq0SjM/Nzr9PMQT+SJgTm8M0ABmBt
         v3XXEfEW1Xun3DRRlYrIXqpb3xmZXfBHAxMNKrq34lwdBHotI9/C81rxhl0cOCrH9/wd
         fTUUraQzF1SjRsSWutg+AWwiCDzzeTcz4CUh5kOEg4AQAYuewct7fXIuP6XZgdbJGv+L
         FigwTiCGjaAICXdD5hl/fcqsft5pFyQLMLWYFpLDUpaB7oB7fjTBdklUVoyc/lqlO99L
         wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWg9wkFT4ZXDaL5R+ZrQ8A3wXuZdrfbZGO5+ybNKwD8=;
        b=fa37kRvywhLgUa8/MarYKDCBhZq/QBioUxU79hrl34dhbJVrH7PHGx+AmNKiXc95yr
         RSCehIkQiEafaJZQzbw8xOFi8tRS78l6vl0sOSej44jpzBvYzR2WKXwWv9mX0GjrC5Rs
         d9Qk2FqdrKBwMTv6gKCRMKpTSKSsGl6bRzPbIymsECgWxVt0Rm3VdgXRbuHAPWAJGzKI
         sUwDXfhb0SCFgJaWXIqJb7O3slvzorK54lKnd83/bAzfEwXr7xQ7ni9prLmF81ElzjlQ
         fExBtQGEtRVGe/cUjS6hMxEgfpnczUVGwputFof3nzJM2U/sFPoWHtpj3G3+2LhvNc40
         B9Mw==
X-Gm-Message-State: ANoB5pk8rPiiSI3Lw7V3wdpMjugvejQavr+AcNvQIE/BTyPBCokf2a6h
        LrZYO/eK3AvvTFF619sa6iXKqJR5SrQ=
X-Google-Smtp-Source: AA0mqf4aFArzmI7oJ6MlqElzjiZLGBrY9qRcgyNH1dHH0RI6U0HJT5i8ik99aMOQrJduJlQEthYfLA==
X-Received: by 2002:a05:6808:98e:b0:35e:5aac:716a with SMTP id a14-20020a056808098e00b0035e5aac716amr13462971oic.45.1671237953918;
        Fri, 16 Dec 2022 16:45:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683022fa00b00661ad8741b4sm1551565otc.24.2022.12.16.16.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 16:45:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <70dab88e-6119-0c12-7c6a-61bcbe239f66@roeck-us.net>
Date:   Fri, 16 Dec 2022 16:45:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
 <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
 <86v8mbphzw.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
In-Reply-To: <86v8mbphzw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/22 05:58, Marc Zyngier wrote:
[ ... ]

>> With both these fixes applied, it actually then leads to the very
>> next WARN_ON failing in msi_ctrl_valid...  Because ctrl->last ==
>> hwsize.  I think Thomas' initial fix for msi_domain_get_hwsize has
>> an off-by-1 error, I think we should return MSI_XA_DOMAIN_SIZE for
>> msi_domain_get_hwsize instead.
> 
> Yes, that's a good point, and that's consistent with what
> __msi_create_irq_domain() does already, assuming MSI_XA_DOMAIN_SIZE
> when info->hwsize is 0. No reason to do something else here.
> 
> I'll update Thomas' patch. Once Guenter confirms that PPC is OK, I'll
> send it out.
> 
With

7a27b6136dcb (local/testing, testing-msi) genirq/msi: Return MSI_XA_DOMAIN_SIZE as the maximum MSI index when no domain is present
c581d525bb1d genirq/msi: Check for the presence of an irq domain when validating msi_ctrl
9d33edb20f7e Merge tag 'irq-core-2022-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

I still get the following runtime warning.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8 at kernel/irq/msi.c:196 .msi_domain_free_descs+0x144/0x170
Modules linked in:
CPU: 0 PID: 8 Comm: kworker/u2:0 Tainted: G                 N 6.1.0-01957-g7a27b6136dcb #1
Hardware name: QEMU ppce500 e5500 0x80240020 QEMU e500
Workqueue: nvme-reset-wq .nvme_reset_work
NIP:  c000000000107d54 LR: c000000000107d44 CTR: 0000000000000000
REGS: c0000000041e74d0 TRAP: 0700   Tainted: G                 N  (6.1.0-01957-g7a27b6136dcb)
MSR:  0000000080029002 <CE,EE,ME>  CR: 44002282  XER: 20000000
IRQMASK: 0
GPR00: c000000000107d44 c0000000041e7770 c000000001629c00 c000000004e748a0
GPR04: 000000005358db0a c000000001ce7a00 c00000000423b5d0 000000004735aaa2
GPR08: 0000000000000002 0000000000000013 c00000000423acc0 c00000000214a998
GPR12: 0000000024002282 c000000002579000 c00000000008e190 c000000004173540
GPR16: 0000000000000000 c0000000043810b8 0000000000000000 0000000000000001
GPR20: c0000000060b22d8 c0000000060a70f0 0000000000000000 c000000001996800
GPR24: c0000000017df6c0 c0000000043810b8 c0000000060b2388 c0000000060b2000
GPR28: ffffffffffffffff c0000000041e7888 c000000006025ac8 c000000004e748a0
NIP [c000000000107d54] .msi_domain_free_descs+0x144/0x170
LR [c000000000107d44] .msi_domain_free_descs+0x134/0x170
Call Trace:
[c0000000041e7770] [c000000000107d44] .msi_domain_free_descs+0x134/0x170 (unreliable)
[c0000000041e7810] [c0000000001085d8] .msi_domain_free_msi_descs_range+0x38/0x70
[c0000000041e78a0] [c0000000008d000c] .pci_msi_teardown_msi_irqs+0x4c/0xa0
[c0000000041e7920] [c0000000008cf9e8] .pci_free_msi_irqs+0x18/0x50
[c0000000041e79a0] [c0000000008cd8d0] .pci_free_irq_vectors+0x80/0xb0
[c0000000041e7a20] [c000000000a6d2a0] .nvme_reset_work+0x870/0x1780
[c0000000041e7bb0] [c000000000080e68] .process_one_work+0x2d8/0x7b0
[c0000000041e7c90] [c0000000000813d8] .worker_thread+0x98/0x4f0
[c0000000041e7d70] [c00000000008e2cc] .kthread+0x13c/0x150
[c0000000041e7e10] [c0000000000005d8] .ret_from_kernel_thread+0x58/0x60
Instruction dump:
7fc3f378 48ff1ca9 60000000 7c7f1b79 41c2002c e8810070 7fc3f378 48ff3491
60000000 813f0000 2c090000 41e2ffb0 <0fe00000> 60000000 60000000 ebc10090
irq event stamp: 98168
hardirqs last  enabled at (98167): [<c00000000110a274>] ._raw_spin_unlock_irqrestore+0x84/0xd0
hardirqs last disabled at (98168): [<c000000000010b58>] .program_check_exception+0x38/0x120
softirqs last  enabled at (97760): [<c00000000110b4dc>] .__do_softirq+0x60c/0x678
softirqs last disabled at (97749): [<c000000000004d20>] .do_softirq_own_stack+0x30/0x50
---[ end trace 0000000000000000 ]---
nvme nvme0: 1/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
...

The system boots fine, though. This is seen when booting the ppce500 machine with
e5500 CPU and corenet64_smp_defconfig from nvme.

Guenter

