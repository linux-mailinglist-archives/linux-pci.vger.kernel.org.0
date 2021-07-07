Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ECF3BEEA0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGGS10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 14:27:26 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:43209 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhGGS1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 14:27:25 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d07 with ME
        id SJQh2500Q21Fzsu03JQiZT; Wed, 07 Jul 2021 20:24:43 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Jul 2021 20:24:43 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 3/3] PCI: tegra: make const array err_msg static
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
 <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
 <20210705223152.GA142312@rocinante>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a3d48884-9e47-8623-6fc5-6c52f4ca0568@wanadoo.fr>
Date:   Wed, 7 Jul 2021 20:24:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705223152.GA142312@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 06/07/2021 à 00:31, Krzysztof Wilczyński a écrit :
> Hi Christophe,
> 
> Thank you for sending the patches over and taking care about these!
> 
> I was wondering whether you will be willing to send a v2 of this series
> that would include fixes to everything the checkpatch.pl script reports
> against this driver?  There aren't a lot of things to fix, thus the idea
> to squash everything at once.  These warnings would be as follows
> (excluding the ones you taken care of in this series):
> 
>    drivers/pci/controller/pci-tegra.c:1661: WARNING: please, no space before tabs
>    drivers/pci/controller/pci-tegra.c:1890: WARNING: quoted string split across lines
>    drivers/pci/controller/pci-tegra.c:1891: WARNING: quoted string split across lines
>    drivers/pci/controller/pci-tegra.c:2619: WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 
> These should be trivial to fix.  The two pertaining to "quoted string
> split across lines" would be something that we might or might not decide
> to do anything about this - technically, as per the Linux kernel coding
> style [1], we ought to fix this... but, this particular case is not
> a terrible example, so I will leave this at your discretion.
> 
> What do you think?

Hi,
I don't think it worth it.

Even for patch 2/3 about 'seq_printf' --> 'seq_puts' conversion, I'm not 
fully convinced myself that is useful.

Too trivial clean-ups only mess-up 'git blame' for no real added value.

If you want these clean-ups, I can send a patch for it, but checkpatch 
output need sometimes to be ignored on files already in the tree. At 
least, this is my point of view.

CJ



> Also, don't worry if you don't have the time or otherwise, as these are
> trivial things and it would only be a bonus to take care of them.
> 
> 1. https://www.kernel.org/doc/html/v4.10/process/coding-style.html#breaking-long-lines-and-strings
> 
> 	Krzysztof
> 

