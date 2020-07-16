Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A5221A57
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGPCzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 22:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGPCzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 22:55:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE23C061755;
        Wed, 15 Jul 2020 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LQ48wgOnwQjXpsDpDux/VDQorpJQWNSKgnudCvhnDSE=; b=Fr8T9im26yPu3EUQ0ArRpwJEpB
        M+nzQYEsTOcvI1ntkABM/4mN9Ig6dYscYw1hKLJgMrBnvgrG2zwkFgIPTeDjJQnbNy1KT9wwtvsJO
        afc6maoZnEmr+xebKuESN8iriMy+l7lzJLoG70OclSQjGJXWQGgbdv0vmg8kG+stoaFSQsFKZGByr
        7PnLSBDlRuEiv23XeR8VzEQl43OlaV53lqCRBPOWmQ3QHG474M5ouQTI8ebckC/L57HcqrKCM1CSl
        FmxFckxL/SkJvPK5jlg6OcDr7yqxzaekiOKYLnsrPMmqH/oH5EVfuBGaWRl/U5DMKYsPmg8vmywd3
        K5FhrJ8w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvu3H-0006oy-Ot; Thu, 16 Jul 2020 02:55:16 +0000
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific
 Capability
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
 <20200714062323.19990-2-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f490460-62f8-8b49-0735-ad29653bfbc0@infradead.org>
Date:   Wed, 15 Jul 2020 19:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714062323.19990-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/20 11:23 PM, David E. Box wrote:
> Add PCIe DVSEC extended capability ID and defines for the header offsets.
> Defined in PCIe r5.0, sec 7.9.6.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..09daa9f07b6b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -720,6 +720,7 @@
> +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
> @@ -1062,6 +1063,10 @@
> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */

Just a little comment: It would make more sense to me to
s/DVSEC/DVSPEC/g.

But then I don't have the PCIe documentation.

-- 
~Randy

