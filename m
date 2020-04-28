Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F91BB472
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 05:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgD1DUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 23:20:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:49195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1DUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 23:20:10 -0400
IronPort-SDR: +XarSrE4j/eQYjdHSLRhLTeseDQhefCxnbBpzm6XuImxfTFLgQjvub6JUMUnVabX5YXCkn/6iA
 2DTvd8GNvKgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 20:20:09 -0700
IronPort-SDR: WSXjJD7yfJNRSt+e6bVRZ/9EXUgYGHUogadn+DgqjX31mBV3nNdPhkHVhNzE2iJxDttzcbGSI2
 sYsU9AXf5LPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="336503126"
Received: from djmuller-mobl.amr.corp.intel.com (HELO [10.255.231.74]) ([10.255.231.74])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2020 20:20:08 -0700
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Jon Derrick <jonathan.derrick@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20200428000213.GA29631@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c5c97e05-2682-9046-a362-d8bc29be7482@linux.intel.com>
Date:   Mon, 27 Apr 2020 20:20:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428000213.GA29631@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/27/20 5:02 PM, Bjorn Helgaas wrote:
> I split this up a bit and applied the first part to pci/error to get
> it into -next so we can start seeing what breaks.  I won't be too
> surprised if we trip over something.
Any reason for the split? I don't see reason for still keeping HEST
parser.
