Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16717B5546
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfIQS0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 14:26:36 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:46261 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfIQS0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 14:26:36 -0400
X-Greylist: delayed 1161 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 14:26:35 EDT
Received: from p2e50e985.dip0.t-ipconnect.de ([46.80.233.133] helo=[192.168.2.138])
        by mx.kernkonzept.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
        id 1iAIBO-0006Ym-Ds; Tue, 17 Sep 2019 20:26:34 +0200
Subject: Re: [PATCH] drivers:pci:quirks: Fix register offset for UPDCR
References: <7990868c-92b1-1404-c4fa-3d155423d732@kernkonzept.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
From:   Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
Message-ID: <cfcbfd7d-a935-bb35-0aca-b949aac42634@kernkonzept.com>
Date:   Tue, 17 Sep 2019 20:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7990868c-92b1-1404-c4fa-3d155423d732@kernkonzept.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I should mention that this patch is untested. I do not have hardware 
that implements said register.

On 9/12/19 1:24 PM, Steffen Liebergeld wrote:
> According to documentation [0] the correct offset for the
> Upstream Peer Decode Configuration Register (UPDCR) is 0x1014.
> It was previously defined as 0x1114. This patch fixes it.
> 
> [0]
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-mobile-i-o-datasheet.pdf
> (page 325)
> 
> Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
> ---
>   drivers/pci/quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..7e184beb2aa4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4602,7 +4602,7 @@ int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
>   #define INTEL_BSPR_REG_BPPD  (1 << 9)
>   
>   /* Upstream Peer Decode Configuration Register */
> -#define INTEL_UPDCR_REG 0x1114
> +#define INTEL_UPDCR_REG 0x1014
>   /* 5:0 Peer Decode Enable bits */
>   #define INTEL_UPDCR_REG_MASK 0x3f
>   
> 
