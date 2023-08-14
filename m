Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764277B3A1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHNIO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHNIOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94244D2;
        Mon, 14 Aug 2023 01:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C9064493;
        Mon, 14 Aug 2023 08:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56655C433C8;
        Mon, 14 Aug 2023 08:14:40 +0000 (UTC)
Date:   Mon, 14 Aug 2023 13:44:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
Subject: Re: [PATCH v1] bus: mhi: ep: Clear channel interrupts that are
 unmasked
Message-ID: <20230814081435.GA9011@thinkpad>
References: <1691747849-15385-1-git-send-email-quic_skananth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1691747849-15385-1-git-send-email-quic_skananth@quicinc.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 02:57:08AM -0700, Subramanian Ananthanarayanan wrote:
> Change is to avoid clearing of interrupts that could have been masked.
> 
> Signed-off-by: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>

Is this scenario possible in real life? We unmask all the interrupts during
power_up and later mask the interrupts specific to channels when they are
started. So I do not see a possibility where the CHDB status would be set for an
unmasked channel.

Looking at the code now, I think we can get rid of the mask check, even the
local copy of mask if there is a guarantee that doorbell interrupts won't be
enabled behind the back of the MHI stack.

IIRC, I added the mask check as the HW channel interrupts were enabled behind
the back. But that was fixed with all unmask during power_up and mask only
started channels strategy.

PS: The term "mask" is horribly used in an inverted manner in MHI.

- Mani

> ---
>  drivers/bus/mhi/ep/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 6008818..a818781 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -867,7 +867,7 @@ static void mhi_ep_check_channel_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
>  		if (ch_int) {
>  			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
>  			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
> -							mhi_cntrl->chdb[i].status);
> +							ch_int);
>  		}
>  	}
>  }
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
