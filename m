Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55725B42E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBTAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 15:00:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:13795 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBTAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 15:00:13 -0400
IronPort-SDR: 8rYD2QRTfnvoft5TSKxE84+MC6Ob6MSgmbgdfHQGhMnsbY/Zio3kyIKzcY26qSRbYqMuulJcFO
 x7iCL5G4HdYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="156732189"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="156732189"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 12:00:08 -0700
IronPort-SDR: j7OW7/avDkeZ25iDhgtv9HUhGze9v/ClP85tjLQYiuYANapdL8uJ9iUaxLxJo5mgXkSezY4yb4
 jb3gCjapUwPA==
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="325895891"
Received: from acduong-mobl2.amr.corp.intel.com (HELO [10.254.87.179]) ([10.254.87.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 12:00:06 -0700
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     alexander.deucher@amd.com, nirmodas@amd.com, Dennis.Li@amd.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, bhelgaas@google.com
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
Date:   Wed, 2 Sep 2020 12:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/2/20 11:42 AM, Andrey Grodzovsky wrote:
> This reverts commit 6d2c89441571ea534d6240f7724f518936c44f8d.
> 
> In the code bellow
> 
>                  pci_walk_bus(bus, report_frozen_detected, &status);
> -               if (reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> +               status = reset_link(dev, service);
> 
> status returned from report_frozen_detected is unconditionally masked
> by status returned from reset_link which is wrong.
> 
> This breaks error recovery implementation for AMDGPU driver
> by masking PCI_ERS_RESULT_NEED_RESET returned from amdgpu_pci_error_detected
> and hence skiping slot reset callback which is necessary for proper
> ASIC recovery. Effectively no other callback besides resume callback will
> be called after link reset the way it is implemented now regardless of what
> value error_detected callback returns.
> 
	}

Instead of reverting this change, can you try following patch ?
https://lore.kernel.org/linux-pci/56ad4901-725f-7b88-2117-b124b28b027f@linux.intel.com/T/#me8029c04f63c21f9d1cb3b1ba2aeffbca3a60df5

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
