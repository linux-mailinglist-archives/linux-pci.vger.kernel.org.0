Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F483769FC9
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGaRwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGaRwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 13:52:22 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3010C9;
        Mon, 31 Jul 2023 10:52:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C112930010C4B;
        Mon, 31 Jul 2023 19:52:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9FE494A177; Mon, 31 Jul 2023 19:52:16 +0200 (CEST)
Date:   Mon, 31 Jul 2023 19:52:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230731175216.GA19517@wunner.de>
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
 <20230725163046.GA23990@wunner.de>
 <20230727093857.000017aa@Huawei.com>
 <CAKmqyKOj9JxKcGbEEiTv_nxQSh+7cM-4uz6Z5uGFYdZyjeQ_5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOj9JxKcGbEEiTv_nxQSh+7cM-4uz6Z5uGFYdZyjeQ_5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 11:30:29AM -0400, Alistair Francis wrote:
> Yep, a big benefit is lspci or other userspace tools to be able to see
> what DOE protocols are supported.

Fair enough, but please make that motivation explicit in the commit
message.


> I also have plans to expose DOE mailboxes to userspace. That way we
> can run the SPDM requester code (using libspdm) in userspace to
> communicate with devices using SPDM. That will allow device
> authentication for example.

That duplicates our effort to bring up authentication in the kernel:
https://github.com/l1k/linux/commits/doe

We had a lengthy debate on the pros and cons of doing SPDM in-kernel
versus in user space.  We realized that when resuming a device from
D3cold or recovering it after reset, the user space component performing
SPDM authentication might reside on the device (disk, network) being
resumed or reset, preventing its execution.

When resuming from system sleep, devices need to be reauthenticated
during the ->resume_noirq phase, i.e. with device interrupts disabled,
as drivers are allowed access to devices already in that phase.
So authentication (and encryption establishment) needs to happen this
early, when user space isn't available yet.

See the commit message of "PCI/CMA: Reauthenticate devices on reset
and resume" on the above-linked branch for details.

Thanks,

Lukas
