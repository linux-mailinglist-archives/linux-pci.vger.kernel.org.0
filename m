Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0542060E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhJDGxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhJDGxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 02:53:48 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F640C061745;
        Sun,  3 Oct 2021 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2U2H+WJMZ7E3Vlp6mwDMBHvaOupxV5RZSvFU2UIcpZc=; b=1IAXHsz2IIDBlCmM7EA+ex7rJJ
        2+CcD1lqn2Ux2g4dZwb8s1/EoBXRn7YBh2csMl6ETCMu11uxX5sqZMFIbNI4iqpiHD662Q85VtZbc
        9DgZNGmryK7lWz16FaD1L+LBh66KwNF3VNkLh4fLM0idB1zSVmvwkJEQBJsLRso1RqKfXWLOiTlir
        bRrv7bLdZQ9HBVVWAu77NVkpbhBxl2EsQiEg9xjGpJQzKfY0S89L+Lk+51nGi7IoTMqpc3RKJVW88
        Q4c5xr3GRuabnhh/B3JDapSwH2YNJdwY9QlfO3TLn28BXGLt4DexARVGkXYdEP44eAnguchGB6XkV
        YM1wO9Kw==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1mXHow-0001zc-PG; Mon, 04 Oct 2021 09:51:52 +0300
Subject: Re: [PATCH 4/5] cpufreq: tegra186/tegra194: Handle errors in BPMP
 response
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-4-mperttunen@nvidia.com>
 <20211004063714.5bux4hwv3lchibnn@vireshk-i7>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <d237c089-88d7-32ec-04cf-f04417b0ef4b@kapsi.fi>
Date:   Mon, 4 Oct 2021 09:51:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211004063714.5bux4hwv3lchibnn@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/4/21 9:37 AM, Viresh Kumar wrote:
> On 15-09-21, 11:55, Mikko Perttunen wrote:
>> The return value from tegra_bpmp_transfer indicates the success or
>> failure of the IPC transaction with BPMP. If the transaction
>> succeeded, we also need to check the actual command's result code.
>> Add code to do this.
>>
>> While at it, explicitly handle missing CPU clusters, which can
>> occur on floorswept chips. This worked before as well, but
>> possibly only by accident.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra186-cpufreq.c | 4 ++++
>>   drivers/cpufreq/tegra194-cpufreq.c | 8 +++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> Should I apply it alone ?
> 

Yes please, all of these patches are independent of each other.

Mikko
