Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10FD325690
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 20:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhBYTUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 14:20:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:23288 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234587AbhBYTR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 14:17:26 -0500
IronPort-SDR: IL96esFtdF8l2WxPCm0a0dKB8/Kcg04+7VooUJoQyI551MH82xt/W1ypOPYUrgxJ4Z/+rGzPe9
 xWX811cv3ZLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="165511517"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="165511517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 11:15:39 -0800
IronPort-SDR: Q4NbPCrOj8ewAhHVXK9/AOSspttBeGrXIVm4pAAMiIfCbyMMkq63rxYhOExH9VFzNLE3Het+6A
 1ljQ8NNBdZfQ==
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="424766251"
Received: from dgnichol-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.104.209])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 11:15:38 -0800
Subject: Re: [PATCH 1/2] PCI: controller: thunder: fix compile testing
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210225185100.GA17711@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2d6143a5-974b-466b-e0a7-0d817c167562@linux.intel.com>
Date:   Thu, 25 Feb 2021 11:15:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225185100.GA17711@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/25/21 10:51 AM, Bjorn Helgaas wrote:
> Thanks for looking this over!  I'd like to acknowledge your review,
> but I need an explicit Reviewed-by or similar.  I don't want to put
> words in your mouth by converting "Looks good to me" to "Reviewed-by".

will do so in future reviews.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
