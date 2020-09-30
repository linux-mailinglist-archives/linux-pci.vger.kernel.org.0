Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7EF27EA1F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgI3Nmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 09:42:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:7212 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgI3Nmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 09:42:43 -0400
IronPort-SDR: 7A5AX6e+74KKSOr0bpw+rZmQ8qwzgB0dRDn3yZdceg/hmGq1vzl2xiZT8aUbwxfW9yR4sg9KyK
 DgWsUgL+FMAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161672041"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="161672041"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:42:43 -0700
IronPort-SDR: wcvB+fCVQuUZkeFuBwdZGojT2EKhvugyjDD5JkoQrX9tXypikCH60coxFhkEd2u1jOJyZ2R6Pu
 ZWC5Raw7iKaA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="515081031"
Received: from pmajewsk-mobl1.ger.corp.intel.com (HELO [10.249.153.66]) ([10.249.153.66])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:42:42 -0700
Subject: Re: [PATCH 0/2] PCI/PM: Fix D2 transition delay
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20200929194748.2566828-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <58f3629e-1564-2202-ac49-3ccb683260e1@intel.com>
Date:   Wed, 30 Sep 2020 15:42:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929194748.2566828-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/29/2020 9:47 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Remove an unused #define.
>
> Fix the D2 transition delay.  I changed this a year ago to conform to the
> PCIe r5.0 spec, but I think the number I relied on is a typo in the spec.
> I asked the PCI-SIG to fix the typo.  Hopefully I'll get a response before
> the merge window.
>
> Bjorn Helgaas (2):
>    PCI/PM: Remove unused PCI_PM_BUS_WAIT
>    PCI/PM: Revert "PCI/PM: Apply D2 delay as milliseconds, not
>      microseconds"
>
>   drivers/pci/pci.c | 2 +-
>   drivers/pci/pci.h | 7 +++----
>   2 files changed, 4 insertions(+), 5 deletions(-)
>
Please add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to both patches.

Cheers!


