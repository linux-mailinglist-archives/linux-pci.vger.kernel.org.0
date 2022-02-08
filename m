Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73EA4AD726
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbiBHLb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbiBHLMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 06:12:52 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 03:12:51 PST
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1313AC03FEC0;
        Tue,  8 Feb 2022 03:12:50 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Feb 2022 20:11:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B20DD2006F53;
        Tue,  8 Feb 2022 20:11:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Feb 2022 20:11:46 +0900
Received: from [10.212.182.146] (unknown [10.212.182.146])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A4949C1E22;
        Tue,  8 Feb 2022 20:11:45 +0900 (JST)
Subject: Re: [PATCH 2/3] PCI: uniphier-ep: Add support for non-legacy SoC
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220204160616.GA183849@bhelgaas>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <664a23d0-7646-3c50-fe4d-d29b6ce99a35@socionext.com>
Date:   Tue, 8 Feb 2022 20:11:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220204160616.GA183849@bhelgaas>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for your comment.

On 2022/02/05 1:06, Bjorn Helgaas wrote:
> On Thu, Feb 03, 2022 at 11:36:25AM +0900, Kunihiko Hayashi wrote:
>> Define SoC data that includes pci_epc_features and boolean 'is_legacy'
>> to distinguish between legacy SoC (ex. Pro5) and non-legacy SoC.
> 
> I'm not a big fan of "legacy" as a description because it conveys very
> little information.  You're adding support for a "non-legacy" SoC, so
> now there are "legacy" ones and "non-legacy" ones.  Next year there
> will be another new SoC, and then there will be *two* kinds of
> "legacy" ones that must be distinguished plus the next "non-legacy"
> one.

Make sense. There will be multiple different "legacy", so it isn't
desirable to distinguish SoCs by legacy and non-legacy.

> You mentioned "Pro5" as an example of "legacy," which is a good start.
> Are there any others?  If Pro5 is the only one, you could just use
> "pro5" where you now use "legacy."
I see. In consideration of the future, I'll define callback functions
and prepare functions for each SoC.
And the "gio" clocks/resets are distinguished by the flag "has_gio".

Thank you,

---
Best Regards
Kunihiko Hayashi
