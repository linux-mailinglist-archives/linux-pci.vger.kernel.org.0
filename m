Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731EF30DA11
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhBCMqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 07:46:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12071 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBCMnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 07:43:45 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DW1Wm2lDrzMV2p;
        Wed,  3 Feb 2021 20:41:24 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Feb 2021
 20:42:55 +0800
Subject: Re: [PATCH] PCI/DPC: Check host->native_dpc before enable dpc service
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>,
        <yangyicong@hisilicon.com>
References: <1612354409-14285-1-git-send-email-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <21de9671-9276-661f-4198-258f73a659d6@hisilicon.com>
Date:   Wed, 3 Feb 2021 20:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1612354409-14285-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/2/3 20:13, Yicong Yang wrote:
> Per PCI Firmware Specification Rev. 3.2 Table 4-6,
> Interpretation of _OSC Control Field Returned Value, for
> bit 7 of _OSC control return value:

Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
affecting PCI Firmware Specification, Rev. 3.2.

will resend to fix this. sorry.

