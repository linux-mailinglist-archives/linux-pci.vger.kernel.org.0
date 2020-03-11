Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA7181F6D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgCKR1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 13:27:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgCKR1o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 13:27:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA041FB;
        Wed, 11 Mar 2020 10:27:44 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 445053F6CF;
        Wed, 11 Mar 2020 10:27:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
References: <Shiju Jose> <20200207103143.20104-1-shiju.jose@huawei.com>
 <30d704c86d8b4be591ee36c0e735069d@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <451c6569-290e-4a55-122a-8a2ce897d7ab@arm.com>
Date:   Wed, 11 Mar 2020 17:27:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <30d704c86d8b4be591ee36c0e735069d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

On 09/03/2020 09:23, Shiju Jose wrote:
> Gentle reminder on this patch set.

Your cover-letter has:
| X-Mailer: git-send-email 2.19.2.windows.1
| In-Reply-To: <Shiju Jose>
| References: <Shiju Jose>

Which causes my mail client to thread this with year-old mail ... hence I've only just
seen this. Other people may have the same problem.
If you're feeding these headers into git-send-email, it expects the value from the
original message's 'Message-Id'... but you don't want this for a cover letter!


Thanks,

James
