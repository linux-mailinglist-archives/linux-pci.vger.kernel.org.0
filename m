Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C748034B771
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 14:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhC0Nq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 09:46:27 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:53332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229901AbhC0Np5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 09:45:57 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2021 09:45:57 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 7E57C18043D20;
        Sat, 27 Mar 2021 13:39:11 +0000 (UTC)
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 27C20100E7B40;
        Sat, 27 Mar 2021 13:39:10 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA id 6092A18A608;
        Sat, 27 Mar 2021 13:39:08 +0000 (UTC)
Message-ID: <50e838ca74c56b9fd5cbbc2d7234829f0e0b4131.camel@perches.com>
Subject: Re: [PATCH v2 06/15] ACPI: LPSS: fix some coding style issues
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Date:   Sat, 27 Mar 2021 06:39:07 -0700
In-Reply-To: <CAHp75Vd0hVqsfsZK=d1dz98Kbchqz-w4RqQQp6FwisxSGG5BzA@mail.gmail.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
         <1616831193-17920-7-git-send-email-tanxiaofei@huawei.com>
         <CAHp75Vd0hVqsfsZK=d1dz98Kbchqz-w4RqQQp6FwisxSGG5BzA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6092A18A608
X-Spam-Status: No, score=1.60
X-Stat-Signature: or65y7ksn6r8hjdwk1z5k5ok7iqhenqo
X-HE-Tag: 1616852348-647392
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2021-03-27 at 10:19 +0200, Andy Shevchenko wrote:
> On Saturday, March 27, 2021, Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> 
> > Fix some coding style issues reported by checkpatch.pl, including
> > following types:
> > 
> > WARNING: simple_strtol is obsolete, use kstrtol instead
> 
> 
> And one more thing, the above message is bogus. Read what the comments in
> the code says about use cases for simple_*() vs. kstrto*() ones.
> 
> Joe?

This check and message is nearly 10 years old and was appropriate for
when it was implemented.

kernel.h currently has:
 * Use these functions if and only if you cannot use kstrto<foo>, because

So the message could be changed to something like:

WARNING: simple_strtol should be used only when kstrtol can not be used.



