Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF676ADC8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPRlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 13:41:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45046 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfGPRlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jul 2019 13:41:11 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hnRRt-0001EU-Ux; Tue, 16 Jul 2019 11:41:10 -0600
To:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     Allen Hubbe <allenbh@gmail.com>, linux@yadro.com
References: <20190716173448.eswemneatvjwnxny@yadro.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
Date:   Tue, 16 Jul 2019 11:41:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716173448.eswemneatvjwnxny@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux@yadro.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, fomichev.ru@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr
 == 0
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-07-16 11:34 a.m., Alexander Fomichev wrote:
> On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
> ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
> combination for setting translation.
> 
> Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>

Looks good, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index db49677..45b9513 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (rc)
>  		return rc;
>  
> -	if (addr == 0 || size == 0) {
> +	if (size == 0) {
>  		if (widx < nr_direct_mw)
>  			switchtec_ntb_mw_clr_direct(sndev, widx);
>  		else
> 
