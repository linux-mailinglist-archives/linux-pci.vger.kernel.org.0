Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765907D71C0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJYQa1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJYQaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 12:30:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB5592
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=dRld3LCpvyA8YW/8PHBulR4ARRFMXMuz0Rb0WXNFFkw=; b=ETrtDOoZNf4+5P2X8S53J30aow
        qe2OZjl85WXiz8vSsuWp2l7L5A3C9MGHehx4uEnHxKjseDq4qLMbGSdWzF1nv6dQPLlHZv3aqp4je
        QA0gPYSrDwzSMkp5nc0pNeZJHSjYcnnso2OTPBmKmmGIiAi1DwYG0mgTz0xQbEQTdXsXCypyHnBi6
        d5030c+a6CKnPyKyFBsFSy0nYBSNhz+gKVAtmR0uXXsUQndWFak/Dcx9jQQdTDkWl0qYu9tXdIyM7
        XCl9JWsEH4Ds9NoQAUE51EhvcSsFuFKhO9sKvPsZQx/IrE1JKloAipv9TcAD3jS5Mmjon6tBcramf
        R1wZnHZg==;
Received: from s010670a741a4a87d.cg.shawcable.net ([70.73.161.44] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qvglq-0060EH-KY; Wed, 25 Oct 2023 10:30:15 -0600
Message-ID: <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
Date:   Wed, 25 Oct 2023 10:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
References: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.161.44
X-SA-Exim-Rcpt-To: u.kleine-koenig@pengutronix.de, bhelgaas@google.com, sjr@debian.org, 1015871@bugs.debian.org, linux-pci@vger.kernel.org, alexander.deucher@amd.com, kw@linux.com, ema@debian.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: Enabling PCI_P2PDMA for distro kernels?
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-10-25 00:19, Uwe Kleine-König wrote:
> Hello,
> 
> in https://bugs.debian.org/1015871 the Debian kernel team got a request
> to enable PCI_P2PDMA. Given the description of the feature and also the
> "If unsure, say N." I wonder if you consider it safe to enable this
> option.

I don't know. Not being a security expert, I'd say the attack surface
exposed is fairly minimal. Most of what goes on is internal to the
kernel. So the main risk is the same rough risk that goes with enabling
any feature: there may be bugs.

My opinion is that 'No' is recommended because the feature is still very
nascent and advanced. Right now it enables two user visible niche
features: p2p transfers in nvme-target between an NVMe device and an
RDMA NIC and transferring buffers between two NVMe devices through the
CMB via O_DIRECT. Both uses require an NVMe device with CMB memory,
which is rare.

Anyone using this option to do GPU P2PDMA transfers are certainly using
out of tree (and likely proprietary) modules as the upstream kernel does
not yet appear to support anything like that at this time. Thus it's not
clear how such code is using the P2PDMA subsystem or what implications
there may be.

It's not commonly the case that using these features increases
throughput as CMB memory is usually much slower than system memory. It's
use makes more sense in smaller/cheaper boutique systems where the
system memory or bus bandwidth to the CPU is limited. Typically with a
PCIe switch involved.

In addition to the above, P2PDMA transfers are only allowed by the
kernel for traffic that flows through certain host bridges that are
known to work. For AMD, all modern CPUs are on this list, but for Intel,
the list is very patchy. When using a PCIe switch (also uncommon) this
restriction is not present seeing the traffic can avoid the host bridge.

Thus, my contention is anyone experimenting with this stuff ought to be
capable of installing a custom kernel with the feature enabled.

Logan
