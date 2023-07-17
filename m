Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6878756AA9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGQRdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGQRc7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:32:59 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016E1723
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 10:32:33 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae98e.dynamic.kabel-deutschland.de [95.90.233.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 159A561E5FE01;
        Mon, 17 Jul 2023 19:32:04 +0200 (CEST)
Message-ID: <80bfadb3-5af3-0100-30bb-c5008660d5a5@molgen.mpg.de>
Date:   Mon, 17 Jul 2023 19:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
To:     Sasha Neftin <sasha.neftin@intel.com>
References: <20230717171927.78516-1-sasha.neftin@intel.com>
Content-Language: en-US
Cc:     intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230717171927.78516-1-sasha.neftin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Cc: +linux-pci@vger.kernel.org]

Dear Sasha,


Thank you for your patch.

Maybe be more specific in the commit message summary. Maybe:

igc: Decrease PTM short interval from 10 us to 1 us

Am 17.07.23 um 19:19 schrieb Sasha Neftin:
> With the 10us interval, we were seeing PTM transactions taking around 12us.
> With the 1us interval, PTM dialogs took around 2us. Checked with the PCIe
> sniffer.

On what board, and with what device and what firmware versions?

> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 44a507029946..c3722f524ea7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -549,7 +549,7 @@
>   #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
>   #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>   
> -#define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
> +#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */

Why is the comment updated?

>   #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>   #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */


Kind regards,

Paul
