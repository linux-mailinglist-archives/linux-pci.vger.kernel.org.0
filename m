Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295F92ED72C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbhAGTF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 14:05:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:25134 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbhAGTF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 14:05:58 -0500
IronPort-SDR: Gi5IosvKN0tRO8JRA3iaLpIsSsh8PL/Xvd/+FMwew+H3rrv2WAji3n2Ct67LL4KfnW0KPMr4Tr
 +SBZq6s8pPxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="174900161"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="174900161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:05:02 -0800
IronPort-SDR: ugZjmmK2T3r417oWf45PqYMOPuOYoYwD0HR+0RRMBVcXPP6uNrBnTBONaMiLjsyNL2sXT4Ipp6
 sNyf/8fHZkDQ==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="379823323"
Received: from testonfe-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.141.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:05:02 -0800
Date:   Thu, 7 Jan 2021 11:05:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 07/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210107190500.qvsb2qkqcvgclanu@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-8-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209002418.1976362-8-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-08 16:24:11, Ben Widawsky wrote:

[snip]

> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	u64 cmd, status;
> +	size_t out_len;
> +	int rc;
> +
> +	lockdep_assert_held(&cxlm->mbox_lock);
> +
> +	/*
> +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> +	 *   2. Caller writes Command Register
> +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> +	 *   4. Caller writes MB Control Register to set doorbell
> +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> +	 *   6. Caller reads MB Status Register to fetch Return code
> +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> +	 */
> +
> +	/* #1 */
> +	WARN_ON(cxl_doorbell_busy(cxlm));
> +
> +	/* #2 */
> +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, mbox_cmd->opcode);
> +
> +	if (mbox_cmd->size_in) {
> +		/* #3 */
> +		CXL_SET_FIELD(mbox_cmd->size_in, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +		cxl_mbox_payload_fill(cxlm, mbox_cmd->payload,
> +				      mbox_cmd->size_in);
> +	}

There is a bug here where the payload length isn't written on input. It was
working in v1. It will be fixed in v3.

[snip]

