Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA04DFF5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfFUFLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 01:11:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43652 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfFUFLM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 01:11:12 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1heBpO-0005gq-B2; Thu, 20 Jun 2019 23:11:11 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
 <20190620134712.GI143205@google.com>
 <SL2P216MB018710C0513F97989DCD3A4880E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7d008368-d358-ede9-215b-1971cbdc2d77@deltatee.com>
Date:   Thu, 20 Jun 2019 23:11:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB018710C0513F97989DCD3A4880E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, benh@kernel.crashing.org, helgaas@kernel.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-20 8:57 p.m., Nicholas Johnson wrote:
>> Adding two new parameters sounds like a good idea to me.
> Yeah, that is basically what I did originally (except I depreciated the 
> old ones rather than keeping them).
> 
> I did it this way on your direct advice in keeping with minimal lines of 
> diff, minimal disruption, etc. If I were to do this, the number of lines 
> of diff will increase and then I will be fielding complaints that it is 
> too large to sign off.
> 
> I am already scrambling to make last minute changes before end of 
> release to the other patches and I am not even convinced that that stuff 
> is going to get accepted based on proximity to deadline and how many 
> change requests are flying around.

Friendly advice: Linux Kernel development doesn't really work on
deadlines. The patch I linked you to has already been around a couple of
cycles and has missed a couple of merge windows. It's not that big of a
deal. I  try to make it better, if I can, and resubmit it once or twice
a cycle. It will get in when other people understand it and it meets the
community's standards. I had one patch set I submitted for more than a
year and a half, or 25 times, and it eventually got picked up. It's not
always the best experience but patience, persistence and openness to
feedback are what works.

New kernel parameters are important to get right because they are user
facing interfaces and we are stuck with them forever -- breaking
existing users is simply not accepted here. Deprecating features is an
extreme action that the Linux community takes pains to avoid. If we cede
to deadlines to get a new parameter in, and it turns out to be
non-ideal, then we are stuck supporting it forever and it's painful for
everyone.

Logan
