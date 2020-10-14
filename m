Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD68928D9AE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 07:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgJNFv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 01:51:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:12505 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgJNFv5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 01:51:57 -0400
IronPort-SDR: XN6jSVruBduUaZ12g5ErPYESO8tYCco70IgSqPq99DhW63Nh04FDXdUs85IQoiPdWaGoUcJUn7
 FBua66Z963rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166159740"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="166159740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 22:51:56 -0700
IronPort-SDR: sVsJXTI7dB54zNeQbmq28Lv8bYlyPQ7lkw+lxcLlGNWwN/HzJc1Sg//7kXCIUc40CxIkzgNlUj
 o8qQDyLD09iQ==
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="314054422"
Received: from isgomez-mobl.amr.corp.intel.com (HELO [10.252.133.97]) ([10.252.133.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 22:51:56 -0700
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Ethan Zhao <xerces.zhao@gmail.com>,
        sathyanarayanan.nkuppuswamy@gmail.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh1Y1eADo_Cuf_MqgNanYuwhjWWe23DvPVByt6gmaf5AGQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <37c7b066-efff-de0c-f4d2-c497792b3150@linux.intel.com>
Date:   Tue, 13 Oct 2020 22:51:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh1Y1eADo_Cuf_MqgNanYuwhjWWe23DvPVByt6gmaf5AGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/13/20 10:44 PM, Ethan Zhao wrote:
> This patch only reverts the commit bdb5ac85777d ?
> or you'd better separate the revert and code you added.

We cannot revert the commit as it is. pcie_do_recovery()
function and Documentation/* folder changed a lot since
fatal and non-fatal error recovery paths were merged. So I
modified the revert so that it can be applied to the latest
kernel version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
