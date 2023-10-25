Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBC7D72BB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJYR61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJYR6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:58:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D54187
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=aJshDtmbgpE+bl/GO9TyrL/miqSyo1kEz4gCYNkIUXk=; b=c1lE6Xpm9VsRhIUdtbNjut0tsw
        9/E/q2n+wfsfEgfo+/4jElV7K3h6EKDxHolW/AAaYd55A4YD10LHcwqwjL8JlFldQZ3esKzxcK4yM
        NB+hJTqgxbNhxqcslD49ycz7kOFyhhiFo4UaInPx8CX5WAOsxDVeQEfVWKO418hV6bEUaIMSV+LM/
        /zmoVZe+eeufc4/TywH7gu1ggMQxUo9CURuHBNRdzeI4gFe0X1ud9cLoucFtCm0enCXkFy578f5pf
        1Pd7fjwadRP3XqqlBFUBT6Nn5/Z3orFHfb0QgW7LX+FNzaPBhhRZVUrVoKEetH9JNcTJggk8G6CJI
        LNSy8mkQ==;
Received: from s010670a741a4a87d.cg.shawcable.net ([70.73.161.44] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qvi8p-0061YR-If; Wed, 25 Oct 2023 11:58:04 -0600
Message-ID: <e2c56983-0111-4132-ae17-0095aa33fd2d@deltatee.com>
Date:   Wed, 25 Oct 2023 11:58:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
References: <20231025173534.GA1755254@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20231025173534.GA1755254@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.161.44
X-SA-Exim-Rcpt-To: helgaas@kernel.org, lukas@wunner.de, u.kleine-koenig@pengutronix.de, bhelgaas@google.com, sjr@debian.org, 1015871@bugs.debian.org, linux-pci@vger.kernel.org, alexander.deucher@amd.com, kw@linux.com, ema@debian.org
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



On 2023-10-25 11:35, Bjorn Helgaas wrote:
> On Wed, Oct 25, 2023 at 07:11:26PM +0200, Lukas Wunner wrote:
>> On Wed, Oct 25, 2023 at 10:30:07AM -0600, Logan Gunthorpe wrote:
>>> In addition to the above, P2PDMA transfers are only allowed by the
>>> kernel for traffic that flows through certain host bridges that are
>>> known to work. For AMD, all modern CPUs are on this list, but for Intel,
>>> the list is very patchy.
>>
>> This has recently been brought up internally at Intel and nobody could
>> understand why there's a whitelist in the first place.  A long-time PCI
>> architect told me that Intel silicon validation has been testing P2PDMA
>> at least since the Lindenhurst days, i.e. since 2005.
>>
>> What's the reason for the whitelist?  Was there Intel hardware which
>> didn't support it or turned out to be broken?
>>
>> I imagine (but am not certain) that the feature might only be enabled
>> for server SKUs, is that the reason?
> 
> No, the reason is that the PCIe spec doesn't require routing of
> peer-to-peer transactions between Root Ports:
> https://git.kernel.org/linus/0f97da831026
> 
> I think there was a little discussion about adding a firmware
> interface to advertise this capability, but I guess nobody cared
> enough to advance it.

Yes, I remember someone advancing that in the PCI spec, but I don't know
that it got anywhere.

I definitely remember also testing Intel hardware several years ago
where P2PDMA "worked" but the performance was so awful there was no point.

I vaguely remember this not working on non-server machines in the past
(circa 2015). That's why we had to buy a Xeon. Though this was a long
time ago and my memory is fuzzy.

I'd love it if someone from Intel can give us a reasonable check on the
CPU that guarantees P2PDMA will work for everything that passes the
check (like AMD has done.) But in the absence of Intel telling us this
we can't easily make these assumptions.

Logan

