Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E945B736
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 10:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhKXJTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 04:19:49 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59633 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241440AbhKXJT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 04:19:26 -0500
Received: from [79.2.93.196] (port=52016 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mpoNw-0004yt-EW; Wed, 24 Nov 2021 10:16:12 +0100
Subject: Re: [PATCH v3 3/3] PCI: apple: Fix #PERST polarity
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        kernel-team@android.com
References: <20211123180636.80558-1-maz@kernel.org>
 <20211123180636.80558-4-maz@kernel.org>
 <453389da-b041-94b3-009e-6c6323134936@lucaceresoli.net>
 <87fsrmc4e6.wl-maz@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <cc7b1e22-a184-1053-870a-966a210ecfd0@lucaceresoli.net>
Date:   Wed, 24 Nov 2021 10:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87fsrmc4e6.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/11/21 10:02, Marc Zyngier wrote:
> On Tue, 23 Nov 2021 21:36:11 +0000,
> Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> Hi Mark,
>>
>> On 23/11/21 19:06, Marc Zyngier wrote:
>>> Now that #PERST is properly defined as active-low in the device tree,
>>> fix the driver to correctly drive the line indemendently of the
>>> implied polarity.
>>>
>>> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
>>> Suggested-by: Pali Rohár <pali@kernel.org>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>
>> Thanks for quickly addressing this!
>>
>> Do we need a transition path for backward compatibility with old DTs
>> already around? Something like this [0]. You said [1] the DT actually
>> used is not even the one in the kernel, thus how do we guarantee DT and
>> driver switch to the new polarity all at once?
> 
> No. As it turns out, neither u-boot nor OpenBSD (the only two other
> payloads that can boot on M1) are upstreamed yet. So we're still in
> that stage where we don't need to maintain backward compatibility. If
> we don't get this patches merged by the end of this cycle, we will
> have to revisit this though.

Good news!

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
