Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803A82C4AD7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 23:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKYWiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 17:38:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:14914 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKYWiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 17:38:23 -0500
IronPort-SDR: ndgBZe6IJ+Im90VqOYAAmXjKv2v462e7yfiLmxwoFb9NaclFdPKkeSeFsTIo8ZV+HRz6yZz75k
 IFquVduAY1DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172366412"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="172366412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:38:22 -0800
IronPort-SDR: vlYo4BNdb3EZC7iMDXqwSHKMYrS7P/mffnZG5vH0OIbaKfa0xsjGIsuluBA37YozIffju3pvEX
 Nvpr7GXagbRA==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333162556"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:38:22 -0800
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
References: <20201125222509.GA688516@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bb291381-fe1c-7fb6-e252-86e896a77c43@linux.intel.com>
Date:   Wed, 25 Nov 2020 14:38:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125222509.GA688516@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/20 2:25 PM, Bjorn Helgaas wrote:
> I've been fiddling with this, so let me post a v12 tonight and you can
> see what you think.
Ok. I will wait for your update.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
