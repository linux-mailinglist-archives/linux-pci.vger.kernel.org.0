Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B63758261
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGRQpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGRQpw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 12:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C21719
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 09:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C1F6167A
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 16:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0EC433C8;
        Tue, 18 Jul 2023 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689698747;
        bh=rSlNjvjzRrnWqAERbD+Th9DUDaRg0H6dEdA0hZG5nGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E+3zbumnbaxkGpPAaU08iYHTdifWS4XmynlZ2knsL0lfzd/vh1C/LqgvHmVR3Jp5R
         n63pl9akI/e0QSTSyJNO8OaOkbircps6YQhbD116vW++qvLlluueJgnnI3+Dq7XwmR
         iUb7weNKGWi6LIcPC0c4H6vl4FhZJ/vu3U3y/jElt5o3Oa9Qypp9C9I80JEj/vCrXO
         5dY4EQ6ajh8NHknS33gRCFhw80bsrp28d043/2awDlLSakpV9dpE/tdeM6cPNsculg
         +T5+Bd2VARhOjxF1sBenpm67Eixwubvk/Z8gDXvovZPSPKy0aFVQepVtsYdOjPgchL
         1ULW00FSogo7Q==
Date:   Tue, 18 Jul 2023 11:45:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sasha Neftin <sasha.neftin@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
Message-ID: <20230718164544.GA486141@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717171927.78516-1-sasha.neftin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Paul, Vinicius, Kai-Heng, Guilherme]

On Mon, Jul 17, 2023 at 08:19:27PM +0300, Sasha Neftin wrote:
> With the 10us interval, we were seeing PTM transactions taking around 12us.
> With the 1us interval, PTM dialogs took around 2us. Checked with the PCIe
> sniffer.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 44a507029946..c3722f524ea7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -549,7 +549,7 @@
>  #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
>  #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>  
> -#define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
> +#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */

Not related to *this* patch, but from looking at igc_ptp_reset(),
where IGC_PTM_SHORT_CYC_DEFAULT is used,

  /* PCIe PTM Control */
  #define IGC_PTM_CTRL_START_NOW  BIT(29) /* Start PTM Now */
  #define IGC_PTM_CTRL_EN         BIT(30) /* Enable PTM */

  ctrl = IGC_PTM_CTRL_EN |
	  IGC_PTM_CTRL_START_NOW |
	  IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
	  IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
	  IGC_PTM_CTRL_TRIG;

  wr32(IGC_PTM_CTRL, ctrl);

Obviously this must be implementation-specific PTM configuration,
which is fine.  But I assume even though this sets IGC_PTM_CTRL_EN and
IGC_PTM_CTRL_START_NOW, the device will not actually send PTM Request
messages unless the architected PTM Enable bit in the PTM Capability
is set (PCIe r6.0, sec 7.9.15.3).  Right?

I'm asking because Kai-Heng has been working on issues where
Unsupported Request errors are reported because some devices seem to
send PTM Requests when we don't think they should.  See
https://lore.kernel.org/r/20230714050541.2765246-1-kai.heng.feng@canonical.com

>  #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>  #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
