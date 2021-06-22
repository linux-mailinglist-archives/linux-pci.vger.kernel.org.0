Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3363B0F46
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 23:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFVVP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Jun 2021 17:15:57 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35877 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhFVVP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 17:15:56 -0400
Received: from [77.244.183.192] (port=62278 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lvniE-0005XZ-Pn; Tue, 22 Jun 2021 23:13:38 +0200
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <58aaadb4-c643-76ce-bda0-294bb2300137@lucaceresoli.net>
Date:   Tue, 22 Jun 2021 23:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622110627.aqzxxtf2j3uxfeyl@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 22/06/21 13:06, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
>> Nothing happened after a few weeks... I understand that knowing the
>> correct reset timings is relevant, but unfortunately I cannot help much
>> in finding out the correct values.
>>
>> However I'm wondering what should happen to this patch. It *does* fix a
>> real bug, but potentially with an incorrect or non-optimal usleep range.
>> Do we really want to ignore a bugfix because we are not sure about how
>> long this delay should be?
> 
> As there is no better solution right now, I'm fine with your patch. But
> patch needs to be approved by Lorenzo, so please wait for his final
> answer.
> 
> I would suggest to add a comment for call "usleep_range(1000, 2000);"
> that you have chosen some "random" values which worked fine on your
> setup and that they fix mentioned bug. Comment just to mark this sleep
> code that is suboptimal / not-so-correct and to prevent other people to
> copy+paste this code into other (new) drivers...

Sure, good idea.

I'm following this thread and will send v3 after a direction is agreed upon.

-- 
Luca

