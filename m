Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3BF6F75
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 09:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKIJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 03:09:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:4047 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfKKIJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 03:09:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 00:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="197593704"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2019 00:09:20 -0800
Received: from [10.226.39.46] (ekotax-mobl.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 354D25803A5;
        Mon, 11 Nov 2019 00:09:16 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
To:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
 <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <e9355886-d667-4b3e-89ae-98de60093273@linux.intel.com>
Date:   Mon, 11 Nov 2019 16:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/8/2019 5:03 AM, Jingoo Han wrote:
> On 11/5/19, 10:44 PM, Dilip Kota wrote:
>> Utilize DesugnWare helper functions to configure Fast Training
> Nitpicking: Fix typo (DesugnWare --> DesignWare)
>
> If possible, how about the following?
> Utilize DesignWare --> Use DesignWare
Sure, i will correct it and update to 'Use DesignWare'

Thanks for reviewing the patch,


Regards,
Dilip

>
> Best regards,
> Jingoo Han
>
