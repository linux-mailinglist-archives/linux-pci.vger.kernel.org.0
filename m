Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE021F6E87
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 07:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKGYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 01:24:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:39697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfKKGYm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 01:24:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 22:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="207035519"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2019 22:24:40 -0800
Received: from [10.226.39.46] (ekotax-mobl.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 8462B5801E3;
        Sun, 10 Nov 2019 22:24:33 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
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
 <DM6PR12MB4010413DC722963F00461666DA790@DM6PR12MB4010.namprd12.prod.outlook.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <2ff60b67-c18f-2bcc-f10c-38b9fdec29fe@linux.intel.com>
Date:   Mon, 11 Nov 2019 14:24:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4010413DC722963F00461666DA790@DM6PR12MB4010.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/6/2019 5:43 PM, Gustavo Pimentel wrote:
> On Wed, Nov 6, 2019 at 3:44:3, Dilip Kota <eswara.kota@linux.intel.com>
> wrote:
>
>> Utilize DesugnWare helper functions to configure Fast Training
>> Sequence. Drop the respective code in the driver.
> Please fix
> s/DesugnWare/DesignWare
Typo error. I will correct it in the next patch version.

Thanks for reviewing it.
Regards,
Dilip


